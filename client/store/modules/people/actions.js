const PEOPLE_ENDPOINT = 'http://localhost:5000/people';

export default {
  fetchPeople: async function ({ commit, state }, payload) {
    const { data } = await axios.get(PEOPLE_ENDPOINT);

    commit('SET_PEOPLE', data.results);
  },

  fetchNextPage: async function ({ commit, state }, payload) {
    const { data } = await axios.get(PEOPLE_ENDPOINT);

    commit('SET_PEOPLE', data.results);
  }
}
