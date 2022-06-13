<script>
import API from '../../api'

export default {
  data: () => ({        
         articles: null,
        load: true,
        dialog: false
    }),    
   created (){
   API.getArticles().then((data) => {
    this.articles = data
    this.load = false 
    console.log(this.articles)
   })
}
}
</script>

<template>
<div class="test">
   <v-container>
       <v-row
       justify="center"
        align="center"
      >                 
             <v-col align="center" justify="center" cols="12">
                 <h1 class="titre">Les dernières nouveautés</h1>                 
             </v-col>             
       </v-row>
   </v-container>
   <v-container>
       <v-row justify="center" align="center" v-if="load" >    
       <v-col align="center" justify="center" cols="12" style="height: 90vh">
         <v-card elevation="2"   >
            Chargement en cours
         </v-card>
      </v-col>
       </v-row>  
       <v-row justify="center" align="center" v-else >   
        
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
    <v-carousel-item  v-for="article in articles" :key="article">    
    <v-card
  elevation="2"  
  style="height: 80vh" 
>
      <v-row
            class="fill-height"
            align="center"
            justify="center"            
          >
                 <v-col align="center" justify="center" cols="6" class="full">        
                   <v-img  :src="article.img" contain></v-img>                              
                 </v-col>
                    <v-col align="center" justify="center" cols="6" style="height: 90vh">
                    <v-card-title style="height: 40%">
  <v-spacer />
  <div class="text-center" >
    <h3 class="titreArticle">{{article.titre}} </h3>
    <div class="titreArticle">{{article.date}} </div>
  </div>
  <v-spacer />
</v-card-title>
<v-card-text class="justify-center" style="height: 60%">
{{article.description}} 
</v-card-text>            
                 </v-col>
           
          </v-row>
    </v-card>
    </v-carousel-item>
  </v-carousel>
      </v-col>
       </v-row>
  </v-container>
</div>
</template>

<style scoped>
.test {
min-height: 100vh;
 background-color: #EFEFEF;
 color: black;

}
.titre{
   text-align: 'center';
       background: #7CC5CF;
	-webkit-background-clip: text;
  background-clip: text;
	-webkit-text-fill-color: transparent;
  font-family: 'Permanent Marker', cursive;
  font-size: 3.75rem
}
.titreArticle{
  height: 10vh;
  font-family: 'Permanent Marker', cursive;
  font-size: 3rem;
  text-align: center;
}
.contenu{
  height: 60vh;
  font-family: 'Permanent Marker', cursive;  
  text-align: center;
}
.full {
  height: 50%;
  width: 100%;
}


</style>
