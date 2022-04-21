<script>
import router from 'vue-router'
import EditBlog from './EditBlog.vue'
export default {
  components: { EditBlog },
    data: () => ({
        types: ['Places to Be', 'Places to See'],
        cards: [{
                titre: 'LAlalala',
                date: "10/02/2020",
                description: "Logoden biniou degemer mat an penn ar bed Plegad-Gwerann pelec’h nijal dirak  c’hwi gousperoù, kreskiñ fraoñval gallout oentr kar oabl tro kichen mezher kastell c’hodell. C’houzoug etrezek vag goulenn Montroulez karr leal egistoc'h vihanañ, graet Plouneour-Menez Mellag prest a-raok  war kentel war ampart, kaeraat wec’h dihuniñ ti ebet fourchetez daoudroad. Yar hervez  ael miliner nag farsus eost Gerveur e, gwin sukr paotr sae bep gavr tavarn drezon kaier, Oskaleg digarez mae betek pluenn tavarnour peroked. Evidout gloan c’houzoug c’harrez toull gwenodenn soñjal ilin stivell, tiegezh eost mouchouer c’hoari trouz krediñ benveg gaou ganti, levrioù klevout bag falc’hat garv poultrenn toenn. Du anezhañ atav a klask Rosporden ouzhin wenodenn santout, egisti enor naer eizhvet a c’harrez pod ul Pederneg, ki tra bro tud seizhvet a Plouared. Skolaer ha divalav kalon ar honnont nemet traonienn grib, gwele Plouared naetaat wech an c’hontrol an bag Kastell-Paol, bep razh melezour marc’had metrad maez dastum. Vuoc’h pod evidout kleiz dimeurzh seizh prad tann kement, war al glav aotre munutenn merkañ pred poan beg, pegoulz naon lavarout daoust ar degemer kilpenn. Lizher eviti kreskiñ us planken moan hent moulañ ifern, c’haod enez ganti kant degas lezenn padout ivez beuziñ, ilin dremm amprevan plij kenetre  arabat riskl. Chokolad chadenn c’horf dud eus c’hreisteiz lies gwelloc’h kuzuliañ, gentel plant terriñ beuziñ Malo eizhvet warnon Baden poazhañ, envel pep genou c’helenner kezeg all kozh. Aet mantell tagañ gounez goz evañ pegen bemnoz egile, laerezh vihan gouelañ Chrouer ur Roazhon Park mevel doujañ gwazh, purgator Montroulez ar Plougasnou kerc’hat eno Kermouster."
            },
            {
                titre: 'LAlalala',
                date: "10/02/2020",
                description: "Logoden biniou degemer mat an penn ar bed naet, mall merenn broustañ arc’h ouzhimp skalier. Teñvalijenn siminal vloaz c’harrez gaou c’houmoul askell pesk mui, divalav priz livañ a unan dimeurzh. Kemener boutailh Mikael gloan meud c’hwevrer, pluenn anavezout hanternoz tavañjer kelc’h, las darn vazh egile. Dour koumoul uhelder ar onest ki hemañ blot kaeraat, beaj rak davarn digant du regiñ. Kompren Lokmikael (an-Traezh) Plouzane gwad ebeul e c’hig here Brasparz, dihuniñ yaouank yalc’h amañ Penmarc’h trugarez. Degemer greiz pobl dija Plegad-Gwerann treuziñ, ruz skeud dirak Kermouster dud, kuzhat dir gaer touellañ. Argol saveteiñ c’huzh kontadenn disul Ar Releg-Kerhuon, ha leziregezh vloaz yaouankiz las, evezh prenañ bed muzell. Ruz diwezhat ennon eizhvet volz pluenn, houad c’hi falc’hat eil noz, meskañ heuliañ gwech eme. Dant arrebeuri menoz Abbarez kriz gwalenn, abardaez asied ler c’huzh araok, paouez kregiñ familh ael. Gortoz stagañ beajiñ boutailh yaou galleg meur ha kibellañ, ebeul Perros-Gireg aon troc’hañ spont an."
            },
            {
                titre: 'LAlalala',
                date: "10/02/2020",
                description: "Logoden biniou degemer mat an penn, ar bed mar feunten. Diskar vloaz kardeur lamm, hennezh ennoc'h gouriz pri, klañv lezirek. Difenn prenañ ur doñv mab Muzilheg, vi dud morzhol keniterv. Pad bouton deiz flamm, doug gouren Rosko vrec’h, plijet c’hilhog. Pemp nijal saveteiñ fiñval egile enep, gallek war berr mevel. Dek stivell o eur patatez Plouganoù, kousket mezheven Moel lemm. Kemper huñvre kraou tabut ruz Sun, kerzhout dimerc’her garantez egistomp. Kav hervez  prennañ lamp beleg rak , sukr dec’h Liger park. Melen Baen-Veur stank kibell Roazhon Park boan, chase nerzh gwriat evit. Marc’h barv ur pesk rumm amañ, gouzañv avat petra loa."
            },
            {
                titre: 'LAlalala',
                date: "10/02/2020",
                description: "Logoden biniou degemer mat, an. Tomm gaoued traoñ kuz’h, arvar. Stur pri c’higer kozh, karantez. Unnek gouest bev laouen, barv. Kazh kein gouest kar, Liger. Baen-Veur estreget  sae an, banniel. Ar zo gousperoù brumenn, giz. Warlene krediñ porzh outo, klañv. Sae riskl lec’h uhelder, meud. Pesk yec’hed c’hemener vignonez, ha."
            },
            {
                titre: 'LAlalala',
                date: "10/02/2020",
                description: "Logoden biniou degemer mat an, penn ar bed. Nevez ur berr seblantout hervez, Plougasnou garv dant. Ganin ha digempenn nec’h c’houmanant, hon d’a da. Marennañ piz dleout e tach, amprevan gouere kaoued. Mezher gwelout warnon Pempont lizher, maen walc’h kerf. Gallout koumoul c’helien muzell kloc’h, kerc’h rak  out. A enebour gaoued da goap, leziregezh Ar Gall eost. Regiñ gegin a betek medisin, ur barrad greiz. Hevelep c’hroc’hen Gwengamp sadorn a, pri veur benveg. Gwer paper evit bras eizh, servijañ kêr spi."
            },
            {
                titre: 'LAlalala',
                date: "10/02/2020",
                description: "Logoden biniou. Leun lamp. Amañ lizherenn. C'hanon arvar. C’hraou ha. Alies an. Logod aval. Betek tiegezh. C’hardeur gwec’h. Bemnoz kloued."
            },
        ],
        socials: [{
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
        dialog: false
    }),

    methods: {
        getImage() {
            const min = 550
            const max = 560

            return Math.floor(Math.random() * (max - min + 1)) + min
        },
        detect() {
            alert("yaaaaaaaaaaaaaaaaah")
        },
        goToHome() {
            this.$router.push('/')
        }
    },
}
</script>
<template>
<div class="test">
    <v-container fill-height fill-width class="title">
        <v-row justify="center" align="center">
            <v-col align="center" justify="center" cols="12">
                <h1 class="titre text-h2">                    
                    Blog
                </h1>
            </v-col>
            <v-col align="center" justify="center" cols="12">
                <v-btn class="ml-2 mt-5" elevation="2" color="warning" @click="goToHome">
                    +
                </v-btn>
            </v-col>
        </v-row>
    </v-container>
    <v-container fill-height fill-width>
        <v-row justify="center" align="center">
            <v-container fluid>
                <v-row>
                    <v-spacer></v-spacer>
                    <v-col v-for="card in cards" :key="card" cols="12" sm="6" md="6">
                        <v-card>
                            <v-card-actions class="white justify-center">
                                <v-container fill-height fill-width>
                                    <v-row justify="center" align="center">
 
                                        <v-col align="center" justify="center" cols="12">                                            
                                            <span class="text-h5 pl-4 pt-4 d-inline-block" v-text="card.titre"></span>
                                        </v-col>
                                        <v-col align="center" justify="center" cols="12">
                                           
                                            {{card.date}}
                                        </v-col>
                                    </v-row>
                                </v-container>
                            </v-card-actions>
                            <v-img :src="`https://picsum.photos/200/200?image=${getImage()}`" contain aspect-ratio="1" @click="detect()" class="image"></v-img>

                            <v-card-actions class="white justify-center">
                                <v-container fill-height fill-width>
                                    <v-row justify="center" align="center">

                                        <v-col align="center" justify="center" cols="12">
                                            {{card.description}}
                                        </v-col>
                                        <v-col align="center" justify="center" cols="6">
                                            <v-btn @click="goToHome" color="error">
                                                <font-awesome-icon icon="trash" />
                                            </v-btn>
                                        </v-col>
                                        <v-col align="center" justify="center" cols="6">
                                                 <EditBlog />
                                        </v-col>
                                    </v-row>
                                </v-container>
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

.title {
    height: 20vh;
}

.image {
    max-height: 40vh;
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
