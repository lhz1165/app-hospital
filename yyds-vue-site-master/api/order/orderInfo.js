import request from '@/utils/request'

const api_name = `/api/order/orderInfo`

export default {
  // 生成订单
  submitOrder(scheduleId, patientId) {
    return request({
      url: `${api_name}/auth/submitOrder/${scheduleId}/${patientId}`,
      method: 'post'
    })
  },
  // 订单详情
  getOrders(orderId) {
    return request({
      url: `${api_name}/auth/getOrders/${orderId}`,
      method: `get`
    })
  },
  // 订单列表（条件查询带分页）
  getPageList(page, limit, searchObj) {
    return request({
      url: `${api_name}/${page}/${limit}`,
      method: 'get',
      params: searchObj
    })
  },
  // 获取订单状态
  getStatusList() {
    return request({
      url: `${api_name}/getStatusList`,
      method: 'get'
    })
  }
}
