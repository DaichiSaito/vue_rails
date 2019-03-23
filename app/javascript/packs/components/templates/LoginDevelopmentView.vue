<template>
    <div class="login-view">
        <h1>開発用ログインビュー</h1>
        <!--<LoginForm :onlogin="handleLogin" />-->
        <input type="text" v-model="userId">
        <input type="button" @click="login" value="ログイン">
    </div>
</template>

<script>
    import axios from 'axios'
    import LoginForm from '@/components/molecules/LoginForm.vue'
    import firebase from 'firebase'
    export default {
        name: 'LoginDevelopmentView',

        components: {

        },
        data() {
          return {
              userId: null
          }
        },

        methods: {
            login () {
                axios
                    .get("/login_as/" + this.userId).then(response => {
                    localStorage.setItem('accesstoken', response.data.token);
                    this.$router.push({ path: '/' })
                })
            }
        }
    }
</script>

<style scoped>
    .login-view {
        width: 320px;
        margin: auto;
    }
</style>
