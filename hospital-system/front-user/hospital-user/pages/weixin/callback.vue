<template>
  <!-- header -->
  <div></div>
  <!-- footer -->
</template>
<script>
export default {
  data() {
    return {};
  },
  mounted() {
    let token = this.$route.query.token;
    let name = this.$route.query.name;
    let openid = this.$route.query.openid;
    // 调用父vue方法
    window.parent["loginCallback"](name, token, openid);
  },
};
</script>
