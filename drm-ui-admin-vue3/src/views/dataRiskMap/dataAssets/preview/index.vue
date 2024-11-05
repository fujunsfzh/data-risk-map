<template>
  <div>
    <el-row :gutter="16" class="preview-module module1">
      <el-col :span="12" class="box-content">
        <div class="total-box flex-box">
          <div class="cont">
            <p class="des font16">总数据量</p>
            <p class="number">{{(total / 10000).toFixed(2)}}W</p>
          </div>
          <div class="cont">
            <p class="des font16">总数据大小</p>
            <p class="number">{{totalSize}}GB</p>
          </div>
        </div>
      </el-col>
      <el-col :span="12">
        <el-row :gutter="16">
          <el-col :span="12" class="total-scan">
            <div class="box-content  clearfix">
              <div class="fl">
                <div class="tit font16">数据源</div>
                <div class="number bold">
                  {{previewData.dsCount}}
                </div>
              </div>
              <div class="fr">
                <img src="../../../../assets/imgs/dataAssets/icon_sjy.png" alt="数据源"/>
              </div>
            </div>
          </el-col>
          <el-col :span="12" class="total-scan">
            <div class="box-content clearfix">
              <div class="fl">
                <div class="tit font16">数据库</div>
                <div class="number bold">
                  {{previewData.dbCount}}
                </div>
              </div>
              <div class="fr">
                <img src="../../../../assets/imgs/dataAssets/icon_sjk.png" alt="数据库"/>
              </div>
            </div>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="12" class="total-scan">
            <div class="box-content clearfix">
              <div class="fl">
                <div class="tit font16">数据表</div>
                <div class="number bold">
                  {{previewData.tbCount}}
                </div>
              </div>
              <div class="fr">
                <img src="../../../../assets/imgs/dataAssets/icon_sjb.png" alt="数据表"/>
              </div>
            </div>
          </el-col>
          <el-col :span="12" class="total-scan">
            <div class="box-content clearfix">
              <div class="fl">
                <div class="tit font16">字段</div>
                <div class="number bold">
                  {{previewData.coCount}}
                </div>
              </div>
              <div class="fr">
                <img src="../../../../assets/imgs/dataAssets/icon_zd.png" alt="字段"/>
              </div>
            </div>
          </el-col>
        </el-row>
      </el-col>
    </el-row>
    <el-row :gutter="16" class="preview-module module2">
      <el-col :span="12">
        <div class="box-content">
          <div class="blue-title">
            数据库占比
          </div>
          <div class="chart-layer">
            <pieChart :data="pieData" v-if="pieData.length>0"/>
            <el-empty description="暂无数据" :image-size="80" v-else/>
          </div>
        </div>
      </el-col>
      <el-col :span="12">
        <div class="box-content">
          <div class="blue-title">
            数据库统计TOP5
          </div>
          <div class="sign flex-box">
            <div :class="['cont',{'active':isActive === index }]"  v-for="(item,index) in dbTypes" :key="item" @click="handleClick(item,index)">
              <div class="img">
                <img v-if="item === 'mysql'" :src="mysql" :alt="item"/>
                <img v-if="item === 'oracle'" :src="oracle" :alt="item"/>
                <img v-if="item === 'postgresql'" :src="postgresql" :alt="item"/>
                <img v-if="item === 'sqlserver'" :src="sqlserver" :alt="item"/>
                <img v-if="item === 'dm'" :src="dm" :alt="item"/>
              </div>
              <div class="font12">
                {{item}}
              </div>
            </div>
          </div>
          <div class="table-layer">
            <el-table :data="tableData" :loading="tableLoading" height="240">
              <el-table-column v-for="item in tableHeader" :prop="item.prop" :label="item.label" :key="item.prop" align="center"/>
            </el-table>
          </div>
        </div>
      </el-col>
    </el-row>
    <el-row :gutter="16" class="preview-module module3">
      <el-col :span="16">
        <div class="box-content">
          <div class="title clearfix">
            <div class="blue-title fl">
              资产数据趋势
            </div>
            <div class="time fr" style="margin-right: 16px; width: 200px">
              <el-date-picker
                v-model="timeValue1"
                size="small"
                type="daterange"
                start-placeholder="开始日期"
                end-placeholder="结束日期"
                format="YYYY-MM-DD"
                value-format="YYYY-MM-DD"
                @change="handleTime1"
              />
            </div>
          </div>
          <div class="chart-layer">
            <trendChart :data="trendData" v-if="trendData.yData.length > 0"/>
            <el-empty description="暂无数据" :image-size="80" v-else/>
          </div>
        </div>
      </el-col>
      <el-col :span="8" class="box-content">
        <div class="title clearfix">
          <div class="blue-title fl">
            资产探查结果
          </div>
          <div class="time fr" style="margin-right: 16px;width: 200px">
            <el-date-picker
              v-model="timeValue2"
              size="small"
              type="daterange"
              start-placeholder="开始日期"
              end-placeholder="结束日期"
              format="YYYY-MM-DD"
              value-format="YYYY-MM-DD"
              @change="handleTime2"
            />
          </div>
        </div>
        <el-row :gutter="16">
          <el-col :span="12">
            <div class="cont">
              <div class="font14">
                共探查IP
              </div>
              <div class="number font18 bold">
                {{checkData.ipCount}}
              </div>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="cont">
              <div class="font14">
                探查发现数据服务数
              </div>
              <div class="number font18 bold">
                {{checkData.dataServiceCount}}
              </div>
            </div>
          </el-col>
        </el-row>
        <div class="chart-bar">
          <barChart :data="checkData.hostList" v-if="checkData.hostList.yData.length >0 "/>
          <el-empty description="暂无数据" :image-size="80" v-else/>
        </div>
      </el-col>
    </el-row>
    <el-row :gutter="16" class="preview-module module4">
      <el-col :span="8">
        <div class="box-content">
          <div class="title clearfix">
            <div class="blue-title fl">
              实例分布占比
            </div>
            <div class="fr">
              <el-tabs v-model="activeDistribute">
                <el-tab-pane label="引擎" name="engine"/>
                <el-tab-pane label="环境" name="env"/>
                <el-tab-pane label="应用系统" name="app"/>
                <el-tab-pane label="添加来源" name="source"/>
                <el-tab-pane label="负责人" name="person"/>
              </el-tabs>
            </div>
          </div>
          <div class="pie-chart">
            <pieChart :data="distributeData" v-if="distributeData.length > 0"/>
            <el-empty description="暂无数据" :image-size="80" v-else/>
          </div>
        </div>
      </el-col>
      <el-col :span="16">
        <div class="box-content">
          <div class="title clearfix">
            <div class="blue-title fl">
              实例数量趋势
            </div>
            <div class="time fr" style="margin-right: 16px;width: 200px;padding: 10px 0 0">
              <el-date-picker
                v-model="timeValue3"
                size="small"
                type="daterange"
                start-placeholder="开始日期"
                end-placeholder="结束日期"
                format="YYYY-MM-DD"
                value-format="YYYY-MM-DD"
                @change="handleTime3"
              />
            </div>
          </div>
          <div class="line-chart">
            <lineChart :data="lineData" v-if="lineData.seriesData.length > 0"/>
            <el-empty description="暂无数据" :image-size="80" v-else/>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import {onMounted} from 'vue'
