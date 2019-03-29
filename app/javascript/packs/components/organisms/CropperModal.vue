<template>
  <div class="text-xs-center">
    <v-dialog
            v-model="dialog"
            width="500"
            v-if="dialog"
    >

      <v-card>
        <v-card-title
                class="headline grey lighten-2"
                primary-title
        >
          モーダルです
        </v-card-title>

        <v-card-text>
          モーダルだよ！
        </v-card-text>

        <v-divider></v-divider>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
                  color="primary"
                  flat
                  @click="close"
          >
            I accept
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
    export default {
        data() {
            return {
                dialog: false
            }
        },
        methods: {
            close: function() {
                this.$emit('close')
            }
        }
    }
</script>
