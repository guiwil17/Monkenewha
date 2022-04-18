<script  setup lang="ts">
export{}
import axios from 'axios';


var valid: boolean = true;

var pseudo: string = '';
var password: string = '';


var champs = [(v: string) => !!v || 'Merci de remplir le champs'];

function connect (this: any){
    console.log(this.password)
    axios.post(`https://a4eslgb0nl.execute-api.eu-west-3.amazonaws.com/prod`, {email: this.pseudo,password: this.password }, {
        headers: {
          'x-api-key': "1HU3xzsQpM7T3JzfYApmS5RyfriD910j9UEqeu6j"
        }})
    .then(response => {
      // JSON responses are automatically parsed.
      this.posts = response.data
    })
    .catch(e => {
      console.log(e)
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
                    <v-toolbar dark color="primary">
                        <v-toolbar-title>Connexion</v-toolbar-title>
                    </v-toolbar>
                     <v-form ref="form" v-model="valid" lazy-validation>
                    <v-card-text>
                            <v-text-field name="login" label="Login" type="text" v-model="pseudo" :rules="champs" ></v-text-field>
                            <v-text-field id="password" name="password" label="Password" type="password" v-model="password" :rules="champs"></v-text-field>                        
                    </v-card-text>
                    <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn :disabled="!valid" color="warning" class="mr-4" @click="connect">Login</v-btn>
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