import PieChart from './component/pieChart.vue'
import TrendChart from './component/trendChart.vue'
import BarChart from './component/barChart.vue'
import LineChart from './component/lineChart.vue'
import {previewApi} from '@/api/dataRiskMap/preview'
import mysql from '@/assets/imgs/dataAssets/logo_mysql.png'
import oracle from '@/assets/imgs/dataAssets/logo_oracle.png'
import dm from '@/assets/imgs/dataAssets/logo_dm.png'
import postgresql from '@/assets/imgs/dataAssets/logo_postgresql.png'
import sqlserver from '@/assets/imgs/dataAssets/logo_sqlserver.png'
import { dateFormatter } from '@/utils/formatTime'
defineOptions({ name: 'DataPreview' })
// 总量
const total = ref(0)
const totalSize = ref(0)

const previewData = ref({
  dsCount: '',
  dbCount: '',
  tbCount: '',
  coCount: ''
})
const pieData = ref([])
const dbTypes = ref([])

const tableLoading = ref(false)
const tableData = ref([])
const tableHeader = ref([
  {prop:'type',label:'数据库类型'},
  {prop:'dbHost',label:'数据库主机'},
  {prop:'dbPort',label:'数据库端口'},
  {prop:'dbCount',label:'数据库个数'},
  {prop:'tbCount',label:'数据表个数'},
  {prop:'coCount',label:'字段个数'}
])
const timeValue1 = ref([])
const trendData = ref({
  xData:[] as Array<number>,
  yData:[] as Array<number>
})
const isActive = ref(0)

const timeValue2 = ref([])
const checkData = ref({
  ipCount: undefined,
  dataServiceCount: undefined,
  hostList: {
    xData: [] as number[],
    yData: [] as number[]
  }
})
const distributeData = ref([])
const activeDistribute = ref('engine')
const timeValue3 = ref([])
const lineData = ref({
  xData:[] as number[],
  legendData:[] as number[],
  seriesData:[] as number[]
})

