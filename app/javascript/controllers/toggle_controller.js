import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ["show", "unhide"];

  initialize() {
    this.imageIcon =  this.value.firstChild;
  }
  password() {

    if (this.value.firstChild.nodeName === 'IMG') {
      this.value.textContent = "hide";
      this.input.type = "text";
    } else {
      this.value.textContent = '';
      this.value.appendChild(this.imageIcon);
      this.input.type = "password";
    }
  }

  get value() {
    return this.showTarget;
  }
  get input() {
    return this.unhideTarget;
  }
}