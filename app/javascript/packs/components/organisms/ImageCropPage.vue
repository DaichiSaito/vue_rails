<template>
  <div>
    <p v-show="show">あいうえおかきくけこ</p>
  </div>
</template>

<script>

    export default {
        props: {
            show: {
                type: Boolean,
                default: true
            }
        },
    };
</script>
