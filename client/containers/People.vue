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
import axios from 'axios';

export default {
  name: 'People',

  components: { Person },

  data: function () {
    return {
      people: [],
    };
  },

  mounted: async function () {
    const response = await axios.get('http://localhost:5000/people?page=1&per_page=6');
    this.people = response.data.results;
  }
}
</script>

<style lang="scss">
.people {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: center;
}

.people__person {
  width: 280px;
  margin: 24px 24px 16px 24px;
}
</style>
