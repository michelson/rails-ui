import "./index.css"

// app/javascript/controllers/ui-collapsible-controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]
  static values = {
    open: Boolean
  }

  connect() {
    this.updateVisibility()
  }

  toggle() {
    this.openValue = !this.openValue
  }

  openValueChanged() {
    this.updateVisibility()
  }

  updateVisibility() {
    if (this.openValue) {
      this.contentTarget.classList.remove("hidden")
    } else {
      this.contentTarget.classList.add("hidden")
    }
  }
}