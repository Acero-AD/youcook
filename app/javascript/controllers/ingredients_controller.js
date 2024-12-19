import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "list"]

  connect() {
    if (this.listTarget.children.length === 0) {
      this.addIngredient()
    }
  }

  addIngredient() {
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime().toString())
    this.listTarget.insertAdjacentHTML('beforeend', content)
    this.updateRemoveButtons()
  }

  removeIngredient(event) {
    event.preventDefault()
    const item = event.target.closest('.ingredient-item')
    item.remove()
    this.updateRemoveButtons()
  }

  updateRemoveButtons() {
    const removeButtons = this.listTarget.querySelectorAll('.remove-ingredient')
    removeButtons.forEach(button => {
      button.style.display = removeButtons.length > 1 ? 'block' : 'none'
    })
  }
}