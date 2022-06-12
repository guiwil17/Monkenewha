<script>
import API from './../../api'
import AuthenticationService from './../../AuthenticationService'

export default {
    data: () => ({
        dialog: false,
        nom: AuthenticationService.nom,
        firstName: AuthenticationService.firstName,
        email: AuthenticationService.email,
        adresse: AuthenticationService.adresse,
         snackbar: false,
        text: 'Mise à jour réussie !',
        timeout: 8000,
        rulesPassword: [
            (value) => !!value || 'Required.',
            (value) => (value && value.length >= 6) || 'Minimum 6 characters',
        ],
        champs: [(v) => !!v || 'Required.']
    }),
     props: {
        update: {
            type: Function
        }
    },
    methods: {
        updateUser() {
            API.updateUser(this.email, this.nom, this.firstName, this.adresse).then((data) => {               
               this.snackbar = true
            this.update(this.nom, this.firstName, this.adresse)
               
               this.dialog = false               
            }).catch((e) => {
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
                    <v-icon>mdi-border-color</v-icon>
                </v-btn>
            </template>
            <v-card>
                <v-card-title>
                    <span class="text-h5">Modification de {{ nom }}</span>
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="12" sm="12" md="12">
                                <v-form ref="form" v-model="valid" validation>                                    
                                    <v-text-field label="Nom" type="text" v-model="nom" :rules="champs" autofocus>
                                    </v-text-field>
                                    <v-text-field label="Prénom" type="text" v-model="firstName" :rules="champs" autofocus>
                                    </v-text-field>
                                    <v-text-field label="Adresse" type="text" v-model="adresse" :rules="champs" autofocus>
                                    </v-text-field>
                                </v-form>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>    
                 <v-card-actions>
                     <v-row justify="center">
                    <v-btn color="green darken-1" @click="updateUser">
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
    </v-row>
</template>