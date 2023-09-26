<template>
  <div class="app-container">
    <el-form :inline="true" class="demo-form-inline">
      <el-form-item>
        <el-input v-model="searchObj.hosname" placeholder="医院名称"/>
      </el-form-item>
      <el-form-item>
        <el-input v-model="searchObj.hoscode" placeholder="医院编号"/>
      </el-form-item>
      <el-button type="primary" icon="el-icon-search" @click="getList()">查询</el-button>
    </el-form>

    <!-- 工具条 -->
    <div>
      <el-button type="primary" size="mini" @click="">添 加</el-button>
      <el-button type="danger" size="mini" @click="removeRows()">批量删除</el-button>
    </div>

    <!-- banner列表  list即是我们的list列表 -->
    <el-table :data="list" stripe style="width: 100%" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"/>
      <el-table-column type="index" width="50" label="序号"/>
      <el-table-column prop="hosname" label="医院名称"/>
      <el-table-column prop="hoscode" label="医院编号"/>
      <el-table-column prop="apiUrl" label="api基础路径" width="200"/>
      <el-table-column label="状态" width="80">
        <template slot-scope="scope">
          <el-tag size="medium">
            {{ scope.row.status === 1 ? '可用' : '不可用' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="contactsName" label="联系人姓名"/>
      <el-table-column prop="contactsPhone" label="联系人手机"/>
      <el-table-column label="操作" width="380" align="center">
        <template slot-scope="scope">
          <router-link :to="'/hosp/hospitalSet/edit/'+scope.row.id">
            <el-button type="primary" size="mini" icon="el-icon-edit">编辑</el-button>
          </router-link>
          <el-button type="danger" size="mini"
                     icon="el-icon-delete" @click="removeDataById(scope.row.id)">删除
          </el-button>
          <el-button v-if="scope.row.status==1" type="success" size="mini"
                     icon="el-icon-delete" @click="lockHostSet(scope.row.id,0)">锁定
          </el-button>
          <el-button v-if="scope.row.status==0" type="success" size="mini"
                     icon="el-icon-goods" @click="lockHostSet(scope.row.id,1)">取消锁定
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <el-pagination
      :current-page="current"
      :page-size="limit"
      :total="total"
      style="padding: 30px 0; text-align: center;"
      layout="total, sizes, prev, pager, next, jumper"
      @current-change="getList"
    />
  </div>
</template>

<script>
import hospitalSetApi from '@/api/hosp/hospitalSet' //即前面定义的那个api下的js

export default {
  name: "index",
  // 定义变量和初始值
  data() {
    return {//(page, limit, searchObj)参考这里传递的参数进行定义变量
      //当前页
      current: 1,
      //每页显示记录数
      limit: 3,
      //总条数
      total: 0,
      //条件封装对象
      searchObj: {hosname: '', hoscode: ''},
      //这个是用来接受返回的列表的
      list: [],
      //批量选择中选择的记录列表
      multipleSelection: [],
    }
  },
  // 页面渲染之前执行 ： 一般用来调用methods定义的方法，得到数据
  created() {  //只能调用当前vue的方法，不能直接调用到  hospitalSetApi.getPageList的
    this.getList()
  },
  methods: {   //定义方法，进行请求接口调用
    getList(page = 1) { //不传默认第1页   //前面已经 import hospitalSetApi from '@/api/hosp/hospitalSet'
      this.current = page
      // 使用hospitalSetApi调用方法即可，这个方法是暴露出来的
      hospitalSetApi.getPageList(this.current, this.limit, this.searchObj).then(response => {
        this.list = response.data.records
        this.total = response.data.total
      }).catch(error => {
        console.log(error)
      })
    },
    //删除医院设置的方法
    removeDataById(id) {
      this.$confirm('此操作将永久删除医院是设置信息，是否继续？', '提示', {
        confirmButtonText: '确实',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {  //确定执行then方法
        //调用删除接口
        hospitalSetApi.deleteHospSet(id).then(response => {
          this.$message({
            type: 'success',
            message: '删除成功！'
          })
          this.getList(1)
        })
      })
    },
    // 当表格复选框选项发生变化的时候触发
    handleSelectionChange(selection) {
      this.multipleSelection = selection
    },
    //批量删除
    removeRows() {
      this.$confirm('此操作将永久删除医院是设置信息, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        var idList = []
        //遍历数组得到每个id值，设置到idList里面
        for (var i = 0; i < this.multipleSelection.length; i++) {
          var obj = this.multipleSelection[i]
          var id = obj.id
          idList.push(id)
        }
        //调用接口
        hospitalSetApi.removeRows(idList).then(response => {
          this.$message({
            type: 'success',
            message: '删除成功!'
          })
          this.getList(1)
        })
      })
    },
    //锁定和取消锁定
    lockHostSet(id, status) {
      hospitalSetApi.lockHospSet(id, status).then(response => {
        this.getList(this.current)
      })
    }
  }
}
</script>
