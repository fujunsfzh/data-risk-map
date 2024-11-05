<template>
  <Dialog v-model="dialogVisible" title="任务详细" width="700px">
    <el-descriptions :column="1" border>
      <el-descriptions-item label="任务主键" min-width="60">
        {{ detailData.id }}
      </el-descriptions-item>
      <el-descriptions-item label="任务名称">
        {{ detailData.name }}
      </el-descriptions-item>
      <el-descriptions-item label="IP扫描范围">
        {{ detailData.ip }}
      </el-descriptions-item>
      <el-descriptions-item label="端口范围">
        {{ detailData.port }}
      </el-descriptions-item>
      <el-descriptions-item label="执行模式">
        {{ detailData.type === 1? '单次' : 'corn'}}
      </el-descriptions-item>
      <div v-if="detailData.type === 2">
        <el-descriptions-item label="cron表达式">
          {{ detailData.cron}}
        </el-descriptions-item>
        <el-descriptions-item label="任务生效时间">
          {{ dateFormatter(detailData.triggerEndTime)}}
        </el-descriptions-item>
        <el-descriptions-item label="任务失效时间">
          {{ dateFormatter(detailData.triggerEndTime)}}
        </el-descriptions-item>
      </div>
      <el-descriptions-item label="任务状态">
        <el-tag>{{detailData.status === 1? '开启':'暂停'}}</el-tag>
      </el-descriptions-item>
      <el-descriptions-item label="重试次数">
        {{ detailData.retryCount }}
      </el-descriptions-item>
      <el-descriptions-item label="重试间隔">
        {{ detailData.retryInterval + ' 秒' }}
      </el-descriptions-item>
      <el-descriptions-item label="后续执行时间">
        <el-timeline>
          <el-timeline-item
            v-for="(nextTime, index) in detailData.nextFiveTime"
            :key="index"
            :timestamp="formatDate(nextTime)"
          >
            第 {{ index + 1 }} 次
          </el-timeline-item>
        </el-timeline>
      </el-descriptions-item>
    </el-descriptions>
  </Dialog>
</template>
<script lang="ts" setup>
import {explorationParam, explorationApi} from '@/api/dataRiskMap/exploration'
import { formatDate } from '@/utils/formatTime'
defineOptions({ name: 'ExplorationDetail' })
const dialogVisible = ref(false) // 弹窗的是否展示
const detailLoading = ref(false) // 表单的加载中
const detailData = ref({} as explorationParam) // 详情数据

/** 打开弹窗 */
const open = async (id: string) => {
  dialogVisible.value = true
  // 查看，设置数据
  if (id) {
    detailLoading.value = true
    try {
      detailData.value = await explorationApi.getTaskDetail({id: id})
    } finally {
      detailLoading.value = false
    }
  }
}
defineExpose({ open }) // 提供 open 方法，用于打开弹窗
</script>
