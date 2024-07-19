import "./index.css"

// app/javascript/controllers/ui-sheet-controller.js
import { Controller } from "@hotwired/stimulus"
import { useTransition } from "stimulus-use"

export default class extends Controller {
  static targets = ["overlay", "content"]

  connect() {
    useTransition(this, {
      element: this.contentTarget,
      enterActive: 'transition ease-out duration-300',
      enterFrom: this.getEnterFromClass(),
      enterTo: this.getEnterToClass(),
      leaveActive: 'transition ease-in duration-200',
      leaveFrom: this.getEnterToClass(),
      leaveTo: this.getEnterFromClass(),
    })
  }

  open() {
    this.overlayTarget.classList.remove('hidden')
    this.contentTarget.classList.remove('hidden')
    this.enter()
  }

  close() {
    this.leave()
    setTimeout(() => {
      this.overlayTarget.classList.add('hidden')
      this.contentTarget.classList.add('hidden')
    }, 200) // Match this with the transition duration
  }

  clickOutside(event) {
    if (!this.contentTarget.contains(event.target)) {
      this.close()
    }
  }

  
  getEnterFromClass() {
    const side = this.contentTarget.dataset.side
    switch (side) {
      case 'top': return '-translate-y-full'
      case 'right': return 'translate-x-full'
      case 'bottom': return 'translate-y-full'
      case 'left': return '-translate-x-full'
      default: return 'translate-x-full'
    }
  }

  getEnterToClass() {
    return 'translate-y-0 translate-x-0'
  }
}