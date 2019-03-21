<template>
    <form novalidate>
        <div class="form-actions">
            <LoginButton
                    :disabled="disableLoginAction"
                    @click="handleClick"
            >
                ログイン
            </LoginButton>
            <p
                    v-if="progress"
                    class="login-progress"
            >
                ログイン中...
            </p>
            <p
                    v-if="error"
                    class="login-error"
            >
                {{ error }}
            </p>
        </div>
    </form>
</template>

<script>
    // KbnButtonをインポート
    import LoginButton from '../../components/atoms/LoginButton.vue'
    // メールアドレスのフォーマットをチェックする正規表現
    const REGEX_EMAIL = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    const required = val => !!val.trim()

    export default {
        name: 'LoginForm',

        components: {
            LoginButton
        },

        props: {
            onlogin: {
                type: Function,
                required: true
            }
        },

        data () {
            return {
                progress: false,
                error: ''
            }
        },

        computed: {
            disableLoginAction () { // validを使ってログイン処理の可否、progressは後述
                return this.progress
            }
        },

        methods: {
            resetError () {
                this.error = ''
            },

            handleClick (ev) {
                if (this.disableLoginAction) { return } // 不備があればログイン処理が実行されないようガード

                this.progress = true // ログイン処理実行中をあらわす
                this.error = ''

                this.$nextTick(() => {
                    this.onlogin()
                        .catch(err => {
                            this.error = err.message
                        })
                        .then(() => {
                            this.progress = false
                        })
                })
            }
        }
    }
</script>

<style scoped>
    form {
        display: block;
        margin: 0 auto;
        text-align: left;
    }
    label {
        display: block;
    }
    input {
        width: 100%;
        padding: .5em;
        font: inherit;
    }
    ul {
        list-style-type: none;
        padding: 0;
        margin: 0.25em 0;
    }
    ul li {
        font-size: 0.5em;
    }
    .validation-errors {
        height: 32px;
    }
    .form-actions p {
        font-size: 0.5em;
    }
</style>
