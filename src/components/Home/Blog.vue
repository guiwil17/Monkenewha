<script setup lan="ts">
var items = [
          {
            src: 'https://www.neozone.org/blog/wp-content/uploads/schema-and-structured-data-for-wp/baleine-chili-1200x675.jpg',
          },
          {
            src: 'https://geo.img.pmdstatic.net/fit/https.3A.2F.2Fi.2Epmdstatic.2Enet.2Fgeo.2F2021.2F10.2F05.2F6a5ddcc1-7f5e-42e1-91dc-55de8c837618.2Ejpeg/1280x720/background-color/ffffff/quality/70/tout-ce-quil-faut-savoir-sur-lelephant.jpg',
          },
          {
            src: 'data:image/jpeg;base64,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',
          },
          {
            src: 'https://cdn.vuetifyjs.com/images/carousel/planet.jpg',
          },
        ]
</script>

<template>
<div class="test">
   <v-container>
       <v-row
       justify="center"
        align="center"
      >    
        <v-col align="center" justify="center" cols="4">
             </v-col>
             <v-col align="center" justify="center" cols="4">
                 <h1 class="titre">Les dernières nouveautés</h1>                 
             </v-col>
               <v-col align="center" justify="center" cols="4">
                 <v-btn elevation="2" color="warning">
<font-awesome-icon icon="fa-book" />
      </v-btn>                 
             </v-col>
       </v-row>
   </v-container>
  <v-container >
       <v-row
       justify="center"
        align="center"
      >    
       <v-col align="center" justify="center" cols="12">
  <v-carousel  show-arrows-on-hover cycle hide-delimiters height="90vh">
      <template v-slot:prev="{ on, attrs }">
      <v-btn
        color="warning"
        v-bind="attrs"
        v-on="on"
      >
      <font-awesome-icon icon="angle-left" />
      </v-btn>
    </template>
    <template v-slot:next="{ on, attrs }">
      <v-btn      
        color="warning"
        v-bind="attrs"
        v-on="on"
      >
      <font-awesome-icon icon="angle-right" />
</v-btn>
    </template>
    <v-carousel-item
      v-for="(item,i) in items"
      :key="i"
     
    >
      <v-row
            class="fill-height"
            align="center"
            justify="center"            
          >
                 <v-col align="center" justify="center" cols="12" class="full">        
                   <v-img  :src="item.src" contain></v-img>                              
                 </v-col>
                    <v-col align="center" justify="center" cols="12">
                       <div class="text-h2">
              Slide {{ i + 1 }}
            </div>
                 </v-col>
           
          </v-row>
    </v-carousel-item>
  </v-carousel>
      </v-col>
       </v-row>
  </v-container>
</div>
</template>

<style scoped>
.test {
 height: 100vh;
 background-color: #EFEFEF;
 color: black;

}
.full {
  height: 80%;
  width: 100%;
}


</style>
