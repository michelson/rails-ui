// app/javascript/controllers/ui_resizable_controller.js
import { Controller } from "@hotwired/stimulus"
import interact from "interactjs"

export default class extends Controller {
  static values = {
    direction: String,
    panels: Array
  }

  connect() {
    this.initializeResizable()
  }

  initializeResizable() {
    const isHorizontal = this.directionValue === "horizontal"
    const handles = this.element.querySelectorAll('[data-panel-resize-handle-enabled="true"]')

    handles.forEach((handle, index) => {
      interact(handle).draggable({
        axis: isHorizontal ? "x" : "y",
        listeners: {
          move: (event) => {
            const prevPanel = this.element.querySelector(`[data-panel-id="${this.element.id}-panel-${index}"]`)
            const nextPanel = this.element.querySelector(`[data-panel-id="${this.element.id}-panel-${index + 1}"]`)
            
            const prevSize = parseFloat(prevPanel.dataset.panelSize)
            const nextSize = parseFloat(nextPanel.dataset.panelSize)
            
            const totalSize = prevSize + nextSize
            const delta = isHorizontal ? 
              (event.dx / this.element.offsetWidth) * totalSize :
              (event.dy / this.element.offsetHeight) * totalSize
            
            const newPrevSize = Math.max(10, Math.min(90, prevSize + delta))
            const newNextSize = totalSize - newPrevSize
            
            prevPanel.style.flex = `${newPrevSize} 1 0%`
            nextPanel.style.flex = `${newNextSize} 1 0%`
            prevPanel.dataset.panelSize = newPrevSize.toString()
            nextPanel.dataset.panelSize = newNextSize.toString()

            // Update aria values
            handle.setAttribute('aria-valuenow', newPrevSize.toFixed(0))
            handle.setAttribute('aria-valuemax', '90')
            handle.setAttribute('aria-valuemin', '10')
          }
        }
      })
    })
  }
}