<script >
import AuthenticationService from './../AuthenticationService'
import axios from 'axios';
import router from '@/router';
import API from './../api'


export default {
  data() {
    return {     
      load: false, 
      error: false           
    }

  },
  created() {   
      console.log(this.$route.query.token)
      API.validateAccount(this.$route.query.token).then((data) => {
console.log("yaaaaaaaaaaaah")
this.load = true
   }).catch((e) => {
console.log(e)
this.error = true
   })

  },
  methods: {       
        goToLogin() {
            this.$router.push('/Login')
        },
  }

}

</script>

<template>
    <div class="test">
        <v-container fill-height fill-width>
            <v-row justify="center" align="center">

                <v-col align="center" justify="center" cols="12" class="titre">
                    <h1 class="text-h2">
                        Monkenewha
                    </h1>
                </v-col>
                <v-col align="center" justify="center" cols="12" class="connexion">

                    <v-card class="elevation-12">
                        <v-toolbar dark color="warning">
                            <v-toolbar-title>Validation de l'utilisateur</v-toolbar-title>
                        </v-toolbar>
                        <v-container>
                            <v-row justify="center" align="center">
                                <v-col align="center" justify="center" cols="12" class="mt-5 mb-5">
                                    <h1 class="text-h5" v-if="load && !error">
                                        Votre adresse email a bien été validé !
                                    </h1>
                                     <h1 class="text-h5" v-else>
                                       Une erreure est arrivée durant la validation de votre adresse email... Si cela persiste merci de nous contacter !
                                    </h1>
                                </v-col>
                                <v-col align="center" justify="center" cols="12" class="mt-5 mb-5">
                                    <v-btn elevation="2" color="warning" @click="goToLogin">
                                        <v-icon>mdi-login-variant</v-icon>
                                    </v-btn>
                                </v-col>
                            </v-row>
                        </v-container>

                    </v-card>
                </v-col>
            </v-row>
        </v-container>
    </div>
</template>

<style scoped>
.test {
    height: 100vh;
    background-color: #FEFFFF;
    color: BLACK;
}

.titre {
    height: 20vh;
}

.btnLogin {
    height: 10vh;
}

.connexion {
    height: 60vh;
}

.buton {
    height: 10vh;
}
</style>
