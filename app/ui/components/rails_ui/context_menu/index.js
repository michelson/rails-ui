// app/javascript/controllers/ui-context-menu-controller.js
import { Controller } from "@hotwired/stimulus"
import { computePosition, flip, shift, offset } from '@floating-ui/dom'

export default class extends Controller {
  static targets = ["menu", "submenuTrigger", "submenu"]
  static values = {
    side: String,
    align: String
  }

  connect() {
    this.element.addEventListener("contextmenu", this.showMenu.bind(this))
    document.addEventListener("click", this.hideMenu.bind(this))
  }

  disconnect() {
    this.element.removeEventListener("contextmenu", this.showMenu.bind(this))
    document.removeEventListener("click", this.hideMenu.bind(this))
  }

  showMenu(event) {
    event.preventDefault()
    this.menuTarget.classList.remove("hidden")
    this.menuTarget.dataset.state = "open"
    
    computePosition(
      { x: event.clientX, y: event.clientY },
      this.menuTarget,
      {
        placement: `${this.sideValue}-${this.alignValue}`,
        middleware: [
          offset(5),
          flip(),
          shift({padding: 5})
        ]
      }
    ).then(({x, y}) => {
      Object.assign(this.menuTarget.style, {
        left: `${x}px`,
        top: `${y}px`,
      });
    });
  }

  hideMenu(event) {
    if (!this.menuTarget.contains(event.target)) {
      this.menuTarget.dataset.state = "closed"
      setTimeout(() => {
        this.menuTarget.classList.add("hidden")
      }, 200)
    }
  }

  showSubmenu(event) {
    const submenu = event.currentTarget.querySelector('[data-ui-context-menu-target="submenu"]')
    if (submenu) {
      submenu.classList.remove("hidden")
      computePosition(event.currentTarget, submenu, {
        placement: 'right-start',
        middleware: [
          offset(5),
          flip(),
          shift({padding: 5})
        ]
      }).then(({x, y}) => {
        Object.assign(submenu.style, {
          left: `${x}px`,
          top: `${y}px`,
        });
      });
    }
  }

  hideSubmenu(event) {
    const submenu = event.currentTarget.querySelector('[data-ui-context-menu-target="submenu"]')
    if (submenu) {
      submenu.classList.add("hidden")
    }
  }
}