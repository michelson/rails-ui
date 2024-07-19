import "./index.css"

// app/javascript/controllers/ui_toast_controller.js
import { Controller } from "@hotwired/stimulus"
import { enter, leave } from 'el-transition'

export default class extends Controller {
  static targets = ["container", "item"]
  static values = {
    theme: String,
    positionY: String,
    positionX: String
  }

  connect() {
    this.setupCustomEvent()
    this.setupTurboStreamListener()
  }

  setupCustomEvent() {
    document.addEventListener('ui:toast', this.handleCustomToast.bind(this))
  }

  setupTurboStreamListener() {
    document.addEventListener('turbo:before-stream-render', (event) => {
      const turboStream = event.target
      if (turboStream.action === 'append' && turboStream.target === 'toasts') {
        event.preventDefault()
        this.appendToast(turboStream.templateContent.querySelector('li'))
      }
    })
  }

  handleCustomToast(event) {
    const { title, content, type } = event.detail
    this.appendToast(this.createToastElement(title, content, type))
  }

  createToastElement(title, content, type) {
    const toast = document.createElement('li')
    toast.innerHTML = `
      <div data-content="">
        <div data-title="">${title}</div>
        <div>${content}</div>
      </div>
    `
    toast.className = "mb-2 p-4 rounded-md shadow-md transition-all duration-300 transform translate-y-full opacity-0-"
    // this.itemTargets[0].className
    toast.dataset.uiToastTarget = "item"
    toast.dataset.action = "click->ui-toast#dismiss"
    return toast
  }

  appendToast(toastElement) {
    this.containerTarget.appendChild(toastElement)
    enter(toastElement)
    // setTimeout(() => this.dismiss({ target: toastElement }), 5000)
  }

  dismiss(event) {
    const toast = event.target.closest('[data-ui-toast-target="item"]')
    leave(toast).then(() => {
      toast.remove()
    })
  }
}