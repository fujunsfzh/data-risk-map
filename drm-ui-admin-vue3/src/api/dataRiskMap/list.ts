import request from '@/config/axios'

export const listApi = {
  // 获取数据源
  getData: async (params: any) =>{
    return await request.get({url: `/dmap/v1/meta/co/page`, params})
  },
  getSheetData: async (params: any) =>{
    return await request.get({url: `/dmap/v1/meta/tb/page`, params})
  },
}
