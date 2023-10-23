import Vue from 'vue'
import Router from 'vue-router'
import { normalizeURL, decode } from 'ufo'
import { interopDefault } from './utils'
import scrollBehavior from './router.scrollBehavior.js'

const _384c96c2 = () => interopDefault(import('..\\pages\\order\\index.vue' /* webpackChunkName: "pages/order/index" */))
const _5246292b = () => interopDefault(import('..\\pages\\patient\\index.vue' /* webpackChunkName: "pages/patient/index" */))
const _35a594ce = () => interopDefault(import('..\\pages\\user\\index.vue' /* webpackChunkName: "pages/user/index" */))
const _4dcf2eb2 = () => interopDefault(import('..\\pages\\hosp\\booking.vue' /* webpackChunkName: "pages/hosp/booking" */))
const _20bfe639 = () => interopDefault(import('..\\pages\\hosp\\schedule.vue' /* webpackChunkName: "pages/hosp/schedule" */))
const _745d3086 = () => interopDefault(import('..\\pages\\order\\show.vue' /* webpackChunkName: "pages/order/show" */))
const _7e56b5ba = () => interopDefault(import('..\\pages\\patient\\add.vue' /* webpackChunkName: "pages/patient/add" */))
const _f6d13798 = () => interopDefault(import('..\\pages\\patient\\show.vue' /* webpackChunkName: "pages/patient/show" */))
const _9f6758b6 = () => interopDefault(import('..\\pages\\weixin\\callback.vue' /* webpackChunkName: "pages/weixin/callback" */))
const _a1beb5a6 = () => interopDefault(import('..\\pages\\hosp\\detail\\_hoscode.vue' /* webpackChunkName: "pages/hosp/detail/_hoscode" */))
const _ea02a918 = () => interopDefault(import('..\\pages\\hosp\\notice\\_hoscode.vue' /* webpackChunkName: "pages/hosp/notice/_hoscode" */))
const _f3ad65c8 = () => interopDefault(import('..\\pages\\hosp\\_hoscode.vue' /* webpackChunkName: "pages/hosp/_hoscode" */))
const _da75f578 = () => interopDefault(import('..\\pages\\index.vue' /* webpackChunkName: "pages/index" */))

const emptyFn = () => {}

Vue.use(Router)

export const routerOptions = {
  mode: 'history',
  base: '/',
  linkActiveClass: 'nuxt-link-active',
  linkExactActiveClass: 'nuxt-link-exact-active',
  scrollBehavior,

  routes: [{
    path: "/order",
    component: _384c96c2,
    name: "order"
  }, {
    path: "/patient",
    component: _5246292b,
    name: "patient"
  }, {
    path: "/user",
    component: _35a594ce,
    name: "user"
  }, {
    path: "/hosp/booking",
    component: _4dcf2eb2,
    name: "hosp-booking"
  }, {
    path: "/hosp/schedule",
    component: _20bfe639,
    name: "hosp-schedule"
  }, {
    path: "/order/show",
    component: _745d3086,
    name: "order-show"
  }, {
    path: "/patient/add",
    component: _7e56b5ba,
    name: "patient-add"
  }, {
    path: "/patient/show",
    component: _f6d13798,
    name: "patient-show"
  }, {
    path: "/weixin/callback",
    component: _9f6758b6,
    name: "weixin-callback"
  }, {
    path: "/hosp/detail/:hoscode?",
    component: _a1beb5a6,
    name: "hosp-detail-hoscode"
  }, {
    path: "/hosp/notice/:hoscode?",
    component: _ea02a918,
    name: "hosp-notice-hoscode"
  }, {
    path: "/hosp/:hoscode?",
    component: _f3ad65c8,
    name: "hosp-hoscode"
  }, {
    path: "/",
    component: _da75f578,
    name: "index"
  }],

  fallback: false
}

export function createRouter (ssrContext, config) {
  const base = (config._app && config._app.basePath) || routerOptions.base
  const router = new Router({ ...routerOptions, base  })

  // TODO: remove in Nuxt 3
  const originalPush = router.push
  router.push = function push (location, onComplete = emptyFn, onAbort) {
    return originalPush.call(this, location, onComplete, onAbort)
  }

  const resolve = router.resolve.bind(router)
  router.resolve = (to, current, append) => {
    if (typeof to === 'string') {
      to = normalizeURL(to)
    }
    return resolve(to, current, append)
  }

  return router
}
