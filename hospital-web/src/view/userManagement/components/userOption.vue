<template>
  <div class="out-box">
    <span class="top-title">{{ userData.isEdit | editOrAdd }}用户信息：</span>
    <div class="info-picture-box">
      <div class="info-out-box">
        <div class="info-in-box" v-show="userData.isEdit">
          <span class="title">编号：</span>
          <el-input v-model="userData.ID" placeholder="请输入内容" class="input-box" :disabled="true"></el-input>
        </div>
        <div class="info-in-box">
          <span class="title">姓名：</span>
          <el-input v-model="userData.name" placeholder="请输入内容" class="input-box"></el-input>
        </div>

        <div class="info-in-box">
          <span class="title">手机号：</span>
          <el-input v-model="userData.phone" placeholder="请输入内容" class="input-box"></el-input>
        </div>

        <div class="info-in-box">
          <span class="title">密码：</span>
          <el-input v-model="userData.password" placeholder="不填不修改密码" class="input-box"></el-input>
        </div>
      </div>
    </div>
    <el-button class="insure-button" type="primary" style="margin-top: 15px;"
               @click="validateData" v-loading.fullscreen.lock="loading">确定</el-button>
  </div>

</template>

<script>
  import {addUser, updateUser} from "@/api/user";
  import {tips} from "@/common/js/optionTips";

  export default {
    name: "userOption",
    props: {
      userData: {}
      },
    data() {
      return {
        loading: false,
        imgUrl: '',
        dialogVisible: false,
        status: '',// 用于记录当前状态是编辑还是添加
      }
    },
    methods: {
      // 对表单进行遍历
      validateData: function() {
        let isValidate = true;
        if (isValidate) {
          if (this.userData.isEdit) {
            this.updateUser()
          } else {
            this.addUser()
          } // end if
        } // end if
      },
      // 向数据库添加医生数据
      addUser: function () {
        this.loading = true;
        addUser({
          id: this.userData.id,
          name: this.userData.name,
          phone: this.userData.phone,
          password: this.userData.password
        }).then(res => {
          if (res.code === 200) {
            this.loading = false;
            this.$notify({
              title: '成功',
              message: '添加成功',
              type: 'success'
            });
          }
        }).catch(() => {
          this.loading = false;
          tips('error', '添加失败')
        })
      },
      // 更新医生信息
      updateUser: function () {
        this.loading = true;
        updateUser(this.userData.ID, {
          id: this.userData.id,
          name: this.userData.name,
          phone: this.userData.phone,
          password: this.userData.password
        }).then(res => {
          if (res.code === 200) {
            this.loading = false;
            this.$notify({
              title: '成功',
              message: '修改成功',
              type: 'success'
            });
          }
        }).catch(() => {
          this.loading = false;
          tips('error', '修改失败')
        })
      },
    },
  }
</script>

<style lang="scss">
  @import "../../.././common/scss/common.scss";
  .out-box{
    @include width-margin(90%, 100%);
    @include flex-direction(column);
    margin-top: 20px;
    // 上面的标题和按钮
    .top-title{
      @include font-style(18px, $major-blue-color);
      margin-right: 40px;
      display: flex;
      align-items: center;
    }
    // 中间的信息
    .info-picture-box{
      @include width-margin(100%, 100%);
      @include flex-direction(row);
      margin-top: 20px;
      .info-out-box{
        width: 50%;
        height: 100%;
      }
      .brief-box{
        @include width-margin(50%,auto);
        @include flex-direction(column);
        text-align: center;
        margin-left: 5%;
        .title{
          width: 100%;
          height: 40px;
          line-height: 40px;
          @include font-style(16px, #000000);
        }
        .brief{
          @include width-margin(80%, auto);
          margin-left: 5%;
        }
      }
    }
  }

</style>
