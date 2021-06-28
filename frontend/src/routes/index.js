import Vue from 'vue'
import Router from 'vue-router'
import Drawing from '@/components/drawing'
import Main from '@/components/Main'
Vue.use(Router)
export const router = new Router({
 mode: 'history',
 routes: [
   {
     path: '/',
     name: 'index',
     component: Main
   },
   {
     path: '/drawing',
     name: 'drawing',
     component: Drawing
   }
 ]
})