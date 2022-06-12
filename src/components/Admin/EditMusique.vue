<script setup lang="ts">
 import API from './../../api'
const props = defineProps({
  musique: { type: Object, required: true },
   updateMusique: { type: Function, required: true }
})
  var dialog = false
  var valid: boolean = true;

var description: string = '' + props.musique.description;
var titre: string = '' + props.musique.titre;
var musiqueInput: string;
var musiqueUrl: string = "" + props.musique.musique;
var image: string;
var imageUrl: string = "" + props.musique.img;

var champs = [(v: string) => !!v || 'Merci de remplir le champs'];

function connect(this: any) {
    console.log(musiqueUrl)
     API.editMusique(props.musique.id, this.titre, this.musiqueUrl, this.description, this.imageUrl).then((result)=>{
       console.log(result)
       props.updateMusique()
         this.dialog = false
    })
      
}


function changeMusique(this:any) {
 if (!this.musiqueInput) {
      return;
    }
  else{
     const reader = new FileReader();

    reader.onload = e => {
      if(e.target !== null){
      this.musiqueUrl = e.target.result;
       console.log(e.target.result)

      }
    };
    reader.readAsDataURL(this.musiqueInput);
  }
}

function changeImage(this:any) {
 if (!this.image) {
      return;
    }
  else{
     const reader = new FileReader();

    reader.onload = e => {
      if(e.target !== null){
      this.imageUrl = e.target.result;
       console.log(e.target.result)

      }
    };
    reader.readAsDataURL(this.image);
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
          color="teal"
          dark
          v-bind="attrs"
          v-on="on"
        >
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
              <v-col
                cols="12"
                sm="12"
                md="12"
              >
                <v-text-field
                  label="Titre*"
                  v-model="titre"
                  required
                ></v-text-field>
              </v-col> 
                 
             
              <v-col cols="12">
                <v-textarea
                v-model="description"
                  label="Description*"
                  required
                ></v-textarea>
              </v-col>                         
              <v-col
                cols="12"
                sm="6"
              >
              <v-file-input  v-model="musiqueInput" label="Musique" accept="audio/*" prepend-icon="mdi-camera-image" @change="changeMusique(e)"></v-file-input>
              <audio
              class="lecteur"
      ref="audio"
      :src="musiqueUrl"    
      loop
      controls
      id="audio"
      
    ></audio>
              </v-col>
               <v-col
                cols="12"
                sm="6"
              >
              <v-file-input  v-model="image" label="Image" accept="image/*" prepend-icon="mdi-camera-image" @change="changeImage(e)"></v-file-input>
              <v-img :src="imageUrl" />
             
              </v-col>
            </v-row>
          </v-container>
          <small>*indicates required field</small>
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
            @click="connect"
          >
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