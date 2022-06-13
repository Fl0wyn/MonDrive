<template>
  <div class="container-xl">
    <div class="page-header d-print-none">
      <div class="row align-items-center">
        <div class="col">
          <div>{{ "Semaine : " + weekNumber }}</div>
          <h2>{{ fullDate }}</h2>
        </div>
        <!-- Début : Erreur -->
        <div
          class="col-12 col-md-auto ms-auto d-print-none"
          v-for="(item, index) in items"
          :key="index"
          v-show="item[2].val.includes('ko')"
        >
          <div class="alert alert-danger" role="alert">
            <h4 class="alert-title">Donnée non disponible</h4>
            <div class="text-muted">
              <div class="list-group list-group-flush">
                {{ "Serveur : " + index }}
              </div>
            </div>
          </div>
        </div>
        <!-- Fin : Erreur -->
      </div>
    </div>
  </div>
</template>

<script>
import { DateTime } from "luxon";

export default {
  name: "Header",
  data: () => ({
    weekNumber: "",
    fullDate: "",
  }),

  props: ["items"],

  methods: {
    DateTime,
  },

  mounted() {
    // Week number
    const date = DateTime.now().weekNumber;
    this.weekNumber = date;

    // Full date
    var DateTimeFormat = new Date();
    var DateFormat = DateTimeFormat.toLocaleDateString("fr-FR", {
      weekday: "long",
      year: "numeric",
      month: "long",
      day: "numeric",
    });
    this.fullDate = DateFormat.charAt(0).toUpperCase() + DateFormat.slice(1);
  },
};
</script>
