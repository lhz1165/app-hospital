import request from '@/utils/request'  //可以理解为导入的公共包

const api_name = '/admin/hosp/hospitalSet' //从java对应的controller复制过来

export default {
  // 带条件的分页查询
  getPageList(current, limit, searchObj) {
    return request({
      url: `${api_name}/findPageHospSet/${current}/${limit}`,//这里前边还会拼上dev.env.js文件中的BASE_API
      method: 'post',
      data: searchObj   //使用json传递参数 用data 其他用params
    })
  },

  //添加医院设置
  saveHospSet(hospitalSet) {
    return request({
      url: `${api_name}/saveHospitalSet`,
      method: 'post',
      data: hospitalSet
    })
  },

  //医院院设置 根据id查询
  getHospSet(id) {
    return request({
      url: `${api_name}/getHospSet/${id}`,
      method: 'get'
    })
  },

  //修改医院设置
  updateHospSet(hospitalSet) {
    return request({
      url: `${api_name}/updateHospitalSet`,
      method: 'post',
      data: hospitalSet
    })
  },

  deleteHospSet(id) {
    return request({
      url: `${api_name}/${id}`,
      method: 'delete'
    })
  },

  removeRows(idList) {
    return request({
      url: `${api_name}/batchRemove`,
      method: 'delete',
      data: idList
    })
  },

  //锁定和取消锁定
  lockHospSet(id, status) {
    return request({
      url: `${api_name}/lockHospitalSet/${id}/${status}`,
      method: 'put'
    })
  },
}
