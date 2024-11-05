<template>
  <Dialog v-model="dialogVisible" title="任务详细" width="700px">
    <el-descriptions :column="2" border v-loading="detailLoading">
      <el-descriptions-item label="主键" min-width="60">{{ detailData.id }}</el-descriptions-item>
      <el-descriptions-item label="数据源名称">{{detailData.name}}</el-descriptions-item>
      <el-descriptions-item label="数据源类型">{{detailData.dbType}}</el-descriptions-item>
      <el-descriptions-item label="连接地址">{{detailData.dbHost}}</el-descriptions-item>
      <el-descriptions-item label="端口号">{{detailData.dbPort}}</el-descriptions-item>
      <el-descriptions-item label="数据库名称">{{detailData.dbName}}</el-descriptions-item>
      <el-descriptions-item label="添加方式" aprop="createType">
        {{detailData.createType === 'MANUAL'? '手动添加' : detailData.createType === 'BATCH_IMPORT' ? '批量导入' : '自动扫描'}}
      </el-descriptions-item>
      <el-descriptions-item label="应用系统名称">{{detailData.appName}}</el-descriptions-item>
      <el-descriptions-item label="应用系统环境">{{detailData.appEnv}}</el-descriptions-item>
      <el-descriptions-item label="应用联系人">{{detailData.appContact}}</el-descriptions-item>
      <el-descriptions-item label="创建时间">{{formatDate(detailData.createTime)}}</el-descriptions-item>
    </el-descriptions>
  </Dialog>
</template>
<script lang="ts" setup>
import { formatDate } from '@/utils/formatTime'
import {manageApi, manageParams} from '@/api/dataRiskMap/manage'

defineOptions({ name: 'ManageDetail' })

const dialogVisible = ref(false) // 弹窗的是否展示
const detailLoading = ref(false) // 表单的加载中
const detailData = ref({} as manageParams) // 详情数据

/** 打开弹窗 */
const open = async (id: number) => {
  dialogVisible.value = true
  // 查看，设置数据
  if (id) {
    detailLoading.value = true
    try {
      detailData.value = await manageApi.getDataDetail(id)
    } finally {
      detailLoading.value = false
    }
  }
}
defineExpose({ open }) // 提供 open 方法，用于打开弹窗
</script>
