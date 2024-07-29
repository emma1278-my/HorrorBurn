import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input", "results" ]

  connect() {
    this.resultsTarget.hidden = true
  }

  search() {
    const query = this.inputTarget.value

    if (query.length < 2) {
      this.resultsTarget.hidden = true
      return
    }

    fetch(`/movies/autocomplete?query=${encodeURIComponent(query)}`)
      .then(response => response.json())
      .then(data => {
        this.resultsTarget.innerHTML = this.movieList(data)
        this.resultsTarget.hidden = false
      })
  }

  movieList(movies) {
    return movies.map(movie => `<li data-action="click->autocomplete#select">${movie.title}</li>`).join("")
  }

  select(event) {
    this.inputTarget.value = event.target.textContent
    this.resultsTarget.hidden = true
  }
}