import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "counter", "charactersLeft"];

  connect() {
    this.updateCharacterCount();
  }

  updateCharacterCount() {
    const currentLength = this.inputTarget.value.length;
    const maxLength = this.inputTarget.maxLength;
    if(this.hasCounterTarget)
      this.counterTarget.textContent = `${currentLength}/${maxLength}`;
    
    const charactersLeft = maxLength - currentLength;
    if(this.hasCharactersLeftTarget)
      this.charactersLeftTarget.textContent = charactersLeft
  }

  onInput() {
    this.updateCharacterCount();
  }
}