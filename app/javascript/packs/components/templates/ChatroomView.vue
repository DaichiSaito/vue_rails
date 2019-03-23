<template>
  <v-layout row>
    <v-flex xs12 sm6 offset-sm3>
      <v-card>

        <v-list subheader>
          <v-subheader>Recent chat</v-subheader>
          <v-list-tile
                  v-for="item in items"
                  :key="item.title"
                  avatar
                  @click=""
          >
            <v-list-tile-avatar>
              <img :src="item.avatar">
            </v-list-tile-avatar>

            <v-list-tile-content>
              <v-list-tile-title v-html="item.title"></v-list-tile-title>
            </v-list-tile-content>

            <v-list-tile-action>
              <v-icon :color="item.active ? 'teal' : 'grey'">chat_bubble</v-icon>
            </v-list-tile-action>
          </v-list-tile>
        </v-list>

        <v-divider></v-divider>

        <v-list subheader>
          <v-subheader>Previous chats</v-subheader>

          <v-list-tile
                  v-for="item in items2"
                  :key="item.title"
                  avatar
                  @click=""
          >
            <v-list-tile-avatar>
              <img :src="item.avatar">
            </v-list-tile-avatar>

            <v-list-tile-content>
              <v-list-tile-title v-html="item.title"></v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
        </v-list>
      </v-card>
    </v-flex>
  </v-layout>
</template>

<script>
    import axios from 'axios'
    export default {
        mounted() {
          this.fetchChatrooms()
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
                ]
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
                    response.data.data.forEach(chatroom => {
                      console.log(chatroom)
                        console.log(chatroom.id)
                        console.log(chatroom.relationships.users.data)
                        console.log()
                    })
                    // const chatroom = {
                    //     id: response.data.
                    // }
                    // response.data.data.forEach(like_user => {
                    //     console.log(like_user.id.toString())
                    //     const id = like_user.id.toString()
                    //     this.like_users.push(like_user.id)
                    // })
                })
            }
        }
    }
</script>
