<script>
import router from 'vue-router'
export default {
      methods: {       
        goToLogin() {
            this.$router.push('/Login')
        },
         goToTicket() {
            this.$router.push('/Concert')
        },
         goToBlog() {
            this.$router.push('/Blog')
        }
    },
}
</script>

<template>
<div class="test">
    <v-container >
        <v-row justify="center" align="center" >

            <v-col align="center" justify="center" cols="12">
                <h1 class="titre">
                    Monkenewha
                </h1>
            </v-col>
            <v-col align="center" justify="center" cols="12">
                <v-img max-height="300" max-width="500" :src="require('../assets/logo.jpeg')" class="pulse-anim image "></v-img>
            </v-col>
        </v-row>       
    </v-container>
</div>
</template>

<style scoped>
.test {
    height: 90vh;   
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
font-size: 6rem

}

@keyframes pulse {
    to {
        box-shadow: 0 0 0 18px rgba(228, 225, 225, 0.01);

    }

}
</style>
