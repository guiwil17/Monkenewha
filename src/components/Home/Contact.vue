<script>
import API from '@/api';
import Vue from 'vue'

export default {
    data: () => ({
        valid: false,
        email: '',
        firsName: '',
        contenu: '',
        snackbar: false,
        text: "L'adresse email ou le mot de passe est incorrect ! ",
        timeout: 4000,
        nomPrenomRules: [(v) => !!v || 'Merci de remplir le champs'],
        emailRules: [(v) => !!v || 'Merci de remplir le champs', (v) => /.+@.+\..+/.test(v) || 'Merci de rentrer un email valide']
    }),
    methods: {
        validate() {
            console.log(this.$refs.form)
            console.log(this.name)
            console.log(this.email)
            console.log(this.firsName)
            console.log(this.contenu)
            API.contact(this.email, this.contenu, this.name, this.firsName).then((data) => {
                console.log(data)
            }).catch((e) => { console.log(e) })
        }
    }
}
</script>

<template>
    <div class="test">
        <v-container>
            <v-row justify="center" align="center">
                <v-col align="center" justify="center" cols="8">
                    <v-divider></v-divider>
                </v-col>
                <v-col align="center" justify="center" cols="12">
                    <h1 class="titre">Contact </h1>
                </v-col>
            </v-row>
        </v-container>
        <v-container>
            <v-row justify="center" align="center">
                <v-col justify="center" align="center" cols="12">
                    <v-sheet elevation="8" height="70vh" rounded class="mt-15">
                        <v-form ref="form" v-model="valid" validation>
                            <v-container>
                                <v-row justify="center" align="center" class="mt-15">
                                    <v-col justify="center" align="center" cols="3">
                                    </v-col>
                                    <v-col justify="center" align="center" cols="6">
                                        <v-text-field label="Email" outlined v-model="email" :rules="emailRules">
                                        </v-text-field>
                                    </v-col>
                                    <v-col justify="center" align="center" cols="3">
                                    </v-col>
                                    <v-col justify="center" align="center" cols="4">
                                        <v-text-field label="Nom" outlined v-model="name" :rules="nomPrenomRules">
                                        </v-text-field>
                                    </v-col>
                                    <v-col justify="center" align="center" cols="4">
                                        <v-text-field label="Prénom" outlined v-model="firsName"
                                            :rules="nomPrenomRules"></v-text-field>
                                    </v-col>

                                    <v-col justify="center" align="center" cols="8">
                                        <v-textarea outlined name="input-7-4" label="Détailler votre demande"
                                            v-model="contenu" :rules="nomPrenomRules"></v-textarea>
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
    min-height: 100vh;
    background-color: #FEFFFF;
    color: black;

}

.top {
    height: 40vh;
}

.titre {
    text-align: 'center';
    background: #7CC5CF;
    -webkit-background-clip: text;
    background-clip: text;
    -webkit-text-fill-color: transparent;
    font-family: 'Permanent Marker', cursive;
    font-size: 3.75rem
}
</style>
