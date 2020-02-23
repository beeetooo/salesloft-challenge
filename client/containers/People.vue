<template>
  <div class="people">
    <h1 class="people__content-title">
      People
    </h1>
    <div
      class="people__people"
    >
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
      :page="page"
      :disable-previous="disablePrevious"
      :disable-next="disableNext"
      @previous="fetchPreviousPage"
      @next="fetchNextPage"
    />
  </div>
</template>

<script>
import axios from 'axios';

import Paginator from '../components/Paginator.vue';
import Person from '../components/Person.vue';

export default {
  name: 'People',

  components: {
    Paginator,
    Person,
  },

  data: function () {
    return {
      people: [],
      page: 1,
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
    const people = await this.requestUsers(this.page, this.perPage);
    this.people = people;
  },

  methods: {
    fetchPreviousPage: async function () {
      this.page = this.page - 1;

      const people = await this.requestUsers(this.page, this.perPage);
      this.people = people;
    },

    fetchNextPage: async function () {
      this.page = this.page + 1;

      const people = await this.requestUsers(this.page, this.perPage);
      this.people = people;
    },

    requestUsers: async function (page, perPage) {
      const response = await axios.get(
        `http://localhost:5000/people?page=${page}&per_page=${perPage}`
      );

      return response.data.results;
    }
  },
}
</script>

<style lang="scss">
.people__people {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: center;
}

.people__content-title {
  text-align: left;
  margin-left: 24px;
}

.people__person {
  width: 280px;
  margin: 24px 24px 16px 24px;
}
</style>
