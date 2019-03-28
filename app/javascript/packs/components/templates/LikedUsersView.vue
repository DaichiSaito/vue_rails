<template>
  <div>
    <tinder
            ref="tinder"
            :allow-super="false"
            :queue.sync="queue"
            @submit="submit">
      <template slot-scope="{data}">
        <!--<div-->
                <!--class="pic"-->
                <!--:style="`background-image:url(https://picsum.photos/710/1152/?random=${data.key})`">-->
        <!--</div>-->
        <!--<img :src="`https://picsum.photos/710/1152/?random=${data.key}`">-->
        <img :src="require('@/assets/profile-placeholder.png')">
        <div>
          <span class="grey--text">{{ data.user.name }}</span><br>
          <span>Whitehaven Beach</span><br>
          <span>Whitsunday Island, Whitsunday Islands</span>
        </div>
      </template>
      <img class="like-pointer" slot="like" src="https://johnnydan.oss-cn-beijing.aliyuncs.com/vue-tinder/like-txt.png">
      <img class="nope-pointer" slot="nope" src="https://johnnydan.oss-cn-beijing.aliyuncs.com/vue-tinder/nope-txt.png">
      <img class="super-pointer" slot="super" src="https://johnnydan.oss-cn-beijing.aliyuncs.com/vue-tinder/super-txt.png">
    </tinder>
    <div class="btns">
      <img src="https://johnnydan.oss-cn-beijing.aliyuncs.com/vue-tinder/nope.png" @click="decide('nope')">
      <img src="https://johnnydan.oss-cn-beijing.aliyuncs.com/vue-tinder/like.png" @click="decide('like')">
    </div>
    <Dialog v-bind:matching-user="matchingUser" v-on:close="closeModal()"/>
  </div>
</template>
<script>
    import axios from 'axios'
    import tinder from 'vue-tinder'
    import Dialog from '@/components/organisms/Dialog.vue'
    import { Read } from '@/api'
    export default {
        data() {
            return {
                user: Object,
                queue: [],
                matchingUser: null
            }
        },
        components: {
            tinder,
            Dialog
        },
        mounted() {
          this.fetchLikedBy()
        },
        created() {
            // this.getData()
        },
        computed: {

        },
        methods: {
            fetchLikedBy() {
                axios.get('/api/v1/unread_liked', {
                    headers: {
                        Authorization:
                            "Bearer " + localStorage.getItem('accesstoken')
                    }
                }).then(response => {
                    console.log(response)
                    const list = []
                    response.data.users.forEach (user => {
                      // this.user = user
                      //   this.queue.push(user)
                        list.push({
                            key: user.id,
                            user: user
                        })
                    })

                    this.queue = this.queue.concat(list)

                }).catch(error => {
                    console.log(error)
                })
            },
            closeModal() {
                this.matchingUser = null
            },
            getData () {
                const list = []
                for (let i = 0; i < 5; i++) {
                    list.push({
                        key: Math.random()
                    })
                }
                this.queue = this.queue.concat(list)
            },
            decide (choice) {
                this.$refs.tinder.decide(choice)
            },

            like(userId) {

                self = this

                axios.post('/api/v1/likes',
                    { to_id: userId },
                    { headers: {
                            Authorization:
                                "Bearer " + localStorage.getItem('accesstoken')
                        }
                    }).then(response => {
                    console.log("いいねしたよ！")
                    if (response.data.meta && response.data.meta.matching) {
                        self.matchingUser = response.data.user
                        this.$emit('fetchUnread')
                    }

                }, (error) => {
                    console.log(error);
                });
            },

            submit (choice) {
                console.log(choice)
                switch (choice.type) {
                    case 'nope': // 左滑
                        break;
                    case 'like': // 右滑
                        console.log(choice.item.user.id)
                        this.like(choice.item.user.id)
                        break;
                    case 'super': // 上滑
                        break;
                }
                if (this.queue.length < 2) {
                    // this.fetchLikedBy()
                }
            },
            closeModal() {
                this.matchingUser = null
            },
        }
    }
</script>
<style scoped>
  /* 此样式可能仅适用本demo，仅供参考，可根据具体设计稿或喜好自定义 */
  html,body{ height: 100%; }

  body { background: #20262E;overflow: hidden; }

  /* 直接script引用建议增加，不然会引发闪烁，单文件组件不需要 */
  [v-cloak] { display: none; }

  /* 注意！组件的宽高必须设置，不然出不来！！！ */
  #app .vue-tinder {
    position: absolute;
    z-index: 1;
    left: 0;
    right: 0;
    top: 23px;
    margin: auto;
    width: calc(100% - 20px);
    height: calc(100% - 23px - 18%);
    min-width: 300px;
    max-width: 355px;
  }

  /* 卡片内的3种状态指示器位置，透明度会由组件自动调整 */
  .nope-pointer { right: 10px; }
  .like-pointer { left: 10px; }
  .nope-pointer,
  .like-pointer {
    position: absolute;
    z-index: 1;
    top: 20px;
    width: 64px;
    height: 64px;
  }
  .super-pointer {
    position: absolute;
    z-index: 1;
    bottom: 80px;
    left: 0;
    right: 0;
    margin: auto;
    width: 112px;
    height: 78px;
  }

  /* slot内图片样式 */
  .pic {
    width: 100%;
    height: 100%;
    background-size: cover;
  }

  /* 按钮样式 */
  .btns {
    position: absolute;
    left: 0;
    right: 0;
    bottom: 30px;
    margin: auto;
    height: 18%;
    display: flex;
    align-items: center;
    justify-content: center;
    min-width: 300px;
    max-width: 355px;
    z-index: 1;
  }
  .btns img{ width: 80px; }
  img {
    max-width: 100%;
  }
</style>
