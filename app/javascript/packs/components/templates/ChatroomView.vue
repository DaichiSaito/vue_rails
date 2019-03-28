<template>
  <v-layout row>
    <v-flex xs12 sm6 offset-sm3>
      <div>
        <ul>
          <li v-for="(message, index) in messages" :key="message.id">
            <p v-if="message.user.id == currentUser.id">{{ message.body }} {{ message.user.name }} </p>
            <p v-else>{{ message.user.name }} {{ message.body }}</p>
          </li>
        </ul>
        <div>
          <input type="text" v-model="newMessage">
          <input type="button" @click="speak" value="投稿">
        </div>
      </div>
    </v-flex>
  </v-layout>
</template>

<script>
    import axios from 'axios'
    import ActionCable from 'actioncable'
    import { Read } from '@/api'
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
                newMessage: null,
                room: null,
                lastReadChannel: null
            }
        },
        computed: {
          currentUser: function() {
              return JSON.parse(localStorage.getItem('currentUser'))
          }
        },
        methods: {
            fetchMessages() {
                self = this
                axios.get(`/api/v1/chatrooms/${this.$route.params.id}/messages`, {
                    headers: {
                        Authorization:
                            "Bearer " + localStorage.getItem('accesstoken')
                    }
                }).then(response => {
                    console.log(response)
                    response.data.messages.forEach(message => {
                        console.log(message)
                        this.messages.push(message)
                    })
                    self.$emit('fetchUnread')
                })
            },
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
            },
            speak() {
                this.room.perform('speak', {
                    room_id: this.$route.params.id,
                    user_id: JSON.parse(localStorage.getItem('currentUser')).id,
                    message: this.newMessage,
                });
                this.newMessage = ''
            },
            lastReadUpdate() {
              this.lastReadChannel.perform('update', {
                  chatroom_id: this.$route.params.id
              })
            },
            subscribeLastRead() {
                let accesstoken = localStorage.getItem('accesstoken')
                this.lastReadChannel = ActionCable.createConsumer(`ws:localhost:5000/cable/?accesstoken=${accesstoken}`)
                    .subscriptions.create(
                        {
                            channel: 'LastReadChannel'
                        },
                        {
                            connected: () => {
                                console.log("last read channel connected")
                            },
                            disconnected: () => {
                                console.log("last read channel disconnected")
                            },
                            received: () => {
                                console.log("last read channel received")
                            }
                        }
                    )
            }

        },
        created() {
            this.fetchMessages()
            this.subscribeLastRead()

            let accesstoken = localStorage.getItem('accesstoken')
            this.room = ActionCable.createConsumer('ws:localhost:5000/cable/?accesstoken=' + accesstoken).subscriptions.create(
                {
                    channel: "RoomChannel", room_id: this.$route.params.id
                },
                {
                    connected: function() {
                        // Called when the subscription is ready for use on the server
                        console.log("connected")
                    },

                    disconnected: function() {
                        // Called when the subscription has been terminated by the server
                        console.log("disconnected")
                    },
                    received: (data) => {
                        console.log("received")
                        console.log(data)
                        const message = {
                            body: data['body'],
                            user: data['user']
                        }
                        this.messages.push(data)
                        this.lastReadUpdate()
                    },
                }
            )
        },
    }
</script>
