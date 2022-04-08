<template>
  <div id="app" v-if="!errored">
    <div class="page">
      <Navbar />
      <!--       <VueHtml2pdf
        :show-layout="true"
        :float-layout="false"
        :enable-download="true"
        :preview-modal="false"
        :filename="
          'MonIT' + '_' + new Date().toLocaleDateString().replaceAll('/', '-')
        "
        :pdf-quality="2"
        :manual-pagination="true"
        pdf-format="a4"
        pdf-orientation="portrait"
        ref="html2Pdf"
        pdf-content-width="100%"
      >
        <section slot="pdf-content"> -->
      <div class="page-wrapper">
        <Header />
        <div class="page-body">
          <div class="container-xl">
            <div class="row row-deck row-cards">
              <DiskList size="col-sm-12" :title="title" :items="items" />
            </div>
          </div>
        </div>
      </div>
      <!--         </section>
      </VueHtml2pdf> -->
    </div>
  </div>

  <div class="alert alert-danger mx-4 my-4" v-else role="!alert">
    <h4 class="alert-title">Oups, quelque chose s'est mal passé &hellip;</h4>
    <div class="text-muted">{{ errorlog }}</div>
  </div>
</template>

<script>
import Navbar from "./components/Navbar";
import Header from "./components/Header";
import DiskList from "./components/DiskList";

import axios from "axios";

export default {
  name: "App",
  components: {
    Navbar,
    Header,
    DiskList,
  },

  data: () => ({
    title: "Liste des lecteurs",
    items: [],
    errored: false,
    errorlog: "",
  }),

  mounted() {
    axios
      .get("data.json")
      .then((response) => {
        this.items = response.data.info;
      })
      .catch((error) => {
        console.log(error);
        this.errored = true;
        this.errorlog = error;
      });
  },
};
</script>