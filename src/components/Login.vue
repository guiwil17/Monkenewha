<script setup lang="ts">
import AuthenticationService from './../AuthenticationService'
export {}
import axios from 'axios';
import router from '@/router';

var valid: boolean = true;

var pseudo: string = '';
var password: string = '';

var champs = [(v: string) => !!v || 'Merci de remplir le champs'];

function connect(this: any) {
   AuthenticationService.login(this.pseudo, this.password).then((result)=>{
       console.log(result)
          console.log(AuthenticationService.user)
          router.push({ name: 'admin' })


   })
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
                        <v-toolbar-title>Connexion</v-toolbar-title>
                    </v-toolbar>
                    <v-form ref="form" v-model="valid" lazy-validation>
                        <v-card-text>
                            <v-text-field name="login" label="Login" type="text" v-model="pseudo" :rules="champs"></v-text-field>
                            <v-text-field id="password" name="password" label="Password" type="password" v-model="password" :rules="champs"></v-text-field>
                        </v-card-text>
                        <v-card-actions>
                            <v-container fill-height fill-width>
                                <v-row justify="center" align="center">
                                    <v-col align="center" justify="center" cols="12" class="titre">
                                        <h1 class="text-h2">
                                            <v-btn :disabled="!valid" color="warning" @click="connect">Login</v-btn>
                                        </h1>
                                    </v-col>
                                </v-row>
                            </v-container>
                        </v-card-actions>
                    </v-form>
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

.connexion {
    height: 60vh;
}

.buton {
    height: 10vh;
}
</style>
