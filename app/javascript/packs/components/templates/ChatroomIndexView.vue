<template>
  <v-layout row>
    <v-flex xs12 sm6 offset-sm3>
      <v-card>

        <v-list subheader>
          <v-subheader>Recent chat</v-subheader>
          <v-list-tile
                  v-for="chatroom in chatrooms"
                  :key="chatroom.id"
                  avatar
                  @click="moveToChatroom(chatroom.id)"
          >
            <v-list-tile-avatar>
              <img :src="chatroom.avatar ? chatorom.avatar : 'https://cdn.vuetifyjs.com/images/lists/3.jpg'">
            </v-list-tile-avatar>

            <v-list-tile-content>
              <v-list-tile-title v-html="chatroom_member_other_than_me(chatroom)"></v-list-tile-title>
            </v-list-tile-content>

            <v-list-tile-action>
              <v-icon :color="chatroom.active ? 'teal' : 'grey'">chat_bubble</v-icon>
            </v-list-tile-action>
          </v-list-tile>
        </v-list>

        <v-divider></v-divider>
      </v-card>
    </v-flex>
  </v-layout>
</template>

<script>
    import axios from 'axios'
    export default {
        mounted() {
          this.fetchChatrooms()
            console.log(JSON.parse(localStorage.getItem('currentUser')))
        },
        data () {
            return {
                chatrooms: [],
                items: [
                    { active: true, title: 'Jason Oner', avatar: 'https://cdn.vuetifyjs.com/images/lists/1.jpg' },
                    { active: true, title: 'Ranee Carlson', avatar: 'https://cdn.vuetifyjs.com/images/lists/2.jpg' },
                    { title: 'Cindy Baker', avatar: 'https://cdn.vuetifyjs.com/images/lists/3.jpg' },
                    { title: 'Ali Connors', avatar: 'https://cdn.vuetifyjs.com/images/lists/4.jpg' }
                ],
                items2: [
                    { title: 'Travis Howard', avatar: 'https://cdn.vuetifyjs.com/images/lists/5.jpg' }
                ],
                chat_targets: []
            }
        },
        computed: {
            chatroom_member_other_than_me: function() {
                self = this
                return function(chatroom) {
                    return chatroom.users.filter(user => user.id != JSON.parse(localStorage.getItem('currentUser')).id).map(user => user.name).join(',')
                }
            }
        },
        methods: {
            fetchChatrooms() {
                axios.get('/api/v1/chatrooms', {
                    headers: {
                        Authorization:
                            "Bearer " + localStorage.getItem('accesstoken')
                    }
                }).then(response => {
                    console.log(response)
                    response.data.chatrooms.forEach(chatroom => {
                      console.log(chatroom)
                      this.chatrooms.push(chatroom)
                    })
                })
            },
            moveToChatroom(chatroomId) {
                this.$router.push({
                    name: "chatroom",
                    params: { id: chatroomId }
                });
            }
        }
    }
</script>
