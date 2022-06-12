<script>
import router from 'vue-router'
import API from './../../api'
import CardConcert from './CardConcert.vue'
export default {
    data: () => ({
        concerts: null,
        concertsActuel: null,
        load: true,
        show: false
    }),
    components: { CardConcert},
    created() {
        API.getConcert().then((data) => {
            this.concerts = data
            this.concertsActuel = data
            this.load = false
        })
    },
    methods: {
        getImage() {
            const min = 550
            const max = 560

            return Math.floor(Math.random() * (max - min + 1)) + min
        },        
        goToHome() {
            this.$router.push('/')
        }
    },
    props:{
    concert: Object
}
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
                        Billeterie
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

                <v-container fluid>

                    <v-row>
                        <v-spacer></v-spacer>
                        <v-col v-for="concert in concertsActuel" :key="concert.id" cols="12" sm="6" md="4">                            
                            <CardConcert :concert="concert"/>
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
