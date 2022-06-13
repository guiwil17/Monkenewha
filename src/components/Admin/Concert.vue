<script>
import 'vue-glide-js/dist/vue-glide.css'
import EditConcert from './EditConcert.vue';
import AddConcert from './AddConcert.vue';
import DeleteConcert from './DeleteConcert.vue';
import API from './../../api'

export default {
    data(){
        return {
concerts: null,
load: true
        }
      
    },
  components: { EditConcert, AddConcert, DeleteConcert },
  created (){
   API.getConcert().then((data) => {
this.concerts = data
this.load = false 
   })
},
methods:{
updateConcert(){
     this.load = true 
      API.getConcert().then((data) => {     
this.concerts = data
this.load = false 
})
}
},
props:{
    concert: Object,
    updateConcert: Function
}

}

var active = 3
</script>

<template>
<div class="test">
    <v-container>
        <v-row justify="center" align="center">
              <v-col align="center" justify="center" cols="8" >
                <v-divider></v-divider>
             </v-col>
            <v-col align="center" justify="center" cols="12">
                <h1 class="titre">Concerts </h1>
            </v-col>
            <v-col align="center" justify="center" cols="12">
              <AddConcert :updateConcert="updateConcert"/>
            </v-col>
        </v-row>
    </v-container>
    <!-- <v-container>
        <v-row v-for="concert in concerts" :key="concert.id" justify="center" align="center">
            <v-col align="center" justify="center" cols="12">
                <h1 class="titre"> </h1>
            </v-col>          
        </v-row>
    </v-container> -->
    <v-container>
         <v-row justify="center" align="center" v-if="load">
            <v-col justify="center" align="center" cols="12">
                <v-sheet elevation="8">

                   Chargement des donnnées en cours

                </v-sheet>
            </v-col>
        </v-row>
        <v-row justify="center" align="center" v-else>
            <v-col justify="center" align="center" cols="12">
                <v-sheet elevation="8">

                    <vue-glide height="100vh" v-model="active" control="true" perView=2>
                        <vue-glide-slide v-for="concert in concerts" :key="concert.id">
                            <v-card class="ma-12" height="70vh" :key="concert.id">
                                <v-row align="center" justify="center">
                                    <v-col align="center" justify="center" cols="12">
                                        <h2>{{concert.lieu}}</h2>

                                        <hr class="hr" />
                                    </v-col>
                                    <v-col align="center" justify="center" cols="12">
                                        <v-img :src="concert.img" max-height="300" min-height="300" max-width="400" min-width="400" ></v-img>
                                    </v-col>
                                    <v-col align="center" justify="center" cols="12">
                                        {{concert.date}}{{ concert.heureDeb }}
                                    </v-col>
                                    <v-col align="center" justify="center" cols="12">
                                        Nombre de place disponible : {{concert.nbrPlaceDispo}} / {{concert.nbrPlace}}
                                    </v-col>
                                      <v-col align="center" justify="center" cols="12">
                                       {{concert.description}}
                                    </v-col>

                                    <v-col align="center" justify="center" cols="6">
                                        <DeleteConcert :concert="concert" :updateConcert="updateConcert"/>
                                    </v-col>
                                    <v-col align="center" justify="center" cols="6">
                                        <EditConcert :concert="concert" :updateConcert="updateConcert"/>
                                    </v-col>
                                </v-row>
                            </v-card>
                        </vue-glide-slide>
                        <template slot="control">
                            <v-btn data-glide-dir="<" color="warning" class="ma-5">
                                <font-awesome-icon icon="angle-left" />
                            </v-btn>

                            <v-btn data-glide-dir=">" color="warning">
                                <font-awesome-icon icon="angle-right" />
                            </v-btn>
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
    height: 110vh;
    background-color: white;
    color: black;

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

.full {
    height: 80%;
    width: 100%;
}

.image {
    height: 100;
    width: 100;
}

.hr {
    rotate: 90%;
}

.fleche {
    margin-right: 30px;
}
</style>
