// import Vue from 'vue/dist/vue.esm.js'
import Vue from 'vue'
import router from './router/router'
import Header from './components/Header.vue'
import App from '../app.vue'
import firebase from 'firebase'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
Vue.use(Vuetify)

var config = {
    apiKey: "AIzaSyDSxKIfSVPa-r2Vo2C3Mlq7YX_s6I29vOs",
    authDomain: "samplefirebase-af9fc.firebaseapp.com",
    databaseURL: "https://samplefirebase-af9fc.firebaseio.com",
    projectId: "samplefirebase-af9fc",
    storageBucket: "samplefirebase-af9fc.appspot.com",
    messagingSenderId: "181483037658"
}

firebase.initializeApp(config)

// var app = new Vue({
//     router,
//     el: '#app',
//     components: {
//         'navbar': Header
//     }
// });

// new Vue({
//     router,
//     render: h => h(App)
// }).$mount('#app')


document.addEventListener('DOMContentLoaded', () => {
    new Vue({
        router,
        render: h => h(App)
    }).$mount('#app')
    console.log("aaaa")
})
