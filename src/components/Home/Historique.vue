<script lang="ts">
import Vue from 'vue';


export default Vue.extend({
    data: () => ({
      items: [
        {
          color: 'orange lighten-3', //orange lighten-3
          icon: 'mdi-star',
          titre: "Création du groupe (2010) ",
          contenu: "Le groupe prend forme dans un petit village des vosges, grâce à la volonté de 4 musiciens voulant s'associer pour créer une musique unique. "
        },
        {
          color: 'deep-orange lighten-3',
          icon: 'mdi-airballoon',
          titre: "Premier single (2013)",
          contenu: "Le premier single du groupe signe le début de notre aventure. Publié en première partie sur youtube il obtient plus d'un million de vue en 2 mois, il nous galvanise pour pousser encore pluis loin notre musique."

        },
        {
          color: 'orange lighten-3',
          icon: 'mdi-book-variant',
          titre: "Premier disque de platine (2014) ",
          contenu: "Suite au début explosif de notre premier single, un album est sorti quelques mois après avec une compilation de nos meilleurs sons nommé ' For life '. 2 semaines après sa sortie nous étions disque d'or et 1 mois plus tard disque de platine."
        },
        {
          color: 'deep-orange lighten-3',
          icon: 'mdi-airballoon',
        titre: "Premier concert (2014)",
          contenu: "Après avoir acquis une certaine notoriété grâce à son disque de platine, le groupe vie son premier concert au bar 'le garman' à St Didier des Vosges."

        },
        {
          color: 'orange lighten-3',
          icon: 'mdi-airballoon',
                  titre: "Jeff le lama quitte le groupe (2015)",
          contenu: "Conscient de l'importance de ce qu'il a apporté au groupe et de l'importance de celui-ci pour lui. Il prend la lourde desicion de quitter le groupe pour aller travailler aux Etats-Unis."

        },
        {
          color: 'deep-orange lighten-3',
          icon: 'mdi-buffer',
          titre: "Tournée mondiale (2020)",
          contenu: "Force de courage et malgré une épidémie grandissante le groupe se lance dans une tournée mondiale qui a commencé au coeur de la capitale française."

        },
      ]
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
             <v-col align="center" justify="center" cols="12" >
                 <h1 class="titre text-h2">Historique</h1>
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
          <p>{{item.contenu}}</p>
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
       background: linear-gradient(to right, #FF6F00, #FBE9E7);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;

}
</style>
