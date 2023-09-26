import request from '@/utils/request'

const api_name = `/api/ucenter/wx`

export default {
  // 生成微信扫描二维码
  getLoginParam() {
    return request({
      url: `${api_name}/getLoginParam`,
      method: `get`
    })
  },
}
