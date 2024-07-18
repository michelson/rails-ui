import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item", "content"]

  toggle(event) {
    const clickedItem = event.currentTarget.closest('[data-ui-accordion-target="item"]')
    const clickedIndex = this.itemTargets.indexOf(clickedItem)

    this.itemTargets.forEach((item, index) => {
      if (index === clickedIndex) {
        this.toggleItem(item)
      } else {
        this.closeItem(item)
      }
    })
  }

  toggleItem(item) {
    const isOpen = item.dataset.uiAccordionOpenValue === 'true'
    if (isOpen) {
      this.closeItem(item)
    } else {
      this.openItem(item)
    }
  }

  openItem(item) {
    const content = item.querySelector('[data-ui-accordion-target="content"]')
    const button = item.querySelector('button')

    item.dataset.uiAccordionOpenValue = 'true'
    content.dataset.uiAccordionOpenValue = 'true'
    content.removeAttribute('hidden')
    button.setAttribute('aria-expanded', 'true')
  }

  closeItem(item) {
    const content = item.querySelector('[data-ui-accordion-target="content"]')
    const button = item.querySelector('button')

    item.dataset.uiAccordionOpenValue = 'false'
    content.dataset.uiAccordionOpenValue = 'false'
    content.setAttribute('hidden', '')
    button.setAttribute('aria-expanded', 'false')
  }
}