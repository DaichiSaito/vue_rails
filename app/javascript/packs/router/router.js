import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import Index from '../components/Index.vue'
import About from '../components/About.vue'
import Contact from '../components/Contact.vue'

Vue.use(VueRouter)

export default new VueRouter({
    mode: 'history',
    routes: [
        { path: '/', component: Index },
        { path: '/about', component: About },
        { path: '/contact', component: Contact },
    ],
})
