import "./index.css"

import { Controller } from "@hotwired/stimulus"
import { computePosition, autoUpdate, flip, shift, offset, arrow } from '@floating-ui/dom'

export default class extends Controller {
  static targets = ["trigger", "content", "arrow"]
  static values = { 
    delay: Number,
    placement: String
  }

  connect() {
    this.showTooltipBound = this.showTooltip.bind(this)
    this.hideTooltipBound = this.hideTooltip.bind(this)

    this.triggerTarget.addEventListener("mouseenter", this.showTooltipBound)
    this.triggerTarget.addEventListener("mouseleave", this.hideTooltipBound)
    this.triggerTarget.addEventListener("focus", this.showTooltipBound)
    this.triggerTarget.addEventListener("blur", this.hideTooltipBound)

    this.cleanup = autoUpdate(
      this.triggerTarget,
      this.contentTarget,
      this.updatePosition.bind(this)
    )
  }

  disconnect() {
    this.triggerTarget.removeEventListener("mouseenter", this.showTooltipBound)
    this.triggerTarget.removeEventListener("mouseleave", this.hideTooltipBound)
    this.triggerTarget.removeEventListener("focus", this.showTooltipBound)
    this.triggerTarget.removeEventListener("blur", this.hideTooltipBound)

    if (this.cleanup) {
      this.cleanup()
    }
  }

  showTooltip() {
    clearTimeout(this.hideTimeout)
    this.showTimeout = setTimeout(() => {
      this.contentTarget.classList.remove("hidden")
      this.updatePosition()
    }, this.delayValue)
  }

  hideTooltip() {
    clearTimeout(this.showTimeout)
    this.hideTimeout = setTimeout(() => {
      this.contentTarget.classList.add("hidden")
    }, 40)
  }

  updatePosition() {
    computePosition(this.triggerTarget, this.contentTarget, {
      placement: this.placementValue,
      middleware: [
        offset(6),
        flip(),
        shift({ padding: 5 }),
        arrow({ element: this.arrowTarget }),
      ],
    }).then(({ x, y, placement, middlewareData }) => {
      Object.assign(this.contentTarget.style, {
        left: `${x}px`,
        top: `${y}px`,
      })

      const { x: arrowX, y: arrowY } = middlewareData.arrow

      const staticSide = {
        top: 'bottom',
        right: 'left',
        bottom: 'top',
        left: 'right',
      }[placement.split('-')[0]]

      Object.assign(this.arrowTarget.style, {
        left: arrowX != null ? `${arrowX}px` : '',
        top: arrowY != null ? `${arrowY}px` : '',
        right: '',
        bottom: '',
        [staticSide]: '-4px',
      })
    })
  }
}