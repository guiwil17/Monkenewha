<script setup lang="ts">
import Vue from 'vue'

var valid = false;

var name: string = '';
var email: string = '';
var prenom: string = '';
var contenu: string = '';

var nomPrenomRules = [(v: string) => !!v || 'Merci de remplir le champs'];
var  emailRules = [(v: string) => !!v || 'Merci de remplir le champs', (v: string) => /.+@.+\..+/.test(v) || 'Merci de rentrer un email valide'];

function validate (this: any) {       
        console.log( this.$refs.form)
        console.log(this.name)
        console.log(this.email)
        console.log(this.prenom)
        console.log(this.contenu)
      }
</script>

<template>
<div class="test">
    <v-container>
        <v-row justify="center" align="center">
            <v-col align="center" justify="center" cols="12">
                <h1 class="titre">Contact </h1>
            </v-col>
        </v-row>
    </v-container>
    <v-container >
        <v-row justify="center" align="center">
            <v-col justify="center" align="center" cols="12" >
                <v-sheet elevation="8" height="70vh" rounded class="mt-15">
                    <v-form ref="form" v-model="valid" lazy-validation>
                        <v-container>
                            <v-row justify="center" align="center" class="mt-15">
                                <v-col justify="center" align="center" cols="3">
                                </v-col>
                                <v-col justify="center" align="center" cols="6">
                                    <v-text-field label="Email" outlined  v-model="email" :rules="emailRules"></v-text-field>
                                </v-col>
                                <v-col justify="center" align="center" cols="3">
                                </v-col>
                                <v-col justify="center" align="center" cols="4">
                                    <v-text-field label="Nom" outlined v-model="name" :rules="nomPrenomRules"></v-text-field>
                                </v-col>
                                <v-col justify="center" align="center" cols="4">
                                    <v-text-field label="Prénom" outlined  v-model="prenom" :rules="nomPrenomRules"></v-text-field>
                                </v-col>

                                <v-col justify="center" align="center" cols="8">
                                    <v-textarea outlined name="input-7-4" label="Détailler votre demande" v-model="contenu" :rules="nomPrenomRules"></v-textarea>
                                </v-col>
                                <v-col justify="center" align="center" cols="8">

                                    <v-btn :disabled="!valid" color="warning" class="mr-4" @click="validate">
                                        Validate
                                    </v-btn>
                                </v-col>
                            </v-row>
                        </v-container>
                    </v-form>
                </v-sheet>
            </v-col>
        </v-row>
    </v-container>
</div>
</template>

<style scoped>
.test {
    height: 100vh;
    background-color: #e9e9e9;
    color: black;

}

.top {
    height: 40vh;
}

.titre {
    text-align: 'center';
}

</style>
