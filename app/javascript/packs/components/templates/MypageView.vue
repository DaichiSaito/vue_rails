<template>
  <v-layout row>
    <v-flex xs12 sm6 offset-sm3>
      <v-card>
        <v-img
                src="https://cdn.vuetifyjs.com/images/lists/ali.png"
                height="300px"
        >
          <v-layout
                  column
                  fill-height
          >
            <v-card-title>
              <v-btn dark icon>
                <v-icon>chevron_left</v-icon>
              </v-btn>

              <v-spacer></v-spacer>

              <v-btn dark icon class="mr-3" @click="moveToEdit">
                <v-icon>edit</v-icon>
              </v-btn>

              <v-btn dark icon>
                <v-icon>more_vert</v-icon>
              </v-btn>
            </v-card-title>

            <v-spacer></v-spacer>

            <v-card-title class="white--text pl-5 pt-5">
              <div class="display-1 pl-5 pt-5">Ali Conners</div>
            </v-card-title>
          </v-layout>
        </v-img>

        <v-list>
          <v-list-tile @click="">
            <v-list-tile-action>
              <v-icon color="indigo">phone</v-icon>
            </v-list-tile-action>

            <v-list-tile-content>
              <v-list-tile-title>(650) 555-1234</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>

          <v-divider></v-divider>

          <v-list-tile @click="">
            <v-list-tile-action>
              <v-icon color="indigo">phone</v-icon>
            </v-list-tile-action>

            <v-list-tile-content>
              <v-list-tile-title>(650) 555-1234</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>

          <v-divider></v-divider>

          <v-list-tile @click="">
            <v-list-tile-action>
              <v-icon color="indigo">phone</v-icon>
            </v-list-tile-action>

            <v-list-tile-content>
              <v-list-tile-title>(650) 555-1234</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>

          <v-divider></v-divider>

        </v-list>
      </v-card>
    </v-flex>
  </v-layout>
</template>
<script>
  export default {
      methods: {
          moveToEdit() {
              this.$router.push({ path: '/mypage/edit'})
          }
      }
  }
</script>
