import request from '@/config/axios'

export const previewApi = {
  // 请求数据类型
  getDataType: async (params: any) => {
    return await request.get({ url: `/dmap/v1/dmap/index/dbTypeInfo`, params })
  },
  // 数据库统计Top5
  getTop5: async () =>{
    return await request.get({url: `/dmap/v1/dmap/index/dbTypeTop5`})
  },
  // 数据库类别占比 饼图
  getAssetType: async () =>{
    return await request.get({url: `/dmap/v1/dmap/index/dsRatio`})
  },
  // 查询实例分布饼图
  getInstanceDistribution: async (params: any) =>{
    return await request.get({url: `/dmap/v1/dmap/index/queryDbService`, params})
  },
  //查询数据库资产总量每日的变化趋势
  getDateDailyTrend: async (params: any) =>{
    return await request.get({url: `/dmap/v1/dmap/index/queryDbTrend`, params})
  },
  // 查询数据库类型每日的变化趋势 [{'类型':[{'日期':'数据'}]}]
  getTypeDailyTrend: async (params: any) =>{
    return await request.get({url: `/dmap/v1/dmap/index/queryDbTypeTrend`, params})
  },
  // 查询资源概览数
  getPreviewData: async () =>{
    return await request.get({url: `/dmap/v1/dmap/index/queryProperty`})
  },
  // 查询扫描指标
  getTarget: async (params: any) =>{
    return await request.get({url: `/dmap/v1/dmap/index/queryScan`, params})
  },
  // 查询总数据量
  getTotalData: async () =>{
    return await request.get({url: `/dmap/v1/dmap/index/queryTotal`})
  },
}
