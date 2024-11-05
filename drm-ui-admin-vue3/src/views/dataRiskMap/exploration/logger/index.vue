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
      <el-form-item label="任务状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择任务状态" style="width:170px;">
          <el-option
            v-for="dict in statusArr"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
            clearable
          />
        </el-select>
      </el-form-item>
      <el-form-item label="任务执行时间范围" >
        <el-date-picker
          v-model="queryParams.startAt"
          type="datetime"
          value-format="YYYY-MM-DD HH:mm:ss"
          format="YYYY/MM/DD HH:mm:ss"
          placeholder="选择开始执行时间"
          clearable
          class="!w-240px"
          style="margin-right: 10px;"
        />
        <el-date-picker
          v-model="queryParams.endAt"
          type="datetime"
          value-format="YYYY-MM-DD HH:mm:ss"
          format="YYYY/MM/DD HH:mm:ss"
          placeholder="选择结束执行时间"
          clearable
          :default-time="new Date('1 23:59:59')"
          class="!w-240px"
        />
      </el-form-item>
      <el-form-item>
        <el-button @click="handleQuery"><Icon icon="ep:search" class="mr-5px" /> 搜索</el-button>
        <el-button @click="resetQuery"><Icon icon="ep:refresh" class="mr-5px" /> 重置</el-button>
      </el-form-item>
    </el-form>
  </ContentWrap>

  <!-- 列表 -->
  <ContentWrap>
    <el-table v-loading="loading" :data="list">
      <el-table-column label="任务实例主键" align="center" prop="id"/>
      <el-table-column label="任务实例" align="center" prop="instanceId"/>
      <el-table-column label="任务执行状态" align="center" prop="exeStatus">
        <template #default="scope">
          <el-tag type="info" v-if="scope.row.exeStatus === 1">未执行</el-tag>
          <el-tag type="primary" v-if="scope.row.exeStatus === 2">执行中</el-tag>
          <el-tag type="success" v-if="scope.row.exeStatus === 3">执行结束（成功）</el-tag>
          <el-tag type="warning" v-if="scope.row.exeStatus === 4">执行结束（失败）</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="发现的IP数" align="center" prop="ipCount"/>
      <el-table-column label="发现的服务数" align="center" prop="hostsCount"/>
      <el-table-column label="耗时/秒" align="center" prop="takeTime"/>
      <el-table-column label="执行时间" align="center" prop="createTime">
        <template #default="scope">
          <span> {{formatDate(scope.row.createTime)}} </span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" fixed="right" width="120">
        <template #default="scope">
          <el-button
            type="primary"
            link
            @click="openDetail(scope.row)"
          >
            查看执行结果
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页组件 -->
    <Pagination
      :total="total"
      v-model:page="queryParams.pageNo"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />
  </ContentWrap>

  <!-- 表单弹窗：查看 -->
  <LogDetail ref="detailRef"/>
</template>
<script lang="ts" setup>
import { formatDate } from '@/utils/formatTime'
import LogDetail from './LogDetail.vue'
import { explorationApi } from '@/api/dataRiskMap/exploration'

defineOptions({ name: 'ExplorationLog'})

const message = useMessage() // 消息弹窗
const { query } = useRoute() // 查询参数
const statusArr = ref([{value: 1, label: '未执行'}, {value: 2, label: '执行中'},{value: 3, label: '执行结束（成功）'}, {value: 4, label: '执行结束（失败）'}])
const loading = ref(true) // 列表的加载中
const total = ref(0) // 列表的总页数
const list = ref([]) // 列表的数据
const queryParams = reactive({
  pageNo: 1,
  pageSize: 10,
  status: undefined,
  taskId: query.id,
  startAt: undefined,
  endAt: undefined,
})
const queryFormRef = ref() // 搜索的表单
const exportLoading = ref(false) // 导出的加载中

/** 查询列表 */
const getList = async () => {
  loading.value = true
  try {
    const data = await explorationApi.getLog(queryParams)
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

/** 查看操作 */
const detailRef = ref()
const openDetail = (row: any) => {
  detailRef.value.open(row)
}

/** 初始化 **/
getList()
</script>
