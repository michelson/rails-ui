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
    var doc = new DOMParser().parseFromString(this.contentTarget.innerHTML, "text/html");
    const source = doc.documentElement.textContent;

    console.log(source)
    //const escapedSource = source.replace(/</g, "&lt;").replace(/>/g, "&gt;");
    // Parse the source using Markdoc
    const ast = Markdoc.parse(source);

    // Transform the AST using an optional config (e.g., custom components, tags, etc.)
    const content = Markdoc.transform(ast, {});

    // Render HTML from the transformed content
    const html = Markdoc.renderers.html(content);

    console.log(html)

    // Set the rendered HTML back into the div
    this.contentTarget.innerHTML = html;
  }
}