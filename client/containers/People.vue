<template>
  <div class="people">
    <Person
      class="people__person"
      v-for="person in people"
      :key="person.email"
      :name="person.name"
      :title="person.title"
      :email="person.email"
    />
  </div>
</template>

<script>
import Person from '../components/Person.vue'

export default {
  name: 'People',

  components: { Person },

  data: function () {
    return {
      people: [{
        id: 1,
        name: 'Peter Jackson',
        title: 'NASA Engineer',
        email: 'email@email.com',
      }, {
        id: 1,
        name: 'Peter Jackson',
        title: 'NASA Engineer',
        email: 'email@email.com',
      }, {
        id: 1,
        name: 'Peter Jackson',
        title: 'NASA Engineer',
        email: 'email@email.com',
      }, {
        id: 1,
        name: 'Peter Jackson',
        title: 'NASA Engineer',
        email: 'email@email.com',
      }, {
        id: 1,
        name: 'Peter Jackson',
        title: 'NASA Engineer',
        email: 'email@email.com',
      }, {
        id: 1,
        name: 'Peter Jackson',
        title: 'NASA Engineer',
        email: 'thisiskindofalongemail@email.com',
      }, {
        id: 1,
        name: 'Peter Jackson',
        title: 'NASA Engineer',
        email: 'email@email.com',
      }, {
        id: 1,
        name: 'Peter Jackson',
        title: 'NASA Engineer',
        email: 'email@email.com',
      }, {
        id: 1,
        name: 'Peter Jackson',
        title: 'NASA Engineer',
        email: 'thisiskindofalongemail@email.com',
      }],
    };
  }
}
</script>

<style lang="scss">
.people {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
}

.people__person {
  width: 280px;
  margin: 24px;
}
</style>
