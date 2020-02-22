<template>
  <div class="paginator">
    <button
      class="paginator__button"
      :disabled="disablePrevious"
      @click="$emit('previous')"
    >
      Previous
    </button>
    <button
      class="paginator__button"
      :disabled="disableNext"
      @click="$emit('next')"
    >
      Next
    </button>
  </div>
</template>

<script>
export default {
  name: 'Paginator',

  props: {
    disablePrevious: {
      type: Boolean,
      required: true
    },
    disableNext: {
      type: Boolean,
      required: true
    }
  },
}
</script>
