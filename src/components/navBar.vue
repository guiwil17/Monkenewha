
<script>
import AuthenticationService from '@/AuthenticationService'
import router from '@/router'
export default {
    data: () => ({
        showMenu: false,
        items: [
            { title: 'Click Me' },
            { title: 'Click Me' },
            { title: 'Click Me' },
            { title: 'Click Me 2' },
        ],
        isAuthenticate: AuthenticationService.isAuthenticated,
        group: null,
    }),

    methods: {
        goToHome() {
            this.$router.push("/")

        },
        goToTicket() {
            console.log("ici")
            this.$router.push("/Concert")
        },
        goToBlog() {
            this.$router.push("/Blog")
        },
        goToLogin() {
            this.$router.push("/Login")
        }
    },
}
</script>
<template>
    <v-app-bar color="orange lighten-2" dark>

        <h1 class="titre">Monkenewha</h1>
        <v-spacer></v-spacer>      

        <v-btn @click="goToLogin" text>
            <v-icon>mdi-account-box</v-icon>
        </v-btn>
        <template v-slot:extension>
            <v-tabs>
                <v-tab @click="goToHome()">Home</v-tab>
                <v-tab @click="goToTicket()">Billeterie</v-tab>
                <v-tab @click="goToBlog()">Blog</v-tab>                
            </v-tabs>
        </template>
    </v-app-bar>
</template>

<style scoped>
.v-tab {
    text-transform: none !important;
}

.titre {
     text-align: 'center';
    background: white;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
     font-family: 'Permanent Marker', cursive;
     font-size: 2.5rem
}
</style>