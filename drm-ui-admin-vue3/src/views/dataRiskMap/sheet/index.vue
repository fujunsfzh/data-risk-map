<template>
  <ContentWrap>
    <!-- 搜索工作栏 -->
    <el-form
      class="-mb-15px"
      :model="queryParams"
      ref="queryFormRef"
      :inline="true"
      label-width="110px"
    >
      <el-form-item label="数据源" prop="dbId">
        <el-select
          v-model="queryParams.dbId"
          filterable
          clearable
          placeholder="请选择数据源"
          style="width: 240px"
        >
          <el-option
            v-for="item in dbNameArr"
            :key="item.name"
            :label="item.name"
            :value="item.id"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="数据表" prop="tableName">
        <el-input
          v-model="queryParams.tableName"
          placeholder="请输入数据表名称"
          clearable
        />
      </el-form-item>
      <el-form-item label="表中文名称" prop="tableNameZh">
        <el-input
          v-model="queryParams.tableNameZh"
          placeholder="请输入表中文名称"
          clearable
        />
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
      </el-form-item>
    </el-form>
  </ContentWrap>
  
  <!-- 列表 -->
  <ContentWrap>
    <el-table v-loading="loading" :data="list">
      <el-table-column label="主键" align="center" prop="id" />
      <el-table-column label="数据源主键" align="center" prop="dbId" />
      <el-table-column label="数据源名称" align="center" prop="dbName"/>
      <el-table-column label="表名" align="center" prop="tableName"/>
      <el-table-column label="表中文名" align="center" prop="tableNameZh"/>
      <el-table-column label="数据条数" align="center" prop="count" />
      <el-table-column label="版本" align="center" prop="version" />
    </el-table>
    <!-- 分页 -->
    <Pagination
      :total="total"
      v-model:page="queryParams.pageNo"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />
  </ContentWrap>
  
</template>
<script lang="ts" setup>
import {sheetApi} from '@/api/dataRiskMap/sheet'
import {manageApi} from '@/api/dataRiskMap/manage'
defineOptions({name: 'DataSheet'})
const {t} = useI18n() // 国际化
const queryFormRef = ref()
const loading = ref(true) // 列表的加载中
const total = ref(0) // 列表的总页数
const list = ref([]) // 列表的数据
const queryParams = reactive({
  pageNo: 1,
  pageSize: 10,
  dbId: '',
  tableName: '',
  tableNameZh: ''
})
const dbNameArr = ref([])
/** 查询岗位列表 */
const getList = async () => {
  loading.value = true
  try {
    const data = await sheetApi.getData(queryParams)
    list.value = data.list
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

const getNames = async () => {
  const params = {
    pageNO: 1,
    pageSize: -1,
    name: ''
  }
  const names = await manageApi.getData(params)
  dbNameArr.value = names.records
}
getNames()
/** 重置按钮操作 */
const resetQuery = () => {
  queryFormRef.value.resetFields()
  handleQuery()
}
/** 初始化 **/
getList()
</script>
