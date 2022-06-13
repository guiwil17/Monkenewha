<script>
import API from './../../api'

export default {
  data: () => ({
    dialog: false,
    valid: true,
    titre: '',
    description: '',
    musique: null,
    musiqueUrl: '',
    image: null,
    imageUrl: '',
    champs: [(v) => !!v || 'Merci de remplir le champs']
  }),
  props: {
    musique: {
      type: Object
    },
    updateMusique: {
      type: Function
    },
  },
  created() {
    this.titre = '' + this.musique.titre
    this.description = '' + this.musique.description
    this.musiqueUrl = '' + this.musique.musique
    this.imageUrl = '' + this.musique.img
  },
  methods: {
    connect() {
      API.addMusique(this.titre, this.musiqueUrl, this.description, this.imageUrl).then((result) => {
        console.log(result)
        this.updateMusique()
        this.titre = ""
        this.musiqueUrl = ""
        this.description = ""
        this.imageUrl = ""
        this.musique = ""
        this.image = ""
        this.dialog = false
      })

    },
    changeMusique() {
      if (!this.musique) {
        return;
      }
      else {
        const reader = new FileReader();

        reader.onload = e => {
          if (e.target !== null) {
            this.musiqueUrl = e.target.result;
            console.log(e.target.result)

          }
        };
        reader.readAsDataURL(this.musique);
      }
    },
    changeImage() {
      if (!this.image) {
        return;
      }
      else {
        const reader = new FileReader();

        reader.onload = e => {
          if (e.target !== null) {
            this.imageUrl = e.target.result;
            console.log(e.target.result)

          }
        };
        reader.readAsDataURL(this.image);
      }
    }
  }
}
</script>
<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" persistent max-width="600px">
      <template v-slot:activator="{ on, attrs }">
        <v-btn color="orange" dark v-bind="attrs" v-on="on">
          +
        </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="text-h5">Ajouter une musique</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12" sm="12" md="12">
                <v-text-field label="Titre*" v-model="titre" required></v-text-field>
              </v-col>


              <v-col cols="12">
                <v-textarea v-model="description" label="Description*" required></v-textarea>
              </v-col>
              <v-col cols="12" sm="6">
                <v-file-input v-model="musique" label="Musique" accept="audio/*" prepend-icon="mdi-camera-image"
                  @change="changeMusique(e)"></v-file-input>
                <audio ref="audio" :src="musiqueUrl" loop controls id="audio"></audio>
              </v-col>
              <v-col cols="12" sm="6">
                <v-file-input v-model="image" label="Image" accept="image/*" prepend-icon="mdi-camera-image"
                  @change="changeImage(e)"></v-file-input>
                <v-img :src="imageUrl" />

              </v-col>
            </v-row>
          </v-container>
          <small>*indicates required field</small>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="dialog = false">
            Close
          </v-btn>
          <v-btn color="blue darken-1" text @click="connect">
            Save
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>