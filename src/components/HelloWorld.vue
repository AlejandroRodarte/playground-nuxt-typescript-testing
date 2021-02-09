<template>
  <div>This is a helloworld component</div>
</template>

<script lang="ts">
import Vue from 'vue'

export default Vue.extend({
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
