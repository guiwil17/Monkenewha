<script>
import API from './../../api'

export default {
  data: () => ({
    dialog: false,
    valid: true,
    titre: '',
    description: '',
    musiqueInput: null,
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
      console.log(this.musiqueUrl)
      API.editMusique(this.musique.id, this.titre, this.musiqueUrl, this.description, this.imageUrl).then((result) => {
        console.log(result)
        this.updateMusique()
        this.dialog = false
      })
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
    },
    changeMusique() {
      if (!this.musiqueInput) {
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
        reader.readAsDataURL(this.musiqueInput);
      }
    }
  }
}
</script>
<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" persistent max-width="600px">
      <template v-slot:activator="{ on, attrs }">
        <v-btn color="teal" dark v-bind="attrs" v-on="on">
          <font-awesome-icon icon="pen" />
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
                <v-file-input v-model="musiqueInput" label="Musique" accept="audio/*" prepend-icon="mdi-camera-image"
                  @change="changeMusique(e)"></v-file-input>
                <audio class="lecteur" ref="audio" :src="musiqueUrl" loop controls id="audio"></audio>
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


<style scoped>
.lecteur {
  width: 100%;
}
</style>