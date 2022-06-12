<script>
import API from '@/api'
import AuthenticationService from '@/AuthenticationService'
import router from 'vue-router'
import userData from './userData.vue'
import cardConcert from './CardConcert.vue'
export default {
    data: () => ({
        concerts: [],
        allConcerts: [],
        load: true
    }),
    created() {
        API.getConcert().then((allConcert) => {
            this.allConcerts = allConcert
             AuthenticationService.concert.forEach((concert) => {            
                this.allConcerts.forEach((data) => {
                    if (concert.id === data.id) {
                        data.nbrPlace = concert.nbrPlace
                        this.concerts.push(data)
                        this.load = false
                        console.log(this.concerts)
                    }
                })           
        })
        })       
    },
    props:{
    concert: Object,
},
    methods: {
        logout() {
            AuthenticationService.logout().then(()=> {
            this.$router.push('/Login')
            })
        }
    },
    components: { userData, cardConcert},
}
</script>

<template>
    <div class="test">
        <v-container>
            <v-row justify="center" align="center">

                <v-col align="center" justify="center" cols="12">
                    <h4 class="titre">
                        Vos concerts
                    </h4>
                </v-col>
                <v-col align="center" justify="center" cols="2">
                    <v-btn elevation="2" color="warning" @click="logout">
                        <v-icon>mdi-login-variant</v-icon>
                    </v-btn>
                </v-col>
                <v-col align="center" justify="center" cols="2">
                    <userData />
                </v-col>
            </v-row>
            <v-row justify="center" align="center">
                <v-container fill-height fill-width>
                    <v-row justify="center" align="center" v-if="load">
                        <v-col align="center" justify="center" cols="12" class="top">
                                Chargement de vos concerts en cours...
                        </v-col>
                    </v-row>
                    <v-row justify="center" align="center" v-else>
                       
                            <v-col v-for="concert in concerts" :key="concert.id" cols="12" sm="6" md="4">
                                <cardConcert :concert="concert"  />
                            </v-col>
                       
                    </v-row>
                </v-container>
            </v-row>
        </v-container>
    </div>
</template>

<style scoped>
.test {
    height: 100vh;
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
    font-size: 4rem
}

@keyframes pulse {
    to {
        box-shadow: 0 0 0 18px rgba(228, 225, 225, 0.01);

    }

}
</style>
