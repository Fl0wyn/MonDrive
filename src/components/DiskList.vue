<template>
  <div :class="size">
    <div class="card">
      <div class="card-header">
        <svg
          class="icon-title"
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 512 512"
        >
          <path
            d="M480 288H32c-17.62 0-32 14.38-32 32v128c0 17.62 14.38 32 32 32h448c17.62 0 32-14.38 32-32v-128C512 302.4 497.6 288 480 288zM352 408c-13.25 0-24-10.75-24-24s10.75-24 24-24s24 10.75 24 24S365.3 408 352 408zM416 408c-13.25 0-24-10.75-24-24s10.75-24 24-24s24 10.75 24 24S429.3 408 416 408zM480 32H32C14.38 32 0 46.38 0 64v128c0 17.62 14.38 32 32 32h448c17.62 0 32-14.38 32-32V64C512 46.38 497.6 32 480 32zM352 152c-13.25 0-24-10.75-24-24S338.8 104 352 104S376 114.8 376 128S365.3 152 352 152zM416 152c-13.25 0-24-10.75-24-24S402.8 104 416 104S440 114.8 440 128S429.3 152 416 152z"
          /></svg
        ><span class="card-title mx-2">{{ title }}</span>
      </div>
      <table class="table card-table table-vcenter">
        <thead>
          <tr>
            <th>Hôte</th>
            <th>Statut</th>
            <th>Disques</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in items" :key="index">
            <td>
              <b> {{ index }} </b>
            </td>

            <!-- Statut-->
            <td>
              <span v-if="item[0].val.includes('on')">
                <IconSuccess />
                En ligne
              </span>
              <span v-else>
                <IconDanger />
                Non joignable
              </span>
            </td>

            <!-- Liste des disques -->
            <td v-if="item[0].val.includes('on') && item[1].val.includes('ok')">
              <div class="row" v-for="n in 1" :key="n">
                <div v-for="k in n + 2" :key="k" style="width: 200px">
                  <div v-if="item[0].val.includes('on') && item[2][k - 1]">
                    <span>
                      {{
                        item[2][k - 1].VolumeName +
                        " (" +
                        item[2][k - 1].DeviceID +
                        ")"
                      }}</span
                    >
                    <br />
                    <div class="progress my-1" style="height: 15px">
                      <div
                        :class="
                          'progress-bar ' +
                          Color(
                            ((item[2][k - 1].Size - item[2][k - 1].FreeSpace) /
                              item[2][k - 1].Size) *
                              100
                          )
                        "
                        :style="
                          'width: ' +
                          ((item[2][k - 1].Size - item[2][k - 1].FreeSpace) /
                            item[2][k - 1].Size) *
                            100 +
                          '%'
                        "
                        role="progressbar"
                      ></div>
                    </div>

                    <span>
                      {{ convertByte(item[2][k - 1].FreeSpace) }}
                      libres sur
                      {{ convertByte(item[2][k - 1].Size) }}
                    </span>
                  </div>
                </div>
              </div>
            </td>

            <td v-if="item[0].val.includes('on') && item[1].val.includes('ko')">
              <IconWindows />
              Version non supportée
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import IconSuccess from "./icons/IconSuccess.vue";
import IconDanger from "./icons/IconDanger.vue";
import IconWindows from "./icons/IconWindows.vue";

export default {
  name: "DiskList",
  components: {
    IconSuccess,
    IconDanger,
    IconWindows,
  },

  props: ["size", "title", "items"],

  methods: {
    Color(a) {
      if (a >= 90) {
        return "bg-danger";
      } else if (a >= 80) {
        return "bg-warning";
      }
    },
    convertByte(a, d = 1, k = 1000) {
      const i = Math.floor(Math.log(a) / Math.log(k));
      return (
        parseFloat((a / Math.pow(k, i)).toFixed(d)) +
        " " +
        ["o", "Ko", "Mo", "Go", "To"][i]
      );
    },
  },
};
</script>
