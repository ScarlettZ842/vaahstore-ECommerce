import { toRaw, watch } from "vue";
import { acceptHMRUpdate, defineStore } from "pinia";
import { vaah } from "../vaahvue/pinia/vaah";
import qs from "qs";
import dayjs from "dayjs";
import { getBaseUrl } from "../utils/base-url";

let base_url = getBaseUrl();
let ajax_url = base_url + "/api/store/dashboard";

export const useDashboardStore = defineStore({
  id: "dashboard",
  state: () => ({
    base_url: base_url,
    ajax_url: ajax_url,
    assets: null,
    stores: null,
    selected_store_at_dashboard: null,
    default_store: null,
  }),
  getters: {},
  actions: {
    //---------------------------------------------------------------------
    async getAssets() {
      await vaah().ajax(this.ajax_url + "/assets", this.afterGetAssets);
    },
    //---------------------------------------------------------------------
    afterGetAssets(data, res) {
      if (data) {
        this.assets = data;
        this.stores = data.stores;
      }
    },
    //---------------------------------------------------------------------
  },
});
