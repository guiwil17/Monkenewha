<script>
import AuthenticationService from '@/AuthenticationService'
import router from 'vue-router'
import API from './../../api'

export default {
    data: () => ({
        concert: null,
        show: false,
    }),
    props: {
        concert: {
            type: Object
        }
    },
    methods: {
    }
}
</script>
<template>

    <v-card min-height="50vh">
        <v-col align="center" justify="center" cols="12">
            <span class="text-h5 pl-4 pt-4 d-inline-block" v-text="concert.lieu"></span>
        </v-col>
        <v-col align="center" justify="center" cols="12">
            <v-divider></v-divider>
        </v-col>
        <v-img :src="concert.img" max-height="300" max-width="700"></v-img>
        <v-card-actions class="white justify-center">
            <v-container fill-height fill-width>
                <v-row justify="center" align="center">
                    <v-col align="center" justify="center" cols="12">
                        Nombre de place prise : {{ concert.nbrPlace }}
                    </v-col>
                    <v-col align="center" justify="center" cols="12">
                        {{ concert.date }} {{ concert.heureDeb }}
                    </v-col>
                </v-row>
            </v-container>
        </v-card-actions>
        <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn icon @click="show = !show">
                <v-icon>{{ show ? 'mdi-chevron-up' : 'mdi-chevron-down' }}</v-icon>
            </v-btn>
        </v-card-actions>

        <v-expand-transition>
            <div v-show="show">
                <v-divider></v-divider>

                <v-card-text>
                    {{ concert.description }}
                </v-card-text>
            </div>
        </v-expand-transition>
    </v-card>
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
