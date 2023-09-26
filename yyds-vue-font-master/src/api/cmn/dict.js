import request from '@/utils/request'

export default {
  // 数据字典列表
  dictList(parentId) {
    return request({
      url: `/admin/cmn/dict/findChildData/${parentId}`,
      method: 'get'
    })
  },

  // 数据字典导出
  exportData() {
    return request({
      url: `/admin/cmn/dict/exportData`,
      method: 'get'
    })
  }
}
