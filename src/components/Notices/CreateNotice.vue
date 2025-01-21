<script>
import { ref } from "vue";

export default {
  props: {
    onNoticeCreated: Function,
  },
  setup(props) {
    const newNotice = ref({
      company_id: "",
      status_id: "",
      notices_button_id: "",
      title: "",
      text: "",
      url: "",
      impression_counter: "",
      crm: "",
      budget: "",
    });
    const errorMessage = ref("");

    const createNotice = async () => {
      try {
        const response = await fetch("http://localhost/api/notices", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(newNotice.value),
        });

        if (!response.ok) {
          throw new Error(`Ошибка: ${response.statusText}`);
        }

        const createdNotice = await response.json();
        props.onNoticeCreated(createdNotice);
        newNotice.value = { company_id: "", status_id: "", notices_button_id: "", title: "", text: "", url: "", impression_counter: "", crm: "", budget: "" };
        errorMessage.value = "";
      } catch (error) {
        console.error("Ошибка при создании объявления:", error);
        errorMessage.value = "Не удалось создать объявление.";
      }
    };

    return { newNotice, createNotice, errorMessage };
  },
};
</script>

<template>
  <tr>
    <td>—</td>
    <td>
      <input v-model="newNotice.company_id" type="number" class="form-control" placeholder="ID Компании"/>
    </td>
    <td>
      <input v-model="newNotice.status_id" type="number" class="form-control" placeholder="ID Статуса"/>
    </td>
    <td>
      <input v-model="newNotice.notices_button_id" type="number" class="form-control" placeholder="ID Кнопки Объявления"/>
    </td>
    <td>
      <input v-model="newNotice.title" type="text" class="form-control" placeholder="Заглавие"/>
    </td>
    <td>
      <input v-model="newNotice.text" type="text" class="form-control" placeholder="Текст"/>
    </td>
    <td>
      <input v-model="newNotice.url" type="url" class="form-control" placeholder="Ссылка"/>
    </td>
    <td>
      <input v-model="newNotice.impression_counter" type="number" class="form-control" placeholder="Количество показов"/>
    </td>
    <td>
      <input v-model="newNotice.crm" type="text" class="form-control" placeholder="CPM"/>
    </td>
    <td>
      <input v-model="newNotice.budget" type="number" class="form-control" placeholder="Бюджет объявления"/>
    </td>
    <td colspan="3">
      <button @click="createNotice" class="btn btn-primary">Сохранить</button>
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
