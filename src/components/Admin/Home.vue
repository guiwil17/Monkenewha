<script>
import router from 'vue-router'
export default {
      methods: {       
        goToHome() {
            this.$router.push('/')
        }
    },
}
</script>
<template>
<div class="test">
    <v-container  fill-width >
        <v-row justify="center" align="center">          
            <v-col align="center" justify="center" cols="12">
                <h1 class="titre">
                    Gestion administrateur
                </h1>
            </v-col>  
            <v-col align="center" justify="center" cols="12">
                <v-btn class="ml-2 mt-5" elevation="2" color="warning" @click="goToHome">
                    <v-icon>mdi-logout</v-icon>
                </v-btn>
            </v-col>                              
        </v-row>      
        <v-row justify="center" align="center" class="ecart"></v-row>
        <v-row justify="center" align="center">          
           <v-col align="center" justify="center" cols="12">
                <v-img max-height="300" max-width="500" :src="require('../../Images/damien.png')" class="pulse-anim image "></v-img>
            </v-col>                         
        </v-row>      
    </v-container>
    
</div>
</template>

<style >
.test {
    height: 100vh;
    background-color: #FEFFFF;
    color: BLACK;
}

.buton {
    height: 10vh;
}

.ecart {
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
