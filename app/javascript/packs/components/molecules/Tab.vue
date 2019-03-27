<template>
    <v-tabs id="tab" fixed-tabs>
        <v-tab to="/">ユーザ</v-tab>
        <v-tab to="/liked_by">
            <v-badge color="red">
                <template v-slot:badge v-if="unreadNotification">
                    <span>!</span>
                </template>

                <v-icon

                        color="grey"
                >
                    mail
                </v-icon>
            </v-badge>
        </v-tab>
        <v-tab to="/chatrooms">
            <v-badge color="red">
                <template v-slot:badge v-if="unreadNotification">
                    <span>!</span>
                </template>

                <v-icon

                        color="grey"
                >
                    mail
                </v-icon>
            </v-badge>
        </v-tab>
        <v-tab to="/about">About</v-tab>
        <v-tab to="/contact">Contact</v-tab>
    </v-tabs>
</template>
<script>
    export default {
        name: 'tab',
        props: {
            unreadNotification: {
                type: Boolean
            }
        }
    }
</script>
<style>
    #tab {
        position: fixed;
        bottom: 0;
        left: 0;
        right: 0;
    }
</style>
