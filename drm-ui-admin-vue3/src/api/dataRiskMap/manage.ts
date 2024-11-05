import request from '@/config/axios'
export interface manageParams {
  id: undefined,
  name: string,
  dbType: string,
  dbHost: string,
  dbPort: number,
  dbNameList: undefined,
  extParams: string,
  dbUser: string,
  dbPwd: string,
  dboType: number,
  appName: string,
  appEnv: string,
  appContact: string,
  appContactPhone: string,
  appContactAddress: string,
}

export const manageApi = {
  // 手动添加数据源
  addData: async (data: manageParams) => {
    return await request.post({ url: `/dmap/v1/meta/ds/create`, data})
  },
  // 查询数据源详情
  getDataDetail: async (id: any) =>{
    return await request.get({url: `/dmap/v1/meta/ds/info/${id}`})
  },
  // 修改数据源
  editData: async (data: manageParams) =>{
    return await request.post({url: `/dmap/v1/meta/ds/update`, data})
  },
  // 获取数据源
  getData: async (params: any) =>{
    return await request.get({url: `/dmap/v1/meta/ds/page`, params})
  },
  // 删除数据源
  delData: async (id: any) =>{
    return await request.put({url: `/dmap/v1/meta/ds/delete/${id}`})
  },
  //手动同步数据源
  handleData: async (params: any) =>{
    return await request.get({url: `/dmap/v1/meta/ds/sync`, params})
  },
  getAllDbs: async (data: any) =>{
    return await request.post({url: `/dmap/v1/meta/ds/schemas`, data: data})
  },
}
