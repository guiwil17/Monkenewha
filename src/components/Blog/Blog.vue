<script>
import router from 'vue-router'
import API from './../../api'

export default {
    data: () => ({
         articles: null,
load: true        
    }),
 created (){
   API.getArticles().then((data) => {
    this.articles = data
    this.load = false 
   })
},
    methods: {       
        goToHome(){
          this.$router.push('/')
        }
    },
}
</script>
<template>
<div class="test">
    <v-container fill-height fill-width>
        <v-row justify="center" align="center">
            <v-col align="center" justify="center" cols="4">
            </v-col>
            <v-col align="center" justify="center" cols="4">
                <h1 class="titre">
                    Blog
                </h1>
            </v-col>            
            <v-col align="center" justify="center" cols="3">
            </v-col>
        </v-row>
 <v-row justify="center" align="center" v-if="load">
            <v-col justify="center" align="center" cols="12">
                <v-sheet elevation="8">

                   Chargement des donnnées en cours

                </v-sheet>
            </v-col>
        </v-row>
        <v-row justify="center" align="center" v-else>

            <v-container fluid >

                <v-row>
                    <v-spacer></v-spacer>
                    <v-col v-for="article in articles" :key="article.id" cols="12" sm="12" md="12">
                        <v-card >
                             <v-img  :src="article.img" contain class="img"></v-img>        
                          
                          <v-card-actions class="white justify-center">
                                <v-container fill-height fill-width>
                                    <v-row justify="center" align="center">

                                        <v-col align="center" justify="center" cols="12">
                                            <span class="text-h5 pl-4 pt-4 d-inline-block" v-text="article.titre"></span>
                                        </v-col>
                                        <v-col align="center" justify="center" cols="12">
                                           {{article.date}}
                                        </v-col>
                                          <v-col align="center" justify="center" cols="8">
                                            <v-divider></v-divider>
                                        </v-col>                                        
                                        <v-col align="center" justify="center" cols="12">
                                         {{article.description}}
                                        </v-col>
                                    </v-row>
                                </v-container>
                            </v-card-actions>
                        </v-card>
                    </v-col>
                </v-row>
            </v-container>
        </v-row>

    </v-container>
</div>
</template>

<style scoped>
.test {
    min-height: 100vh;
    background-color: #FEFFFF;
    color: BLACK;
}

.buton {
    height: 10vh;
}

.img {
    height: 40vh;
}
.image {
    border-radius: 100%;
    width: 300px;
}

.pulse-anim {
    box-shadow: 0 0 0 0 black;
    animation: pulse 1.3s infinite;
}

.titre {
    text-align: 'center';
    background: #7CC5CF;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
     font-family: 'Permanent Marker', cursive;
     font-size: 3.75rem
}
</style>
