<template>
  <div class="app-container">
    <div style="margin-bottom: 10px;font-size: 10px;">选择：{{ baseMap.hosname }} / {{ depname }} / {{ workDate }}</div>
    <div style="margin-bottom: 10px;font-size: 10px;">选择：</div>
    <el-container style="height: 100%">
      <el-aside width="200px" style="border: 1px silver solid">
        <!-- 部门 -->
        <el-tree
          :data="data"
          :props="defaultProps"
          :default-expand-all="true"
          @node-click="handleNodeClick"/>
      </el-aside>
      <el-main style="padding: 0 0 0 20px;">
        <el-row style="width: 100%">
          <!-- 排班日期 分页 -->
          <el-tag
            v-for="(item,index) in bookingScheduleList"
            :key="item.id"
            :type="index == activeIndex ? '' : 'info'"
            style="height: 60px;margin-right: 5px;margin-right:15px;cursor:pointer;"
            @click="selectDate(item.workDate, index)">
            {{ item.workDate }} {{ item.dayOfWeek }}<br>
            {{ item.availableNumber }} / {{ item.reservedNumber }}
          </el-tag>
          <!-- 分页 -->
          <el-pagination
            :current-page="page"
            :total="total"
            :page-size="limit"
            class="pagination"
            layout="prev, pager, next"
            @current-change="getPage"/>
        </el-row>
        <el-row style="margin-top: 20px;">
          <!-- 排班日期对应的排班医生 -->
          <el-table
            v-loading="listLoading"
            :data="scheduleList"
            border
            fit
            highlight-current-row>
            <el-table-column
              label="序号"
              width="60"
              align="center">
              <template slot-scope="scope">
                {{ scope.$index + 1 }}
              </template>
            </el-table-column>
            <el-table-column label="职称" width="150">
              <template slot-scope="scope">
                {{ scope.row.title }} | {{ scope.row.docname }}
              </template>
            </el-table-column>
            <el-table-column label="号源时间" width="80">
              <template slot-scope="scope">
                {{ scope.row.workTime == 0 ? '上午' : '下午' }}
              </template>
            </el-table-column>
            <el-table-column prop="reservedNumber" label="可预约数" width="80"/>
            <el-table-column prop="availableNumber" label="剩余预约数" width="100"/>
            <el-table-column prop="amount" label="挂号费(元)" width="90"/>
            <el-table-column prop="skill" label="擅长技能"/>
          </el-table>
        </el-row>
      </el-main>
    </el-container>
  </div>
</template>

<script>
import departmentApi from '../../api/hosp/departmentApi'
import scheduleApi from '../../api/hosp/scheduleApi'
import { getCurDate } from '../../utils'

export default {
  name: 'Schedule',
  data() {
    return {
      data: [],
      defaultProps: {
        children: 'children',
        label: 'depname'
      },
      hoscode: null,
      activeIndex: 0,
      depcode: null,
      depname: null,
      workDate: null,

      bookingScheduleList: [],
      baseMap: {},

      page: 1,
      limit: 10,
      total: 0,

      listLoading: true,
      // 排班详情
      scheduleList: []
    }
  },
  created() {
    this.hoscode = this.$route.params.hoscode
    this.workDate = getCurDate()
    this.fetchData()
  },
  methods: {
    fetchData() {
      departmentApi.getDeptList(this.hoscode)
        .then(res => {
          this.data = res.data
          // 默认选中第一个
          if (this.data.length > 0) {
            this.depcode = this.data[0].children[0].depcode
            this.depname = this.data[0].children[0].depname
            this.getPage()
          }
          this.listLoading = false
        })
    },
    getPage(page = 1) {
      this.page = page
      this.workDate = null
      this.activeIndex = 0
      this.getScheduleRule()
    },
    getScheduleRule() {
      scheduleApi.getScheduleRule(this.page, this.limit, this.hoscode, this.depcode)
        .then(response => {
          this.bookingScheduleList = response.data.bookingScheduleRuleList
          this.total = response.data.total
          this.baseMap = response.data.baseMap
          // 分页后workDate=null，默认选中第一个
          if (this.workDate == null && this.bookingScheduleList[0]) {
            this.workDate = this.bookingScheduleList[0].workDate
          } else {
            this.workDate = getCurDate()
          }
          // 调用查询排班详情
          this.getDetailSchedule()
        })
    },
    handleNodeClick(data) {
      // 科室大类直接返回
      if (data.children != null) return
      this.depcode = data.depcode
      this.depname = data.depname

      this.getPage()
    },
    selectDate(workDate, index) {
      this.workDate = workDate
      this.activeIndex = index
      // 调用查询排班详情
      this.getDetailSchedule()
    },
    getDetailSchedule() {
      scheduleApi.getScheduleDetail(this.hoscode, this.depcode, this.workDate)
        .then(response => {
          this.scheduleList = response.data
        })
    }
  }
}
</script>

<style scoped>
/*控制树形展示数据选中效果*/
.el-tree-node.is-current > .el-tree-node__content {
  background-color: #409EFF !important;
  color: white;
}

.el-checkbox__input.is-checked + .el-checkbox__label {
  color: black;
}
</style>
