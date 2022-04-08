import Vue from "vue";
import App from "./App.vue";
import "@tabler/core/dist/css/tabler.min.css";

require('./assets/style.css')

Vue.config.productionTip = false;

new Vue({
  render: (h) => h(App),
}).$mount("#app");
