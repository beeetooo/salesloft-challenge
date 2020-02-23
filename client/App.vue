<template>
  <div id="app">
    <Sidebar
      :active="active"
      @showPeople="active = 'people'"
      @showFrequency="active = 'frequency'"
      @showDuplicated="active = 'duplicated'"
    />
    <div class="app__content">
      <People v-if="active === 'people'" />
      <Frequency v-if="active === 'frequency'" />
    </div>
  </div>
</template>

<script>
import Sidebar from './components/Sidebar.vue'
import People from './containers/People.vue'
import Frequency from './containers/Frequency.vue'

export default {
  name: 'App',

  components: {
    Frequency,
    People,
    Sidebar,
  },

  data: function () {
    return {
      active: 'people',
    }
  },
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
  width: 100%;
}
</style>
