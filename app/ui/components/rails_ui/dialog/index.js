// app/javascript/controllers/ui_alert_dialog_controller.js
import { Controller } from "@hotwired/stimulus"
import { useClickOutside } from 'stimulus-use'

export default class extends Controller {
  static targets = ["overlay", "content"]
  static values = {
    closeOnClickOutside: Boolean
  }

  connect() {
    if (this.closeOnClickOutsideValue) {
      useClickOutside(this, { element: this.contentTarget })
    }
  }

  open() {
    this.overlayTarget.style.display = "block"
    this.contentTarget.style.display = "block"
    setTimeout(() => {
      this.overlayTarget.dataset.uiDialogState = "open"
      this.contentTarget.dataset.uiDialogState = "open"
    }, 10) // Small delay to ensure the display change has taken effect
  }

  close() {
    this.overlayTarget.dataset.uiDialogState = "closed"
    this.contentTarget.dataset.uiDialogState = "closed"
    setTimeout(() => {
      this.overlayTarget.style.display = "none"
      this.contentTarget.style.display = "none"
    }, 30) // Adjust this timeout to match your animation duration
  }

  cancel(event) {
    event.preventDefault()
    this.close()
  }

  clickOutside(event) {
    if (this.closeOnClickOutsideValue) {
      this.close()
    }
  }
}