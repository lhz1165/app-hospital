<template>
  <div>
    <template>
      <el-table
        v-loading="loading"
        element-loading-text="拼命加载中"
        element-loading-spinner="el-icon-loading"
        element-loading-background="rgba(0, 0, 0, 0.8)"
        :data="tableAllData.tableData"
        border
        :max-height="tableAllData.maxHeight"
        class="table-box">
        <el-table-column
          v-for="(item,index) in tableAllData.tableTitle"
          :key="index"
          :prop="item.prop"
          :label="item.label"
          :width="item.width"
          align="center">
          <template slot-scope="scope">
<!--            当显示的不是状态按钮时，即单纯写在页面上-->
            <div v-show="item.option !== 'radio' && item.option !== 'icon' && item.option !== 'time'">
              <span v-show="item.option === '' || !isEdit || edit !== scope.row.ID ">{{ scope.row[item.prop]}}</span>
            </div>
<!--            当显示的是时间-->
            <data v-show="item.option === 'time'">
              <span>{{ scope.row[item.prop] | dateTime('date')}}</span>
            </data>
<!--            点点击了编辑变成输入框-->
            <div v-show="item.option === 'input' && edit === scope.row.ID && isEdit">
              <el-input  size="small" v-model="scope.row[item.prop]" style="width: 90%;"/>
            </div>
<!--            当点击了编辑变成了下拉框-->
            <div v-show="item.option === 'select' && edit === scope.row.ID && isEdit">
              <el-select v-model="scope.row[item.prop]" placeholder="请选择"
                         style="width: 90%;" @change="selectDataFun(item.prop)">
                <el-option
                  v-for="item2 in selectData"
                  :key="item2.ID"
                  :label="item2.name"
                  :value="item2.ID">
                </el-option>
              </el-select>
            </div>
<!--            权限处的状态按钮-->
            <div v-show="item.option === 'radio'">
              <el-switch
                @change="handleStatusChange(scope.$index, scope.row)"
                :active-value="1"
                :inactive-value="0"
                v-model="scope.row.status">
              </el-switch>
            </div>
<!--            权限处的icon图标-->
            <div v-show="item.option === 'icon'" class="icon-size">
              <i :class="scope.row.icon" ></i>
            </div>
          </template>
        </el-table-column>
        <el-table-column
          v-if="tableAllData.option !== ''"
          label="操作"
          width="tableAllData.option.width"
          align="center">
          <template slot-scope="scope">
            <div v-show="edit !== scope.row.ID || !isEdit">
              <el-button
                v-for="(item,index) in tableAllData.option.button"
                :key = "item.name"
                :size="item.size"
                :type="item.type"
                v-if="item.name !== '就诊'"
                @click="emitIndex(scope.$index, scope.row, item.name)">{{item.name}}</el-button>
              <el-button
                v-for="(item,index) in tableAllData.option.button"
                :key = "item.name"
                :size="item.size"
                :type="item.type"
                v-if="item.name === '就诊' && scope.row.btnStatus === 0"
                @click="emitIndex(scope.$index, scope.row, item.name)">{{item.name}}</el-button>
              <el-button
                size="mini"
                type="warning"
                v-if="scope.row.btnStatus === 3"
                @click="emitIndex(scope.$index, scope.row, '重新叫号')">过号</el-button>
              <el-button
                size="mini"
                type="primary"
                v-if="scope.row.btnStatus === 3 || scope.row.btnStatus === 1"
                @click="emitIndex(scope.$index, scope.row, '查看')">查看</el-button>
            </div>

            <div v-show="isEdit && edit === scope.row.ID">
              <el-button
                size="mini"
                type="primary"
                plain
                @click="cancelEdit()">取消</el-button>
              <el-button
                size="mini"
                type="success"
                @click="emitIndex(scope.$index, scope.row, '修改')">修改</el-button>
            </div>
            <div >

            </div>
          </template>
        </el-table-column>
      </el-table>
    </template>
  </div>
</template>

<script>
  export default {
    name: "tableTest",
    props: {
      tableAllData: {
        maxHeight: {
          type: String,
          default: '430px'
        }
      }
    },
    data() {
      return {
        isEdit: false,
        edit: '', // 只有点击了编辑操作或者就诊操作的才有用
        saveEdit: {},// 作为编辑时的中间保留值
        showEdit: {},
        selectData: {},
        // loading: true // 用于表格的加载中
      }
    },
    methods: {
      // 点击操作中的按钮进行相关操作
      /**
       * @param scopeIndex number 用于传达点击的按钮的是哪一行，第一行为0
       * @param scopeRow object 用于传达点击的那行的相关显示的数据
       * @param buttonName string 用于传达点击的按钮的名称
       * **/
      emitIndex: function (scopeIndex, scopeRow, buttonName) {
        console.log(scopeRow);
        let option = {
          scopeIndex: scopeIndex,
          scopeRow: scopeRow,
          buttonName: buttonName
        }
        this.$emit('getTableData', option)
      },

      // 点击的删除按钮
      /**
       * @param index number 为列表中的第几条数据
       * 只是因为不刷新数据所以在删除成功后之间删除表格的某条数据
       ***/
      deleteData: function (index) {
        this.$notify({
          title: '成功',
          message: '删除成功',
          type: 'success',
          duration: 2000
        })
        this.tableAllData.tableData.splice(index,1)
      },
      // 点击了编辑操作
      /**
       * @param row object 为点击按钮的那行的数据
       * showEdit 为那行数据的引用数据，当showEdit发生改变时那行数据也会改变
       * saveEdit 只是为了存那行数据的最开始没有进行操作时的值，用于用户修改又后悔选取消
       * **/
      // @param row 为点击的那行的数据
      editIndex: function (row) {
        this.showEdit = row;
        this.saveEdit = JSON.parse(JSON.stringify(row))
        this.edit = row.ID;
        this.isEdit = true
      },

      // 点击了编辑之后的取消按钮
      cancelEdit: function () {
        this.isEdit = false;
        this.edit = '';
        // 此处是用户选择了取消，所以要将保留的值一个个传回去
        for (let item in this.saveEdit) {
          this.showEdit[item] = this.saveEdit[item]
        }
      },
      // 点击了编辑之后的修改按钮
      // 因为showEdit是指向那行数据的地址的，所以会相互影响，进而确定修改则直接传值
      handleUpdate: function () {
        this.$notify({
          title: '成功',
          message: '更新成功',
          type: 'success',
        });
        this.isEdit = false;
        this.edit = ''
      },
      /**
       * 点击了的是编辑是下拉框的
       * **/
      editSelect: function (data,row) {
        this.editIndex(row);
        this.selectData = data
      },
    },
    computed: {
      loading: function () {
        if (this.tableAllData.tableData.length !== 0 || this.tableAllData.dataNull) {
          return false
        }
        return true
      }
    }
  }
</script>

<style lang="scss">
  @import ".././common/scss/common.scss";
  .table-box{
    @include width-margin(100%, 100%);
    margin-top: 15px;
  }
  // 给权限的icon图标增大
  .icon-size{
    font-size: 20px;
  }
</style>
