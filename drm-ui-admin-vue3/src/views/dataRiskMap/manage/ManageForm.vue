<template>
  <Dialog v-model="dialogVisible" :title="dialogTitle" width="800">
    <el-form
      ref="formRef"
      v-loading="formLoading"
      :model="formData"
      :rules="formRules"
      label-width="150px"
    >
      <el-form-item label="数据源类型" prop="dbType">
        <el-select v-model="formData.dbType" placeholder="请选择数据源类型" style="width:192px;">
          <el-option v-for="item in dbTypeArr" :key="item" :label="item" :value="item"/>
        </el-select>
      </el-form-item>
      <el-form-item label="连接主机IP" prop="dbHost">
        <el-input v-model="formData.dbHost" placeholder="请输入数据库地址"/>
      </el-form-item>
      <el-form-item label="端口" prop="dbPort">
        <el-input v-model="formData.dbPort" placeholder="请输入端口" />
      </el-form-item>
      <el-form-item label="连接参数" prop="extParams" v-if="isAdd">
        <el-input v-model="formData.extParams" placeholder="请输入连接参数"/>
      </el-form-item>
      <el-form-item label="oracle连接方式 " prop="dboType" v-if="formData.dbType === 'oracle'">
        <el-select v-model="formData.dboType" placeholder="请选择oracle连接方式" style="width: 240px">
          <el-option
            v-for="item in dboTypeArr"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="连接用户名" prop="dbUser">
        <el-input v-model="formData.dbUser" placeholder="请输入连接连接用户名"/>
      </el-form-item>
      <el-form-item label="连接密码" prop="dbPwd">
        <el-input type="password" v-model="formData.dbPwd" auto-complete="off" placeholder="请输入连接密码"/>
      </el-form-item>
      <el-form-item label="数据库名称" prop="dbNameList">
        <el-select
          v-model="formData.dbNameList"
          multiple
          placeholder="请选择数据库名称，支持多选"
          style="width: 240px"
        >
          <el-option
            v-for="item in dbNameArr"
            :key="item"
            :label="item"
            :value="item"
          />
        </el-select>
        <div style="display: inline-block">
          <el-button type="primary" @click="getDbName" style="margin-left: 10px;">数据库名称</el-button>
          <em style="color:#999;font-size: 12px;margin-left: 5px;">请先完成上方数据填写，获取数据库名称</em>
        </div>
      </el-form-item>
      <el-form-item label="数据源名称" prop="name">
        <el-input v-model="formData.name" placeholder="请输入数据库名称" />
      </el-form-item>
      <el-form-item label="系统应用名称 " prop="appName">
        <el-input v-model="formData.appName" placeholder="请输入系统应用名称" />
      </el-form-item>
      <el-form-item label="系统环境 " prop="appEnv">
        <el-select v-model="formData.appEnv" placeholder="请选择系统环境" style="width: 240px">
          <el-option
            v-for="item in appEnvArr"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="联系人" prop="appContact">
        <el-input v-model="formData.appContact" placeholder="请输入联系人姓名" />
      </el-form-item>
      <el-form-item label="联系方式" prop="appContactPhone">
        <el-input v-model="formData.appContactPhone" placeholder="请输入联系方式"/>
      </el-form-item>
      <el-form-item label="联系地址" prop="appContactAddress">
        <el-input v-model="formData.appContactAddress" placeholder="请输入联系地址"/>
      </el-form-item>
    </el-form>
    <template #footer>
      <el-button :disabled="formLoading" type="primary" @click="submitForm">确 定</el-button>
      <el-button @click="dialogVisible = false">取 消</el-button>
    </template>
  </Dialog>
</template>
<script lang="ts" setup>
import {manageApi, manageParams} from '@/api/dataRiskMap/manage'
const props = defineProps({
  dbTypeArr: Array
})
defineOptions({ name: 'DataManageForm' })

const { t } = useI18n() // 国际化
const message = useMessage() // 消息弹窗

