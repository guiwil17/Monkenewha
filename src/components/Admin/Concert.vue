<script setup lang="ts">
import 'vue-glide-js/dist/vue-glide.css'

var active = 3

</script>

<template>
<div class="test">
   <v-container>
       <v-row
       justify="center"
        align="center"
      >    
             <v-col align="center" justify="center" cols="12">
                 <h1 class="titre">Concerts </h1>
             </v-col>
               <v-col align="center" justify="center" cols="12">
                 <v-btn class="ml-2 mt-5" elevation="2" color="warning" @click="goToHome">
                   +
                </v-btn>
             </v-col>
       </v-row>
   </v-container>
     <v-container >
       <v-row
        justify="center"
        align="center">    
       <v-col   justify="center"
        align="center" cols="12">
<v-sheet
    elevation="8"
  >
 
   <vue-glide height="100vh" v-model="active" control="true" perView=2>        
    <vue-glide-slide
      v-for="i in 10"      
      :key="i"
      >
    <v-card
          class="ma-12"
          height="60vh"
        >
          <v-row
            align="center"
            justify="center"
          >         
                    <v-col align="center" justify="center" cols="12"> 
                      <h2>Reims Arena </h2>

                      <hr class="hr"/>                      
</v-col>
          <v-col align="center" justify="center" cols="12"> 
              <v-img src="https://remeng.rosselcdn.net/sites/default/files/dpistyles_v2/ena_16_9_extra_big/2019/08/29/node_89564/11018792/public/2019/08/29/B9720726729Z.1_20190829202512_000%2BGAREB9GAM.2-0.jpg?itok=b2AfeySY1567147356"></v-img>
          </v-col>
           <v-col align="center" justify="center" cols="12"> 
              Coucou  + {{i}}           
          </v-col>
          </v-row>
        </v-card>

    </vue-glide-slide>            
   <template slot="control">
        <v-btn data-glide-dir="<" color="warning" class="ma-5"><font-awesome-icon icon="angle-left" /></v-btn>

        <v-btn data-glide-dir=">" color="warning"><font-awesome-icon icon="angle-right" /></v-btn>
      </template>
  </vue-glide>
       
   </v-sheet>
      </v-col>
       </v-row>
  </v-container>
</div>
</template>

<style scoped>
.test {
 height: 100vh;
 background-color: white;
 color: black;

}
.full {
  height: 80%;
  width: 100%;
}

.hr {
 rotate: 90%;
}

.fleche{
margin-right: 30px;}


</style>
