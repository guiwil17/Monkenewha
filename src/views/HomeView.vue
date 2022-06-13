<script setup lang="ts">
import Home from '@/components/Home.vue'
import Groupe from '@/components/Home/Groupe.vue'
import Blog from '@/components/Home/Blog.vue'
import Concert from '@/components/Home/Concert.vue'
import Contact from '@/components/Home/Contact.vue'
import Historique from '@/components/Home/Historique.vue'
import Musique from '@/components/Musique/Home.vue'

</script>

<template>
<div>
    <Home />    
    <Historique />
    <Groupe />
    <!-- <Musique /> -->
    <Blog />  
    <Concert />
    <Contact />  
</div>
</template>
<style scoped>
.test {
 width: 100vw;
}

</style>