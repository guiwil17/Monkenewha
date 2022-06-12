<script>
import API from './../../api'
import AuthenticationService from './../../AuthenticationService'

export default {
    data: () => ({
        dialog: false,
        password: "",
        verifPassword: "",
        actualPassword: "",
        snackbar: false,
        text: 'Mise à jour du mot de passe réussite !',
        timeout: 4000,
          snackbarFail: false,
        textFail: 'Echec de la mise à jour du mot de passe...',
        timeoutFail: 4000,
        rulesPassword: [
            (value) => !!value || 'Required.',
            (value) => (value && value.length >= 6) || 'Minimum 6 characters',
        ],
        champs: [(v) => !!v || 'Required.']
    }),
    methods: {
        updatePassword() {
            API.updatePassword(AuthenticationService.email,this.password, this.actualPassword).then((data) => {
                console.log("yaaaaaaaaaaaah")
               this.snackbar = true
               this.dialog = false
            }).catch((e) => {
                this.snackbarFail = true
                this.dialog = false
                console.log(e)                
            })
        },
    }
}
</script>
<template>
    <v-row justify="center">
        <v-dialog v-model="dialog" persistent max-width="600px">
            <template v-slot:activator="{ on, attrs }">
                <v-btn v-bind="attrs" v-on="on">
                    <v-icon>mdi-account-convert</v-icon>
                </v-btn>
            </template>
            <v-card>
                <v-card-title>
                    <span class="text-h5">Changement du mot de passe</span>
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="12" sm="12" md="12">
                                <v-form ref="form" v-model="valid" validation>
                                    <v-text-field label="Actual Password" type="password" v-model="actualPassword"
                                        :rules="champs" autofocus></v-text-field>
                                    <v-text-field label="New Password" type="password" v-model="password"
                                        :rules="rulesPassword"></v-text-field>
                                    <v-text-field label="Confirm Password" type="password" v-model="verifPassword"
                                        :rules="[(password === verifPassword) || 'Password must match', !!verifPassword || 'Required']">
                                    </v-text-field>
                                </v-form>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-row justify="center">
                        <v-btn color="green darken-1" @click="updatePassword">
                            <v-icon>mdi-check</v-icon>
                        </v-btn>
                    </v-row>
                </v-card-actions>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="blue darken-1" text @click="dialog = false">
                        <v-icon>mdi-close-circle-outline</v-icon>
                    </v-btn>
                </v-card-actions>
            </v-card>          
        </v-dialog>
          <v-snackbar color="success" v-model="snackbar" :timeout="timeout">
                {{ text }}

                <template v-slot:action="{ attrs }">
                    <v-btn color="white" text v-bind="attrs" @click="snackbar = false">
                        Close
                    </v-btn>
                </template>
            </v-snackbar>
             <v-snackbar color="success" v-model="snackbarFail" :timeout="timeoutFail">
                {{ textFail }}

                <template v-slot:action="{ attrs }">
                    <v-btn color="white" text v-bind="attrs" @click="snackbarFail = false">
                        Close
                    </v-btn>
                </template>
            </v-snackbar>
    </v-row>
</template>