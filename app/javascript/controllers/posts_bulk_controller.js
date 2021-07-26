import CheckboxSelectAll from "stimulus-checkbox-select-all"

export default class extends CheckboxSelectAll {
  destroy(event) {
    event.preventDefault()
    console.log(this.checked)
  }
}
