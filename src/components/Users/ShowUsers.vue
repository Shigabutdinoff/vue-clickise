<script>
import { onMounted, ref } from "vue";
import CreateUser from "./CreateUser.vue";
import DeleteUser from "./DeleteUser.vue";

export default {
  components: {
    CreateUser,
    DeleteUser,
  },
  setup() {
    const users = ref([]);

    const fetchData = async () => {
      try {
        const response = await fetch("http://localhost/api/users");
        if (!response.ok) {
          throw new Error(`Ошибка: ${response.statusText}`);
        }
        users.value = await response.json();
      } catch (error) {
        console.error("Ошибка при загрузке данных:", error);
      }
    };

    const addUserToTable = (newUser) => {
      users.value.push(newUser);
    };

    const handleUserDeleted = (id) => {
      users.value = users.value.filter((user) => user.id !== id);
    };

    onMounted(fetchData);

    return { users, addUserToTable, handleUserDeleted };
  },
};
</script>

<template>
  <div class="container mt-4">
    <table class="table table-striped table-bordered">
      <thead>
      <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Created At</th>
        <th>Updated At</th>
        <th></th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="user in users" :key="user.id">
        <td>{{ user.id }}</td>
        <td>{{ user.name }}</td>
        <td>{{ user.email }}</td>
        <td>{{ user.created_at }}</td>
        <td>{{ user.updated_at }}</td>
        <td>
          <DeleteUser :userId="user.id" @userDeleted="handleUserDeleted" />
        </td>
      </tr>
      <CreateUser @userCreated="addUserToTable" />
      </tbody>
    </table>
  </div>
</template>

<style scoped>
</style>
