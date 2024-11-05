<template>
  <Dialog v-model="dialogVisible" :title="dialogTitle" width="800">
    <el-form
      ref="formRef"
      v-loading="formLoading"
      :model="formData"
      :rules="formRules"
      label-width="150px"
    >
      <el-form-item label="任务名称" prop="name">
        <el-input v-model="formData.name" placeholder="请输入资产名称" />
      </el-form-item>
      <el-form-item label="IP扫描范围" prop="ip">
        <el-input v-model="formData.ip" placeholder="支持CIDR 方式输入" />
      </el-form-item>
      <el-form-item label="端口范围" prop="port">
        <el-input v-model="formData.port" placeholder="端口范围 1-65535，连续端口-分隔，不连续端口，分隔"/>
      </el-form-item>
      <el-form-item label="执行模式" prop="type">
        <el-select v-model="formData.type" clearable placeholder="请选择执行模式">
          <el-option
            v-for="dict in typeArr"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
            clearable
          />
        </el-select>
      </el-form-item>
      <div v-if="formData.type === 2">
        <el-form-item label="CRON 表达式" prop="cron">
          <crontab v-model="formData.cron"/>
        </el-form-item>
        <el-form-item label="周期任务生效时间" prop="triggerStartTime">
          <el-date-picker
            v-model="formData.triggerStartTime"
            type="datetime"
            placeholder="选择周期任务生效时间"
            @change="convertToGMTStart"/>
        </el-form-item>
        <el-form-item label="请周期任务失效时间" prop="triggerEndTime">
          <el-date-picker
            v-model="formData.triggerEndTime"
            type="datetime"
            placeholder="请选择周期任务失效时间"
            @change="convertToGMTEnd"/>
        </el-form-item>
      </div>
      <el-form-item label="重试次数" prop="retryCount">
        <el-input type="number" min="0" v-model="formData.retryCount" placeholder="请输入重试最大次数>设置为 0 时，不进行重试" />
      </el-form-item>
      <el-form-item label="重试间隔/秒" prop="retryInterval">
        <el-input type="number" min="0" v-model="formData.retryInterval" placeholder="请输入重试间隔.单位：秒。设置为 0 时，无需间隔" />
      </el-form-item>
    </el-form>
    <template #footer>
      <el-button :disabled="formLoading" type="primary" @click="submitForm">确 定</el-button>
      <el-button @click="dialogVisible = false">取 消</el-button>
    </template>
  </Dialog>
</template>
<script lang="ts" setup>
import { explorationApi } from '@/api/dataRiskMap/exploration'
defineOptions({ name: 'SystemPostForm' })

const { t } = useI18n() // 国际化
const message = useMessage() // 消息弹窗

const dialogVisible = ref(false) // 弹窗的是否展示
const dialogTitle = ref('') // 弹窗的标题
const formLoading = ref(false) // 表单的加载中：1）修改时的数据加载；2）提交的按钮禁用
const formType = ref('') // 表单的类型：create - 新增；update - 修改
const formData = ref({
  id: undefined,
  name: '',
  type: '',
  remark: '',
  triggerStartTime:'',
  triggerEndTime:'',
  cron:'',
  retryCount:'',
  retryInterval:''
})
// const validateIP = (rule, value, callback) => {
//   const ipRegex = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
//   if (!ipRegex.test(value)) {
//     callback(new Error('请输入有效的IP地址'));
//   } else {
//     callback();
//   }
// }
// const validatePort = (rule, value, callback) => {
//   const portRegex = /^([0-9]{1,4}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]{1}|6553[0-5])$/;
//   if (!portRegex.test(value)) {
//     callback(new Error('请输入有效的端口号（1-65535）'));
//   } else {
//     callback()
//   }
// }
const formRules = reactive({
  name: [{ required: true, message: '资产名称不能为空', trigger: 'blur' }],
  ip: [{ required: true, message: 'ip不能为空', trigger: 'blur' }], //{ validator: validateIP, trigger: 'blur' }
  port: [{ required: false, message: '端口号为空时，全端口扫描', trigger: 'blur' }], //{ validator: validatePort, trigger: 'blur' }
  type: [{ required: true, message: '任务类型不能为空', trigger: 'change' }],
  cron: [{ required: true, message: 'CRON表达式不能为空', trigger: 'blur' }],
  retryCount: [{ required: true, message: '重试最大次数不能为空', trigger: 'blur' }],
  retryInterval: [{ required: true, message: '重试间隔不能为空', trigger: 'blur' }]
})
const statusArr = ref([{value: 1, label: '正常'}, {value: 2, label: '暂停'}])
const typeArr = ref([{value: 1, label: '单次'}, {value: 2, label: 'corn'}])
const formRef = ref() // 表单 Ref
const convertToGMT = async (date: string) => {
  const year = date.getFullYear()
  const month = await padStart(date.getMonth() + 1)
  const day = await padStart(date.getDate())
  const hours = await padStart(date.getHours())
  const minutes = await padStart(date.getMinutes())
  const seconds = await padStart(date.getSeconds())
  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`
}
const padStart = (value) => {
  return value.toString().padStart(2, '0')
}
const triggerStartTime = ref()
const triggerEndTime = ref()
const convertToGMTStart = async (val) => {
  if(val){
    triggerStartTime.value= await convertToGMT(val)
  }
}
const convertToGMTEnd = async (val) => {
  if(val){
    triggerEndTime.value = await convertToGMT(val)
  }
}
/** 打开弹窗 */
const open = async (type: string,id?: number) => {
  dialogVisible.value = true
  dialogTitle.value = t('action.' + type)
  formType.value = type
  resetForm()
  // 修改时，设置数据
  if (id) {
    formLoading.value = true
    try {
      formData.value = await explorationApi.getTaskDetail({id: id })
    } finally {
      formLoading.value = false
    }
  }
}
defineExpose({ open }) // 提供 open 方法，用于打开弹窗

/** 提交表单 */
const emit = defineEmits(['success']) // 定义 success 事件，用于操作成功后的回调
const submitForm = async () => {
  // 校验表单
  if (!formRef) return
  const valid = await formRef.value.validate()
  if (!valid) return
  // 提交请求
  formLoading.value = true
  try {
    const data = Object.assign(formData.value, {triggerStartTime:triggerStartTime.value, triggerEndTime:triggerEndTime.value})
    if (formType.value === 'create') {
      await explorationApi.creatTask(data)
      message.success(t('common.createSuccess'))
    } else {
      await explorationApi.editTask(data)
      message.success(t('common.updateSuccess'))
    }
    dialogVisible.value = false
    // 发送操作成功的事件
    emit('success')
  } finally {
    formLoading.value = false
  }
}

/** 重置表单 */
const resetForm = () => {
  formData.value = {
    id: undefined,
    name: '',
    type: '',
    remark: '',
    triggerStartTime:'',
    triggerEndTime:'',
    cron:'',
    retryCount:'',
    retryInterval:''
  } as any
  formRef.value?.resetFields()
}
</script>
