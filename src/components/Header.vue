<template>
  <div class="container-xl">
    <div class="page-header d-print-none">
      <div class="row align-items-center">
        <div class="col">
          <div>{{ "Semaine : " + weekNumber }}</div>
          <h2>{{ fullDate }}</h2>
        </div>
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
