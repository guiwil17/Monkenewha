<script>
 import API from './../../api'

  export default {
    data: () => ({
      dialog: false
    }),
     props: {
       article: {
         type: Object
       },
        updateBlog: {
         type: Function
       },
     },
     methods:{
         deleteArticle(id){
              API.deleteBlog(id).then((result)=>{
       console.log(result)
       this.updateBlog()
       this.dialog = false
    })
         }
     }
  }
</script>
<template>
  <v-row justify="center">
    <v-dialog
      v-model="dialog"
      persistent
      max-width="600px"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          color="error"
          dark
          v-bind="attrs"
          v-on="on"
        >
          <font-awesome-icon icon="trash" />
        </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="text-h5">Suppresion d'un article</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col
                cols="12"
                sm="12"
                md="12"
              >
              Vous êtes sur le point de supprimer l'article : {{article.titre}} du {{article.date}}. 
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="blue darken-1"
            text
            @click="dialog = false"
          >
            Close
          </v-btn>
          <v-btn
            color="blue darken-1"
            text
            @click="deleteArticle(article.id)"
          >
            Supprimer
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>