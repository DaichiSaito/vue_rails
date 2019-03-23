<template>
    <v-tabs id="tab" fixed-tabs>
        <v-tab to="/">ユーザ</v-tab>
        <v-tab to="/chatrooms">チャットルーム</v-tab>
        <v-tab to="/about">About</v-tab>
        <v-tab to="/contact">Contact</v-tab>
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
