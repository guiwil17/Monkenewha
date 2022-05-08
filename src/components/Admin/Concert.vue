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
props:{
    concert: Object
}

}

var active = 3
</script>

<template>
<div class="test">
    <v-container>
        <v-row justify="center" align="center">
            <v-col align="center" justify="center" cols="12">
                <h1 class="titre">Concerts </h1>
            </v-col>
            <v-col align="center" justify="center" cols="12">
              <AddConcert />
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
                            <v-card class="ma-12" height="60vh" :key="concert.id">
                                <v-row align="center" justify="center">
                                    <v-col align="center" justify="center" cols="12">
                                        <h2>{{concert.lieu}}</h2>

                                        <hr class="hr" />
                                    </v-col>
                                    <v-col align="center" justify="center" cols="12">
                                        <v-img :src="concert.img" max-height="700" max-width="700" ></v-img>
                                    </v-col>
                                    <v-col align="center" justify="center" cols="12">
                                        {{concert.date}}
                                    </v-col>
                                    <v-col align="center" justify="center" cols="12">
                                        Nombre de place disponible : {{concert.nbrPlaceDispo}} / {{concert.nbrPlace}}
                                    </v-col>
                                      <v-col align="center" justify="center" cols="12">
                                       {{concert.description}}
                                    </v-col>

                                    <v-col align="center" justify="center" cols="6">
                                        <DeleteConcert :concert="concert"/>
                                    </v-col>
                                    <v-col align="center" justify="center" cols="6">
                                        <EditConcert :concert="concert"/>
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
    height: 100vh;
    background-color: white;
    color: black;

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
