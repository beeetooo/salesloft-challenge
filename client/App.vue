<template>
  <div id="app">
    <Sidebar />
    <div class="app__content">
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

<style>
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
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #A9B6C0;
  display: flex;
  height: 100%;
}
</style>
