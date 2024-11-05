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
  const lineChart = echarts.init(chart.value)
  const chartOption = {
    tooltip: {
      trigger: 'axis'
    },
    legend: {
      data: props.data.legendData
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '20%',
      containLabel: true
    },
    dataZoom: [
      {
        type: 'inside',
        start: 0,
        end: 10
      },
      {
        start: 0,
        end: 10
      }
    ],
    toolbox: {
      feature: {
        saveAsImage: {}
      }
    },
    xAxis: {
      type: 'category',
      boundaryGap: false,
      data: props.data.xData
    },
    yAxis: {
      type: 'value'
    },
    series: props.data.seriesData
  }
  lineChart.setOption(chartOption)
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
