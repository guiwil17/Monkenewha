<script>
import API from './../../api'
import AuthenticationService from './../../AuthenticationService'
import updateUser from './updateUser.vue'
import updatePassword from './updatePassword.vue'

export default {
  data: () => ({
    dialog: false,
    nom: AuthenticationService.nom,
    firstName: AuthenticationService.firstName,
    email: AuthenticationService.email,
    adresse: AuthenticationService.adresse
  }),
  components: { updateUser, updatePassword },   
  methods: {
        update(nom, firsName, adresse){
          AuthenticationService.updateUser(nom, firsName, adresse).then(()=> {
            this.nom = nom
            this.firsName = firsName
            this.adresse = adresse
          })
            console.log("yooooooooo")
        }
  }
}
</script>
<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" persistent max-width="600px">
      <template v-slot:activator="{ on, attrs }">
        <v-btn v-bind="attrs" v-on="on">
          <v-icon>mdi-badge-account-horizontal</v-icon>
        </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="text-h5">Bienvenue {{ nom }}</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12" sm="12" md="12">
                Nom : {{ nom }} <br />
                Prénom : {{ firstName }}<br />
                email : {{ email }}<br />
                adresse : {{ adresse }}
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-row justify="center">
            <v-col cols="6">
              <update-user :update="update"/>
            </v-col>
            <v-col cols="6">
              <updatePassword />
            </v-col>
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
  </v-row>
</template>