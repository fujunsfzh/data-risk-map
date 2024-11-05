<template>
  <ContentWrap>
    <!-- 搜索工作栏 -->
    <el-form
      class="-mb-15px"
      :model="queryParams"
      ref="queryFormRef"
      :inline="true"
      label-width="100px"
    >
      <el-form-item label="数据源" prop="dbId">
        <el-select
          v-model="queryParams.dbId"
          filterable
          clearable
          placeholder="请选择数据源"
          style="width: 240px"
          @change="getTableIdArr"
        >
          <el-option
            v-for="item in dbNameArr"
            :key="item.name"
            :label="item.name"
            :value="item.id"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="数据表" prop="tableId">
        <el-select
          v-model="queryParams.tableId"
          filterable
          clearable
          placeholder="请选择数据表"
          style="width: 240px"
        >
          <el-option
            v-for="item in tableIdArr"
            :key="item.id"
            :label="item.tableNameZh"
            :value="item.id"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="字段名称" prop="colName">
        <el-input
          v-model="queryParams.colName"
          placeholder="请输入字段名称"
          clearable
        />
      </el-form-item>
      <el-form-item label="字段文名称" prop="colNameZh">
        <el-input
          v-model="queryParams.colNameZh"
          placeholder="请输入字段中文名称"
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
      <el-table-column label="表名" align="center" prop="tableName" width="150px"/>
      <el-table-column label="版本" align="center" prop="version" width="200px"/>
      <el-table-column label="字段名" align="center" prop="colName" width="150px"/>
      <el-table-column label="字段中文名" align="center" prop="colNameZh" width="200px"/>
      <el-table-column label="字段类型" align="center" prop="dataType" />
      <el-table-column label="字段长度" align="center" prop="dataLength" />
      <el-table-column label="数据精度" align="center" prop="dataScale"/>
      <el-table-column label="是否为空" align="center" prop="nullable">
        <template  #default="scope">
          <span>{{scope.row.nullable === true? '是' : '否'}}</span>
        </template>
      </el-table-column>
      <el-table-column label="是否主键" align="center" prop="primaryKey">
        <template  #default="scope">
          <span>{{scope.row.primaryKey === true? '是' : '否'}}</span>
        </template>
      </el-table-column>
      <el-table-column label="主键是否为自增类型" align="center" prop="keyIdentityFlag">
        <template  #default="scope">
          <span>{{scope.row.keyIdentityFlag === true? '是' : '否'}}</span>
        </template>
      </el-table-column>
      <el-table-column label="默认值" align="center" prop="defaultValue"/>
      <el-table-column label="样例数据" align="center" prop="colDemo"/>
      <el-table-column label="创建时间" align="center" prop="createTime" width="200px">
        <template  #default="scope">
          <span>{{formatDate(scope.row.createTime)}}</span>
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

</template>
<script lang="ts" setup>
import { formatDate } from '@/utils/formatTime'
import {listApi} from '@/api/dataRiskMap/list'
import {manageApi} from '@/api/dataRiskMap/manage'

defineOptions({name: 'DataSheet'})
const {t} = useI18n() // 国际化
const queryFormRef = ref()
const typeArr = ref([{value: 1, label: '表'}, {value: 2, label: '视图'}])
const loading = ref(true) // 列表的加载中
const total = ref(0) // 列表的总页数
const list = ref([]) // 列表的数据
const queryParams = reactive({
  pageNo: 1,
  pageSize: 10,
  dbId: '',
  tableId: '',
  colName: '',
  colNameZh: ''
})
const dbNameArr = ref([])
const tableIdArr = ref([])
/** 查询岗位列表 */
const getList = async () => {
  loading.value = true
  try {
    const data = await listApi.getData(queryParams)
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

/** 重置按钮操作 */
const resetQuery = () => {
  queryFormRef.value.resetFields()
  handleQuery()
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

const getTableIdArr = async () => {
  const params = {
    pageNO: 1,
    pageSize: -1,
    dbId: queryParams.dbId
  }
  const nameArr = await listApi.getSheetData(params)
  tableIdArr.value = nameArr.list
}
/** 初始化 **/
getList()
</script>
