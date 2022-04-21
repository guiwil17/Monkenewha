<script>
  export default {
    data: () => ({
      dialog: false,
    }),
  }
</script>
<template>
  <v-row justify="center">
    <v-dialog
      v-model="dialog"
      persistent
      max-width="600px"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          color="teal"
          dark
          v-bind="attrs"
          v-on="on"
        >
          <font-awesome-icon icon="pen" />
        </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="text-h5">Modification du post</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col
                cols="12"
                sm="12"
                md="6"
              >
                <v-text-field
                  label="Titre*"
                  required
                ></v-text-field>
              </v-col>            
             
              <v-col cols="12">
                <v-textarea
                  label="Détails du post*"
                  required
                ></v-textarea>
              </v-col>             
              <v-col
                cols="12"
                sm="6"
              >
                <v-dialog
        ref="dialog"
        v-model="modal"
        :return-value.sync="date"
        persistent
        width="290px"
      >
        <template v-slot:activator="{ on, attrs }">
          <v-text-field
            v-model="date"
            label="Date"
            prepend-icon="mdi-calendar"            
            readonly
            v-bind="attrs"
            v-on="on"
          ></v-text-field>
        </template>
        <v-date-picker
          v-model="date"
          scrollable
        >
          <v-spacer></v-spacer>
          <v-btn
            text
            color="primary"
            @click="modal = false"
          >
            Cancel
          </v-btn>
          <v-btn
            text
            color="primary"
            @click="$refs.dialog.save(date)"
          >
            OK
          </v-btn>
        </v-date-picker>
      </v-dialog>

              </v-col>
              <v-col
                cols="12"
                sm="6"
              >
              <v-file-input label="Image" accept="image/*" prepend-icon="mdi-camera-image"></v-file-input>
              </v-col>
            </v-row>
          </v-container>
          <small>*indicates required field</small>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="blue darken-1"
            text
            @click="dialog = false"
          >
            Close
          </v-btn>
          <v-btn
            color="blue darken-1"
            text
            @click="dialog = false"
          >
            Save
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>