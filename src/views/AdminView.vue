<script setup lang="ts">
import Admin from '@/components/Admin/Home.vue'
import Musique from '@/components/Admin/Musique.vue'
import Concert from '@/components/Admin/Concert.vue'
import Blog from '@/components/Admin/Blog.vue'

</script>

<template>
<div>
 <Admin/>
 <Musique/>
<Concert/>
<Blog/>

</div>
</template>



<style scoped>
.test {
 min-height: 100vh;
 width: 100vw;
}

</style>
