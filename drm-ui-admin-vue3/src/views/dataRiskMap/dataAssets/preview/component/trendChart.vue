<template>
  <div ref="chart" class="chart"></div>
</template>

<script setup lang="js">
import * as echarts from 'echarts/index'

const chart = ref(null)
const props = defineProps({
  data: {
    type: Object,
    default: () => {}
  }
})

function initChart() {
  const trendChart = echarts.init(chart.value)
  const chartOption = {
    grid: {
      top:'5%',
      left: '5%',
      bottom:'20%',
      containLabel: true
    },
    tooltip: {
      trigger: 'axis'
    },
    dataZoom: [
      {
        type: 'inside',
        start: 0,
        end: 80
      },
      {
        start: 0,
        end: 80
      }
    ],
    xAxis: {
      type: 'category',
      boundaryGap: false,
      data: props.data.xData
    },
    yAxis: {
      type: 'value'
    },
    series: [
      {
        data: props.data.yData,
        type: 'line',
        symbolSize: 0,
        smooth: true,
        itemStyle:{
          color:'#165DFE'
        },
        areaStyle: {
          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
            offset: 0,
            color: 'rgba(22,93,254,0.16)'
          }, {
            offset: .5,
            color: 'rgba(22,93,254,0.05)'
          },{
            offset: 1,
            color: 'rgba(22,93,254,0.00)'
          }])
        }
      }
    ]
  }
  trendChart.setOption(chartOption)
}

onMounted(() => {
  initChart()
})
</script>

<style scoped lang="scss">
.chart {
  width: 100%;
  height: 100%;
}
</style>
