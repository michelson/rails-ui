import { Controller } from "@hotwired/stimulus"
import { computePosition, flip, shift, offset } from '@floating-ui/dom'

export default class extends Controller {
  static targets = ["trigger", "menu"]
  static classes = ["active"]

  connect() {
    this.closeMenu = this.closeMenu.bind(this)
  }

  toggle() {
    if (this.menuTarget.classList.contains(this.activeClass)) {
      this.closeMenu()
    } else {
      this.openMenu()
    }
  }

  openMenu() {
    this.menuTarget.classList.add(this.activeClass)
    this.menuTarget.removeAttribute("hidden")
    document.addEventListener("click", this.closeMenu)

    this.updatePosition()
  }

  closeMenu(event) {
    if (!event || !this.element.contains(event.target)) {
      this.menuTarget.classList.remove(this.activeClass)
      this.menuTarget.setAttribute("hidden", "")
      document.removeEventListener("click", this.closeMenu)
    }
  }

  updatePosition() {
    computePosition(this.triggerTarget, this.menuTarget, {
      placement: 'bottom-start',
      middleware: [
        offset(6),
        flip(),
        shift({padding: 5})
      ]
    }).then(({x, y}) => {
      Object.assign(this.menuTarget.style, {
        left: `${x}px`,
        top: `${y}px`,
      })
    })
  }
}