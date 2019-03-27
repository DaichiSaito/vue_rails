import axios from 'axios'
export default {
    fetchUnreadMessages: () => {
        return new Promise((resolve, reject) => {
            axios.get(`/api/v1/messages/unread`, {
                headers: {
                    Authorization:
                        "Bearer " + localStorage.getItem('accesstoken')
                }
            }).then(response => {
                resolve(response.data)
            }).catch(err => {
                reject(new Error(err.response.data.message || err.message))
            })
        })
    }
}
