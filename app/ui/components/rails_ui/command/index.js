// app/javascript/controllers/ui_command_controller.js
import { Controller } from "@hotwired/stimulus"
import { useHotkeys } from 'stimulus-use/hotkeys'

export default class extends Controller {
  static targets = ["input", "list", "item"]
  static values = {
    hotkeys: Object
  }

  connect() {
    useHotkeys(this, {
      ...this.hotkeysValue,
      'ArrowUp': (event) => this.navigateItems(event, -1),
      'ArrowDown': (event) => this.navigateItems(event, 1),
      'Enter': (event) => this.selectItem(event)
    })
    
    this.currentIndex = -1
  }

  navigateItems(event, direction) {
    event.preventDefault()
    this.currentIndex += direction
    if (this.currentIndex < 0) this.currentIndex = this.itemTargets.length - 1
    if (this.currentIndex >= this.itemTargets.length) this.currentIndex = 0
    this.highlightItem()
  }

  highlightItem() {
    this.itemTargets.forEach((item, index) => {
      if (index === this.currentIndex) {
        item.setAttribute('aria-selected', 'true')
        item.scrollIntoView({ block: 'nearest' })
      } else {
        item.setAttribute('aria-selected', 'false')
      }
    })
  }

  selectItem(event) {
    event.preventDefault()
    const selectedItem = this.itemTargets[this.currentIndex]
    if (selectedItem) {
      console.log('Selected:', selectedItem.dataset.value)
      // Implement your selection logic here
    }
  }

  search() {
    const query = this.inputTarget.value.toLowerCase()
    this.itemTargets.forEach(item => {
      const matches = item.textContent.toLowerCase().includes(query)
      item.style.display = matches ? '' : 'none'
    })
  }
}
