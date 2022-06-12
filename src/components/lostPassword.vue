<script >
import AuthenticationService from './../AuthenticationService'
import axios from 'axios';
import router from '@/router';
import API from './../api'

export default {
    data() {
        return {
            load: false,
            error: false,
            email: "",
            valid: true,
            champs : [(v) => !!v || 'Merci de remplir le champs']            
        }

    },
    methods: {
        goToLogin() {
            router.push('/Login')
        },
        connect() {
            console.log(this.email)
            API.lostPassword(this.email).then((data) => {
                console.log("yaaaaaaaaaaaah")
                this.load = true
            }).catch((e) => {
                console.log(e)
                this.error = true
            })
        }
    }

}

</script>

<template>
    <div class="test">
        <v-container fill-height fill-width>
            <v-row justify="center" align="center">

                <v-col align="center" justify="center" cols="12" class="titre">                   
                    <v-btn elevation="2" color="warning" @click="goToLogin">
                        <v-icon>mdi-login-variant</v-icon>
                    </v-btn>
                </v-col>
                <v-col align="center" justify="center" cols="12" class="connexion">

                    <v-card class="elevation-12" v-if="!load">
                        <v-toolbar dark color="warning">
                            <v-toolbar-title>Mot de passe oublié</v-toolbar-title>
                        </v-toolbar>
                        <v-form ref="form" v-model="valid" validation>
                            <v-card-text>
                                <v-text-field name="email" label="email" type="text" v-model="email" :rules="champs">
                                </v-text-field>
                            </v-card-text>
                        </v-form>
                        <v-card-actions>
                            <v-container fill-height fill-width>
                                <v-row justify="center" align="center">
                                    <v-col align="center" justify="center" cols="12" class="btnLogin">
                                        <h1 class="text-h2">
                                            <v-btn :disabled="!valid" color="warning" @click="connect">Envoyer</v-btn>
                                        </h1>
                                    </v-col>
                                </v-row>
                            </v-container>
                        </v-card-actions>

                    </v-card>
                     <v-card class="elevation-12" v-if="load">
                        <v-toolbar dark color="warning">
                            <v-toolbar-title>Mot de passe oublié</v-toolbar-title>
                        </v-toolbar>

                        Un email a été envoyé à {{this.email}}. Merci de cliquer sur le lien 
                       
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
