const path = require('path')

module.exports = {
    resolve: {
        alias: {
            '@': path.resolve(__dirname, '..', '..', 'app/javascript/packs'),
            'vue$': 'vue/dist/vue.common.js'
        }
    }
}
