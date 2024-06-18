import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  search() {
    const query = this.inputTarget.value
    if (query.length < 3) {
      this.resultsTarget.innerHTML = ""
      return
    }

    fetch(`/movies/autocomplete?looking_for=${query}`)
      .then(response => response.json())
      .then(data => {
        this.resultsTarget.innerHTML = data.map(movie => `<div>${movie.title}</div>`).join("")
      })
  }
}