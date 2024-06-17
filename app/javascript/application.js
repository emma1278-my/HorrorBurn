// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "chartkick/chart.js"
import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="autocomplete"
export default class extends Controller {
  static targets = ["input"]
  connect() {
    new Autocomplete(this.inputTarget, {
      source: this.sourceValue,
      onSelect: (item) => {
        this.inputTarget.value = item
      },
    })
  }

  get sourceValue() {
    return this.data.get("source")
  }
}


document.addEventListener('DOMContentLoaded', () => {
  const file_button = document.querySelector('#avator-input');
  const preview_img = document.querySelector('#preview');

  file_button.addEventListener('change', (e) => {
    let file = e.target.files;
    let reader = new FileReader() ;
    reader.readAsDataURL(file[0])
    reader.onload = function() {
      preview_img.src = reader.result;
    }
    },false);
});