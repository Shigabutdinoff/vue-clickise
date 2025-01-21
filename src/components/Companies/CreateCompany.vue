<script>
import { ref } from "vue";

export default {
  props: {
    onCompanyCreated: Function,
  },
  setup(props) {
    const newCompany = ref({
      user_id: "",
      status_id: "",
      name: "",
    });
    const errorMessage = ref("");

    const createCompany = async () => {
      try {
        const response = await fetch("http://localhost/api/companies", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(newCompany.value),
        });

        if (!response.ok) {
          throw new Error(`Ошибка: ${response.statusText}`);
        }

        const createdCompany = await response.json();
        props.onCompanyCreated(createdCompany);
        newCompany.value = { user_id: "", status_id: "", name: "" };
        errorMessage.value = "";
      } catch (error) {
        console.error("Ошибка при создании компании:", error);
        errorMessage.value = "Не удалось создать компанию.";
      }
    };

    return { newCompany, createCompany, errorMessage };
  },
};
</script>

<template>
  <tr>
    <td>—</td>
    <td>
      <input v-model="newCompany.user_id" type="number" class="form-control" placeholder="ID Пользователя"/>
    </td>
    <td>
      <input v-model="newCompany.status_id" type="number" class="form-control" placeholder="ID Статуса"/>
    </td>
    <td>
      <input v-model="newCompany.name" type="text" class="form-control" placeholder="Наименование"/>
    </td>
    <td colspan="3">
      <button @click="createCompany" class="btn btn-primary">Сохранить</button>
    </td>
  </tr>

  <div v-if="errorMessage" class="error-popup">
    {{ errorMessage }}
  </div>
</template>

<style scoped>
/* Стили для всплывающего окна с ошибкой */
.error-popup {
  position: fixed;
  bottom: 20px;
  right: 20px;
  background-color: rgba(255, 0, 0, 0.8);
  color: white;
  padding: 10px 20px;
  border-radius: 5px;
  font-size: 14px;
  animation: fadeIn 0.5s ease-in-out;
}

/* Анимация появления */
@keyframes fadeIn {
  0% {
    opacity: 0;
    transform: translateY(20px);
  }
  100% {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>
