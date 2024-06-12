// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "chartkick/chart.js"
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  search(event) {
    const query = event.target.value.trim()
    if (query.length > 0) {
      fetch(`/movies/autocomplete?looking_for=${encodeURIComponent(query)}`)
        .then(response => response.json())
        .then(data => {
          this.renderResults(data)
        })
    } else {
      this.resultsTarget.innerHTML = ""
    }
  }

  renderResults(results) {
    const html = results.map(result => `
      <div class="result" data-action="click->autocomplete#selectResult">
        ${result.title}
      </div>
    `).join('')

    this.resultsTarget.innerHTML = html
  }

  selectResult(event) {
    this.inputTarget.value = event.currentTarget.innerText
    this.resultsTarget.innerHTML = ""
  }
}


document.addEventListener('DOMContentLoaded', function() {
  const avatarInput = document.getElementById('avator-input');
  const previewImage = document.getElementById('preview');

  avatarInput.addEventListener('change', function(event) {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function(e) {
        previewImage.src = e.target.result;
      }
      reader.readAsDataURL(file);
    } else {
      previewImage.src = '/path/to/default/sample.jpg';
    }
  });
});