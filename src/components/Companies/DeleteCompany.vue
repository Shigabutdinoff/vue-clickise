<script>
export default {
  name: 'DeleteCompanyButton',
  props: {
    companyId: {
      type: Number,
      required: true,
    },
  },
  emits: ['companyDeleted'],
  methods: {
    async deleteCompany() {
      try {
        const response = await this.deleteCompanyRequest();
        if (!response.ok) {
          throw new Error(`Ошибка удаления компании с id ${this.companyId}`);
        }

        // Сообщаем родителю об удалении
        this.$emit('companyDeleted', this.companyId);
      } catch (error) {
        this.handleError(error);
      }
    },
    async deleteCompanyRequest() {
      return fetch(`http://localhost/api/companies/${this.companyId}`, {
        method: 'DELETE',
      });
    },
    handleError(error) {
      console.error('Ошибка при удалении компании:', error);
    },
  },
};
</script>

<template>
  <button @click="deleteCompany" class="btn btn-danger">
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
