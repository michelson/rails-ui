import "./index.css"

import { Controller } from "@hotwired/stimulus";
import Markdoc from "@markdoc/markdoc";

export default class extends Controller {
  static targets = ["content"];

  connect() {
    this.renderMarkdoc();
  }

  renderMarkdoc() {
    // Get the content from the div
    const source = this.contentTarget.textContent.trim();

    const escapedSource = source.replace(/</g, "&lt;").replace(/>/g, "&gt;");
    // Parse the source using Markdoc
    const ast = Markdoc.parse(escapedSource);

    // Transform the AST using an optional config (e.g., custom components, tags, etc.)
    const content = Markdoc.transform(ast, {});

    // Render HTML from the transformed content
    const html = Markdoc.renderers.html(content);

    // Set the rendered HTML back into the div
    this.contentTarget.innerHTML = html;
  }
}