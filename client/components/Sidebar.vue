<template>
  <section class="sidebar">
    <img class="sidebar__logo" :src="logo" />
    <ul class="sidebar__options">
      <li
        class="sidebar__option"
        :class="{
          'sidebar__option--active': active === 'people'
        }"
        @click="showPeople">
        People
      </li>
      <li
        class="sidebar__option"
        :class="{
          'sidebar__option--active': active === 'frequency'
        }"
        @click="showFrequency">
        Frequency
      </li>
      <li
        class="sidebar__option"
        :class="{
          'sidebar__option--active': active === 'duplicated'
        }"
        @click="showDuplicated">
        Duplicated
      </li>
    </ul>
  </section>
</template>

<script>
import Logo from '../assets/logo.png';

export default {
  name: 'Sidebar',

  data: function () {
    return {
      logo: Logo,
      active: 'people',
    };
  },

  methods: {
    showPeople: function () {
      this.active = 'people';
      this.$emit('showPeople');
    },

    showFrequency: function () {
      this.active = 'frequency';
      this.$emit('showFrequency');
    },

    showDuplicated: function () {
      this.active = 'duplicated';
      this.$emit('showDuplicated');
    },
  }
}
</script>

<style lang="scss">
.sidebar {
  padding: 20px 0 0 0;
  width: 20%;
  height: 100%;
  position: fixed;
  border-right: 1px solid white;

  &__logo {
    width: 80px;
    height: 80px;
    align-self: center;
  }

  &__options {
    margin-top: 40px;
    padding: 0 12px 0 12px;
  }

  &__option {
    list-style: none;
    text-align: left;
    cursor: pointer;
    margin: 12px;
    border-radius: 4px;
    padding: 4px 4px 4px 8px;
    color: #d3d3d3;

    &--active {
      background-color: rgba(#1997DE, 0.5);
    }
  }
}
</style>
