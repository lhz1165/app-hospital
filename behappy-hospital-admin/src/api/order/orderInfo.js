import request from '../../utils/request'
const api_name = '/admin/order/orderInfo'
export default {
  getPageList(page, limit, searchObj) {
    return request({
      url: `${api_name}/${page}/${limit}`,
      method: 'get',
      params: searchObj
    })
  },
  getStatusList() {
    return request({
      url: `${api_name}/getStatusList`,
      method: 'get'
    })
  },
  getById(id) {
    return request({
      url: `${api_name}/show/${id}`,
      method: 'get'
    })
  }
}
