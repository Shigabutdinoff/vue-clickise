<script>
import { ref } from "vue";

export default {
  props: {
    onUserCreated: Function,
  },
  setup(props) {
    const newUser = ref({
      name: "",
      email: "",
      password: "",
    });
    const errorMessage = ref("");

    const createUser = async () => {
      try {
        const response = await fetch("http://localhost/api/users", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(newUser.value),
        });

        if (!response.ok) {
          throw new Error(`Ошибка: ${response.statusText}`);
        }

        const createdUser = await response.json();
        props.onUserCreated(createdUser);
        newUser.value = { name: "", email: "", password: "" };
        errorMessage.value = "";
      } catch (error) {
        console.error("Ошибка при создании пользователя:", error);
        errorMessage.value = "Не удалось создать пользователя.";
      }
    };

    return { newUser, createUser, errorMessage };
  },
};
</script>

<template>
  <tr>
    <td>—</td>
    <td>
      <input v-model="newUser.name" type="text" class="form-control" placeholder="Имя"/>
    </td>
    <td>
      <input v-model="newUser.email" type="email" class="form-control" placeholder="Email"/>
    </td>
    <td>
      <input v-model="newUser.password" type="password" class="form-control" placeholder="Password"/>
    </td>
    <td colspan="3">
      <button @click="createUser" class="btn btn-primary">Сохранить</button>
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
