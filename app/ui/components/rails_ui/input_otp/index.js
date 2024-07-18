// app/javascript/controllers/ui_input_otp_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "digit"]
  static values = {
    groups: Array
  }

  connect() {
    this.inputTarget.addEventListener('input', this.handleInput.bind(this))
    this.inputTarget.addEventListener('keydown', this.handleKeydown.bind(this))
    this.inputTarget.addEventListener('focus', this.handleFocus.bind(this))
    this.inputTarget.addEventListener('blur', this.handleBlur.bind(this))
  }

  handleInput(event) {
    const input = event.target
    const value = input.value.replace(/\D/g, '').slice(0, this.totalDigits)
    input.value = value
    this.updateDigits(value)
    this.focusDigit(value.length)
  }

  handleKeydown(event) {
    if (event.key === 'Backspace' && event.target.value === '') {
      this.focusPreviousInput()
    }
  }

  handleFocus() {
    this.element.classList.add('focused')
    this.focusDigit(this.inputTarget.value.length)
  }

  handleBlur() {
    this.element.classList.remove('focused')
    this.digitTargets.forEach(digit => {
      digit.classList.remove('ring-2', 'ring-ring', 'ring-offset-background')
    })
  }

  updateDigits(value) {
    this.digitTargets.forEach((digit, index) => {
      digit.textContent = value[index] || ''
      digit.classList.toggle('filled', !!value[index])
    })
  }

  focusDigit(index) {
    this.digitTargets.forEach((digit, i) => {
      if (i === index) {
        digit.classList.add('ring-2', 'ring-ring', 'ring-offset-background')
      } else {
        digit.classList.remove('ring-2', 'ring-ring', 'ring-offset-background')
      }
    })
  }

  focusPreviousInput() {
    const currentValue = this.inputTarget.value
    if (currentValue.length > 0) {
      this.inputTarget.value = currentValue.slice(0, -1)
      this.updateDigits(this.inputTarget.value)
      this.focusDigit(this.inputTarget.value.length)
    }
  }

  get totalDigits() {
    return this.groupsValue.reduce((sum, group) => sum + group, 0)
  }
}