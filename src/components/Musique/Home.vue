<script>
import API from './../../api'
import router from 'vue-router'
export default {
    data: () => ({        
        musiques : null,
        load: true
    }),
      created (){
   API.getMusique().then((data) => {
this.musiques = data
console.log(this.musiques)
this.load = false 
   })
},
    methods: {
        getImage() {
            const min = 550
            const max = 560

            return Math.floor(Math.random() * (max - min + 1)) + min
        },
        detect() {
            alert("yaaaaaaaaaaaaaaaaah")
        },
        goToHome() {
            this.$router.push('/')
        }
    },
}
</script>
<template>
<div class="test">
    <v-container fill-height fill-width>
        <v-row justify="center" align="center">
            <v-col align="center" justify="center" cols="12">
                <h1 class="titre">
                    Nos Hits
                </h1>
            </v-col>           
        </v-row>

<v-row justify="center" align="center" v-if="load">
            <v-col justify="center" align="center" cols="12">
                <v-sheet elevation="8">

                   Chargement des musiques en cours

                </v-sheet>
            </v-col>
        </v-row>
        <v-row justify="center" align="center" v-else>

            <v-container fluid>

                <v-row>
                    <v-spacer></v-spacer>
                    <v-col v-for="musique in musiques" :key="musique" cols="12" sm="6" md="3">
                        <v-card>
                            <v-img :src="musique.img" aspect-ratio="1" @click="detect()">

                            </v-img>

                            <v-card-actions class="white justify-center">
                                <v-container fill-height fill-width>
                                    <v-row justify="center" align="center">

                                        <v-col align="center" justify="center" cols="12">
                                            <span class="text-h5 pl-4 pt-4 d-inline-block" v-text="musique.titre"></span>
                                        </v-col>
                                        <v-col align="center" justify="center" cols="12">
                                            {{musique.date}}
                                        </v-col>
                                        <v-col align="center" justify="center" cols="12">
                                            {{musique.description}}
                                        </v-col>
                                        <v-col align="center" justify="center" cols="12" >
                                            <audio  class="ccc"
      :src="musique.musique"    
      loop
      controls
      
    ></audio>
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

.image {
    border-radius: 100%;
    width: 300px;
}
.ccc {
   overflow: hidden;
  width: 100%;
}

.pulse-anim {
    box-shadow: 0 0 0 0 black;
    animation: pulse 1.3s infinite;
}

.titre {
    text-align: 'center';
       background: linear-gradient(#FF6F00, #FBE9E7);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
  font-family: 'Permanent Marker', cursive;
  font-size: 3.75rem
}
</style>
