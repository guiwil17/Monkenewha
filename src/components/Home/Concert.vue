<script setup>

</script>

<template>
<div class="test">
   <v-container>
       <v-row
       justify="center"
        align="center"
      >    
             <v-col align="center" justify="center" cols="12">
                 <h1 class="titre">Nos prochains concerts </h1>
             </v-col>
       </v-row>
   </v-container>
  <v-container >
       <v-row
       justify="center"
        align="center"
      >    
       <v-col align="center" justify="center" cols="12">
<v-sheet
    class="mx-auto"
    elevation="8"
  >
    <v-slide-group
      v-model="model"      
      show-arrows    
    >
     <template v-slot:prev="{ on, attrs }">
      <v-btn
      icon
        color="warning"
        v-bind="attrs"
        v-on="on"
      >
      <font-awesome-icon icon="angle-left" />
      </v-btn>
    </template>
    <template v-slot:next="{ on, attrs }">
      <v-btn      
      icon
        color="warning"
        v-bind="attrs"
        v-on="on"
      >
      <font-awesome-icon icon="angle-right" />
</v-btn>
    </template>
      <v-slide-item
        v-for="n in 15"
        :key="n"
        v-slot="{ active, toggle }"
      >
        <v-card
          :color="active ? 'primary' : 'grey lighten-1'"
          class="ma-12"
          height="80vh"
          width="50vw"
          @click="toggle"
        >
          <v-row
            class="fill-height"
            align="center"
            justify="center"
          >         
          <v-col align="center" justify="center" cols="12"> 
              <v-img src="https://remeng.rosselcdn.net/sites/default/files/dpistyles_v2/ena_16_9_extra_big/2019/08/29/node_89564/11018792/public/2019/08/29/B9720726729Z.1_20190829202512_000%2BGAREB9GAM.2-0.jpg?itok=b2AfeySY1567147356"></v-img>
          </v-col>
           <v-col align="center" justify="center" cols="12"> 
              Coucou              
          </v-col>
          </v-row>
        </v-card>
      </v-slide-item>
    </v-slide-group>
  </v-sheet>
      </v-col>
       </v-row>
  </v-container>
</div>
</template>

<style scoped>
.test {
 height: 100vh;
 background-color: white;
 color: black;

}
.full {
  height: 80%;
  width: 100%;
}


</style>
