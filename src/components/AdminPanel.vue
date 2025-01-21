<script setup lang="ts">
import { ref } from "vue";
import ShowUsers from "@/components/Users/ShowUsers.vue";
import ShowCompanies from "@/components/Companies/ShowCompanies.vue";
import ShowNotices from "@/components/Notices/ShowNotices.vue";

// Текущее состояние активного компонента
const activeComponent = ref("users");

const setActiveComponent = (component: string) => {
  activeComponent.value = component;
};
</script>

<template>
  <div class="button-container">
    <button
        class="btn btn-outline-primary"
        @click="setActiveComponent('users')">
      Пользователи
    </button>
    <button
        class="btn btn-outline-primary"
        @click="setActiveComponent('companies')">
      Компании
    </button>
    <button
        class="btn btn-outline-primary"
        @click="setActiveComponent('notices')">
      Объявления
    </button>
  </div>

  <div class="mt-4">
    <div class="table-container">
      <ShowUsers v-if="activeComponent === 'users'" />
       <ShowCompanies v-else-if="activeComponent === 'companies'" />
       <ShowNotices v-else-if="activeComponent === 'notices'" />
    </div>
  </div>
</template>

<style scoped>
.button-container {
  position: fixed;
  top: 10px;
  left: 10px;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.btn {
  width: 200px;
}

.mt-4 {
  margin-top: 40px;
}

.table-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}
</style>
