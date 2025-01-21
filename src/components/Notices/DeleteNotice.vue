<script>
export default {
  name: 'DeleteNoticeButton',
  props: {
    noticeId: {
      type: Number,
      required: true,
    },
  },
  emits: ['noticeDeleted'],
  methods: {
    async deleteNotice() {
      try {
        const response = await this.deleteNoticeRequest();
        if (!response.ok) {
          throw new Error(`Ошибка удаления объявления с id ${this.noticeId}`);
        }

        // Сообщаем родителю об удалении
        this.$emit('noticeDeleted', this.noticeId);
      } catch (error) {
        this.handleError(error);
      }
    },
    async deleteNoticeRequest() {
      return fetch(`http://localhost/api/notices/${this.noticeId}`, {
        method: 'DELETE',
      });
    },
    handleError(error) {
      console.error('Ошибка при удалении объявления:', error);
    },
  },
};
</script>

<template>
  <button @click="deleteNotice" class="btn btn-danger">
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
