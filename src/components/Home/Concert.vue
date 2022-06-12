<script >
import 'vue-glide-js/dist/vue-glide.css'
import API from './../../api'
import moment from 'moment';
import Places from 'vue-places'


export default {
  data() {
    return {
      active: 3,
      concerts: null,
      concertsActuel: null,
      load: true,
      dateDeb: (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10),
      menuDeb: false,
      dateFin: (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10),
      menuFin: false,
      ville: "",
      lieu: "",  
      place: "",         
      options: {
        appId: "G8YOMKNVQ6",
        apiKey: "28082ad8e12892e6c58df6f99a34c3e5",
        countries: ['FR'],
      },
      form: {
        country: {
          label: null,
          data: {},
        },
      },
    }

  },
   components: {Places},
  created() {
    API.getConcert().then((data) => {
      this.concerts = data
      this.concertsActuel = data
      this.load = false
    })
  },
  methods: {
     getAllConcerts() {
       console.log("ici")
       this.concertsActuel = this.concerts
     }
     ,
    trieConcert() {
      console.log("ici")
      var newConcert = []
      this.load = true
      this.concertsActuel = null
      this.concerts.forEach((concert) => {
        console.log(concert)
        console.log(this.dateDeb)
        console.log(this.dateFin)
        if (this.dateDeb !== (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10) && this.dateFin !== (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10)) {
          console.log("ddddd")
           console.log(moment(this.dateDeb, "YYYY-MM-DD"))
           console.log(moment(this.dateFin, "YYYY-MM-DD"))
          if (moment(concert.date, "YYYY-MM-DD").isBetween(moment(this.dateDeb, "YYYY-MM-DD"), moment(this.dateFin, "YYYY-MM-DD"), undefined, '[]')) {
            if (this.ville !== "" || this.lieu !== "") {
              if (this.ville !== "") {
                if (concert.includes(this.ville)) {
                  newConcert.push(concert)
                }
              }
              if (this.lieu !== "") {
                if (concert.lieu.includes(this.lieu)) {
                  newConcert.push(concert)
                }
              }
            }
            else {
              newConcert.push(concert)
            }
          }
        }
        else if (this.ville !== "" || this.lieu !== "") {
          console.log("ddddd")
          if (this.ville !== "" || this.lieu !== "") {
            if (this.ville !== "") {
              if (concert.lieu.includes(this.ville)) {

                newConcert.push(concert)
              }
            }
            if (this.lieu !== "") {
              if (concert.includes(this.lieu)) {

                newConcert.push(concert)
              }
            }
          }
        }

      })

      if (newConcert.length !== 0) this.concertsActuel = newConcert
      else this.concertsActuel = []
      this.load = false
      console.log(this.concertsActuel)

    }
  },
  props: {
    concert: Object
  }

}

</script>

<template>
  <div class="test">
    <v-container>
      <v-row justify="center" align="center">        
        <v-col align="center" justify="center" cols="12">
          <h1 class="titre">Nos prochains concerts </h1>
        </v-col>
      </v-row>
    </v-container>
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
            <v-row justify="center" align="center">
              <v-col align="center" justify="center" cols="2">
                Filtre
              </v-col>

              <v-col align="center" justify="center" cols="2">
                <v-text-field v-model="ville" label="Ville" required>
                </v-text-field>
              </v-col>
              <v-col align="center" justify="center" cols="2">

              </v-col>              
              <v-col align="center" justify="center" cols="2">
                <v-menu ref="menuDeb" v-model="menuDeb" :close-on-content-click="false" :return-value.sync="dateDeb"
                  transition="scale-transition" offset-y min-width="auto">
                  <template v-slot:activator="{ on, attrs }">
                    <v-text-field v-model="dateDeb" label="Date de début" prepend-icon="mdi-calendar" readonly
                      v-bind="attrs" v-on="on"></v-text-field>
                  </template>
                  <v-date-picker v-model="dateDeb" no-title scrollable>
                    <v-spacer></v-spacer>
                    <v-btn text color="primary" @click="menuDeb = false">
                      Cancel
                    </v-btn>
                    <v-btn text color="primary" @click="$refs.menuDeb.save(dateDeb)">
                      OK
                    </v-btn>
                  </v-date-picker>
                </v-menu>

              </v-col>
              <v-col align="center" justify="center" cols="2">
                <v-menu ref="menuFin" v-model="menuFin" :close-on-content-click="false" :return-value.sync="dateFin"
                  transition="scale-transition" offset-y min-width="auto">
                  <template v-slot:activator="{ on, attrs }">
                    <v-text-field v-model="dateFin" label="Date de Fin" prepend-icon="mdi-calendar" readonly
                      v-bind="attrs" v-on="on"></v-text-field>
                  </template>
                  <v-date-picker v-model="dateFin" no-title scrollable>
                    <v-spacer></v-spacer>
                    <v-btn text color="primary" @click="menuFin = false">
                      Cancel
                    </v-btn>
                    <v-btn text color="primary" @click="$refs.menuFin.save(dateFin)">
                      OK
                    </v-btn>
                  </v-date-picker>
                </v-menu>

              </v-col>
              <v-col align="center" justify="center" cols="2">
                <v-btn color="primary" @click="trieConcert">
                  OK
                </v-btn>
              </v-col>
              <v-col align="center" justify="center" cols="2">
                <v-btn color="primary" @click="getAllConcerts">
                  Voir tous les concerts
                </v-btn>
              </v-col>
            </v-row>
            <v-row justify="center" align="center" v-if="concertsActuel.length !== 0">
              <vue-glide min-height="100vh" v-model="active" control="true" perView=2>
                <vue-glide-slide v-for="concert in concertsActuel" :key="concert.id">
                  <v-card class="ma-12" min-height="60vh" :key="concert.id">
                    <v-row align="center" justify="center">
                      <v-col align="center" justify="center" cols="12">
                        <h2>{{ concert.lieu }}</h2>

                        <hr class="hr" />
                      </v-col>
                      <v-col align="center" justify="center" cols="12">
                        <v-img :src="concert.img"  max-height="300" min-height="300" max-width="400" min-width="400"></v-img>
                      </v-col>
                      <v-col align="center" justify="center" cols="12">
                        {{ concert.date }}
                         {{ concert.heureDeb }}
                      </v-col>
                      <v-col align="center" justify="center" cols="12">
                        Nombre de place disponible : {{ concert.nbrPlaceDispo }} / {{ concert.nbrPlace }}
                      </v-col>
                      <v-col align="center" justify="center" cols="12">
                        {{ concert.description }}
                      </v-col>

                      <v-col align="center" justify="center" cols="6">
                        <DeleteConcert :concert="concert" />
                      </v-col>
                      <v-col align="center" justify="center" cols="6">
                        <EditConcert :concert="concert" />
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
            </v-row>
            <v-row justify="center" align="center" v-else>

                Aucun concert n'est prévue avec les données saisies

            </v-row>
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
  -webkit-text-fill-color: transparent;
  font-family: 'Permanent Marker', cursive;
  font-size: 3.75rem
}

.full {
  min-height: 80%;
  width: 100%;
}

.hr {
  rotate: 90%;
}

.fleche {
  margin-right: 30px;
}
</style>
