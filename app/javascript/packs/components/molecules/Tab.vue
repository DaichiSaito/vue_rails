<template>
    <v-tabs id="tab" fixed-tabs>
        <v-tab>
            <router-link to="/">Item One</router-link>
        </v-tab>
        <v-tab><router-link to="/chatrooms">チャットルーム</router-link></v-tab>
        <v-tab><router-link to="/about">About</router-link></v-tab>
        <v-tab><router-link to="/contact">Contact</router-link></v-tab>
    </v-tabs>
</template>
<script>
    export default {
        name: 'tab'
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
