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
                    {{ matchingUser.name }}
                </v-card-title>

                <v-card-text>
                    マッチング成立だよ！！
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
        props: {
            matchingUser: {
              type: Object
          }
        },
        // data() {
        //     return {
        //         dialog: false
        //     }
        // },
        computed: {
            dialog: function() {
                return this.matchingUser != null
            }
        },
        methods: {
            close: function() {
                this.$emit('close')
            }
        }
    }
</script>