const dialogVisible = ref(false) // 弹窗的是否展示
const dialogTitle = ref('') // 弹窗的标题
const formLoading = ref(false) // 表单的加载中：1）修改时的数据加载；2）提交的按钮禁用
const formType = ref('') // 表单的类型：create - 新增；update - 修改
const formData = ref({
  id: undefined,
  name: '',
  dbType: '',
  dbHost: '',
  dbPort: '',
  dbNameList: undefined,
  extParams: '',
  dbUser: '',
  dbPwd: '',
  dboType: undefined,
  appName: '',
  appEnv: '',
  appContact: '',
  appContactPhone: '',
  appContactAddress: '',
})
const formRules = reactive({
  dbType:[{ required: true, message: '数据源类型不能为空', trigger: 'blur' }],
  dbHost:[{ required: true, message: '主机不能为空', trigger: 'blur' }],
  dbPort:[{ required: true, message: '端口不能为空', trigger: 'blur' }],
  dbUser:[{ required: true, message: '连接用户名不能为空', trigger: 'blur' }],
  dbPwd:[{ required: true, message: '密码不能为空', trigger: 'blur' }],
  dbNameList: [{ required: true, message: '密码不能为空', trigger: 'blur' }],
  appName:[{ required: true, message: '系统名称不能为空', trigger: 'blur' }],
  appEnv:[{ required: true, message: '系统环境不能为空', trigger: 'change' }],
  name: [{ required: true, message: '岗位标题不能为空', trigger: 'blur' }],
  appContact:[{ required: true, message: '联系人不能为空', trigger: 'blur' }],
  appContactPhone:[{ required: true, message: '联系方式不能为空', trigger: 'blur' }],
  appContactAddress:[{ required: true, message: '联系地址不能为空', trigger: 'blur' }]
})
const formRef = ref() // 表单 Ref
const dboTypeArr = ref([{label:'SERVICE_NAME',value:'1'}, {label:'SID',value:'2'}])
const appEnvArr = ref([{label:'dev',value:'dev'}, {label:'test',value:'test'}, {label:'pre',value:'pre'}, {label:'prod',value:'prod'}])
const dbNameArr = ref([])
const isAdd = ref(true)
/** 打开弹窗 */
const open = async (type: string, id?: number) => {
  dialogVisible.value = true
  dialogTitle.value = t('action.' + type)
  formType.value = type
  resetForm()
  // 修改时，设置数据
  if (id) {
    isAdd.value = false
    formLoading.value = true
    try {
      formData.value = await manageApi.getDataDetail(id)
    } finally {
      formLoading.value = false
    }
  }else{
    isAdd.value = true
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
    const data = formData.value as unknown as manageParams
    if (formType.value === 'create') {
      await manageApi.addData(data)
      message.success(t('common.createSuccess'))
    } else {
      await manageApi.editData(data)
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
    dbType: '',
    dbHost: '',
    dbPort: '',
    dbNameList: undefined,
    extParams: '',
    dbUser: '',
    dbPwd: '',
    dboType: undefined,
    appName: '',
    appEnv: '',
    appContact: '',
    appContactPhone: '',
    appContactAddress: '',
  } as any
  formRef.value?.resetFields()
}

const params = computed(() => {
  return {
    dbType: formData.value.dbType,
    dbHost: formData.value.dbHost,
    dbPort: formData.value.dbPort,
    extParams: formData.value.extParams,
    dbUser: formData.value.dbUser,
    dbPwd: formData.value.dbPwd,
    dboType: formData.value.dboType
  }
})

// 查询账号下所有库
const getDbName = async() => {
  try{
    const params = {
      dbType: formData.value.dbType,
      dbHost: formData.value.dbHost,
      dbPort: formData.value.dbPort,
      extParams: formData.value.extParams,
      dbUser: formData.value.dbUser,
      dbPwd: formData.value.dbPwd,
      dboType: formData.value.dboType
    }
    const nameArr = await manageApi.getAllDbs(params)
    nameArr.forEach(item => {
      dbNameArr.value.push(item)
    })
  } catch {

  }
}
</script>
