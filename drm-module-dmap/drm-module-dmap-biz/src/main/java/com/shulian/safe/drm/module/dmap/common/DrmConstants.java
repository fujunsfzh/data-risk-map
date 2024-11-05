package com.shulian.safe.drm.module.dmap.common;

public class DrmConstants {

    // mark 打标 /////////////////////////////////////////////////////////////
    /**
     * 打标任务详情 缓存 Key: 任务主键
     */
    public static final String MARK_TASK_INFO_BY_ID = "mark_task_info_by_id:";

    /**
     * 打标任务标签 缓存 Key: 任务主键
     */
    public static final String MARK_TASK_TAG_BY_ID = "mark_task_tag_by_id:";

    /**
     * 打标任务待处理的消息个数 Key: 任务主键
     */
    public static final String MARK_TASK_PENDING_MESSAGES = "mark_task_pending_messages:";

    /**
     * 打标任务分页查询 每页条数
     */
    public static final Integer MARK_TASK_SELECT_PAGE_SIZE = 1000;

    /**
     * 打标任务 保存数据样本条数
     */
    public static final Integer MARK_TASK_SAMPLE = 5;

    /**
     * 标签组级联详情[标签组([标签([标签规则])])]
     */
    public static final String TAG_GROUP_CASCADE_DETAILS = "tag_group_cascade_details:";


    //锁/////////////////////////////////////////////////////////////

    /**
     * 历史资产统计分布式锁 Key
     */
    public static final String MATE_HIS_STATISTICAL_LOCK = "mate_his_statistical:";
}
