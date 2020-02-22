<template>
  <div class="people-container">
    <div class="people-container__people">
      <Person
        v-for="person in people"
        :key="person.email"
        :name="person.name"
        :title="person.title"
        :email="person.email"

        class="people__person"
      />
    </div>

    <Paginator
      :disable-previous="disablePrevious"
      :disable-next="disableNext"
      @previous="fetchPreviousPage"
      @next="fetchNextPage"
    />
  </div>
</template>

<script>
import axios from 'axios';

import Paginator from '../components/Paginator.vue'
import Person from '../components/Person.vue'

export default {
  name: 'People',

  components: {
    Paginator,
    Person,
  },

  data: function () {
    return {
      people: [],
      page: 59,
      perPage: 6,
    };
  },

  computed: {
    disablePrevious: function () {
      return this.page === 1;
    },
    disableNext: function () {
      return this.people.length === 0 || this.people.length < 6;
    }
  },

  mounted: async function () {
    const response = await axios.get(
      `http://localhost:5000/people?page=${this.page}&per_page=${this.perPage}`
    );
    this.people = response.data.results;
  },

  methods: {
    fetchPreviousPage: async function () {
      this.page = this.page - 1;

      const response = await this.requestUsers(this.page, this.perPage);
      this.people = response.data.results;
    },

    fetchNextPage: async function () {
      this.page = this.page + 1;

      const response = await this.requestUsers(this.page, this.perPage);
      this.people = response.data.results;
    },

    requestUsers: async function (page, perPage) {
      return await axios.get(
        `http://localhost:5000/people?page=${page}&per_page=${perPage}`
      );
    }
  },
}
</script>

<style lang="scss">
.people-container__people {
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
