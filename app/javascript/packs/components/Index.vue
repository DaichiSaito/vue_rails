<template>
    <div>
        <p>Index</p>
        <p><input type="text" v-model="newTask"></p>
        <p><input type="button" v-on:click="post" value="投稿"></p>
        <ul>
            <li v-for="(task, index) in tasks">
                {{ task.name }}
            </li>
        </ul>
    </div>
</template>
<script>
    import axios from 'axios'
    export default {
        data() {
            return {
                newTask: null,
                tasks: []
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
