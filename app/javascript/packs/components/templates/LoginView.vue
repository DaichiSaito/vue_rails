<template>
    <div class="login-view">
        <h1>Kanban App</h1>
        <LoginForm :onlogin="handleLogin" />
    </div>
</template>

<script>
    import axios from 'axios'
    import LoginForm from '../../components/molecules/LoginForm.vue'
    import firebase from 'firebase'
    export default {
        name: 'LoginView',

        components: {
            LoginForm
        },

        methods: {
            handleLogin () {
                const provider = new firebase.auth.TwitterAuthProvider();
                return firebase
                    .auth()
                    .signInWithPopup(provider)
                    .then(function(result) {
                        // This gives you a the Twitter OAuth 1.0 Access Token and Secret.
                        // You can use these server side with your app's credentials to access the Twitter API.
                        var token = result.credential.accessToken;
                        var secret = result.credential.secret;
                        // The signed-in user info.
                        var user = result.user;
                        console.log(user);
                        console.log(token);
                        console.log(secret);
                        console.log(user.uid);
                        console.log(user.providerData[0]["email"]);
                        // console.log(result.credential);

                        // ...
                        return axios
                            .post("/api/v1/login_or_create", {
                                uid: user.uid,
                                provider: "twitter",
                                email: user.providerData[0]["email"],
                                name: user.displayName
                            })
                    })
                    .then(response => {
                        console.log(response);
                        localStorage.setItem('accesstoken', response.data.token);
                        this.$router.push({ path: '/' })
                    })
                    .catch(function(error) {
                        // Handle Errors here.
                        var errorCode = error.code;
                        var errorMessage = error.message;
                        // The email of the user's account used.
                        var email = error.email;
                        // The firebase.auth.AuthCredential type that was used.
                        var credential = error.credential;
                        // ...
                        console.log(error)
                        // this.throwReject(error)
                    });
                // return this.$store.dispatch('login', authInfo)
                //     .then(() => {
                //         this.$router.push({ path: '/' })
                //     })
                //     .catch(err => this.throwReject(err))
            },
            throwReject (err) { return Promise.reject(err) }
        }
    }
</script>

<style scoped>
    .login-view {
        width: 320px;
        margin: auto;
    }
</style>
