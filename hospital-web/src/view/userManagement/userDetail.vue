<template>
  <div>
    <!--      表格位置-->
    <div class="button-table-box" v-loading="isLoading">
      <div class="info-in-box">
        <span class="title">姓名：</span>
        <el-input placeholder="输入用户姓名" v-model="name" style="width: 15%"></el-input>

        <el-button type="primary" size="mini" style="margin-left: 30px;" @click="getUserList()">查询</el-button>
      </div>
      <div class="button-box" style="margin-top: 20px;">
        <el-button type="primary"  size="small" icon="el-icon-circle-plus"
                   class="add-button" @click="addUser()">添加</el-button>
      </div>
      <table-list :tableAllData="tableAllData" @getTableData="getTableData" ref="tableList"></table-list>
    </div>
    <page-pagination :page-list="pageList" ref="pagePagination"></page-pagination>
    <!--    用作删除的弹框-->
    <delete-dialog :dialog="deleteDialog" ref="deleteDialog"></delete-dialog>
  </div>
</template>

<script>
import {getUserList, deleteUser} from "@/api/user";
import {tips} from "@/common/js/optionTips";



export default {
  name: "userDetail",
  data() {
    return {
      // 顶部筛选信息
      isLoading: false,
      name: '',
      selectDepartmentData:[],
      selectDepartmentID: 0,
      selectOutpatientData: [],
      selectOutpatientID: 0,
      // 表格数据
      tableAllData: {
        dataNull: false,
        tableTitle: [{
          prop: 'ID',
          label: '用户ID',
          width: '150',
          option: ''
        }, {
          prop: 'name',
          label: '姓名',
          width: '150',
          option: ''
        }, {
          prop: 'phone',
          label: '手机号',
          width: '200',
          option: ''
        }, {
          prop: 'gmtCreate',
          label: '创建时间',
          width: '130',
          option: ''
        }],
        tableData: [],
        option: {
          width: '150',
          button: [
            {
            size: 'mini',
            type: 'success',
            name: '编辑'
          }, {
            size: 'mini',
            type: 'danger',
            name: '删除'
          }]
        }
      },
      // 底部分页的数据
      pageList: {
        pageNum: 1,
        pageSize: 5,
        total: 0
      },
      // 删除的模态框的数据
      deleteDialog: {
        title: '科室',
        dialogFormVisible: false,
        id: ''
      },
      deleteScope: {}, // 用作当从组件传过来确认删除时用的
    }
  },
  methods: {
    // 获取表格的点击按钮的信息反馈
    getTableData: function (option) {
      if (option.buttonName === '删除') {

        this.deleteScope = option; // 将删除的数据存起来
        this.deleteDialog.dialogFormVisible = true; // 打开删除弹窗
        this.deleteDialog.id = option.scopeRow.ID; // 发送删除id

      } else if (option.buttonName === '编辑') {
        sessionStorage.setItem('userInfo', JSON.stringify(option.scopeRow));
        this.$router.push({
          path: '/editUser'
        })
      }
    },

    // 添加用户信息
    addUser: function() {
      this.$router.push({
        path: '/addUser',
        query: {
          specialId: this.selectDepartmentID,
          outpatientId: this.selectOutpatientID
        }
      })
    },

    // 用户点击删除某条用户信息
    deleteData: function () {
      deleteUser(this.deleteScope.scopeRow.ID).then(res => {
        if (res.code === 200) {
          this.deleteDialog.dialogFormVisible = false;
          this.$refs.tableList.deleteData(this.deleteScope.scopeIndex)
          this.getUserList();
        }
      }).catch(() => {
        this.deleteDialog.dialogFormVisible = false;
        tips('error', '删除失败')
      });

    },

    // 从数据库获取用户信息列表
    getUserList: function () {
      this.tableAllData.tableData = [];
      let _this = this;
      getUserList(
        this.name,
        this.pageList.pageNum,
        this.pageList.pageSize
      ).then(res => {
        if (res.code === 200 && res.data.list.length >0 ){
          res.data.list.forEach(function (item, index) {
            _this.tableAllData.tableData.push({
              ID: item.id,
              name: item.name,
              phone: item.phone,
              gmtCreate: item.gmtCreate
            })
          })
        } else {
          this.tableAllData.dataNull = true
        }
      })
    },

    // 子组件分页通过调用父组件的方法进行调用更新表格
    fatherMethod: function (pageNum, pageSize) {
      this.pageList.pageNum = pageNum;
      this.pageList.pageSize = pageSize;
      this.getUserList()
    }
  },
  mounted() {
    this.getUserList()
  }
}
</script>

<style scoped lang="scss">
@import "../.././common/scss/common.scss";
.button-table-box{
  @include width-margin(90%, 100%);
  margin-top: 15px;
}
</style>