watch(() => [activeDistribute.value], (newValue, oldValue) => {
  if(newValue){
    getDistributeData(newValue[0])
  }
}, {immediate: false})
//获取总量数据
const today = () => {
  const today = new Date();
  today.setDate(today.getDate() - 1); // 设置日期为前一天
  const year = today.getFullYear();
  const month = today.getMonth() + 1; // 月份是从0开始的
  const day = today.getDate();
  timeValue1.value[1] = `${year}-${month.toString().padStart(2, '0')}-${day.toString().padStart(2, '0')}`;
  timeValue2.value[1] = `${year}-${month.toString().padStart(2, '0')}-${day.toString().padStart(2, '0')}`;
  timeValue3.value[1] = `${year}-${month.toString().padStart(2, '0')}-${day.toString().padStart(2, '0')}`;
}
const Last30Days = async () => {
  const curDate = new Date();
  curDate.setDate(curDate.getDate() - 30);
  timeValue1.value[0] = formatDate(curDate);
  timeValue2.value[0] = formatDate(curDate);
  timeValue3.value[0] = formatDate(curDate);
}
const formatDate = (date) => {
  const year = date.getFullYear();
  const month = date.getMonth() + 1;
  const day = date.getDate();
  return `${year}-${month.toString().padStart(2, '0')}-${day.toString().padStart(2, '0')}`;
}
const getTotal = async () => {
  try {
    const data = await previewApi.getTotalData()
    total.value = data.total
    totalSize.value = data.size
  } catch{}
}
const getPreview = async () => {
  try {
    previewData.value = await previewApi.getPreviewData()
  } catch{}
}
const getDbRadio = async () => {
  try {
    const data = await previewApi.getAssetType()
    pieData.value = data.map(item => {
      return{...item, name: item.key}
    })
  } catch{}
}
const getdbTypeArr = async () => {
  try {
    const data = await previewApi.getTop5()
    dbTypes.value =  data.map(item => item.key)
  }catch{}
}
const handleClick = (type,index) => {
  isActive.value = index
  getDbType(type)
}
const getDbType = async ( type: any) => {
  try {
    tableData.value.length = 0
    tableData.value = await previewApi.getDataType({type: type})
  }catch{}
}
const handleTime1 = (val: any)=> {
  getDailyTrend(val)
}
const getDailyTrend = async (params: any) => {
  trendData.value.xData.length = 0
  trendData.value.yData.length = 0
  try {
    const data = {
      begin: params[0],
      end: params[1]
    }
    const resData = await previewApi.getDateDailyTrend(data)
    const xData = [] as number[]
    const yData = [] as number[]
    trendData.value = resData.forEach((item) => {
      xData.push(item.key)
      yData.push(item.value)
    })
    trendData.value = {
      xData:[...xData],
      yData: [...yData]
    }
  }catch{}
}
const handleTime2 = (val: any)=> {
  getTargetRes(val)
}
const getTargetRes = async (timeArr: any) => {
  try {
    const params = {
      begin: timeArr[0],
      end: timeArr[1]
    }
    const data = await previewApi.getTarget(params)
    const xData = [] as number[]
    const yData = [] as number[]
    data.hostList.forEach(item => {
      xData.push(item.key)
      yData.push(item.value)
    })
    checkData.value.ipCount = data.ipCount
    checkData.value.dataServiceCount = data.dataServiceCount
    checkData.value.hostList.xData = [...xData]
    checkData.value.hostList.yData = [...yData]
  }catch {

  }
}
const getDistributeData = async (type: string) => {
  try {
    distributeData.value.length = 0
    const data = await previewApi.getInstanceDistribution({type: type})
    distributeData.value = data.map(item => {
      return{...item, name: item.key}
    })
  } catch{}
}
const handleTime3 = (val: any)=> {
  getTypeTrend(val)
}
const getTypeTrend = async (timeArr: any) => {
  lineData.value.xData.length = 0
  lineData.value.legendData.length = 0
  lineData.value.seriesData.length = 0
  try {
    const params = {
      begin: timeArr[0],
      end: timeArr[1]
    }
    const data = await previewApi.getTypeDailyTrend(params)
    
    if(data && data.length > 0){
      lineData.value.xData = data[0].value.map( item => [item.key])
      type objItem = {
        type: string;
        name: string;
        stack: string;
        data: number[];
      }
      const seriesData = [] as objItem[]
      let yData = [] as number[]
      data.forEach(item => {
        lineData.value.legendData.push(item.key)
        if(item.value && item.value.length > 0){
          yData = item.value.map(e => e.value)
        }
        seriesData.push({
          name: item.key,
          type: 'line',
          stack: 'Total',
          data: yData
        })
      })
      lineData.value.seriesData = [...seriesData]
    }
    
  }catch {

  }
}

