
<script>
  export default {
    data: () => ({
      types: ['Places to Be', 'Places to See'],
      cards: [{
          nom : 'Reims Arena',
          date: "10/02/2020",
          start: "18:00" ,
          end: "20:00",
          place: 9000
          },
          {
          nom : 'La cygalle',
          date: "10/02/2020",
          start: "18:00" ,
          end: "20:00",
          place: 5000
          },
          {
          nom : 'Montpelly arena',
          date: "10/02/2020",
          start: "18:00" ,
          end: "20:00",
          place: 12000
          },
          {
          nom : 'Lille',
          date: "10/02/2020",
          start: "18:00" ,
          end: "20:00",
          place: 800
          },
          {
          nom : 'Caen',
          date: "10/02/2020",
          start: "18:00" ,
          end: "20:00",
          place: 3000
          },
          {
          nom : 'Bercy',
          date: "10/02/2020",
          start: "18:00" ,
          end: "20:00",
          place: 30000 
          },],
      socials: [
        {
          icon: 'mdi-facebook',
          color: 'indigo',
        },
        {
          icon: 'mdi-linkedin',
          color: 'cyan darken-1',
        },
        {
          icon: 'mdi-instagram',
          color: 'red lighten-3',
        },
      ],
    }),

    methods: {
      getImage () {
        const min = 550
        const max = 560

        return Math.floor(Math.random() * (max - min + 1)) + min
      },
      detect(){
        alert("yaaaaaaaaaaaaaaaaah")
      }
    },
  }
</script>
<template>
    <div class="test">
  <v-container fill-height fill-width>
       <v-row
       justify="center"
        align="center"        
      >
      
      <v-col align="center" justify="center" cols="12">
    <h1 class="titre text-h2">
      
      Concert
      </h1>
        </v-col>  
       </v-row>

         <v-row
       justify="center"
        align="center"        
      >
      
      <v-container     
      fluid
    >

      <v-row>
        <v-spacer></v-spacer>
        <v-col
          v-for="card in cards"
          :key="card"
          cols="12"
          sm="6"
          md="4"
        >
          <v-card @click="detect()">
            <v-img
              :src="`https://picsum.photos/200/300?image=${getImage()}`"
             aspect-ratio="1"
            >
             
            </v-img>

            <v-card-actions class="white justify-center">
              <v-container fill-height fill-width>
       <v-row
       justify="center"
        align="center"        
      >
      
      <v-col align="center" justify="center" cols="12">
         <span
                class="text-h5 pl-4 pt-4 d-inline-block"
                v-text="card.nom"
              ></span>
      </v-col>
      <v-col align="center" justify="center" cols="12">
         {{card.date}}           
      </v-col>
        <v-col align="center" justify="center" cols="12">        
            {{card.start}} - {{card.end}}
      </v-col>
       </v-row></v-container>
            </v-card-actions>
          </v-card>
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

.image{
      border-radius: 100%;  
      width: 300px; 
}
.pulse-anim{
    box-shadow: 0 0 0 0 black;
    animation: pulse 1.3s infinite;
}
.titre{
  text-align: 'center';
       background: linear-gradient(to right, #FF6F00, #FBE9E7);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;

}

</style>
