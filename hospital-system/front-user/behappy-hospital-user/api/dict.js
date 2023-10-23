import request from '@/utils/request'

const api_name = '/admin/cmn/dict'
export default {
    //根据dictcode获取下级节点
    findByDictCode(dictCode) {
        return request({
            url: `${api_name}/findByDictCode/${dictCode}`,
            method: 'get'
        })
      },
    //根据id获取下级节点
    findByParentId(parentId) {
        return request({
            url: `${api_name}/findChildData/${parentId}`,
            method: 'get'
        })
      }
    }
    