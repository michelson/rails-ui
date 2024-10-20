
// Add a Stimulus controller for this component.
// It will automatically registered and its name will be available
// via #component_name in the component class.
//
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"];

  connect() {
    this.step = parseFloat(this.inputTarget.getAttribute("step")) || 1;
  }

  up() {
    this.changeValue(this.step);
  }

  down() {
    this.changeValue(-this.step);
  }

  changeValue(delta) {
    const currentValue = parseFloat(this.inputTarget.value) || 0;
    this.inputTarget.value = currentValue + delta;
  }
}