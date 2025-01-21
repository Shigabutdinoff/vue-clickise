<script>
import { onMounted, ref } from "vue";
import CreateNotice from "./CreateNotice.vue";
import DeleteNotice from "./DeleteNotice.vue";

export default {
  components: {
    CreateNotice,
    DeleteNotice,
  },
  setup() {
    const notices = ref([]);

    const fetchData = async () => {
      try {
        const response = await fetch("http://localhost/api/notices");
        if (!response.ok) {
          throw new Error(`Ошибка: ${response.statusText}`);
        }
        notices.value = await response.json();
      } catch (error) {
        console.error("Ошибка при загрузке данных:", error);
      }
    };

    const addNoticeToTable = (newNotice) => {
      notices.value.push(newNotice);
    };

    const handleNoticeDeleted = (id) => {
      notices.value = notices.value.filter((notice) => notice.id !== id);
    };

    onMounted(fetchData);

    return { notices, addNoticeToTable, handleNoticeDeleted };
  },
};
</script>

<template>
  <div class="container mt-4">
    <table class="table table-striped table-bordered">
      <thead>
      <tr>
        <th>ID</th>
        <th>Company</th>
        <th>Status</th>
        <th>Notices Button</th>
        <th>Title</th>
        <th>Text</th>
        <th>URL</th>
        <th>Impression Counter</th>
        <th>CRM</th>
        <th>Budget</th>
        <th>Updated_at</th>
        <th>Created_at</th>
        <th></th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="notice in notices" :key="notice.id">
        <td>{{ notice.id }}</td>
        <td>{{ notice.company.name}}</td>
        <td>{{ notice.status.name}}</td>
        <td>{{ notice.notices_button.name}}</td>
        <td>{{ notice.title}}</td>
        <td>{{ notice.text}}</td>
        <td>{{ notice.url}}</td>
        <td>{{ notice.impression_counter}}</td>
        <td>{{ notice.crm}}</td>
        <td>{{ notice.budget}}</td>
        <td>{{ notice.updated_at}}</td>
        <td>{{ notice.created_at}}</td>
        <td>
          <DeleteNotice :noticeId="notice.id" @noticeDeleted="handleNoticeDeleted" />
        </td>
      </tr>
      <CreateNotice @noticeCreated="addNoticeToTable" />
      </tbody>
    </table>
  </div>
</template>

<style scoped>
</style>
