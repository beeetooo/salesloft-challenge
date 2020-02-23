<template>
  <div class="frequency">
    <h1 class="frequency__content-title">
      Frequency
    </h1>
    <p v-if="isLoading">
      Loading... (This may take time)
    </p>
    <div
      v-else
      class="frequency__table-container"
    >
      <table align="center">
        <thead>
          <td> Character </td>
          <td> Frequency </td>
        </thead>
        <tr
          v-for="result in data"
          :key="result[0]"
        >
          <td> {{ result[0] }} </td>
          <td> {{ result[1] }} </td>
        </tr>
      </table>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'Frequency',

  data: function () {
    return {
      data: [],
      isLoading: false
    };
  },

  mounted: async function () {
    this.isLoading = true;

    const response = await axios.get('http://localhost:5000/frequency');

    this.data = response.data.result;
    this.isLoading = false;
  }
}
</script>

<style lang="scss" scoped>
.frequency__content-title {
  text-align: left;
  margin-left: 24px;
}

table {
  border-collapse: collapse;
}

table, th, td {
  border: 1px solid white;
  padding: 0 8px 0 8px;
}
</style>
