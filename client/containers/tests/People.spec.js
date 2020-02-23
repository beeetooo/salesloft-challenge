import { mount } from '@vue/test-utils';
import flushPromises from 'flush-promises';
import AxiosMockAdapter from 'axios-mock-adapter';
import axios from 'axios';

import People from '../People.vue';
import PersonPageObject from '../../components/tests/Person.po';

class PeoplePageObject {
  constructor(wrapper) {
    this.wrapper = wrapper;
  }

  get people () {
    return this.wrapper.findAll('.person').wrappers.map(wrapper => {
      return new PersonPageObject(wrapper);
    })
  }
}

describe('People', () => {
  let mocker;

  const mountPeople = () => {
    const wrapper = mount(People);
    return new PeoplePageObject(wrapper);
  };

  beforeEach(() => {
    mocker = new AxiosMockAdapter(axios);
  })

  it('should fetch people and render person cards', async () => {
    mocker
      .onGet('http://localhost:5000/people?page=1&per_page=6')
      .reply(200, {
        results: [{
          name: 'Alberto Romero',
          title: 'Software Engineer',
          email: 'aromeronavia@gmail.com'
        }, {
          name: 'Steve Vai',
          title: 'Guitarrist (the best)',
          email: 'steve@vai.io'
        }]
      });

    const component = mountPeople();

    await flushPromises();

    expect(component.people[0].name).toEqual('Alberto Romero');
    expect(component.people[0].title).toEqual('Software Engineer');
    expect(component.people[0].email).toEqual('aromeronavia@gmail.com');

    expect(component.people[1].name).toEqual('Steve Vai');
    expect(component.people[1].title).toEqual('Guitarrist (the best)');
    expect(component.people[1].email).toEqual('steve@vai.io');
  });
});
