<template>
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
                  :img="option.img"
                  :outputSize="1"
                  :outputType="option.outputType"
                  :info="false"
                  :autoCrop="true"
                  :autoCropWidth="400"
                  :autoCropHeight="400"
                  :centerBox="true"
                  @imgLoad="imgLoad"
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
</template>

<script>
    import { VueCropper } from "vue-cropper";

    // import { VueCropper } from '../test'

    // import codes from "./code";
    import axios from 'axios'

    export default {
        data: function() {
            return {
                model: false,
                modelSrc: "",
                crap: false,
                previews: {},
                lists: [
                    // {
                    // 	img: 'https://fengyuanchen.github.io/cropper/images/picture.jpg'
                    // },
                    {
                        img: "https://avatars2.githubusercontent.com/u/15681693?s=460&v=4"
                    },
                    {
                        img: "http://cdn.xyxiao.cn/Landscape_1.jpg"
                    },
                    {
                        img: "http://cdn.xyxiao.cn/Landscape_2.jpg"
                    },
                    {
                        img: "http://cdn.xyxiao.cn/Landscape_3.jpg"
                    },
                    {
                        img: "http://cdn.xyxiao.cn/Landscape_4.jpg"
                    },
                    {
                        img: "http://cdn.xyxiao.cn/Portrait_1.jpg"
                    },
                    {
                        img: "http://cdn.xyxiao.cn/Portrait_2.jpg"
                    }
                ],
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
                example2: {
                    img: "http://cdn.xyxiao.cn/Landscape_1.jpg",
                    info: true,
                    size: 1,
                    outputType: "jpeg",
                    canScale: true,
                    autoCrop: true,
                    // 只有自动截图开启 宽度高度才生效
                    autoCropWidth: 300,
                    autoCropHeight: 250,
                    fixed: true,
                    // 真实的输出宽高
                    infoTrue: true,
                    fixedNumber: [4, 3]
                },
                example3: {
                    img: "http://cdn.xyxiao.cn/Landscape_1.jpg",
                    autoCrop: true,
                    autoCropWidth: 200,
                    autoCropHeight: 200,
                    fixedBox: true
                },
                downImg: "#",
                previewStyle1: {},
                previewStyle2: {},
                previewStyle3: {},
                previewStyle4: {},
                code0: '',
                code1: '',
                code2: '',
                code3: '',
                preview3: '',
            };
        },
        methods: {
            changeImg() {
                this.option.img = this.lists[~~(Math.random() * this.lists.length)].img;
            },
            // 实时预览函数
            realTime(data) {
                var previews = data;
                var h = 0.5;
                var w = 0.2;

                this.previewStyle1 = {
                    width: previews.w + "px",
                    height: previews.h + "px",
                    overflow: "hidden",
                    margin: "0",
                    zoom: h
                };

                this.previewStyle2 = {
                    width: previews.w + "px",
                    height: previews.h + "px",
                    overflow: "hidden",
                    margin: "0",
                    zoom: w
                };

                this.previewStyle3 = {
                    width: previews.w + "px",
                    height: previews.h + "px",
                    overflow: "hidden",
                    margin: "0",
                    zoom: (100 / previews.w)
                };

                this.previewStyle4 = {
                    width: previews.w + "px",
                    height: previews.h + "px",
                    overflow: "hidden",
                    margin: "0",
                    zoom: (100 / previews.h)
                };

                this.previews = data;
            },

            down(type) {
                // event.preventDefault()
                // 输出
                if (type === "blob") {
                    this.$refs.cropper.getCropBlob(data => {
                        let formData = new FormData();
                        formData.append('avatar', data);
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
                        }).catch(error => {
                            console.log(error)
                        })

                        this.$nextTick(() => {
                            this.$refs.downloadDom.click();
                        });
                    });
                } else {
                    this.$refs.cropper.getCropData(data => {
                        this.downImg = data;
                        if (window.navigator.msSaveBlob) {
                            var blobObject = new Blob([data]);
                            window.navigator.msSaveBlob(blobObject, "demo.png");
                        } else {
                            this.$nextTick(() => {
                                this.$refs.downloadDom.click();
                            });
                        }
                    });
                }
            },

            uploadImg(e, num) {
                //上传图片
                // this.option.img
                var file = e.target.files[0];
                if (!/\.(gif|jpg|jpeg|png|bmp|GIF|JPG|PNG)$/.test(e.target.value)) {
                    alert(".gif,jpeg,jpg,png,bmpファイルしかアップロードできません。");
                    return false;
                }
                var reader = new FileReader();
                reader.onload = e => {
                    let data;
                    if (typeof e.target.result === "object") {
                        // 把Array Buffer转化为blob 如果是base64不需要
                        data = window.URL.createObjectURL(new Blob([e.target.result]));
                    } else {
                        data = e.target.result;
                    }
                    if (num === 1) {
                        this.option.img = data;
                    } else if (num === 2) {
                        this.example2.img = data;
                    }
                };
                // 转化为base64
                // reader.readAsDataURL(file)
                // 转化为blob
                reader.readAsArrayBuffer(file);
            },
            imgLoad(msg) {
                console.log(msg);
            },

            cropMoving(data) {
                this.option.cropData = data;
            }
        },
        components: {
            VueCropper,
            // codes
        },
        mounted() {
            this.changeImg();
        }
    };
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
