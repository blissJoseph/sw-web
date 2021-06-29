<template>
  <div class="wrapper">
    <div class="title">도면</div>
    <img class="drawing" :src="url" />
  </div>
</template>

<script>

export default {
  name: 'Drawing',
  props: {
    msg: String
  },
  data() {
    return {
      url: this.$route.params.url
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.wrapper {
  display: flex;
  width: 1920px;
  height: 1080px;
  padding: 16px;
}
.title {
  display: flex;
  margin-right: 8px;
  align-items: center;
  padding: 32px;
  font-size: 28px;
  font-weight: bold;
  background-color: #ccc;
}
.drawing {
  border: 1px solid #000;
}
</style>
