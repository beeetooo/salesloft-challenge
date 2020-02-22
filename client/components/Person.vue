<template>
  <div class="person">
    <div class="person__circle">
      <p class="person__first-letter">
        {{ name[0] }}
      </p>
    </div>
    <div class="person__meta">
      <span class="person__name"> {{ name }} </span>
      <span class="person__title"> {{ title }} </span>
      <span class="person__email"> {{ email }} </span>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Person',

  props: {
    name: {
      type: String,
      required: true
    },
    title: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      required: true,
    }
  },
}
</script>

<style lang="scss">
.person {
  padding: 12px 0 12px 0;
  background-color: #FFFFFF;
  border-radius: 4px;

  display: flex;
  flex-direction: column;
  justify-content: space-around;
  align-items: center;

  &__circle {
    width: 54px;
    height: 54px;
    border-radius: 50%;
    margin-bottom: 20px;

    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;

    background-color: #18577B;
  }

  &__meta {
    width: 100%;
    display: block;
  }

  &__name {
    display: block;
    color: black;
  }

  &__title {
    display: block;
    font-style: italic;
  }

  &__email {
    display: block;
    text-overflow: ellipsis;
  }
}
</style>
