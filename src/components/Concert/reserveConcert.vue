<script>
import API from './../../api'
import AuthenticationService from './../../AuthenticationService'

export default {
    data: () => ({
        dialog: false,
        nbrPlace: 0,
        snackbar: false,
        text: 'Mise à jour réussie',
        timeout: 8000,
        champs: [(v) => !!v || 'Required.']
    }),
    props: {
        concert: Object
    },
    methods: {
        reserv(){
            console.log("ici") 
            try{
                console.log(AuthenticationService.concert)
                var newConcert = AuthenticationService.concert
                newConcert.push({"id": this.concert.id, "nbrPlace": this.nbrPlace})
                   console.log("ici")               
            console.log(AuthenticationService.email)
            API.reserveConcert(AuthenticationService.email,this.concert.id,this.nbrPlace, JSON.stringify(newConcert) ).then((data) => {
                console.log(data)
            }).catch((e) => {
                console.log(e)
                console.log(AuthenticationService.concert)
            })
            }      
            catch(e)     {
                console.log(e)
                                console.log(AuthenticationService.concert)

            }
            
            
         
        }
    }
}
</script>
<template>
    <v-row justify="center">
        <v-dialog v-model="dialog" persistent max-width="600px">
            <template v-slot:activator="{ on, attrs }">
                <v-btn color="orange lighten-2" text v-bind="attrs" v-on="on">
                    Réserver
                </v-btn>
            </template>
            <v-card>
                <v-card-title>
                    <span class="text-h5"> Réservation de {{ concert.lieu }} le {{ concert.date }} </span>
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="12" sm="12" md="12">
                                <v-form ref="form" v-model="valid" validation>
                                    <v-text-field label="Nombre de place souhaitée"  type="number" v-model="nbrPlace"
                                        :rules="champs" autofocus>
                                    </v-text-field>
                                </v-form>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-row justify="center">
                        <v-btn color="green darken-1" @click="reserv()">
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
        <v-snackbar v-model="snackbar" :timeout="timeout">
            {{ text }}

            <template v-slot:action="{ attrs }">
                <v-btn color="blue" text v-bind="attrs" @click="snackbar = false">
                    Close
                </v-btn>
            </template>
        </v-snackbar>
    </v-row>
</template>