<template>
  <div>This is a helloworld component</div>
</template>

<script lang="ts">
import Vue from 'vue'

export default Vue.extend({
  props: {
    required: {
      type: Number,
      required: true,
    },
    optional: {
      type: Number,
      default: 30,
    },
  },
  computed: {
    computedOptional() {
      return this.optional
    },
  },
  mounted() {
    this.testFunction('hello')
  },
  methods: {
    testFunction(word: string) {
      // eslint-disable-next-line no-console
      console.log(word)
    },
  },
})
</script>
