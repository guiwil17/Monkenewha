// @ts-ignore
import Vue from 'vue';
import VueRouter from 'vue-router';
import Login from '@/views/Login.vue';
import HomeView from '../views/HomeView.vue';
import Admin from '../views/AdminView.vue'
import createAccount from '../views/CreateAccountView.vue'
import lostPassword from '../views/lostPasswordView.vue'
import validateUser from '../views/validateUserView.vue'
import blog from '../views/BlogView.vue'
import user from '../views/userView.vue'
import changePassword from '../views/changePasswordView.vue'
import AuthenticationService from './../AuthenticationService'

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  base: import.meta.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/concert',
      name: 'concert',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/ConcertView.vue')
    },    
    {
      path: '/login',
      name: 'login',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: Login,
      beforeEnter: (to, from, next) => {
        if(!AuthenticationService.isAdmin && AuthenticationService.isAuthenticated){   
         next("/user")
        } 
        else if (AuthenticationService.isAdmin && AuthenticationService.isAuthenticated){
          next("/admin")
        }
        else{
          next()
        }
      },
    },
    {
      path: '/createAccount',
      name: 'createAccount',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: createAccount
    },
    {
      path: '/lostPassword',
      name: 'lostPassword',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: lostPassword
    },
    {
      path: '/validationEmail',
      name: 'validationEmail',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: validateUser
    },
    {
      path: '/ChangePassword',
      name: 'ChangePassword',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: changePassword
    },
    {
      path: '/blog',
      name: 'blog',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: blog
    },
    {
      path: '/admin',
      name: 'admin',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: Admin,
      beforeEnter: (to, from, next) => {
        if(AuthenticationService.isAuthenticated && AuthenticationService.isAdmin){   
         next()
        }
        else if (!AuthenticationService.isAdmin && AuthenticationService.isAuthenticated){
          next('/user')
        }
        else{
          next('/login')
        }
      },      
    },
    {
      path: '/user',
      name: 'user',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: user,
      beforeEnter: (to, from, next) => {
        if(!AuthenticationService.isAdmin && AuthenticationService.isAuthenticated){   
         next()
        }      
        else{
          next('/login')
        }
      },      
    }    
  ]
})

export default router
