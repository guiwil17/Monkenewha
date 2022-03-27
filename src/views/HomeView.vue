<script setup lang="ts">
import Home from '@/components/Home.vue'
import Groupe from '@/components/Home/Groupe.vue'
import Blog from '@/components/Home/Blog.vue'
import Concert from '@/components/Home/Concert.vue'
import Contact from '@/components/Home/Contact.vue'
import Historique from '@/components/Home/Historique.vue'
import Footer from '@/components/Home/footer.vue'

</script>

<template>
<div>
    <Home />    
    <Historique />
    <Groupe />
    <Blog />  
    <Concert />
    <Contact />  
    <Footer />
</div>
</template>



<style scoped>
.test {
 min-height: 100vh;
 width: 100vw;
}

</style>
