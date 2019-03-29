<template>
    <!--<div>-->
        <!--<p>Index</p>-->
        <!--<p><input type="text" v-model="newTask"></p>-->
        <!--<p><input type="button" v-on:click="post" value="投稿"></p>-->
        <!--<ul>-->
            <!--<li v-for="(task, index) in tasks">-->
                <!--{{ task.name }}-->
            <!--</li>-->
        <!--</ul>-->
    <!--</div>-->
    <div>
    <v-layout row wrap>
        <v-flex  pa-1 xs12 sm6 md4 v-for="(user, index) in users" v-bind:id="'user_' + user.id" :key="user.id">
            <v-card>
                <v-img
                        class="white--text"
                        :src="user.avatar ? user.avatar : require('@/assets/profile-placeholder.png')"
                >
                    <v-container fill-height fluid>
                        <v-layout fill-height>
                            <v-flex xs12 align-end flexbox>
                                <span class="headline">{{ user.name }}</span>
                            </v-flex>
                        </v-layout>
                    </v-container>
                </v-img>
                <v-card-title>
                    <div>
                        <span class="grey--text">Number 10</span><br>
                        <span>Whitehaven Beach</span><br>
                        <span>Whitsunday Island, Whitsunday Islands</span>
                    </div>
                </v-card-title>
                <v-card-actions>
                    <v-btn flat color="orange">Share</v-btn>
                    <v-btn flat color="orange" @click="like(user.id)" v-if="!liking(user.id)">いいね</v-btn>
                    <v-btn flat color="orange" v-if="liking(user.id)">いいね済み</v-btn>
                </v-card-actions>
            </v-card>
        </v-flex>
    </v-layout>
        <Dialog v-bind:matching-user="matchingUser" v-on:close="closeModal()"/>
    </div>
</template>
<script>
    import axios from 'axios'
    import Dialog from '@/components/organisms/Dialog.vue'
    import { Read } from '@/api'
    // import 'profile-placeholder.png'
    export default {
        data() {
            return {
                newTask: null,
                tasks: [],
                users: [],
                // liking: false,
                like_users: [],
                matchingUser: null
            }
        },
        components: {
            Dialog
        },
        mounted() {
            this.fetchLikeUser()
            this.fetchUser()
        },
        computed: {
          // liking: function() {
          //     self = this
          //     return function(userId) {
          //         return self.like_users.includes(userId)
          //     }
          // }
        },
        methods: {
            liking(userId) {
                return this.like_users.includes(userId)
            },
            fetch() {
                axios.get('/api/v1/tasks').then(response => {
                    // console.log(response)
                    // console.log(response.data.tasks)
                    response.data.tasks.forEach (task => {
                        this.tasks.unshift(task)
                    })
                }).catch(error => {
                    console.log(error)
                })
            },
            fetchLikeUser() {
                self = this
                axios.get('/api/v1/users/like_users', {
                    headers: {
                        Authorization:
                            "Bearer " + localStorage.getItem('accesstoken')
                    }
                }).then(response => {
                    response.data.users.forEach(like_user => {
                        self.like_users.push(like_user.id)
                        // this.like_users[id] = true
                        // this.like_users.push(user)
                        // this.like_users.push( { [id]: true } )
                    })
                })
            },
            fetchUser() {
                axios.get('/api/v1/users').then(response => {
                    console.log(response)
                    response.data.users.forEach (user => {
                        // console.log(user)
                        // this.like_users[user.id.toString()] = false
                        // console.log(user.id)
                        this.users.unshift(user)


                        // this.fetchLikeUser()
                    })
                }).catch(error => {
                    console.log(error)
                })
            },
            post() {
                axios.post('/api/v1/tasks', { task: { name: this.newTask } }).then(response => {
                    console.log(response)
                    this.newTask = ''
                    this.tasks.unshift(response.data.task)
                }).catch(error => {
                    console.log(error)
                })
            },
            like(userId) {

                self = this

                axios.post('/api/v1/likes',
                    { to_id: userId },
                    { headers: {
                        Authorization:
                            "Bearer " + localStorage.getItem('accesstoken')
                    }
                    }).then(response => {
                        console.log("いいねしたよ！")
                        console.log(response.data.user.id)
                        self.like_users.push(response.data.user.id)
                        console.log(response.data.user)
                        if (response.data.meta && response.data.meta.matching) {
                            self.matchingUser = response.data.user
                            this.$emit('fetchUnread')
                        }

                }, (error) => {
                    console.log(error);
                });
            },
            closeModal() {
                this.matchingUser = null
            },
        }
    }
</script>
