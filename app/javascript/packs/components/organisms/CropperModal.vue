<template>
  <div class="text-xs-center">
    <v-dialog
            v-model="imgSrc"
            width="90%"
            v-if="imgSrc"
    >

      <v-card>
        <v-card-title
                class="headline grey lighten-2"
                primary-title
        >
          モーダルです
        </v-card-title>

        <v-card-text>
          <div class="wrapper">
            <div class="model" v-show="model">
              <div class="model-show" @click="model = false">
                <img :src="modelSrc" alt="" @click="model = false">
              </div>
            </div>
            <div class="content">
              <div class="show-info">
                <h2>example1 基本例子 无限制</h2>
                <div class="test test1">
                  <vueCropper
                          ref="cropper"
                          :img="imgSrc"
                          :outputSize="1"
                          :outputType="option.outputType"
                          :info="false"
                          :autoCrop="true"
                          :autoCropWidth="400"
                          :autoCropHeight="400"
                          :centerBox="true"
                          @cropMoving="cropMoving"
                          :fixed="true"
                  ></vueCropper>
                </div>
                <div class="test-button">
                  <label class="btn" for="uploads">upload</label>
                  <input type="file" id="uploads" style="position:absolute; clip:rect(0 0 0 0);" accept="image/png, image/jpeg, image/gif, image/jpg" @change="uploadImg($event, 1)">
                  <a @click="down('blob')" class="btn">download(blob)</a>
                </div>
              </div>
            </div>
          </div>
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
    import { VueCropper } from "vue-cropper";
    import axios from "axios"
    export default {
        props: {
            imgSrc: {
                type: String,
            },
        },
        data() {
            return {
                model: false,
                modelSrc: "",
                crap: false,
                option: {
                    img: "",
                    size: 1,
                    full: false,
                    outputType: "jpeg",
                    canMove: true,
                    fixedBox: true,
                    original: false,
                    canMoveBox: true,
                    autoCrop: true,
                    // 只有自动截图开启 宽度高度才生效
                    autoCropWidth: 400,
                    autoCropHeight: 400,
                    centerBox: false,
                    high: false,
                    cropData: {},
                    enlarge: 1,
                    mode: 'contain',
                    maxImgSize: 2000
                },
            }
        },
        methods: {
            close: function() {
                this.$emit('close', JSON.parse(localStorage.getItem('currentUser')))
            },
            down(type) {
                self = this
                // event.preventDefault()
                // 输出
                this.$refs.cropper.getCropBlob(data => {
                    let formData = new FormData();
                    let fileName = new Date().getTime()
                    formData.append('avatar', data, fileName);
                    axios.patch('/api/v1/profile/avatar',
                        formData,
                        {
                            headers: {
                                Authorization:
                                    "Bearer " + localStorage.getItem('accesstoken'),
                                'content-type': 'multipart/form-data'
                            }
                        }).then(response => {
                        localStorage.setItem('currentUser', JSON.stringify(response.data.user));
                        alert("アップロード完了")
                        self.close()
                    }).catch(error => {
                        console.log(error)
                    })
                });
            },

            cropMoving(data) {
                this.option.cropData = data;
            }
        },
        components: {
            VueCropper,
        },
    }
</script>

<style>
  * {
    margin: 0;
    padding: 0;
  }

  .content {
    margin: auto;
    max-width: 1200px;
    margin-bottom: 100px;
  }

  .test-button {
    display: flex;
    flex-wrap: wrap;
  }

  .btn {
    display: inline-block;
    line-height: 1;
    white-space: nowrap;
    cursor: pointer;
    background: #fff;
    border: 1px solid #c0ccda;
    color: #1f2d3d;
    text-align: center;
    box-sizing: border-box;
    outline: none;
    margin: 20px 10px 0px 0px;
    padding: 9px 15px;
    font-size: 14px;
    border-radius: 4px;
    color: #fff;
    background-color: #50bfff;
    border-color: #50bfff;
    transition: all 0.2s ease;
    text-decoration: none;
    user-select: none;
  }

  .des {
    line-height: 30px;
  }

  code.language-html {
    padding: 10px 20px;
    margin: 10px 0px;
    display: block;
    background-color: #333;
    color: #fff;
    overflow-x: auto;
    font-family: Consolas, Monaco, Droid, Sans, Mono, Source, Code, Pro, Menlo,
    Lucida, Sans, Type, Writer, Ubuntu, Mono;
    border-radius: 5px;
    white-space: pre;
  }

  .show-info {
    margin-bottom: 50px;
  }

  .show-info h2 {
    line-height: 50px;
  }

  /*.title, .title:hover, .title-focus, .title:visited {
      color: black;
    }*/

  .title {
    display: block;
    text-decoration: none;
    text-align: center;
    line-height: 1.5;
    margin: 20px 0px;
    background-image: -webkit-linear-gradient(
            left,
            #3498db,
            #f47920 10%,
            #d71345 20%,
            #f7acbc 30%,
            #ffd400 40%,
            #3498db 50%,
            #f47920 60%,
            #d71345 70%,
            #f7acbc 80%,
            #ffd400 90%,
            #3498db
    );
    color: transparent;
    -webkit-background-clip: text;
    background-size: 200% 100%;
    animation: slide 5s infinite linear;
    font-size: 40px;
  }

  .test {
    height: 500px;
  }

  .model {
    position: fixed;
    z-index: 10;
    width: 100vw;
    height: 100vh;
    overflow: auto;
    top: 0;
    left: 0;
    background: rgba(0, 0, 0, 0.8);
  }

  .model-show {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100vw;
    height: 100vh;
    text-align: center;
  }

  .model img {
    display: block;
    margin: auto;
    max-width: 80%;
    width: auto;
    user-select: none;
    background-position: 0px 0px, 10px 10px;
    background-size: 20px 20px;
    background-image: linear-gradient(
            45deg,
            #eee 25%,
            transparent 25%,
            transparent 75%,
            #eee 75%,
            #eee 100%
    ),
    linear-gradient(45deg, #eee 25%, white 25%, white 75%, #eee 75%, #eee 100%);
  }

  .c-item {
    display: block;
    padding: 10px 0;
    user-select: none;
  }

  .pre {
    display: flex;
  }

  .pre-item {
    padding-right: 20px;
  }

  @keyframes slide {
    0% {
      background-position: 0 0;
    }
    100% {
      background-position: -100% 0;
    }
  }

  @media screen and (max-width: 1000px) {
    .content {
      max-width: 90%;
      margin: auto;
    }

    .test {
      height: 400px;
    }
  }
</style>
