<script lang="ts">
import Vue from 'vue';


export default Vue.extend({
    data: () => ({
      items: [
        {
          color: 'orange lighten-3', //orange lighten-3
          icon: 'mdi-star',
          titre: "Création du groupe"
        },
        {
          color: 'deep-orange lighten-3',
          icon: 'mdi-airballoon',
          titre: "Premier single"

        },
        {
          color: 'orange lighten-3',
          icon: 'mdi-book-variant',
          titre: "Premier disque de platine"
        },
        {
          color: 'deep-orange lighten-3',
          icon: 'mdi-airballoon',
        titre: "Premier concert"

        },
        {
          color: 'orange lighten-3',
          icon: 'mdi-airballoon',
                  titre: "Tournée mondiale"

        },
        {
          color: 'deep-orange lighten-3',
          icon: 'mdi-buffer',
          titre: "Jeff le lama quitte le groupe"

        },
      ],
    }),
})
</script>

<template>
<div>
   <v-container>
       <v-row
       justify="center"
        align="center"
      >    
             <v-col align="center" justify="center" cols="12">
                 <h1 class="titre">Historique</h1>
             </v-col>
       </v-row>
   </v-container>
  <v-container >
       <v-row
       justify="center"
        align="center"
      >               
       <v-col align="center" justify="center" cols="12" class="top">
  
  <v-timeline
    align-top
    :dense="$vuetify.breakpoint.smAndDown"
  >
    <v-timeline-item
      v-for="(item, i) in items"
      :key="i"
      :color="item.color"
      :icon="item.icon"
      fill-dot
    >
      <v-card
        :color="item.color"
        dark
      >
        <v-card-title class="text-h6">
          {{item.titre}}
        </v-card-title>
        <v-card-text class="white text--primary">
          <p>Lorem ipsum dolor sit amet, no nam oblique veritus. Commune scaevola imperdiet nec ut, sed euismod convenire principes at. Est et nobis iisque percipit, an vim zril disputando voluptatibus, vix an salutandi sententiae.</p>
          <v-btn
            :color="item.color"
            class="mx-0"
            outlined
          >
            Button
          </v-btn>
        </v-card-text>
      </v-card>
    </v-timeline-item>
  </v-timeline>

      </v-col>
       </v-row>
  </v-container>
</div>
</template>

<style scoped>
.test {
    min-height: 100vh;
 background-color: #dfd7d7;
 color: black;

}


.titre{
  text-align: 'center';
}
</style>
