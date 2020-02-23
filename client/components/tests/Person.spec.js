import { shallowMount } from '@vue/test-utils';

import Person from '../Person.vue';
import PersonPageObject from './Person.po';

describe('Person', () => {
  const mountComponent = () => {
    const wrapper = shallowMount(Person, {
      propsData: {
        name: 'Juan Pablo',
        title: 'Software Engineer',
        email: 'juanpablo@gmail.com'
      }
    });

    return new PersonPageObject(wrapper);
  };

  it('should render a person correctly', () => {
    const person = mountComponent();

    expect(person.name).toEqual('Juan Pablo');
    expect(person.title).toEqual('Software Engineer');
    expect(person.email).toEqual('juanpablo@gmail.com');
  });

  it('should match a snapshot', () => {
    expect(
      shallowMount(Person, {
        propsData: {
          name: 'Juan Pablo',
          title: 'Software Engineer',
          email: 'juanpablo@gmail.com'
        }
      })
    ).toMatchSnapshot();
  });
})
