<script >
import API from './../api'

export default {
    data: () => ({
        step: 1,
        valid: true,
        email: '',
        password: '',
        name: '',
        firstName: '',
        verifPassword: '',
        adresse: '',
        rulesEmail: [
            value => !!value || 'Required.',
            value => {
                const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
                return pattern.test(value) || 'Email invalide.'
            },
        ],
        rulesPassword: [
            (value) => !!value || 'Required.',
            (value) => (value && value.length >= 6) || 'Minimum 6 characters',
        ],
        rulesConfirmPassword: [
            (value) => !!value || 'Required',
            (value) => value === "vvvvv" || 'Les 2 mots de passes ne sont pas identiques',
        ],
        champs: [(v) => !!v || 'Required.']
    }),

    computed: {
        currentTitle() {
            switch (this.step) {
                case 1: return 'Sign-up'
                case 2: return 'Création du mot de passe'
                case 3: return 'Informations complémentaires'
                default: return 'Compte créé'
            }
        },
        test(value) {
            console.log(value)
        }
    },
    methods: {
        goToLogin() {
            this.$router.push('/Login')
        },
        createAccount() {
            API.createAccount(this.email, this.password, this.name, this.firstName, this.adresse).then((data) => {
                console.log(data)
                this.step++
            })  
        }
    }
}
</script>

<template>
    <div class="test">
        <v-container fill-height fill-width>
            <v-row justify="center" align="center">
                <v-col align="center" justify="center" cols="12" class="distance"></v-col>
                <v-col align="center" justify="center" cols="12" class="titre">                   
                    <v-btn elevation="2" color="warning" @click="goToLogin">
                        <v-icon >mdi-login-variant</v-icon>
                    </v-btn>
                </v-col>
                <v-col align="center" justify="center" cols="12" class="connexion">

                    <v-card class="elevation-12 form">
                        <v-toolbar dark color="warning">
                            <v-toolbar-title>{{ currentTitle }}</v-toolbar-title>
                        </v-toolbar>
                        <v-card class="mt-5" max-width="700">
                            <v-card-title class="text-h6 font-weight-regular justify-space-between">
                                <span></span>
                                <v-avatar color="primary lighten-2" class="subheading white--text" size="24"
                                    v-text="step"></v-avatar>
                            </v-card-title>

                            <v-window v-model="step">
                                <v-window-item :value="1">
                                    <v-card-text>
                                        <v-form ref="form" v-model="valid" validation>
                                            <v-text-field label="Email" value="john@vuetifyjs.com" v-model="email"
                                                :rules="rulesEmail" autofocus></v-text-field>
                                        </v-form>
                                        <span class="text-caption grey--text text--darken-1">
                                            Merci de rentrer un email valide
                                        </span>
                                    </v-card-text>
                                </v-window-item>

                                <v-window-item :value="2">
                                    <v-card-text>
                                        <v-form ref="form" v-model="valid" validation>
                                            <v-text-field label="Password" type="password" v-model="password"
                                                :rules="rulesPassword" autofocus></v-text-field>
                                            <v-text-field label="Confirm Password" type="password"
                                                v-model="verifPassword"
                                                :rules="[(password === verifPassword) || 'Password must match', !!verifPassword || 'Required']">
                                            </v-text-field>
                                        </v-form>
                                        <span class="text-caption grey--text text--darken-1">
                                            Merci d'entrer un mot de passe !
                                        </span>
                                    </v-card-text>
                                </v-window-item>
                                <v-window-item :value="3">
                                    <v-card-text>
                                        <v-form ref="form" v-model="valid" validation>
                                            <v-text-field label="Nom" v-model="name" :rules="champs" autofocus>
                                            </v-text-field>
                                            <v-text-field label="Prénom" v-model="firstName" :rules="champs">
                                            </v-text-field>
                                            <v-text-field label="Adresse" v-model="adresse" :rules="champs">
                                            </v-text-field>.
                                        </v-form>
                                        <span class="text-caption grey--text text--darken-1">
                                            Merci d'entrer vos informations
                                        </span>
                                    </v-card-text>
                                </v-window-item>

                                <v-window-item :value="4">
                                    <div class="pa-4 text-center">
                                        <v-img class="mb-4" contain height="128"
                                            src="https://cdn.vuetifyjs.com/images/logos/v.svg"></v-img>
                                        <h3 class="text-h6 font-weight-light mb-2">
                                            Bienvenue sur Monkenewha
                                        </h3>
                                        <span class="text-caption grey--text">Merci pour votre inscription, un email de
                                            validation va vous être envoyé ! </span>
                                    </div>
                                </v-window-item>
                            </v-window>

                            <v-divider></v-divider>

                            <v-card-actions>
                                <v-btn :disabled="step === 1 || step === 4" text @click="step--">
                                    Back
                                </v-btn>
                                <v-spacer></v-spacer>


                                <v-btn elevation="2" color="warning" @click="goToLogin" v-if="step === 4">
                                    <v-icon>mdi-login-variant</v-icon>
                                </v-btn>

                                <v-btn :disabled="step === 4 || !valid" color="primary" depressed @click="createAccount"
                                    v-else-if="step === 3">
                                    Next
                                </v-btn>
                                    <v-btn :disabled="step === 4 || !valid" color="primary" depressed @click="step++"
                                    v-else>
                                    Next
                                </v-btn>
                            </v-card-actions>
                        </v-card>
                    </v-card>
                </v-col>
            </v-row>
        </v-container>
    </div>
</template>

<style scoped>
.test {
    min-height: 100vh;
    color: BLACK;
}

.titre {
    height: 10vh;
}

.btnLogin {
    height: 10vh;
}

.logo{
    color: white;
    background-color: white;
}

.connexion {
    height: 50vh;
}

.form {
    height: 50vh;
}

.buton {
    height: 10vh;
}

.distance{
    height: 10vh;
}
</style>
