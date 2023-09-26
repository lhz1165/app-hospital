import Vue from 'vue'
import Router from 'vue-router'

// in development-env not use lazy-loading, because lazy-loading too many pages will cause webpack hot update too slow. so only in production use lazy-loading;
// detail: https://panjiachen.github.io/vue-element-admin-site/#/lazy-loading

Vue.use(Router)

/* Layout */
import Layout from '../views/layout/Layout'
import fa from "element-ui/src/locale/lang/fa";

/**
* hidden: true                   if `hidden:true` will not show in the sidebar(default is false)
* alwaysShow: true               if set true, will always show the root menu, whatever its child routes length
*                                if not set alwaysShow, only more than one route under the children
*                                it will becomes nested mode, otherwise not show the root menu
* redirect: noredirect           if `redirect:noredirect` will no redirect in the breadcrumb
* name:'router-name'             the name is used by <keep-alive> (must set!!!)
* meta : {
    title: 'title'               the name show in submenu and breadcrumb (recommend set)
    icon: 'svg-name'             the icon show in the sidebar,
  }
**/
export const constantRouterMap = [
  { path: '/login', component: () => import('@/views/login/index'), hidden: true },
  { path: '/404', component: () => import('@/views/404'), hidden: true },

  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    name: 'Dashboard',
    hidden: false,
    children: [{
      path: 'dashboard',
      component: () => import('@/views/dashboard/index'),
      meta: { title: '首页', icon: 'table' }
    }]
  },

  // {
  //   path: '/example',
  //   component: Layout,
  //   redirect: '/example/table',
  //   name: 'Example',
  //   meta: { title: 'Example', icon: 'example' },
  //   children: [
  //     {
  //       path: 'table',
  //       name: 'Table',
  //       component: () => import('@/views/table/index'),
  //       meta: { title: 'Table', icon: 'table' }
  //     },
  //     {
  //       path: 'tree',
  //       name: 'Tree',
  //       component: () => import('@/views/tree/index'),
  //       meta: { title: 'Tree', icon: 'tree' }
  //     }
  //   ]
  // },

  {
    path: '/form',
    component: Layout,
    children: [
      {
        path: 'index',
        name: 'Form',
        component: () => import('@/views/form/index'),
        meta: { title: 'Form', icon: 'form' }
      }
    ]
  },

  {
    path: '/nested',
    component: Layout,
    redirect: '/nested/menu1',
    name: 'Nested',
    meta: {
      title: 'Nested',
      icon: 'nested'
    },
    children: [
      {
        path: 'menu1',
        component: () => import('@/views/nested/menu1/index'), // Parent router-view
        name: 'Menu1',
        meta: { title: 'Menu1' },
        children: [
          {
            path: 'menu1-1',
            component: () => import('@/views/nested/menu1/menu1-1'),
            name: 'Menu1-1',
            meta: { title: 'Menu1-1' }
          },
          {
            path: 'menu1-2',
            component: () => import('@/views/nested/menu1/menu1-2'),
            name: 'Menu1-2',
            meta: { title: 'Menu1-2' },
            children: [
              {
                path: 'menu1-2-1',
                component: () => import('@/views/nested/menu1/menu1-2/menu1-2-1'),
                name: 'Menu1-2-1',
                meta: { title: 'Menu1-2-1' }
              },
              {
                path: 'menu1-2-2',
                component: () => import('@/views/nested/menu1/menu1-2/menu1-2-2'),
                name: 'Menu1-2-2',
                meta: { title: 'Menu1-2-2' }
              }
            ]
          },
          {
            path: 'menu1-3',
            component: () => import('@/views/nested/menu1/menu1-3'),
            name: 'Menu1-3',
            meta: { title: 'Menu1-3' }
          }
        ]
      },
      {
        path: 'menu2',
        component: () => import('@/views/nested/menu2/index'),
        meta: { title: 'menu2' }
      }
    ]
  },

  {
    path: '/cmn',
    component: Layout,
    redirect: '/cmn/dict/index',
    name: '数据管理',
    alwaysShow: true,
    meta: { title: '数据管理', icon: 'example' },
    children: [
      {
        path: 'list',
        name: '数据字典',
        component: () => import('@/views/cmn/dict/index'),
        meta: { title: '数据字典', icon: 'table' }
      }
    ]
  },

  {
    path: '/hosp',
    component: Layout,
    redirect: '/hosp/hospital/index',
    name: 'hospital',
    meta: { title: '医院管理', icon: 'table' },
    children: [
      {
        path: 'hospitalSet/index',
        name: '医院设置列表',
        component: () =>import('@/views/hosp/hospitalSet/index'),
        meta: { title: '医院设置', icon: 'table' }
      },
      {
        path: 'hospitalSet/add',
        name: '医院设置添加',
        component: () =>import('@/views/hosp/hospitalSet/form'),
        meta: { title: '医院设置添加', icon: 'form' },
        hidden: false
      },
      {
        path: 'hospitalSet/edit/:id',
        name: '医院设置修改',
        component: () =>import('@/views/hosp/hospitalSet/form'),
        meta: { title: '医院设置编辑', noCache: true },
        hidden: true
      },
      {
        path: 'hospital/index',
        name: '医院管理列表',
        component: () =>import('@/views/hosp/hospital/index'),
        meta: { title: '医院管理', icon: 'table' }
      },
      {
        path: 'hospital/detail/:id',
        name: '医院管理详情',
        component: () => import('@/views/hosp/hospital/detail'),
        meta: { title: '医院管理详情', noCache: true },
        hidden: true
      },
      {
        path: 'hospital/schedule/:hoscode',
        name: '排班',
        component: () => import('@/views/hosp/hospital/schedule'),
        meta: { title: '排班', noCache: true },
        hidden: true
      }
    ]
  },

  {
    path: '/user',
    component: Layout,
    redirect: '/user/userInfo/list',
    name: 'userInfo',
    meta: { title: '用户管理', icon: 'table' },
    alwaysShow: true,
    children: [
      {
        path: 'userInfo/list',
        name: '用户列表',
        component: () =>import('@/views/user/userInfo/list'),
        meta: { title: '用户列表', icon: 'table' }
      },
      {
        path: 'userInfo/show/:id',
        name: '用户查看',
        component: () =>import('@/views/user/userInfo/show'),
        meta: { title: '用户查看' },
        hidden: true
      },
      {
        path: 'userInfo/authList',
        name: '认证审批列表',
        component: () =>import('@/views/user/userInfo/authList'),
        meta: { title: '认证审批列表', icon: 'table' }
      }
    ]
  },

  {
    path: '/order',
    component: Layout,
    redirect: '/order/orderInfo/list',
    name: 'BasesInfo',
    meta: { title: '订单管理', icon: 'table' },
    alwaysShow: true,
    children: [
      {
        path: 'orderInfo/list',
        name: '订单列表',
        component: () =>import('@/views/order/orderInfo/list'),
        meta: { title: '订单列表', icon: 'table' }
      },
      {
        path: 'orderInfo/show/:id',
        name: '查看',
        component: () =>import('@/views/order/orderInfo/show'),
        meta: { title: '订单管理详情', noCache: true },
        hidden: true
      }
    ]
  },

  {
    path: '/statistics',
    component: Layout,
    redirect: '/statistics/order/index',
    name: 'BasesInfo',
    meta: { title: '统计管理', icon: 'table' },
    alwaysShow: true,
    children: [
      {
        path: 'order/index',
        name: '预约统计',
        component: () =>import('@/views/statistics/order/index'),
        meta: { title: '预约统计', icon: 'table' }
      }
    ]
  }

]

export default new Router({
  // mode: 'history', //后端支持可开
  scrollBehavior: () => ({ y: 0 }),
  routes: constantRouterMap
})
