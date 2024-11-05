package com.shulian.safe.drm.module.dmap;

/**
 * 数据风险地图 操作日志枚举
 * 目的：统一管理，也减少 Service 里各种“复杂”字符串
 *
 * @author 系统源码
 */
public interface LogRecordConstants {

    // ======================= 资产探查 =======================
    String SCAN_TYPE = "资产探查";
    String SCAN_CREATE_SUB_TYPE = "添加探查任务";
    String SCAN_CREATE_SUCCESS = "添加了探查任务【{{#reqDTO.name}}】";
    String SCAN_TRIGGER_SUB_TYPE = "触发探查任务";
    String SCAN_TRIGGER_SUCCESS = "手动执行了一次探查任务【{{#task.name}}】";
    String SCAN_UPDATE_STATUS_SUB_TYPE = "修改任务状态";
    String SCAN_UPDATE_STATUS_SUCCESS = "将【{{#task.name}}】的任务状态从【{{#oldStatus == 1 ? '正常':'暂停'}}】变更为了【{{#status == 1 ? '正常':'暂停'}}】";
    String SCAN_UPDATE_SUB_TYPE = "更新探查任务";
    String SCAN_UPDATE_SUCCESS = "更新了探查任务【{{#task.name}}】: {_DIFF{#reqDTO}}";
    String SCAN_DELETE_SUB_TYPE = "删除探查任务";
    String SCAN_DELETE_SUCCESS = "删除了探查任务【{{#task.name}}】";


    // ======================= DMAP_META 数据资产 =======================
    String META_TYPE = "资产管理";
    String META_CREATE_SUB_TYPE = "添加数据源";
    String META_CREATE_SUCCESS = "添加了数据源【{{#reqDTO.name}}】";
    String META_UPDATE_SUB_TYPE = "更新数据源";
    String META_UPDATE_SUCCESS = "更新了数据源【{{#reqDTO.name}}】: {_DIFF{#reqDTO}}";
    String META_DELETE_SUB_TYPE = "删除数据源";
    String META_DELETE_SUCCESS = "删除了数据源【{{#database.name}}】";
    String META_SYNC_SUB_TYPE = "同步元数据";
    String META_SYNC_SUCCESS = "同步了元数据【{{#dbIds}}】";


}
