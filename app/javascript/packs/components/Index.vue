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
    <v-layout row wrap>
        <v-flex  pa-1 xs12 sm6 md4 v-for="(user, index) in users" v-bind:id="'user_' + user.id" :key="user.id">
            <v-card>
                <v-img
                        class="white--text"
                        :src="require('@/assets/profile-placeholder.png')"
                >
                    <v-container fill-height fluid>
                        <v-layout fill-height>
                            <v-flex xs12 align-end flexbox>
                                <span class="headline">{{ user.attributes.name }}</span>
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
</template>
<script>
    import axios from 'axios'
    // import 'profile-placeholder.png'
    export default {
        data() {
            return {
                newTask: null,
                tasks: [],
                users: [],
                // liking: false,
                like_users: []
            }
        },
        mounted() {
            this.fetchLikeUser()
            this.fetchUser()
        },
        computed: {
          liking: function() {
              self = this
              return function(userId) {
                  return self.like_users.includes(userId)
              }
          }
        },
        methods: {
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
                axios.get('/api/v1/users/like_users', {
                    headers: {
                        Authorization:
                            "Bearer " + localStorage.getItem('accesstoken')
                    }
                }).then(response => {
                    console.log(response)
                    response.data.data.forEach(like_user => {
                        console.log(like_user.id.toString())
                        const id = like_user.id.toString()
                        this.like_users.push(like_user.id)
                        // this.like_users[id] = true
                        // this.like_users.push(user)
                        // this.like_users.push( { [id]: true } )
                    })
                })
            },
            fetchUser() {
                axios.get('/api/v1/users').then(response => {
                    // console.log(response)
                    response.data.data.forEach (user => {
                        // console.log(user)
                        // this.like_users[user.id.toString()] = false
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

                axios.post('/api/v1/likes',
                    { to_id: userId },
                    { headers: {
                        Authorization:
                            "Bearer " + localStorage.getItem('accesstoken')
                    }
                    }).then(response => {
                        console.log(response)
                        this.like_users.push(response.data.data.id)

                }, (error) => {
                    console.log(error);
                });
            },
        }
    }
</script>
