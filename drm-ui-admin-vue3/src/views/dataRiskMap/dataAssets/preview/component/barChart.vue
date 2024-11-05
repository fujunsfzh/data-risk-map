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
  const barChart = echarts.init(chart.value)
  const chartOption = {
    grid: {
      top:'5%',
      left: '5%',
      bottom:20,
      containLabel: true
    },
    dataZoom: [
      {
        type: 'inside',
        start: 0,
        end: 50,
        width:'80%',
        height: 10,
        bottom: 5
      },
      {
        type: 'slider',
        start: 0,
        end: 50,
        width:'80%',
        height: 10,
        bottom: 5
      }
    ],
    tooltip: {
      trigger: 'axis'
    },
    xAxis: {
      type: 'category',
      data: props.data.xData
    },
    yAxis: {
      type: 'value'
    },
    series: [
      {
        data: props.data.yData,
        type: 'bar',
        color:'#1CC683'
      }
    ]
  }
  barChart.setOption(chartOption)
}
onMounted(() => {
  initChart()
})
</script>

<style lang="scss" scoped>
.chart{
  width: 100%;
  height: 100%;
}
</style>
