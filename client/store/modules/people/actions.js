export default {
  fetchPeople ({ commit, state }) {
    const { data } await axios.get('http://localhost:5000/people');

    commit('SET_PEOPLE', data)
  }
}
