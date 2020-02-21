<template>
  <div id="app">
    <Sidebar />
    <div class="app__content">
      <h1 class="app__content-title"> People </h1>
      <People />
    </div>
  </div>
</template>

<script>
import Sidebar from './components/Sidebar.vue'
import People from './containers/People.vue'

export default {
  name: 'App',
  components: {
    Sidebar,
    People,
  }
}
</script>

<style lang="scss">
html {
  background-color: #151618;
  height: 100%;
}

body {
  width: 100%;
  height: 100%;
  margin: 0;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  text-align: center;
  color: #A9B6C0;
  display: flex;
  height: 100%;
}

.app__content {
  margin-left: 20%;
}

.app__content-title {
  text-align: left;
  margin-left: 24px;
}
</style>
