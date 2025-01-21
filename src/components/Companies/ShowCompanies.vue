<script>
import { onMounted, ref } from "vue";
import CreateCompany from "./CreateCompany.vue";
import DeleteCompany from "./DeleteCompany.vue";

export default {
  components: {
    CreateCompany,
    DeleteCompany,
  },
  setup() {
    const companies = ref([]);

    const fetchData = async () => {
      try {
        const response = await fetch("http://localhost/api/companies");
        if (!response.ok) {
          throw new Error(`Ошибка: ${response.statusText}`);
        }
        companies.value = await response.json();
      } catch (error) {
        console.error("Ошибка при загрузке данных:", error);
      }
    };

    const addCompanyToTable = (newCompany) => {
      companies.value.push(newCompany);
    };

    const handleCompanyDeleted = (id) => {
      companies.value = companies.value.filter((company) => company.id !== id);
    };

    onMounted(fetchData);

    return { companies, addCompanyToTable, handleCompanyDeleted };
  },
};
</script>

<template>
  <div class="container mt-4">
    <table class="table table-striped table-bordered">
      <thead>
      <tr>
        <th>ID</th>
        <th>User</th>
        <th>Status</th>
        <th>Name</th>
        <th>Created At</th>
        <th>Updated At</th>
        <th></th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="company in companies" :key="company.id">
        <td>{{ company.id }}</td>
        <td>{{ company.user.name }}</td>
        <td>{{ company.status.name }}</td>
        <td>{{ company.name }}</td>
        <td>{{ company.created_at }}</td>
        <td>{{ company.updated_at }}</td>
        <td>
          <DeleteCompany :companyId="company.id" @companyDeleted="handleCompanyDeleted" />
        </td>
      </tr>
      <CreateCompany @companyCreated="addCompanyToTable" />
      </tbody>
    </table>
  </div>
</template>

<style scoped>
</style>
