<template>
  <div ref="chart" class="chart"></div>
</template>

<script setup lang="ts">
import * as echarts from 'echarts/index'
const chart = ref(null)
const props = defineProps({
  data: {
    type: Array,
    default: () => [],
    deep:true,
    immediate: true
  }
})
const initChart = () => {
  const pieChart = echarts.init(chart.value)
  const colorList = ['#023CBA', '#165DFE', '#44BFFF', '#9EECFF']
  const chartOption = {
    tooltip: {
      trigger: 'item'
    },
    legend: {
      top: '5%',
      left:'2%',
      orient: 'vertical',
    },
    color: colorList,
    series: [
      {
        name: '',
        type: 'pie',
        radius: ['40%', '70%'],
        avoidLabelOverlap: false,
        itemStyle: {
          borderColor: '#fff',
          borderWidth: 2
        },
        label: {
          show: false,
          position: 'center'
        },
        emphasis: {
          label: {
            show: true,
            fontSize: 40,
            fontWeight: 'bold'
          }
        },
        labelLine: {
          show: false
        },
        data: props.data
      }
    ]
  }
  pieChart.setOption(chartOption)
}
onMounted(() => {
  initChart()
})
</script>

<style scoped lang="scss">
.chart{
  width: 100%;
  height: 100%;
}
</style>
