<template>
<div class="test">
    <v-container fill-height fill-width>
        <v-row justify="center" align="center">
            <v-col align="center" justify="center" cols="2">
            </v-col>
            <v-col align="center" justify="center" cols="8">
                <h1 class="titre text-h2">
                    Gestion administrateur
                </h1>
            </v-col>
            <v-col align="center" justify="center" cols="1">
                <v-btn class="ml-2 mt-5" elevation="2" color="warning" @click="goToHome">
                    <font-awesome-icon icon="house" />
                </v-btn>
            </v-col>
            <v-col align="center" justify="center" cols="3">
            </v-col>
        </v-row>

        <v-row justify="center" align="center">
            <v-container fill-height fill-width>
                <v-row justify="center" align="center">
                    <v-col align="center" justify="center" cols="12" class="top">
                    </v-col>
                    <v-col align="center" justify="center" cols="4">
                        <v-btn elevation="2" color="warning">A propos de nous</v-btn>
                    </v-col>
                       <v-col align="center" justify="center" cols="4">
                        <v-btn elevation="2" color="warning">A propos de nous</v-btn>
                    </v-col>

                    <v-col align="center" justify="center" cols="4">
                        <v-btn elevation="2" color="warning">
                            <font-awesome-icon icon="ticket" />
                        </v-btn>
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
    background: linear-gradient(to right, #FF6F00, #FBE9E7);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;

}
</style>
