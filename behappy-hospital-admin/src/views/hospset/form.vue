<template>
  <div class="app-container">
    <el-form label-width="120px">
      <el-form-item label="医院名称">
        <el-input v-model="hospitalSet.hosname"/>
      </el-form-item>
      <el-form-item label="医院编号">
        <el-input v-model="hospitalSet.hoscode"/>
      </el-form-item>
      <el-form-item label="api基础路径">
        <el-input v-model="hospitalSet.apiUrl"/>
      </el-form-item>
      <el-form-item label="联系人姓名">
        <el-input v-model="hospitalSet.contactsName"/>
      </el-form-item>
      <el-form-item label="联系人手机">
        <el-input v-model="hospitalSet.contactsPhone"/>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="saveOrUpdate">保存</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import hospitalSetApi from '../../api/hosp/hospitalSetApi'

export default {
  name: 'Add',
  data() {
    return {
      hospitalSet: {}
    }
  },
  created() {
    // 判断是新增还是修改
    if (this.$route.params && this.$route.params.id) {
      hospitalSetApi
        .getHospSet(this.$route.params.id)
        .then(res => {
          this.hospitalSet = res.data
        })
    }
  },
  methods: {
    saveOrUpdate() {
      if (this.hospitalSet.id) {
        this.update()
      } else {
        this.save()
      }
    },
    save() {
      hospitalSetApi
        .saveHospSet(this.hospitalSet)
        .then(res => {
          // 提示
          this.$message({
            type: 'success',
            message: '添加成功!'
          })
          // 跳转列表页面，使用路由跳转方式实现
          this.$router.push({ path: '/hospSet/list' })
        })
    },
    update() {
      hospitalSetApi
        .updateHospSet(this.hospitalSet)
        .then(res => {
          // 提示
          this.$message({
            type: 'success',
            message: '修改成功!'
          })
          // 跳转列表页面，使用路由跳转方式实现
          this.$router.push({ path: '/hospSet/list' })
        })
    }
  }
}
</script>

<style scoped>

</style>
