import request from '@/utils/request'



export function getUserList(name,pageNum, pageSize) {
  return request({
    url: '/user/basic/list',
    method: 'get',
    params: {name,pageNum, pageSize }
  })
}

export function deleteUser(id) {
  return request({
    url: '/user/basic/' + id,
    method: 'delete'
  })
}

// 2、添加用户信息
export function addUser(data) {
  return request({
    url: '/user/basic/account/register',
    method: 'post',
    data
  })
}
// 3、更新用户信息
export function updateUser(id, data) {
  return request({
    url: '/user/basic/UserAccount/' + id,
    method: 'put',
    data
  })

  //4，用户详情
  // export function getUser(id) {
  //   return request({
  //     url: '/user/basic/userInfo?userId=' + id,
  //     method: 'GET',
  //   })
  // }
}
