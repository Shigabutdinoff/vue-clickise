<script>
export default {
  name: 'DeleteUserButton',
  props: {
    userId: {
      type: Number,
      required: true,
    },
  },
  emits: ['userDeleted'],
  methods: {
    async deleteUser() {
      try {
        const response = await this.deleteUserRequest();
        if (!response.ok) {
          throw new Error(`Ошибка удаления пользователя с id ${this.userId}`);
        }

        // Сообщаем родителю об удалении
        this.$emit('userDeleted', this.userId);
      } catch (error) {
        this.handleError(error);
      }
    },
    async deleteUserRequest() {
      return fetch(`http://localhost/api/users/${this.userId}`, {
        method: 'DELETE',
      });
    },
    handleError(error) {
      console.error('Ошибка при удалении пользователя:', error);
    },
  },
};
</script>

<template>
  <button @click="deleteUser" class="btn btn-danger">
    🗑️
  </button>
</template>

<style scoped>
button {
  font-size: 0.9em;
}

button:hover {
  background-color: darkred;
}
</style>
