<template>
  <ContentWrap>
    <!-- 搜索工作栏 -->
    <el-form
      class="-mb-15px"
      :model="queryParams"
      ref="queryFormRef"
      :inline="true"
      label-width="150px"
    >
      <el-form-item label="数据源名称" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入数据名称"
          clearable
        />
      </el-form-item>
      <el-form-item label="数据源类型" prop="dbType">
        <el-select v-model="queryParams.dbType" placeholder="请选择数据源类型" clearable style="width:192px;">
          <el-option v-for="item in dbTypeArr" :key="item" :label="item" :value="item"/>
        </el-select>
      </el-form-item>
      <el-form-item label="主机地址" prop="dbHost">
        <el-input
          v-model="queryParams.dbHost"
          placeholder="请输入主机地址"
          clearable
        />
      </el-form-item>
      <el-form-item label="端口号" prop="dbPort">
        <el-input
          v-model="queryParams.dbPort"
          placeholder="请输入端口号"
          clearable
        />
      </el-form-item>
      <el-form-item label="系统名称" prop="appName">
        <el-input
          v-model="queryParams.appName"
          placeholder="请输入系统名称"
          clearable
        />
      </el-form-item>
      <el-form-item label="添加方式" prop="createType">
        <el-select v-model="queryParams.createType" clearable placeholder="请选择添加方式" style="width:192px;">
          <el-option v-for="item in addMethodArr" :key="item.value" :label="item.label" :value="item.value"/>
        </el-select>
      </el-form-item>
      <el-form-item label="应用联系人" prop="appContact">
        <el-input
          v-model="queryParams.appContact"
          placeholder="请输入应用联系人"
          clearable
        />
      </el-form-item>
      <el-form-item label="系统环境" prop="appEnv">
        <el-select v-model="queryParams.appEnv" clearable placeholder="请选择系统环境" style="width:192px;">
          <el-option v-for="item in appEnvArr" :key="item" :label="item" :value="item"/>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button @click="handleQuery">
          <Icon icon="ep:search" class="mr-5px"/>
          搜索
        </el-button>
        <el-button @click="resetQuery">
          <Icon icon="ep:refresh" class="mr-5px"/>
          重置
        </el-button>
        <el-button
          type="primary"
          plain
          @click="openForm('create')"
        >
          <Icon icon="ep:plus" class="mr-5px"/>
          新增
        </el-button>
      </el-form-item>
    </el-form>
  </ContentWrap>
  
  <!-- 列表 -->
  <ContentWrap>
    <el-table v-loading="loading" :data="list">
      <el-table-column label="主键" align="center" prop="id" width="120"/>
      <el-table-column label="数据源名称" align="center" prop="name" width="120"/>
      <el-table-column label="数据源类型" align="center" prop="dbType" width="120"/>
      <el-table-column label="主机地址" align="center" prop="dbHost"/>
      <el-table-column label="端口号" align="center" prop="dbPort"/>
      <el-table-column label="数据库名称" align="center" prop="dbName" width="150"/>
      <el-table-column label="添加方式" align="center" prop="createType" width="150">
        <template #default="scope">
          <span v-if="scope.row.createType === 'MANUAL'">手动添加</span>
          <span v-if="scope.row.createType === 'BATCH_IMPORT'">批量导入</span>
          <span v-if="scope.row.createType === 'SCAN'">自动扫描</span>
        </template>
      </el-table-column>
      <el-table-column label="应用系统名称" align="center" prop="appName"/>
      <el-table-column label="应用系统环境" align="center" prop="appEnv"/>
      <el-table-column label="应用联系人" align="center" prop="appContact"/>
      <el-table-column label="版本" align="center" prop="version"/>
      <el-table-column label="创建时间" align="center" prop="createTime" width="150">
        <template #default="scope">
          <span>{{formatDate(scope.row.createTime)}}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" fixed="right" width="280">
        <template #default="scope">
          <el-button
            link
            type="primary"
            @click="openDetail(scope.row.id)"
          >
            查看
          </el-button>
          <el-button
            link
            type="primary"
            @click="openForm('update', scope.row.id)"
          >
            编辑
          </el-button>
          <el-button
            link
            type="danger"
            @click="handleDelete(scope.row.id)"
          >
            删除
          </el-button>
          <el-button
            link
            type="primary"
            @click="handleSync(scope.row.id)"
          >
            同步元数据
          </el-button>
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
  <ManageDetail ref="detailRef"/>
  <!-- 表单弹窗：添加/修改 -->
  <ManageForm ref="formRef" @success="getList" :dbTypeArr="dbTypeArr"/>
</template>
<script lang="ts" setup>
import { onMounted} from "vue"
import { formatDate } from '@/utils/formatTime'
import {manageApi} from '@/api/dataRiskMap/manage'
import { explorationApi} from '@/api/dataRiskMap/exploration'
import ManageForm from './ManageForm.vue'
import ManageDetail from "./ManageDetail.vue"

defineOptions({name: 'DataManage'})
const message = useMessage() // 消息弹窗
const {t} = useI18n() // 国际化

const detailRef = ref()
const loading = ref(true) // 列表的加载中
const total = ref(0) // 列表的总页数
const list = ref([]) // 列表的数据
const queryParams = reactive({
  pageNo: 1,
  pageSize: 10,
  name: '',
  dbType: '',
  dbHost:'',
  dbPort: '',
  appName: '',
  createType: undefined,
  appContact: '',
  appEnv: undefined
})
const queryFormRef = ref() // 搜索的表单
const exportLoading = ref(false) // 导出的加载中
const dbTypeArr = ref([])
const appEnvArr = ref(['dev', 'test', 'pre', 'prod'])
const addMethodArr = ref([{label:'手动添加', value:'MANUAL'}, {label: '批量导入', value: 'BATCH_IMPORT'}, {label: '自动扫描', value: 'SCAN'}])
/** 查询岗位列表 */

const getdbTypeArr = async () => {
  dbTypeArr.value = await explorationApi.getDataBaseType()
}
const getList = async () => {
  loading.value = true
  try {
    const data = await manageApi.getData(queryParams)
    list.value = data.records
    total.value = data.total
  } finally {
    loading.value = false
  }
}

/** 搜索按钮操作 */
const handleQuery = () => {
  queryParams.pageNo = 1
  getList()
}

/** 重置按钮操作 */
const resetQuery = () => {
  queryFormRef.value.resetFields()
  handleQuery()
}
const openDetail = (id: number) => {
  detailRef.value.open(id)
}
/** 添加/修改操作 */
const formRef = ref()
const openForm = (type: string, id?: number) => {
  formRef.value.open(type, id)
}

/** 删除按钮操作 */
const handleDelete = async (id: number) => {
  try {
    // 删除的二次确认
    await message.delConfirm('删除数据源会删除已同步的数据表和字段，是否确认删除所选数据源？')
    // 发起删除
    await manageApi.delData(id)
    message.success(t('common.delSuccess'))
    // 刷新列表
    await getList()
  } catch {
  }
}

const handleSync = async (id: number) => {
  try {
    // 发起删除
    await manageApi.handleData({dbIds: id})
    message.success(t('同步成功'))
    // 刷新列表
    await getList()
  } catch {
  }
}
/** 初始化 **/
onMounted(() => {
  getdbTypeArr()
  getList()
})
</script>
