<script setup lang="ts">
import AuthenticationService from './../AuthenticationService'
import axios from 'axios';
import router from '@/router';



var valid: boolean = true;

var pseudo: string = '';
var password: string = '';
var snackbar: boolean =  false
var text: string =  "L'adresse email ou le mot de passe est incorrect ! "
var timeout: number = 4000

var champs = [(v: string) => !!v || 'Merci de remplir le champs'];

function connect(this: any) {
    AuthenticationService.login(this.pseudo, this.password).then((result) => {       
        console.log("yaaaaaaaaaaaaaaaaaaaaaaaaaah")
        if(AuthenticationService.isAdmin){
        this.$router.push("/admin")
        }        
        else{
            this.$router.push("/user")
        }
        
    }).catch(()=>{
this.snackbar = true
    })
}
function createAccount(this: any) {
    router.push({ name: 'createAccount' })
}
function lostPassword(this: any) {
    router.push({ name: 'lostPassword' })
}
function goToHome(this: any) {
    router.push({ name: 'home' })
}
</script>

<template>
    <div class="test">
        <v-container fill-height fill-width>
            <v-row justify="center" align="center">               
                <v-col align="center" justify="center" cols="12" class="connexion">

                    <v-card class="elevation-12">
                        <v-toolbar dark color="warning">
                            <v-toolbar-title>Connexion</v-toolbar-title>
                        </v-toolbar>
                        <v-form ref="form" v-model="valid" validation>
                            <v-card-text>
                                <v-text-field name="login" label="Login" type="text" v-model="pseudo" :rules="champs">
                                </v-text-field>
                                <v-text-field id="password" name="password" label="Password" type="password"
                                    v-model="password" :rules="champs"></v-text-field>
                            </v-card-text>
                        </v-form>
                        <v-card-actions>
                            <v-container fill-height fill-width>
                                <v-row justify="center" align="center">
                                    <v-col align="center" justify="center" cols="12" class="btnLogin">
                                        <h1 class="text-h2">
                                            <v-btn :disabled="!valid" color="warning" @click="connect">Login</v-btn>
                                        </h1>
                                    </v-col>
                                </v-row>
                                <v-row justify="center" align="center">
                                    <v-col align="center" justify="center" cols="12">
                                        <a @click="createAccount">Créer un compte</a>
                                    </v-col>
                                    <v-col align="center" justify="center" cols="6">
                                        <v-divider></v-divider>
                                    </v-col>
                                    <v-col align="center" justify="center" cols="12">
                                        <a @click="lostPassword">Mot de passe oublié</a>
                                    </v-col>
                                </v-row>
                            </v-container>
                        </v-card-actions>

                    </v-card>
                </v-col>
            </v-row>
            <v-snackbar v-model="snackbar" :timeout="timeout" color="red accent-2">
                {{ text }}

                <template v-slot:action="{ attrs }">
                    <v-btn color="white" text v-bind="attrs" @click="snackbar = false">
                        Close
                    </v-btn>
                </template>
            </v-snackbar>
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
