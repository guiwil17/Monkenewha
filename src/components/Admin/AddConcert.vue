<script >
import API from './../../api'

export default {
  data: () => ({
    dialog: false,
    valid: true,
    place: '',
    description: '',
    lieu: '',
    image: null,
    imageUrl: '',
    time: '',
    menu2: false,
    date: new Date(),
    champs: [(v) => !!v || 'Merci de remplir le champs']
  }),
  props: {
    concert: {
      type: Object
    },
    updateConcert: {
      type: Function
    },
  },
  methods: {
    connect() {
      console.log(this.time)
      API.createConcert(this.lieu, this.place, this.description, this.date, this.imageUrl, this.time).then((result) => {
        console.log(result)
        this.updateConcert()
        this.lieu = ""
        this.place = ""
        this.description = ""
        this.date = ""
        this.imageUrl = ""
        this.image = ""
        this.time = ""
        this.dialog = false
      })

    },
    change() {
      if (!this.image) {
        return;
      }
      else {
        const reader = new FileReader();

        reader.onload = e => {
          if (e.target !== null) {
            this.imageUrl = e.target.result;
            console.log(e.target.result)

          }
        };
        reader.readAsDataURL(this.image);
      }
    }
  }
}
</script>
<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" persistent max-width="600px">
      <template v-slot:activator="{ on, attrs }">
        <v-btn color="orange" dark v-bind="attrs" v-on="on">
          +
        </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="text-h5">Ajouter un concert</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12" sm="12" md="6">
                <v-text-field label="Lieu*" v-model="lieu" required></v-text-field>
              </v-col>
              <v-col cols="12" sm="12" md="6">
                <v-text-field v-model="place" label="Nombre de place*" required></v-text-field>
              </v-col>
              <v-col cols="12" sm="12" md="12">
                <v-menu ref="menu" v-model="menu2" :close-on-content-click="false" :nudge-right="40"
                  :return-value.sync="time" transition="scale-transition" offset-y max-width="290px" min-width="290px">
                  <template v-slot:activator="{ on, attrs }">
                    <v-text-field v-model="time" label="Picker in menu" prepend-icon="mdi-clock-time-four-outline"
                      readonly v-bind="attrs" v-on="on"></v-text-field>
                  </template>
                  <v-time-picker v-if="menu2" v-model="time" full-width @click:minute="$refs.menu.save(time)">
                  </v-time-picker>
                </v-menu>
              </v-col>

              <v-col cols="12">
                <v-textarea v-model="description" label="Description*" required></v-textarea>
              </v-col>
              <v-col cols="12" sm="6">
                <v-dialog ref="dialog" v-model="modal" :return-value.sync="date" persistent width="290px">
                  <template v-slot:activator="{ on, attrs }">
                    <v-text-field v-model="date" label="Date" prepend-icon="mdi-calendar" readonly v-bind="attrs"
                      v-on="on"></v-text-field>
                  </template>
                  <v-date-picker v-model="date" scrollable>
                    <v-spacer></v-spacer>
                    <v-btn text color="primary" @click="modal = false">
                      Cancel
                    </v-btn>
                    <v-btn text color="primary" @click="$refs.dialog.save(date)">
                      OK
                    </v-btn>
                  </v-date-picker>
                </v-dialog>

              </v-col>
              <v-col cols="12" sm="6">
                <v-file-input v-model="image" label="Image" accept="image/*" prepend-icon="mdi-camera-image"
                  @change="change(e)"></v-file-input>
                <v-img :src="imageUrl" />
              </v-col>
            </v-row>
          </v-container>
          <small>*indicates required field</small>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="dialog = false">
            Close
          </v-btn>
          <v-btn color="blue darken-1" text @click="connect">
            Save
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>