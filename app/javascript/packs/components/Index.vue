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
        <v-flex  pa-1 xs12 sm6 md4 v-for="(user, index) in users">
            <v-card>
                <v-img
                        class="white--text"
                        :src="require('@/assets/profile-placeholder.png')"
                >
                    <v-container fill-height fluid>
                        <v-layout fill-height>
                            <v-flex xs12 align-end flexbox>
                                <span class="headline">Top 10 Australian beaches</span>
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
                    <v-btn flat color="orange">Explore</v-btn>
                </v-card-actions>
            </v-card>
        </v-flex>
    </v-layout>
</template>
<script>
    import axios from 'axios'
    import 'profile-placeholder.png'
    export default {
        data() {
            return {
                newTask: null,
                tasks: [],
                users: [{},{},{},{},{},{},{},{},{},{}]
            }
        },
        mounted() {
            this.fetch()
        },
        methods: {
            fetch() {
                axios.get('/api/v1/tasks').then(response => {
                    console.log(response)
                    console.log(response.data.tasks)
                    response.data.tasks.forEach (task => {
                        this.tasks.unshift(task)
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
            }
        }
    }
</script>
