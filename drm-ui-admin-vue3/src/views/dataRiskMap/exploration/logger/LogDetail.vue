<template>
  <Dialog v-model="dialogVisible" title="任务详细" width="1200px">
    <ContentWrap>
      <!-- 搜索工作栏 -->
      <el-form
        class="-mb-15px"
        :model="queryParams"
        ref="queryFormRef"
        :inline="true"
        label-width="100px"
      >
        <el-form-item label="数据库类型" prop="dsType">
          <el-select v-model="queryParams.dsType" placeholder="轻选择数据源类型" clearable style="width:240px;">
            <el-option v-for="item in dsTypeArr" :key="item" :label="item" :value="item"/>
          </el-select>
        </el-form-item>
        <el-form-item label="数据源URL" prop="dsUrl">
          <el-input
            v-model="queryParams.dsUrl"
            placeholder="请输入数据库地址"
            clearable
            class="!w-240px"
          />
        </el-form-item>
        <el-form-item>
          <el-button @click="handleQuery"><Icon icon="ep:search" class="mr-5px" /> 搜索</el-button>
          <el-button @click="resetQuery"><Icon icon="ep:refresh" class="mr-5px" /> 重置</el-button>
        </el-form-item>
      </el-form>
    </ContentWrap>
    <ContentWrap>
      <el-table v-loading="loading" :data="list">
        <el-table-column label="任务实例主键" prop="taskId"/>
        <el-table-column label="任务实例" prop="instanceId"/>
        <el-table-column label="数据源URL" prop="dsUrl"/>
        <el-table-column label="服务端口" prop="dsPort"/>
        <el-table-column label="数据库服务类型" prop="dsType"/>
        <el-table-column label="操作" align="center" width="100px" fixed="right">
          <template #default="scope">
            <el-button
              link
              type="primary"
              @click="openForm( scope.row)"
            >
              添加资产
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <!-- 分页组件 -->
      <Pagination
        :total="total"
        v-model:page="queryParams.pageNo"
        v-model:limit="queryParams.pageSize"
        @pagination="getList"/>
      <ManageForm ref="formRef" @success="getList" :dbTypeArr="dbTypeArr"/>
    </ContentWrap>
  </Dialog>
</template>
<script lang="ts" setup>
import { explorationApi} from '@/api/dataRiskMap/exploration'
import ManageForm from "./ManageForm.vue"
defineOptions({ name: 'LogDetail' })
const queryFormRef = ref()
const formRef = ref()
const dbTypeArr = ref([])
const queryParams = reactive({
  pageNo: 1,
  pageSize: 10,
  dsUrl: '',
  dsType:'',
})
const loading = ref(true) // 列表的加载中
const total = ref(0) // 列表的总页数
const list = ref([]) // 列表的数据
const dialogVisible = ref(false) // 弹窗的是否展示
const rowParam = ref({})
const dsTypeArr = ref([])

const getdsTypeArr = async () => {
    dsTypeArr.value = await explorationApi.getDataBaseType()
}
const getList = async () => {
  loading.value = true
  try {//instanceId: rowParam.value.instanceId
    const data = await explorationApi.getLogDetail(Object.assign(queryParams,{taskId: rowParam.value.taskId,instanceId: rowParam.value.instanceId}))
    list.value = data.records
    total.value = data.total
  } finally {
    loading.value = false
  }
}
const handleQuery = () => {
  queryParams.pageNo = 1
  getList()
}

/** 重置按钮操作 */
const resetQuery = () => {
  queryFormRef.value.resetFields()
  handleQuery()
}
/** 打开弹窗 */
const open = async (row: any) => {
  dialogVisible.value = true
  rowParam.value = Object.assign({},row)
  await getList()
  await getdsTypeArr()
}
const getdbTypeArr = async () => {
  dbTypeArr.value = await explorationApi.getDataBaseType()
}
const openForm = async (row: any) => {
  formRef.value.open(row)
}
onMounted(() => {
  getdbTypeArr()
})
defineExpose({ open }) // 提供 open 方法，用于打开弹窗
</script>
<style lang="scss" scoped>
:deep(.el-table__label){
  width: 100px;
}
</style>
