<template>
  <section class="sidebar">
    <img class="sidebar__logo" :src="logo">
    <ul class="sidebar__options">
      <li class="sidebar__option" @click="$emit('showPeople')"> People </li>
      <li class="sidebar__option" @click="$emit('showCharactersFrequency')"> Frequency </li>
      <li class="sidebar__option" @click="$emit('showDuplicatedEmails')"> Duplicated </li>
    </ul>
  </section>
</template>

<script>
import Logo from '../assets/logo.png';

export default {
  name: 'Sidebar',
  data: function () {
    return { logo: Logo };
  }
}
</script>

<style lang="scss">
.sidebar {
  width: 15%;

  &__logo {
    width: 80px;
    height: 80px;
    align-self: center;
  }

  &__options {
    margin-top: 40px;
    padding: 0 16px 0 16px;
  }

  &__option {
    list-style: none;
    text-align: left;
    cursor: pointer;
    margin: 12px;
    border-radius: 4px;
    padding: 4px;
    color: #1997DE;
    background-color: #2a4554;
  }
}
</style>
