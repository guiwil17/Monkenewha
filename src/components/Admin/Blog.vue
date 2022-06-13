<script>
import router from 'vue-router'
import API from '../../api'
import EditBlog from './EditBlog.vue'
import AddBlog from './AddBlog.vue'
import DeleteBlog from './DeleteBlog.vue'
export default {
  components: { EditBlog, AddBlog, DeleteBlog },
    data() { return {
       articles: null,
load: true,
        dialog: false
}},
   created (){
   API.getArticles().then((data) => {
    this.articles = data
    this.load = false 
   })
},
methods:{
updateBlog (){
    this.load = true
    API.getArticles().then((data) => {
    this.articles = data
    this.load = false 
   })
}
},
props:{
    article: Object,
    updateBlog: Function
}

}
</script>
<template>
<div class="test">
    <v-container fill-height fill-width >        
        <v-row justify="center" align="center">
              <v-col align="center" justify="center" cols="8" >
                <v-divider></v-divider>
             </v-col>
            <v-col align="center" justify="center" cols="12">
                <h1 class="titre">                    
                    Blog
                </h1>
            </v-col>
             <v-col align="center" justify="center" cols="12">
                <AddBlog :updateBlog="updateBlog"></AddBlog>
            </v-col>         
        </v-row>    
          <v-row justify="center" align="center" v-if="load">
            <v-col justify="center" align="center" cols="12">
                <v-sheet elevation="8">

                   Chargement des donnnées en cours

                </v-sheet>
            </v-col>
        </v-row>
        <v-row justify="center" align="center" v-else class="l">           
                    <v-spacer></v-spacer>
                    <v-col v-for="article in articles" :key="article" cols="12" sm="6" md="6" >
                        <v-card>
                            <v-card-actions class="white justify-center">
                                <v-container >
                                    <v-row justify="center" align="center">
 
                                        <v-col align="center" justify="center" cols="12">                                            
                                            <span class="text-h5 pl-4 pt-4 d-inline-block" v-text="article.titre"></span>
                                        </v-col>
                                        <v-col align="center" justify="center" cols="12">
                                           
                                            {{article.date}}
                                        </v-col>
                                    </v-row>
                                </v-container>
                            </v-card-actions>
                            <v-img :src="article.img" contain aspect-ratio="1" class="img"></v-img>

                            <v-card-actions class="white justify-center">
                                <v-container fill-height fill-width>
                                    <v-row justify="center" align="center">

                                        <v-col align="center" justify="center" cols="12">
                                            {{article.description}}
                                        </v-col>
                                        <v-col align="center" justify="center" cols="6">
                                            <v-btn @click="goToHome" color="error">
                                               <DeleteBlog :article="article" :updateBlog="updateBlog"/>
                                            </v-btn>
                                        </v-col>
                                        <v-col align="center" justify="center" cols="6">
                                                 <EditBlog :article="article" :updateBlog="updateBlog"/>
                                        </v-col>
                                    </v-row>
                                </v-container>
                            </v-card-actions>
                        </v-card>
                    </v-col>               
        </v-row>

    </v-container>
</div>
</template>

<style scoped>
.test {  
    min-height: 130vh;  
    background-color: #FEFFFF;
    color: BLACK;
}

.buton {
    height: 10vh;
}
.l{
    max-height: 90vh;
    overflow-y:auto;
}

.title {
    height: 20vh;
}

.img {
    max-height: 40vh;
}

.pulse-anim {
    box-shadow: 0 0 0 0 black;
    animation: pulse 1.3s infinite;
}

.titre {
    text-align: 'center';
    background: #7CC5CF;
    -webkit-background-clip: text;
    background-clip: text;
    -webkit-text-fill-color: transparent;
     font-family: 'Permanent Marker', cursive;
     font-size: 3.75rem
}
</style>
