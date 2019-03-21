// import Vue from 'vue/dist/vue.esm.js'
import Vue from 'vue'
import Router from 'vue-router'
import Index from '../components/Index.vue'
import About from '../components/About.vue'
import Contact from '../components/Contact.vue'
import LoginView from '../components/templates/LoginView.vue'

Vue.use(Router)

const router = new Router({
    mode: 'history',
    routes: [
        { path: '/', component: Index },
        { path: '/about', component: About },
        { path: '/contact', component: Contact },
        {
            path: '/login',
            component: LoginView
        },
    ],
})

export default router

// export default new VueRouter({
//     mode: 'history',
//     routes: [
//         { path: '/', component: Index },
//         { path: '/about', component: About },
//         { path: '/contact', component: Contact },
//         {
//             path: '/login',
//             component: LoginView
//         },
//     ],
// })
