import Vue from 'vue'
import VueRouter from 'vue-router'
import index from "@/pages/index.vue";


Vue.use(VueRouter)


const routes = [

    {
        path: '/',
        name: 'default',
        redirect:'/index'
    },

    // {
    //     path: '/login',
    //     name: 'login',
    //     component: login
    // },

    {
        path: '/index',
        name: 'main',
        component: index,
        // redirect:"/index/welcome",
        // props:true,
        //嵌套路由
        // children: [
        //     {
        //         path: '/index/houseHolder',
        //         component: houseHolder,
        //     },
        //
        // ],

    },


]

const router = new VueRouter({
    // mode: 'history',
    base: process.env.BASE_URL,
    routes
})



export default router