onMounted( () => {
  today()
  Last30Days()
  getTotal()
  getPreview()
  getDbRadio()
  getdbTypeArr()
  getDbType('mysql')
  getTargetRes(timeValue1.value)
  getDailyTrend(timeValue2.value)
  getDistributeData(activeDistribute.value)
  getTypeTrend(timeValue3.value)
})
</script>

<style scoped lang="scss">
:deep(.el-empty){
  width: 100%;
  height: 80%;
}
:deep(.el-range-editor.el-input__wrapper){
  width: 100%;
  box-sizing: border-box;
}
.box-content{
  width: 100%;
  height: 100%;
  background-color: #fff;
  border-radius: 8px;
  box-sizing: border-box;
}
.preview-module{
  margin-bottom: 16px;
}
.blue-title{
  height: 20px;
  ling-height: 20px;
  font-size: 16px;
  color: #333;
  padding-left: 18px;
  border-left: 3px solid #165DFE;
  margin-bottom: 16px;
}
.module1{
  height: 196px;
  .box-content{
    padding: 0;
    .total-box{
      width: 100%;
      height: 100%;
      background: url("../../../../assets/imgs/dataAssets/img_zsjl.png") no-repeat left center;
      background-size: 100% 100%;
      .cont{
        padding: 63px 0 0 38px;
        box-sizing: border-box;
        margin-right: 70px;
        .des{
          margin-bottom: 10px;
        }
        .number{
          font-weight: bold;
          font-size: 30px;
          color: #082567;
          font-family: SFPro, SFPro;
        }
      }
    }
  }
  .total-scan{
    height: 90px;
    margin-bottom: 16px;
    .box-content{
      width: 100%;
      height: 100%;
      padding: 8px 20px 16px 16px;
      .tit{
        padding-top:8px;
        box-sizing: border-box;
        margin-bottom: 5px;
      }
      .number{
        font-size: 22px;
        color: #333;
      }
    }
  }
}
.module2{
  height:406px;
  .box-content{
    padding-top: 16px;
    .chart-layer{
      width: 100%;
      height: 332px;
    }
  }
  .sign{
    height: 60px;
    padding-left:16px;
    box-sizing: border-box;
    margin-bottom:25px;
    .cont{
      margin-right: 48px;
      text-align: center;
      cursor:pointer;
      min-width:70px;
      .img{
        width: 42px;
        height: 42px;
        margin: 0 auto 3px;
        border-radius: 42px;
        border: 1px solid transparent;
      }
      &:hover,
      &.active{
        .img{
          border-color: #165DFE;
        }
        .font12{
          color: #165DFE;
        }
      }
    }
    
  }
  .table-layer{
    padding: 0 16px;
    box-sizing: border-box;
    :deep(.el-table){
      width: 100%;
    }
  }
}
.module3{
  height: 318px;
  .title{
    padding-top: 16px;
  }
  .chart-layer{
    width: 100%;
    height: 270px;
  }
  .cont{
    width: 100%;
    height: 68px;
    padding: 16px;
    box-sizing: border-box;
    margin-bottom: 16px;
    background-color: #F7F8FA;
    border-radius: 8px;
  }
  .chart-bar{
    width: 100%;
    height: 170px;
    padding: 0 16px;
    box-sizing: border-box;
  }
}
.module4{
  height: 318px;
  .title{
    overflow: hidden;
    .blue-title{
      margin-top: 16px;
    }
    .fr{
      padding: 10px 16px 0 0;
      box-sizing: border-box;
    }
  }
  :deep(.el-tabs>.el-tabs__header){
    height: 32px;
    --el-tabs-header-height:32px;
    font-size: 14px;
    color:#333;
    background:transparent;
  }
  :deep(.el-tabs__content){
    padding: 0;
  }
  :deep(.el-tabs__item){
    margin-left: 3px;
    border: none;
    padding: 0 10px;
    background-color: #F2F3F5;
  }
  :deep(.el-tabs__active-bar){
    background-color: transparent;
  }
  :deep(.el-tabs__nav-wrap:after){
    background-color: transparent;
  }
  .pie-chart,.line-chart{
    width: 100%;
    height: 280px;
    padding: 0 16px;
    box-sizing: border-box;
  }
}
</style>
