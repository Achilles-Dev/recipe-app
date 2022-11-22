import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ["show", "unhide", "showconf", "unhideconf"];

  initialize() {
    this.imageIcon =  this.passValue.firstChild;
    this.passImageIcon = this.passConfValue.firstChild;
  }
  password() {

    if (this.passValue.firstChild.nodeName === 'IMG') {
      this.passValue.textContent = "hide";
      this.passInput.type = "text";
    } else {
      this.passValue.textContent = '';
      this.passValue.appendChild(this.imageIcon);
      this.passInput.type = "password";
    }
  }

  password_confirmation() {
    if (this.passConfValue.firstChild.nodeName === 'IMG') {
      this.passConfValue.textContent = "hide";
      this.passConfInput.type = "text";
    } else {
      this.passConfValue.textContent = '';
      this.passConfValue.appendChild(this.passImageIcon);
      this.passConfInput.type = "password";
    }
  }

  get passValue() {
    return this.showTarget;
  }
  get passInput() {
    return this.unhideTarget;
  }

  get passConfValue() {
    return this.showconfTarget
  }

  get passConfInput() {
    return this.unhideconfTarget;
  }
}