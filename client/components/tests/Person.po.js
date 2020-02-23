export default class PersonPageObject {
  constructor (wrapper) {
    this.wrapper = wrapper;
  }

  get name () {
    return this.wrapper.find('.person__name').text();
  }

  get title () {
    return this.wrapper.find('.person__title').text();
  }

  get email () {
    return this.wrapper.find('.person__email').text();
  }
}

