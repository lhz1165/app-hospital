import request from '@/utils/request'

const api_name = '/admin/statistics'

export default {
  // 获取订单统计数据
  getCountMap(searchObj) {
    return request({
      url: `${api_name}/getCountMap`,
      method: 'get',
      params: searchObj
    })
  }
}
