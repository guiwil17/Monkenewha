import Vue from 'vue'
import VueCompositionAPI, { createApp, h } from '@vue/composition-api'
import { createPinia, PiniaVuePlugin } from 'pinia'
import vuetify from '@/plugins/vuetify'
import { library } from '@fortawesome/fontawesome-svg-core'
import { faCoffee, faTicket,faAngleRight, faAngleLeft, faBook, faHouse, faPen, faTrash, faImage  } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import App from './App.vue';
import router from './router'
import VueGlide from 'vue-glide-js'
import 'vue-glide-js/dist/vue-glide.css'

library.add(faCoffee, faAngleLeft, faBook, faHouse, faPen, faTrash, faImage)
library.add(faTicket)
library.add(faAngleRight)

Vue.component('font-awesome-icon', FontAwesomeIcon)

Vue.use(VueCompositionAPI)
Vue.use(VueGlide)


const app = createApp({
  router,
  pinia: createPinia(),
  vuetify: vuetify,
  render: () => h(App)
})
app.use(PiniaVuePlugin)

app.mount('#app')
