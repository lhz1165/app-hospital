import request from '@/utils/request'

export default {
  // 生成二维码
  createNative(orderId) {
    return request({
      url: `/api/order/weixin/createNative/${orderId}`,
      method: 'get'
    })
  },
  // 查询订单状态
  queryPayStatus(orderId) {
    return request({
      url: `/api/order/weixin/queryPayStatus/${orderId}`,
      method: 'get'
    })
  },
  // 取消预约
  cancelOrder(orderId) {
    return request({
      url: `/api/order/orderInfo/auth/cancelOrder/${orderId}`,
      method: 'get'
    })
  }
}
