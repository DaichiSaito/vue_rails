<template>
  <v-layout row>
    <v-flex xs12 sm6 offset-sm3>
      <div>
        <ul>
          <li v-for="(message, index) in messages" :key="message.id">

          </li>
        </ul>
        <div>
          <input type="text" v-model="newMessage">
          <input type="button" @click="post" value="投稿">
        </div>
      </div>
    </v-flex>
  </v-layout>
</template>

<script>
    import axios from 'axios'
    export default {
        data () {
            return {
                items: [
                    { icon: 'folder', iconClass: 'grey lighten-1 white--text', title: 'Photos', subtitle: 'Jan 9, 2014' },
                    { icon: 'folder', iconClass: 'grey lighten-1 white--text', title: 'Recipes', subtitle: 'Jan 17, 2014' },
                    { icon: 'folder', iconClass: 'grey lighten-1 white--text', title: 'Work', subtitle: 'Jan 28, 2014' }
                ],
                items2: [
                    { icon: 'assignment', iconClass: 'blue white--text', title: 'Vacation itinerary', subtitle: 'Jan 20, 2014' },
                    { icon: 'call_to_action', iconClass: 'amber white--text', title: 'Kitchen remodel', subtitle: 'Jan 10, 2014' }
                ],
                messages: [],
                newMessage: null
            }
        },
        methods: {
            post() {
              const message = {
                message: {
                  user_id: JSON.parse(localStorage.getItem('currentUser')).id,
                  chatroom_id: this.$route.params.id,
                  body: this.newMessage
                }
              }

              axios.post('/api/v1/messages', message, {
                  headers: {
                      Authorization:
                          "Bearer " + localStorage.getItem('accesstoken')
                  }
              }).then(response => {
                  console.log(response)
              })
            }
        }
    }
</script>
