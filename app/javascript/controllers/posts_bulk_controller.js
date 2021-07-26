import CheckboxSelectAll from "stimulus-checkbox-select-all"

export default class extends CheckboxSelectAll {
  execute(event) {
    event.preventDefault()
    const method = event.target.dataset.methodTarget
    let data = new FormData()

    if (this.checked.length === this.checkboxTargets.length) {
      data.append('all', true)
    } else {
      this.checked.forEach((checkbox) => data.append("ids[]", checkbox.value))
    }
    Rails.ajax({
      url: '/posts/bulk/' + method,
      type: "POST",
      data: data
    })
  }
}
