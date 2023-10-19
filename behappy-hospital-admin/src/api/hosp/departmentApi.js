import request from '../../utils/request'

export default {
  // 根据医院编号，查询医院所有科室列表
  getDeptList(hoscode) {
    return request({
      url: `/admin/hosp/department/getDeptList/${hoscode}`,
      method: 'get'
    })
  }
}
