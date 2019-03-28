<template>
  <v-form
          ref="form"
          v-model="valid"
          lazy-validation
  >
    <v-text-field
            v-model="user.name"
            :counter="10"
            :rules="nameRules"
            label="Name"
            required
    ></v-text-field>

    <v-text-field
            v-model="email"
            :rules="emailRules"
            label="E-mail"
            required
    ></v-text-field>

    <v-select
            v-model="select"
            :items="items"
            item-text="name"
            item-value="id"
            :rules="[v => !!v || 'Item is required']"
            label="Item"
            required
            return-object
    ></v-select>

    <v-checkbox
            v-model="checkbox"
            :rules="[v => !!v || 'You must agree to continue!']"
            label="Do you agree?"
            required
    ></v-checkbox>

    <v-btn
            :disabled="!valid"
            color="success"
            @click="validate"
    >
      Validate
    </v-btn>

    <v-btn
            :disabled="!valid"
            color="success"
            @click="updateProfile"
    >
      プロフィールを更新
    </v-btn>

    <v-btn
            color="error"
            @click="reset"
    >
      Reset Form
    </v-btn>

    <v-btn
            color="warning"
            @click="resetValidation"
    >
      Reset Validation
    </v-btn>
  </v-form>
</template>

<script>
    import axios from 'axios'
    export default {
        data: () => ({
            valid: true,
            name: '',
            nameRules: [
                v => !!v || 'Name is required',
                v => (v && v.length <= 10) || 'Name must be less than 10 characters'
            ],
            email: '',
            emailRules: [
                v => !!v || 'E-mail is required',
                v => /.+@.+/.test(v) || 'E-mail must be valid'
            ],
            select: {},
            items: [
                { id: 1, name: 'Item1' },
                { id: 2, name: 'Item2' },
                { id: 3, name: 'Item3' },
                { id: 4, name: 'Item4' },
            ],
            checkbox: false,
            user: {}
        }),
        mounted() {
            let user = JSON.parse(localStorage.getItem('currentUser'))
            console.log("user")
            this.user = user
            this.fetchAges()

        },

        methods: {
            validate () {
                if (this.$refs.form.validate()) {
                    this.snackbar = true
                }
            },
            reset () {
                this.$refs.form.reset()
            },
            resetValidation () {
                this.$refs.form.resetValidation()
            },
            fetchAges() {
                self = this
              axios.get('/api/v1/ages',
                  {
                      headers: {
                          Authorization:
                              "Bearer " + localStorage.getItem('accesstoken')
                      }
              }).then(response => {
                  console.log(response)
                  self.items = response.data.ages
                  self.items.forEach(item => {
                      if(item.id == self.user.age_id) {
                          self.select = item
                          return
                      }
                  })
              }).catch(error => {
                  console.log(error)
              })
            },
            updateProfile() {
                console.log(this.select)
                axios.patch('/api/v1/profile',
                    {
                        user: {
                            name: this.user.name,
                            age_id: this.select.id
                        }
                    },
                    {
                    headers: {
                        Authorization:
                            "Bearer " + localStorage.getItem('accesstoken')
                    }
                }).then(response => {
                    console.log(response)
                    localStorage.setItem('currentUser', JSON.stringify(response.data.user));
                }).catch(error => {
                    console.log(error)
                })

            }
        }
    }
</script>
