<script>
import API from './../../api'

export default {
  data: () => ({
    dialog: false,
    valid: true,
    description: '',
    titre: '',
    image: '',
    imageUrl: '',
    champs: [(v) => !!v || 'Merci de remplir le champs']
  }),
  props: {
    article: {
      type: Object
    },
    updateBlog: {
      type: Function
    },
  },
  created() {
    this.description = '' + this.article.description
    this.titre = '' + this.article.titre
    this.image = '' + this.article.image
    this.imageUrl = '' + this.article.imageUrl
  },
  methods: {
    editConcert() {
      API.editBlog(this.article.id, this.titre, this.description, this.imageUrl).then((result) => {
        console.log(result)
        this.updateBlog()
        this.dialog = true
      })        
    },
    change() {
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
        <v-btn color="teal" dark v-bind="attrs" v-on="on">
          <font-awesome-icon icon="pen" />
        </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="text-h5">Modification de l'article</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12" sm="12" md="6">
                <v-text-field label="Titre*" v-model="titre" required></v-text-field>
              </v-col>


              <v-col cols="12">
                <v-textarea label="Description*" required v-model="description"></v-textarea>
              </v-col>
              <v-col cols="12" sm="6">
                <v-file-input v-model="image" label="Image" accept="image/*" prepend-icon="mdi-camera-image"
                  @change="change(e)"></v-file-input>
                <v-img :src="imageUrl" />

              </v-col>
            </v-row>
          </v-container>
          <small>*indicates required field </small>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="dialog = false">
            Close
          </v-btn>
          <v-btn color="blue darken-1" text @click="editConcert()">
            Save
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>