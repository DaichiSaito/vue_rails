<template>
  <v-app>
    <v-navigation-drawer
            fixed
            clipped
            app
            v-model="navBar"
    >
      <v-list dense class="pt-0">
        <router-link to="/">
          <v-list-tile>
            <v-list-tile-action>
              <v-icon>dashboard</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title>DASHBOARD</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
        </router-link>
        <router-link to="/setting">
          <v-list-tile>
            <v-list-tile-action>
              <v-icon>settings</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title>SETTING</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
        </router-link>
      </v-list>
    </v-navigation-drawer>
    <v-toolbar
            dark
            color="primary"
            clipped-left
            fixed
            app
    >
      <v-toolbar-side-icon @click.stop="navBar = !navBar"></v-toolbar-side-icon>
      <v-toolbar-title class="white--text">Title</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn icon>
        <v-icon>search</v-icon>
      </v-btn>
      <v-btn icon>
        <v-icon>apps</v-icon>
      </v-btn>
      <v-btn icon>
        <v-icon>refresh</v-icon>
      </v-btn>
      <v-btn icon>
        <v-icon>more_vert</v-icon>
      </v-btn>

    </v-toolbar>
    <v-content>
      <v-container fluid fill-height>
        <v-fade-transition mode="out-in">
          <router-view v-on:fetchUnread="fetchUnread()"></router-view>
        </v-fade-transition>
      </v-container>
    </v-content>
    <Tab v-bind:unread-notification="unreadNotification" v-bind:unread-like="unreadLike"/>
  </v-app>
</template>

<script>
    import Tab from './packs/components/molecules/Tab'
    import { Read } from '@/api'
    export default {
        name: "app",
        data() {
            return {
                navBar: false,
                unreadNotification: false,
                unreadLike: false
            }
        },
        components: {
            Tab
        },
        methods: {
            addUnread: function() {
                console.log("addUnread")
                this.unreadNotification = true
            },
            removeUnread: function() {
                console.log("removeUnread")
                this.unreadNotification = false
            },
            fetchUnreadMessages() {
                self = this
                Read.fetchUnreadMessages().then(response => {
                    if (response.has_unread) {
                        console.log('未読あり')
                        // self.$emit('addUnread')
                        this.unreadNotification = true
                    } else {
                        console.log('未読なし')
                        // self.$emit('removeUnread')
                        this.unreadNotification = false
                    }
                })
            },
            fetchUnreadLikes() {
                self = this
                Read.fetchUnreadLikes().then(response => {
                    if(response.users.length > 0) {
                        this.unreadLike = true
                    } else {
                        this.unreadLike = false
                    }
                })
            },
            fetchUnread() {
                this.fetchUnreadLikes()
                this.fetchUnreadMessages()

            }
        },
        watch: {
            '$route': 'fetchUnread'
        }
    };
</script>

<style lang="scss">
  #app {
    font-family: "Avenir", Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
  }
  a {
    text-decoration: none;
  }
</style>
