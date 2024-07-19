import "./index.css"

// app/javascript/controllers/ui-toggle-controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]
  static values = {
    pressed: Boolean
  }

  connect() {
    this.updatePressed()
  }

  toggle() {
    this.pressedValue = !this.pressedValue
    this.updatePressed()
  }

  updatePressed() {
    this.buttonTarget.setAttribute("aria-pressed", this.pressedValue)
    this.buttonTarget.dataset.state = this.pressedValue ? "on" : "off"
  }
}