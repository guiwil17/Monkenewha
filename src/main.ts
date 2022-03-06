import Vue from 'vue'
import VueCompositionAPI, { createApp, h } from '@vue/composition-api'
import { createPinia, PiniaVuePlugin } from 'pinia'
import vuetify from '@/plugins/vuetify'
import { library } from '@fortawesome/fontawesome-svg-core'
import { faCoffee } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import App from './App.vue'
import router from './router'

library.add(faCoffee)
Vue.component('font-awesome-icon', FontAwesomeIcon)

Vue.use(VueCompositionAPI)

const app = createApp({
  router,
  pinia: createPinia(),
  vuetify: vuetify,
  render: () => h(App)
})
app.use(PiniaVuePlugin)

app.mount('#app')
