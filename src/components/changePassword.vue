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
            password: "",
            verifPassword: "",
            valid: true,
            email: "",
            validation: false,
            rulesPassword: [
                (value) => !!value || 'Required.',
                (value) => (value && value.length >= 6) || 'Minimum 6 characters',
            ],
        }

    },
    created() {
        console.log(this.$route.query.token)
        API.changePassword(this.$route.query.token).then((data) => {
            console.log(data.email)
            this.email = data.email
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
        validPassword() {
            API.updatePassword(this.email, this.password).then((data) => {
                console.log("yaaaaaaaaaaaah")
                this.validation = true
            }).catch((e) => {
                console.log(e)
                this.error = true
            })
        },
    }

}

</script>

<template>
    <div class="test">
        <v-container fill-height fill-width>
            <v-row justify="center" align="center">

                <v-col align="center" justify="center" cols="12" class="titre">                    
                </v-col>
                <v-col align="center" justify="center" cols="12" class="connexion">

                    <v-card class="elevation-12">
                        <v-toolbar dark color="warning">
                            <v-toolbar-title>Validation de l'utilisateur</v-toolbar-title>
                        </v-toolbar>
                        <v-container>
                            <v-row justify="center" align="center" v-if="load && !error && !validation">
                                <v-col align="center" justify="center" cols="12" class="mt-5 mb-5">
                                    <v-form ref="form" v-model="valid" validation>
                                        <v-text-field label="Password" type="password" v-model="password"
                                            :rules="rulesPassword" autofocus></v-text-field>
                                        <v-text-field label="Confirm Password" type="password" v-model="verifPassword"
                                            :rules="[(password === verifPassword) || 'Password must match', !!verifPassword || 'Required']">
                                        </v-text-field>
                                    </v-form>
                                </v-col>
                                <v-col align="center" justify="center" cols="12" class="mt-5 mb-5">
                                    <v-btn :disabled="!valid" elevation="2" color="warning" @click="validPassword">
                                        <v-icon>Ok</v-icon>
                                    </v-btn>
                                </v-col>
                            </v-row>
                            <v-row justify="center" align="center" v-if="!load && error && !validation">
                                <v-col align="center" justify="center" cols="12" class="mt-5 mb-5">
                                    <h1 class="text-h5">
                                        Une erreure est arrivée durant la validation de votre adresse email... Si cela
                                        persiste merci de nous contacter !
                                    </h1>
                                </v-col>
                                <v-col align="center" justify="center" cols="12" class="mt-5 mb-5">
                                    <v-btn elevation="2" color="warning" @click="goToLogin">
                                        <v-icon>mdi-login-variant</v-icon>
                                    </v-btn>
                                </v-col>
                            </v-row>
                            <v-row justify="center" align="center" v-if="load && !error && validation">
                                <v-col align="center" justify="center" cols="12" class="mt-5 mb-5">
                                    <h1 class="text-h5">
                                     Mise à jour de votre mot de passe réussite ! 
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
