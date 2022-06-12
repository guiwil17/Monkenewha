<script>
export default {
    data: () => ({        
        currentActif : null,
        currentClick : 0
    }),      
    methods: {
        getImage() {
            const min = 550
            const max = 560

            return Math.floor(Math.random() * (max - min + 1)) + min
        },        
        changeClick(value) {          
          if(value === this.currentClick){
            this.currentClick = 0
          }
          else{
                this.currentClick = value
          }
          console.log(this.currentClick)
            
        },
        goToHome() {
            this.$router.push('/')
        }
    },
}
</script>
<template>
<div class="test">
   <v-container>
    
       <v-row
       justify="center"
        align="center"
      >    
      <v-col align="center" justify="center" cols="8" >
                <v-divider></v-divider>
             </v-col>
             <v-col align="center" justify="center" cols="12">
                 <h1 class="titre">Composition du groupe</h1>
             </v-col>
       </v-row>
   </v-container>
  <v-container fill-height fill-width>
      
       <v-row
       justify="center"
        align="center"
         align-content="center"
         v-if="currentClick === 1"
      >               
       <v-col align="center" justify="center" cols="5" @click="changeClick(1)"  >   
       <v-card
  elevation="2"
   class="rounded-pill top"
>
<v-card-title style="height: 40%">
  <v-spacer />
  <div class="text-center" >
    <h3 class="headline text--accent-2">Damien</h3>
    <div>Créateur du groupe</div>
  </div>
  <v-spacer />
</v-card-title>
<v-card-text class="justify-center" style="height: 60%">
Créateur du groupe, Damien est tombé dans la musique depuis petit. Il est également un grand fan de basket ou il alterne entre des entrainements de haute volée et les répétitions de musique.  
</v-card-text>
</v-card>
      </v-col>
       </v-row>
        <v-row
       justify="center"
       align="center"      
      v-else
      >               
       <v-col align="center" justify="center" cols="12" class="top" @click="changeClick(1)">
    <v-img        
  max-height="300"
  max-width="500"
  :src="require('../../Images/damien.png')"
  class="rounded-pill"
></v-img>
      </v-col>
       </v-row>
       <v-row
       justify="center"
        align="center"       
      >
       <v-col align="center" justify="center" cols="6" @click="changeClick(2)"  v-if="currentClick === 2">
      <v-card
  elevation="2"
   class="rounded-pill top"
>
<v-card-title style="height: 40%">
  <v-spacer />
  <div class="text-center" >
    <h3 class="headline text--accent-2">Oursagne</h3>
    <div>Créateur du groupe</div>
  </div>
  <v-spacer />
</v-card-title>
<v-card-text class="justify-center" style="height: 60%">
Créateur du groupe, Damien est tombé dans la musique depuis petit. Il est également un grand fan de basket ou il alterne entre des entrainements de haute volée et les répétitions de musique.  
</v-card-text>
</v-card>
      </v-col>
       <v-col align="center" justify="center" cols="6" @click="changeClick(2)" v-else>
     <v-img        
  max-height="300"
  max-width="500"
  :src="require('../../Images/ours.jpg')"
  class="rounded-pill"
></v-img>
      </v-col>      
           <v-col align="center" justify="center" cols="6" @click="changeClick(3)"  v-if="currentClick === 3">
      <v-card
  elevation="2"
   class="rounded-pill top"
>
<v-card-title style="height: 40%">
  <v-spacer />
  <div class="text-center" >
    <h3 class="headline text--accent-2">kanga</h3>
    <div>Créateur du groupe</div>
  </div>
  <v-spacer />
</v-card-title>
<v-card-text class="justify-center" style="height: 60%">
Créateur du groupe, Damien est tombé dans la musique depuis petit. Il est également un grand fan de basket ou il alterne entre des entrainements de haute volée et les répétitions de musique.  
</v-card-text>
</v-card>
      </v-col>
       <v-col align="center" justify="center" cols="6" @click="changeClick(3)" v-else>
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
 min-height: 100vh;
 background-color: #FEFFFF;
 color: black;

}
.top{
    height: 40vh;  
}

.description{
    text-align: center;
    
}

.titre{
  text-align: 'center';
       background: #7CC5CF;
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
  font-family: 'Permanent Marker', cursive;
  font-size: 3.75rem
}
</style>
