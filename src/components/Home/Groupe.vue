<template>
<div class="test">
   <v-container>
       <v-row
       justify="center"
        align="center"
      >    
             <v-col align="center" justify="center" cols="12">
                 <h1 class="titre">Composition du groupe</h1>
             </v-col>
       </v-row>
   </v-container>
  <v-container fill-height fill-width>
       <v-row
       justify="center"
        align="center"
      >               
       <v-col align="center" justify="center" cols="12" class="top">
    <v-img        
  max-height="300"
  max-width="500"
  :src="require('../../Images/damien.png')"
  class="rounded-pill"
></v-img>
      </v-col>
       <v-col align="center" justify="center" cols="6">
     <v-img        
  max-height="300"
  max-width="500"
  :src="require('../../Images/ours.jpg')"
  class="rounded-pill"
></v-img>
      </v-col>
         
       <v-col align="center" justify="center" cols="6">
     <v-img        
  max-height="300"
  max-width="500"
  :src="require('../../Images/kangourou.jpg')"
  class="rounded-pill"
></v-img>
      </v-col>
       </v-row>
  </v-container>
</div>
</template>

<style scoped>
.test {
 height: 100vh;
 background-color: #e9e9e9;
 color: black;

}
.top{
    height: 40vh;
}

.titre{
  text-align: 'center';
}
</style>
