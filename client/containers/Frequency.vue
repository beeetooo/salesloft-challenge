<template>
  <div class="frequency">
    <h1 class="frequency__content-title">
      Frequency
    </h1>
    <p v-if="isLoading"> Loading... </p>
    <div v-else class="frequency__table-container">
      <table align="center">
        <th>
          <td> Character </td>
          <td> Frequency </td>
        </th>
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
    const response = await axios.get('http://localhost:5000/frequency');

    this.data = response.data.result;
  }
}
</script>

<style lang="scss">
.frequency__content-title {
  text-align: left;
  margin-left: 24px;
}
</style>
