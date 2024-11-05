import request from '@/config/axios'
export interface explorationParam  {
  id: undefined,
  name: string,
  ip: string,
  port: string,
  type: number,
  cron: string,
  status: number,
  triggerStartTime: string,
  triggerEndTime: string,
  retryCount: number,
  retryInterval: number,
  creator: string,
  deptId: string,
  createTime: string,
  updater: string,
  updateTime: string,
  nextFiveTime: string
}
export const explorationApi = {
  creatTask: async (data: explorationParam) => {
    return await request.post({
      url: '/dmap/v1/sc/task/create',
      data
    })
  },
  deleteTask: async (params: any) => {
    return await request.put({
      url: '/dmap/v1/sc/task/delete/' + params,
    })
  },
  getTaskDetail: async (params: any) => {
    return await request.get({
      url: '/dmap/v1/sc/task/info',
      params
    })
  },
  getTask: async (params: any) => {
    return await request.get({
      url: '/dmap/v1/sc/task/page',
      params
    })
  },
  goTask: async (params: any) => {
    return await request.put({
      url: '/dmap/v1/sc/task/trigger/'+ params,
    })
  },
  editTask: async (params: explorationParam) => {
    return await request.post({
      url: '/dmap/v1/sc/task/update',
      data: params,
    })
  },
  editTaskState: async (params: any) => {
    return await request.put({
      url: `/dmap/v1/sc/task/update/status/?id=`+ params.id + '&status='+ params.status,
    })
  },
  //调度日志
  getLog:async (params: any) => {
    return await request.get({
      url: '/dmap/v1/sc/task/instance/page',
      params,
    })
  },
  // 详情
  getLogDetail: async (params: any) => {
    return await request.get({
      url: '/dmap/v1/sc/task/result/page',
      params,
    })
  },
// 检查支持的数据源类型
  getDataBaseType: async () => {
    return await request.get({
      url: '/dmap/v1/meta/ds/supported/type',
    })
  },
}

