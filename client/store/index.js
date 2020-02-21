import Vue from 'vue'
import Vuex from 'vuex'

import people from './modules/people'

export default new Vuex.Store({
  modules: {
    people,
  }
})
