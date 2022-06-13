<script>
import API from './../../api'
import AddMusique from './AddMusique.vue';
import EditMusique from './EditMusique.vue';
import DeleteMusique from './DeleteMusique.vue';
import router from 'vue-router'
export default {
    data: () => ({
        musiques: null,
        load: true
    }),
    components: { AddMusique, DeleteMusique, EditMusique },
    created() {
        API.getMusique().then((data) => {
            this.musiques = data
            console.log(this.musiques)
            this.load = false
        })
    },
    methods: {        
        goToHome() {
            this.$router.push('/')
        },
        updateMusique(){
           
             API.getMusique().then((data) => {
            this.musiques = data                        
        })
        }
    },
    props:{   
    updateMusique: Function
}
}
</script>
<template>
    <div class="test">
        <v-container fill-height fill-width>
            
            <v-row justify="center" align="center">
                  <v-col align="center" justify="center" cols="8" >
                <v-divider></v-divider>
             </v-col>
                <v-col align="center" justify="center" cols="12">
                    <h1 class="titre">
                        Musique
                    </h1>
                </v-col>
                <v-col align="center" justify="center" cols="12">

                    <AddMusique :updateMusique="updateMusique"/>
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
                        <v-col v-for="musique in musiques" :key="musique" cols="12" sm="6" md="3">
                            <v-card>
                                <v-img :src="musique.img" aspect-ratio="1" @click="detect()">

                                </v-img>

                                <v-card-actions class="white justify-center">
                                    <v-container  fill-width>
                                        <v-row justify="center" align="center">

                                            <v-col align="center" justify="center" cols="12">
                                                <span class="text-h5 pl-4 pt-4 d-inline-block"
                                                    v-text="musique.titre"></span>
                                            </v-col>
                                            <v-col align="center" justify="center" cols="12">
                                                {{ musique.date }}
                                            </v-col>
                                            <v-col align="center" justify="center" cols="12">
                                                {{ musique.description }}
                                            </v-col>
                                            <v-col align="center" justify="center" cols="12">
                                                <audio class="ccc" :src="musique.musique" loop controls></audio>
                                            </v-col>
                                            <v-col align="center" justify="center" cols="6">
                                                <DeleteMusique :musique="musique" :updateMusique="updateMusique"/>

                                            </v-col>
                                            <v-col align="center" justify="center" cols="6">
                                                <EditMusique :musique="musique" :updateMusique="updateMusique"/>
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
    min-height: 120vh;
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

.l{
    max-height: 100vh;
    overflow-y:auto;
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
