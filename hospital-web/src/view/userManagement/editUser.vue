<!--用于修改页面，调用与添加页面相同的组件页面-->
<template>
  <user-option :user-data="userInfo"></user-option>
</template>

<script>
  import userOption from '@/view/userManagement/components/userOption'
  export default {
    name: "editUser",
    components: {
      userOption
    },
    data() {
      return {
        userInfo: {}
      }
    },
    created() {
      this.userInfo = JSON.parse(sessionStorage.getItem('userInfo'));
      this.userInfo['isEdit'] = true
      console.log(this.doctorInfo)
    }
  }
</script>

<style scoped>

</style>
