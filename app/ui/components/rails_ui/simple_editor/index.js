import "./index.css"

import { Controller } from '@hotwired/stimulus';

import Document from '@tiptap/extension-document';
import Paragraph from '@tiptap/extension-paragraph';
import Text from '@tiptap/extension-text';
import { Editor } from '@tiptap/core';
import Heading from '@tiptap/extension-heading';
import Bold from '@tiptap/extension-bold';
import Italic from '@tiptap/extension-italic';
import Link from '@tiptap/extension-link';
import ListItem from '@tiptap/extension-list-item';
import OrderedList from '@tiptap/extension-ordered-list';
import BulletList from '@tiptap/extension-bullet-list';
import History from '@tiptap/extension-history';
import HardBreak from '@tiptap/extension-hard-break';
import Image from '@tiptap/extension-image';
import Dropcursor from '@tiptap/extension-dropcursor'


import { generateHTML } from '@tiptap/html';
import { DirectUpload } from '@rails/activestorage';

export default class extends Controller {
  static targets = ['editor', 'linkField', 'linkWrapper', 'textInput'];

  connect() {
    const textInput = this.textInputTarget;
    const previewInput = document.getElementById(
      this.element.dataset.previewId
    );

    const richExtensions = [
      Document,
      Paragraph,
      HardBreak,
      Text,
      Bold,
      Italic,
      Link,
      Image,
      OrderedList,
      Dropcursor,
      ListItem,
      BulletList,
      History.configure({
        depth: 10,
      }),
      Heading.configure({
        levels: [1, 2, 3],
      }),
    ];

    const plainExtensions = [Document, Paragraph, Text, HardBreak];

    const extensions = this.element.dataset.plain
      ? plainExtensions
      : richExtensions;

    if (this.hasEditorTarget) {
      this.editor = new Editor({
        element: this.editorTarget,
        extensions: extensions,
        editorProps: {
          handleDrop: this.handleDrop.bind(this)
        },
        // all your other extensions
        onBeforeCreate({ editor }) {
          // Before the view is created.
        },
        onCreate({ editor }) {
          // The editor is ready.
          editor.commands.insertContent(textInput.value);
        },
        onUpdate({ editor }) {
          // The content has changed.
          const html = generateHTML(editor.state.toJSON().doc, [
            Document,
            Paragraph,
            Text,
            Bold,
            Italic,
            HardBreak,
            Link,
            Image,
            OrderedList,
            ListItem,
            BulletList,
            History.configure({
              depth: 10,
            }),
            Heading.configure({
              levels: [1, 2, 3],
            }),
          ]);

          textInput.value = html;
          if (previewInput) {
            previewInput.innerHTML = html;

            const event = new CustomEvent('simple_editor:preview_changed', {
              detail: { html },
            });
            previewInput.dispatchEvent(event);
          }
        },
        onSelectionUpdate({ editor }) {
          // The selection has changed.
        },
        onTransaction({ editor, transaction }) {
          // The editor state has changed.
        },
        onFocus({ editor, e }) {},
        onBlur({ editor, event }) {
          // The editor isn’t focused anymore.
        },
        onDestroy() {
          // The editor is being destroyed.
        },
      });

      //this.editor.insertContent(textInput.value)
      //this.editor.commands.setContent(this.textInputTarget.value)
      window.ed = this.editor;

      document.addEventListener(
        'simple_editor:assign_content',
        this.handleAssignContent.bind(this)
      );
    }
  }

  handleAssignContent(e) {
    if (e.detail.targetId === this.textInputTarget.id) {
      this.assignContent(e.detail.content);
    }
  }

  assignContent(content) {
    this.editor.commands.clearContent();
    this.editor.commands.insertContent(content);
  }

  toggleBold(e) {
    e.preventDefault();
    this.editor.commands.toggleBold();
  }

  toggleItalic(e) {
    e.preventDefault();
    this.editor.commands.toggleItalic();
  }

  toggleHeading(e) {
    e.preventDefault();
    this.editor.commands.toggleHeading({
      level: parseInt(e.currentTarget.dataset.level),
    });
  }

  toggleOrderedList(e) {
    e.preventDefault();
    this.editor.commands.toggleOrderedList();
  }

  toggleBulletList(e) {
    e.preventDefault();
    this.editor.commands.toggleBulletList();
  }

  insert(e) {
    e.preventDefault();
    this.editor.commands.insertContent(e.currentTarget.dataset.value);
  }

  insertTextField(e) {
    e.preventDefault();
    this.textInputTarget.value = `${this.textInputTarget.value}${e.currentTarget.dataset.value}`;

    // Create and dispatch the 'input' event
    const inputEvent = new Event('input', {
      bubbles: true,
      cancelable: true,
    });

    this.textInputTarget.dispatchEvent(inputEvent);
  }

  setLink(e) {
    e.preventDefault();
    this.editor.commands.toggleLink({
      href: this.linkFieldTarget.value,
      target: '_blank',
    });
  }

  toggleLink(e) {
    e.preventDefault();
    this.editor.commands.toggleLink({
      href: this.linkFieldTarget.value,
      target: '_blank',
    });
  }

  openLinkPrompt(e) {
    e.preventDefault();
    this.linkWrapperTarget.classList.toggle('hidden');
  }

  uploadImage(e) {
    e.preventDefault();
    const input = document.createElement('input');
    input.type = 'file';
    input.accept = 'image/*';
    input.onchange = () => {
      const file = input.files[0];
      this.uploadHandler(file, this.insertImage.bind(this));
    };
    input.click();
  }

  uploadHandler(file, imageBlock) {
    const url = '/api/v1/direct_uploads';
    const upload = new DirectUpload(file, url);
    upload.create((error, blob) => {
      if (error) {
        console.error('Upload failed:', error);
      } else {
        imageBlock(blob);
      }
    });
  }

  insertImage(blob) {
    const imageUrl = `/rails/active_storage/blobs/${blob.signed_id}/${blob.filename}`;
    this.editor.chain().focus().setImage({ src: imageUrl }).run();
  }

  handleDrop(view, event, slice, moved) {
    if (!moved && event.dataTransfer && event.dataTransfer.files && event.dataTransfer.files[0]) {
      let file = event.dataTransfer.files[0];
      let filesize = ((file.size/1024)/1024).toFixed(4); // filesize in MB
      if ((file.type === "image/jpeg" || file.type === "image/png") && filesize < 10) {
        let _URL = window.URL || window.webkitURL;
        let img = new window.Image();
        img.src = _URL.createObjectURL(file);
        img.onload = () => {
          if (img.width > 5000 || img.height > 5000) {
            alert("Your images need to be less than 5000 pixels in height and width.");
          } else {
            debugger
            this.uploadHandler(file, this.insertImage.bind(this));
          }
        };
      } else {
        alert("Images need to be in jpg or png format and less than 10mb in size.");
      }
      return true; // handled
    }
    return false; // not handled, use default behaviour
  }

  disconnect() {
    this.editor && this.editor.cleanup && this.editor.cleanup();
    document.removeEventListener('simple_editor:assign_content', this.handleAssignContent);
  }
}
