// app/javascript/controllers/ui_popover_controller.js
import { Controller } from "@hotwired/stimulus"
import { computePosition, flip, shift, offset, arrow } from '@floating-ui/dom'

export default class extends Controller {
  static targets = ["trigger", "contentTemplate", "arrow"]
  static values = {
    placement: String,
    offset: Number,
    arrow: Boolean,
    triggerType: String
  }

  connect() {
    this.visible = false
    this.clickOutsideHandler = this.clickOutside.bind(this)
    
    if (this.triggerTypeValue === 'hover') {
      this.triggerTarget.addEventListener('mouseenter', this.show.bind(this))
      this.triggerTarget.addEventListener('mouseleave', this.hide.bind(this))
    }
  }

  disconnect() {
    document.removeEventListener('click', this.clickOutsideHandler)
    if (this.triggerTypeValue === 'hover') {
      this.triggerTarget.removeEventListener('mouseenter', this.show.bind(this))
      this.triggerTarget.removeEventListener('mouseleave', this.hide.bind(this))
    }
    if (this.popoverContent) {
      document.body.removeChild(this.popoverContent)
    }
  }

  toggle(event) {
    event.stopPropagation()
    this.visible ? this.hide() : this.show()
  }

  show() {
    if (!this.popoverContent) {
      this.popoverContent = this.contentTemplateTarget.content.firstElementChild.cloneNode(true)
      document.body.appendChild(this.popoverContent)
    }
    this.popoverContent.style.display = 'block'
    this.popoverContent.style.visibility = 'hidden' // Hide content while positioning
    
    // Use setTimeout to ensure content is rendered before positioning
    setTimeout(() => {
      this.positionPopover()
      this.popoverContent.style.visibility = 'visible' // Show content after positioning
    }, 0)

    this.visible = true
    if (this.triggerTypeValue === 'click') {
      document.addEventListener('click', this.clickOutsideHandler)
    }
  }

  hide() {
    if (this.popoverContent) {
      this.popoverContent.style.display = 'none'
    }
    this.visible = false
    if (this.triggerTypeValue === 'click') {
      document.removeEventListener('click', this.clickOutsideHandler)
    }
  }

  clickOutside(event) {
    if (!this.element.contains(event.target) && !this.popoverContent.contains(event.target)) {
      this.hide()
    }
  }

  positionPopover() {
    const middleware = [
      offset(this.offsetValue),
      flip(),
      shift({padding: 5}),
    ]

    if (this.arrowValue) {
      const arrowElement = this.popoverContent.querySelector('[data-ui-popover-target="arrow"]')
      if (arrowElement) {
        middleware.push(arrow({ element: arrowElement }))
      }
    }

    computePosition(this.triggerTarget, this.popoverContent, {
      placement: this.placementValue,
      middleware: middleware,
    }).then(({x, y, placement, middlewareData}) => {
      Object.assign(this.popoverContent.style, {
        position: 'absolute',
        left: `${x}px`,
        top: `${y}px`,
        zIndex: 1000,
      })

      
      if (this.arrowValue) {
        const arrowElement = this.popoverContent.querySelector('[data-ui-popover-target="arrow"]')
        if (arrowElement) {
          const {x: arrowX, y: arrowY} = middlewareData.arrow

          const staticSide = {
            top: 'bottom',
            right: 'left',
            bottom: 'top',
            left: 'right',
          }[placement.split('-')[0]]

          Object.assign(arrowElement.style, {
            left: arrowX != null ? `${arrowX}px` : '',
            top: arrowY != null ? `${arrowY}px` : '',
            right: '',
            bottom: '',
            [staticSide]: '-4px',
          })
        }
      }
    })
  }
}