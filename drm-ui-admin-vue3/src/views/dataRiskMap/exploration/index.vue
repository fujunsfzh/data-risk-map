<template>
  <ContentWrap>
    <!-- 搜索工作栏 -->
    <el-form
      class="-mb-15px"
      :model="queryParams"
      ref="queryFormRef"
      :inline="true"
      label-width="68px"
    >
      <el-form-item label="任务名称" prop="name">
        <el-input placeholder="请输入任务名称" v-model="queryParams.name"/>
      </el-form-item>
      <el-form-item label="任务状态" prop="status">
        <el-select v-model="queryParams.status" clearable placeholder="请选择任务状态" style="width:170px;">
          <el-option
            v-for="dict in statusArr"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
            clearable
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button @click="handleQuery"><Icon icon="ep:search" class="mr-5px" /> 搜索</el-button>
        <el-button @click="resetQuery"><Icon icon="ep:refresh" class="mr-5px" /> 重置</el-button>
        <el-button
          type="primary"
          plain
          @click="openForm('create')"
        >
          <Icon icon="ep:plus" class="mr-5px" /> 新增
        </el-button>
      </el-form-item>
    </el-form>
  </ContentWrap>
  <!-- 列表 -->
  <ContentWrap>
    <el-table v-loading="loading" :data="list">
      <el-table-column label="任务主键" align="center" prop="id" />
      <el-table-column label="任务名称" align="center" prop="name" />
      <el-table-column label="类型" align="center" prop="type">
        <template #default="scope">
          <span>{{scope.row.type === 1? '单次':'corn'}}</span>
        </template>
      </el-table-column>
      <el-table-column label="探查范围" align="center" prop="ip" />
      <el-table-column label="端口号" align="center" prop="port" />
      <el-table-column label="任务状态" align="center" prop="status">
        <template #default="scope">
          <el-tag type="primary" v-if="scope.row.status === 1">正常</el-tag>
          <el-tag type="danger" v-if="scope.row.status === 2">暂停</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180" :formatter="dateFormatter"/>
      <el-table-column label="操作" align="center" min-width="160px" fixed="right">
        <template #default="scope">
          <el-button
            link
            type="primary"
            @click="openForm('update', scope.row.id)"
          >
            修改
          </el-button>
          <el-button
            type="primary"
            link
            @click="changeState(scope.row.status, scope.row.id)"
          >
            {{ scope.row.status === 1 ? '暂停' : '开启' }}
          </el-button>
          <el-button
            link
            type="danger"
            @click="handleDelete(scope.row.id)"
          >
            删除
          </el-button>
          <el-dropdown @command="(command) => handleCommand(command, scope.row)"  size="small">
            <el-button type="primary" link style="font-size: 12px;margin-top: 3px">更多 <Icon icon="ep:d-arrow-right"/> </el-button>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item command="handleExecute">
                  执行一次
                </el-dropdown-item>
                <el-dropdown-item command="openDetail">
                  任务详细
                </el-dropdown-item>
                <el-dropdown-item command="handleLog">
                  调度日志
                </el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页 -->
    <Pagination
      :total="total"
      v-model:page="queryParams.pageNo"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />
  </ContentWrap>
  <!-- 表单弹窗：添加/修改 -->
  <ExplorationForm ref="formRef" @success="getList" />
  <!-- 详情 -->
  <ExplorationDetail ref="detailRef" />
</template>
<script lang="ts" setup>
import { dateFormatter } from '@/utils/formatTime'
import { explorationApi } from '@/api/dataRiskMap/exploration'
import ExplorationForm from './ExplorationForm.vue'
import ExplorationDetail from './ExplorationDetail.vue'

defineOptions({ name: 'DataExploration' })
const { push } = useRouter() // 路由
const message = useMessage() // 消息弹窗
const { t } = useI18n() // 国际化

const loading = ref(true) // 列表的加载中
const total = ref(0) // 列表的总页数
const list = ref([]) // 列表的数据
const queryParams = reactive({
  pageNo: 1,
  pageSize: 10,
  status: undefined,
})
const statusArr = ref([{value: 1, label: '开启'}, {value: 2, label: '暂停'}])
const queryFormRef = ref() // 搜索的表单
const exportLoading = ref(false) // 导出的加载中

const getList = async () => {
  loading.value = true
  try {
    const data = await explorationApi.getTask(queryParams)
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

const resetQuery = () => {
  queryFormRef.value.resetFields()
  handleQuery()
}
const handleCommand = (command, row) => {
  switch (command) {
    case 'handleExecute':
      handleExecute(row)
      break
    case 'openDetail':
      openDetail(row.id)
      break
    case 'handleLog':
      handleLog(row?.id)
      break
    default:
      break
  }
}
const detailRef = ref()
const openDetail = (id: number) => {
  detailRef.value.open(id)
}
const handleLog = (id?: number) => {
  if (id && id > 0) {
    push('/dataRiskMap/exploration/log?id=' + id)
  } else {
    push('/dataRiskMap/exploration/log')
  }
}
const formRef = ref()
const openForm = (type, id) => {
  formRef.value.open(type, id)
}

const handleDelete = async (id) => {
  try {
    // 删除的二次确认
    await message.delConfirm()
    // 发起删除
    await explorationApi.deleteTask(id)
    message.success(t('common.delSuccess'))
    // 刷新列表
    await getList()
  } catch {}
}
const handleExecute = async (row) => {
  try {
    await message.confirm('确认要立即执行一次' + row.name + '?', t('common.reminder'))
    await explorationApi.goTask(row.id)
    message.success('执行成功')
    // 刷新列表
    await getList()
  } catch {}
}
const changeState = async (val: number, id?: any) => {
  try{
    const status =  val === 1 ? 2 : 1
    const param = {
      status: status,
      id: id
    }
    await explorationApi.editTaskState(param)
    message.notifySuccess('状态修改成功')
    // 刷新列表
    await getList()
  } catch {}
}


/** 初始化 **/
getList()
</script>
