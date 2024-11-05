

SET NAMES utf8mb4;
SET
FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cg_industrial
-- ----------------------------
DROP TABLE IF EXISTS `cg_industrial`;
CREATE TABLE `cg_industrial`
(
    `id`            bigint       NOT NULL AUTO_INCREMENT COMMENT '主键',
    `industry_code` varchar(50)  NOT NULL COMMENT '行业编码',
    `industry_name` varchar(50)  NOT NULL COMMENT '行业名称',
    `refer`         varchar(200) NOT NULL COMMENT '依据标准',
    `deleted`       tinyint      NOT NULL DEFAULT '0' COMMENT '0-未删除，1-已删除',
    `creator`       varchar(50)           DEFAULT NULL COMMENT '创建人',
    `dept_id`       bigint                DEFAULT NULL COMMENT '部门id',
    `create_time`   timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `updater`       varchar(50)           DEFAULT NULL COMMENT '更新人',
    `update_time`   timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='行业标准';

-- ----------------------------
-- Records of cg_industrial
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ds_meta_column
-- ----------------------------
DROP TABLE IF EXISTS `ds_meta_column`;
CREATE TABLE `ds_meta_column`
(
    `id`                bigint       NOT NULL AUTO_INCREMENT COMMENT '主键',
    `db_id`             bigint       NOT NULL COMMENT '数据源主键',
    `table_id`          bigint       NOT NULL COMMENT '数据表主键',
    `table_name`        varchar(50)  NOT NULL COMMENT '数据表名称',
    `col_name`          varchar(50)  NOT NULL COMMENT '列名',
    `col_name_zh`       varchar(50)           DEFAULT NULL COMMENT '中文名',
    `data_type`         varchar(50)  NOT NULL COMMENT '数据类型',
    `data_length`       varchar(50)           DEFAULT NULL COMMENT '数据长度',
    `data_scale`        int          NOT NULL DEFAULT '0' COMMENT '数据精度',
    `nullable`          int                   DEFAULT NULL COMMENT '是否可为空:1-是 0-否',
    `default_value`     varchar(50)           DEFAULT NULL COMMENT '默认值',
    `primary_key`       tinyint               DEFAULT NULL COMMENT '是否主键:1-是 0-否',
    `key_identity_flag` tinyint               DEFAULT NULL COMMENT '主键是否为自增类型:1-是 0-否',
    `foreign_key`       tinyint               DEFAULT NULL COMMENT '是否外键:1-是 0-否',
    `col_demo`          varchar(200)          DEFAULT NULL COMMENT '样例数据',
    `version`           varchar(50)           DEFAULT '1' COMMENT '版本号',
    `deleted`           tinyint      NOT NULL DEFAULT '0' COMMENT '0-未删除，1-已删除',
    `creator`           varchar(50)           DEFAULT NULL COMMENT '创建人',
    `dept_id`           bigint                DEFAULT NULL COMMENT '部门id',
    `create_time`       timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `updater`           varchar(50)           DEFAULT NULL COMMENT '更新人',
    `update_time`       timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY                 `idx_column` (`db_id`,`table_id`,`col_name`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据源column';

-- ----------------------------
-- Records of ds_meta_column
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ds_meta_database
-- ----------------------------
DROP TABLE IF EXISTS `ds_meta_database`;
CREATE TABLE `ds_meta_database`
(
    `id`                  bigint       NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name`                varchar(50)  NOT NULL COMMENT '数据源名称',
    `db_type`             varchar(50)  NOT NULL COMMENT '数据源类型',
    `db_host`             varchar(50)  NOT NULL COMMENT '连接地址',
    `db_port`             int          NOT NULL COMMENT '端口',
    `db_name`             varchar(50)  NOT NULL COMMENT '数据库名称',
    `db_md5`              varchar(50)           DEFAULT NULL COMMENT 'md5数据源的标识',
    `create_type`         varchar(50)           DEFAULT NULL COMMENT '添加方式',
    `ext_params`          varchar(200)          DEFAULT NULL COMMENT '连接参数',
    `db_user`             varchar(50)  NOT NULL COMMENT '用户名',
    `db_pwd`              varchar(50)  NOT NULL COMMENT '密码',
    `dbo_type`            tinyint               DEFAULT NULL COMMENT 'oracle数据库连接方式 1-SERVICE_NAME，2-SID',
    `app_name`            varchar(50)  NOT NULL COMMENT '应用系统名称',
    `app_env`             varchar(50)  NOT NULL COMMENT '系统环境:dev;test;pre;prod;',
    `app_contact`         varchar(50)  NOT NULL COMMENT '应用联系人',
    `app_contact_phone`   varchar(50)  NOT NULL COMMENT '负责人联系电话',
    `app_contact_address` varchar(100) NOT NULL COMMENT '负责人联系地址',
    `status`              tinyint      NOT NULL DEFAULT '1' COMMENT '状态:1-未同步;2-同步中;3-同步成功;4-同步失败',
    `version`             varchar(50)           DEFAULT '1' COMMENT '版本号',
    `db_conn_uri`         varchar(300)          DEFAULT NULL COMMENT '扩展属性:连接字符串',
    `deleted`             tinyint      NOT NULL DEFAULT '0' COMMENT '0-未删除，1-已删除',
    `creator`             varchar(50)           DEFAULT NULL COMMENT '创建人',
    `dept_id`             bigint                DEFAULT NULL COMMENT '部门id',
    `create_time`         timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `updater`             varchar(50)           DEFAULT NULL COMMENT '更新人',
    `update_time`         timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY                   `idx_database` (`db_host`,`db_port`,`db_name`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据源';

-- ----------------------------
-- Records of ds_meta_database
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ds_meta_his
-- ----------------------------
DROP TABLE IF EXISTS `ds_meta_his`;
CREATE TABLE `ds_meta_his`
(
    `id`               bigint       NOT NULL AUTO_INCREMENT COMMENT '主键',
    `statistical_date` date         NOT NULL COMMENT '统计日期',
    `db_type`          varchar(50)  NOT NULL DEFAULT '0' COMMENT '数据源类型',
    `db_count`         bigint       NOT NULL DEFAULT '0' COMMENT '数据源数量',
    `deleted`          tinyint      NOT NULL DEFAULT '0' COMMENT '0-未删除，1-已删除',
    `creator`          varchar(50)           DEFAULT NULL COMMENT '创建人',
    `dept_id`          bigint                DEFAULT NULL COMMENT '部门id',
    `create_time`      timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `updater`          varchar(50)           DEFAULT NULL COMMENT '更新人',
    `update_time`      timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='历史资产统计表';

-- ----------------------------
-- Records of ds_meta_his
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ds_meta_table
-- ----------------------------
DROP TABLE IF EXISTS `ds_meta_table`;
CREATE TABLE `ds_meta_table`
(
    `id`            bigint       NOT NULL AUTO_INCREMENT COMMENT '主键',
    `db_id`         bigint       NOT NULL COMMENT '数据源主键',
    `type`          tinyint      NOT NULL COMMENT '表类型 1-表，2-视图',
    `table_name`    varchar(50)  NOT NULL COMMENT '表名',
    `table_name_zh` varchar(50)           DEFAULT NULL COMMENT '中文名',
    `count`         bigint                DEFAULT NULL COMMENT '记录条数',
    `version`       varchar(50)           DEFAULT '1' COMMENT '版本号',
    `deleted`       tinyint      NOT NULL DEFAULT '0' COMMENT '0-未删除，1-已删除',
    `creator`       varchar(50)           DEFAULT NULL COMMENT '创建人',
    `dept_id`       bigint                DEFAULT NULL COMMENT '部门id',
    `create_time`   timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `updater`       varchar(50)           DEFAULT NULL COMMENT '更新人',
    `update_time`   timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY             `idx_table` (`db_id`,`table_name`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据源table';

-- ----------------------------
-- Records of ds_meta_table
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for mark_data_sample
-- ----------------------------
DROP TABLE IF EXISTS `mark_data_sample`;
CREATE TABLE `mark_data_sample`
(
    `id`          bigint       NOT NULL AUTO_INCREMENT COMMENT '主键',
    `task_id`     bigint                DEFAULT NULL COMMENT '任务id',
    `db_id`       bigint       NOT NULL COMMENT '数据源id',
    `table_id`    bigint       NOT NULL COMMENT '数据表id',
    `table_name`  varchar(50)  NOT NULL COMMENT '数据表名称',
    `col_name`    varchar(50)  NOT NULL COMMENT '字段名称',
    `data_sample` text         NOT NULL COMMENT '样本数据',
    `deleted`     tinyint      NOT NULL DEFAULT '0' COMMENT '0-未删除，1-已删除',
    `creator`     varchar(50)           DEFAULT NULL COMMENT '创建人',
    `dept_id`     bigint                DEFAULT NULL COMMENT '部门id',
    `create_time` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `updater`     varchar(50)           DEFAULT NULL COMMENT '更新人',
    `update_time` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY           `idx_table_col` (`table_id`,`col_name`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据识别样本X条';

-- ----------------------------
-- Records of mark_data_sample
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sc_task
-- ----------------------------
DROP TABLE IF EXISTS `sc_task`;
CREATE TABLE `sc_task`
(
    `id`                 bigint       NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name`               varchar(50)  NOT NULL COMMENT '任务名称',
    `ip`                 varchar(50)  NOT NULL COMMENT 'ip,cidr',
    `port`               varchar(50)           DEFAULT NULL COMMENT '端口,多个用逗号分隔',
    `type`               tinyint      NOT NULL COMMENT '执行模式 1-单次，2-cron',
    `cron`               varchar(50)           DEFAULT NULL COMMENT 'cron表达式',
    `trigger_start_time` datetime              DEFAULT NULL COMMENT '周期任务生效时间',
    `trigger_end_time`   datetime              DEFAULT NULL COMMENT '周期任务失效时间',
    `retry_count`        int          NOT NULL DEFAULT '0' COMMENT '重试次数',
    `retry_interval`     int          NOT NULL DEFAULT '0' COMMENT '重试间隔',
    `status`             tinyint      NOT NULL DEFAULT '1' COMMENT '任务状态 1：正常，2：暂停',
    `deleted`            tinyint      NOT NULL DEFAULT '0' COMMENT '0-未删除，1-已删除',
    `creator`            varchar(50)  NOT NULL COMMENT '创建人',
    `dept_id`            bigint                DEFAULT NULL COMMENT '部门id',
    `create_time`        timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `updater`            varchar(50)  NOT NULL COMMENT '更新人',
    `update_time`        timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='探查任务表';

-- ----------------------------
-- Records of sc_task
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sc_task_instance
-- ----------------------------
DROP TABLE IF EXISTS `sc_task_instance`;
CREATE TABLE `sc_task_instance`
(
    `id`          bigint       NOT NULL AUTO_INCREMENT COMMENT '主键',
    `task_id`     bigint       NOT NULL COMMENT '任务id',
    `instance_id` varchar(50)  NOT NULL COMMENT '实例id',
    `exe_status`  tinyint      NOT NULL DEFAULT '1' COMMENT '任务执行状态 1：未执行，2：执行中，3：执行结束（成功）4，执行结束（失败）',
    `ip_count`    int                   DEFAULT NULL COMMENT '发现ip数量',
    `hosts_count` int                   DEFAULT NULL COMMENT '发现主机数量',
    `take_time`   varchar(50)           DEFAULT NULL COMMENT '耗时',
    `deleted`     tinyint      NOT NULL DEFAULT '0' COMMENT '0-未删除，1-已删除',
    `creator`     varchar(50)           DEFAULT NULL COMMENT '创建人',
    `dept_id`     bigint                DEFAULT NULL COMMENT '部门id',
    `create_time` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `updater`     varchar(50)           DEFAULT NULL COMMENT '更新人',
    `update_time` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY           `idx_instance` (`task_id`,`instance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='探查任务实例表';

-- ----------------------------
-- Records of sc_task_instance
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sc_task_result
-- ----------------------------
DROP TABLE IF EXISTS `sc_task_result`;
CREATE TABLE `sc_task_result`
(
    `id`          bigint       NOT NULL AUTO_INCREMENT COMMENT '主键',
    `task_id`     bigint       NOT NULL COMMENT '任务id',
    `instance_id` varchar(50)  NOT NULL COMMENT '实例id',
    `ds_url`      varchar(50)  NOT NULL COMMENT '数据源URL',
    `ds_port`     varchar(50)  NOT NULL COMMENT '数据源端口',
    `ds_type`     varchar(50)  NOT NULL COMMENT '数据源类型',
    `remark`      varchar(100)          DEFAULT NULL COMMENT '备注',
    `deleted`     tinyint      NOT NULL DEFAULT '0' COMMENT '0-未删除，1-已删除',
    `creator`     varchar(50)           DEFAULT NULL COMMENT '创建人',
    `dept_id`     bigint                DEFAULT NULL COMMENT '部门id',
    `create_time` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `updater`     varchar(50)           DEFAULT NULL COMMENT '更新人',
    `update_time` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY           `idx_instance` (`task_id`,`instance_id`),
    KEY           `idx_host` (`ds_url`,`ds_port`),
    KEY           `idx_create` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='探查任务结果表';

-- ----------------------------
-- Records of sc_task_result
-- ----------------------------
BEGIN;
COMMIT;


-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS`
(
    `SCHED_NAME`    varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `TRIGGER_NAME`  varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `BLOB_DATA`     blob,
    PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
    KEY             `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
    CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB  COMMENT='以Blob 类型存储的触发器';

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS`
(
    `SCHED_NAME`    varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `CALENDAR_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `CALENDAR`      blob                                                          NOT NULL,
    PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE=InnoDB  COMMENT='存放日历信息，quartz可配置一个日历来指定一个时间范围';

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS`
(
    `SCHED_NAME`      varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `TRIGGER_NAME`    varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `TRIGGER_GROUP`   varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `TIME_ZONE_ID`    varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
    CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB  COMMENT='存放cron类型的触发器';

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS`
(
    `SCHED_NAME`        varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `ENTRY_ID`          varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL,
    `TRIGGER_NAME`      varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `TRIGGER_GROUP`     varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `INSTANCE_NAME`     varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `FIRED_TIME`        bigint                                                        NOT NULL,
    `SCHED_TIME`        bigint                                                        NOT NULL,
    `PRIORITY`          int                                                           NOT NULL,
    `STATE`             varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL,
    `JOB_NAME`          varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `JOB_GROUP`         varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `IS_NONCONCURRENT`  varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   DEFAULT NULL,
    `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   DEFAULT NULL,
    PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE,
    KEY                 `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`) USING BTREE,
    KEY                 `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`) USING BTREE,
    KEY                 `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
    KEY                 `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE,
    KEY                 `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
    KEY                 `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE
) ENGINE=InnoDB  COMMENT='存放已触发的触发器';

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS`
(
    `SCHED_NAME`        varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `JOB_NAME`          varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `JOB_GROUP`         varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `DESCRIPTION`       varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `JOB_CLASS_NAME`    varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `IS_DURABLE`        varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   NOT NULL,
    `IS_NONCONCURRENT`  varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   NOT NULL,
    `IS_UPDATE_DATA`    varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   NOT NULL,
    `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   NOT NULL,
    `JOB_DATA`          blob,
    PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
    KEY                 `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`) USING BTREE,
    KEY                 `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE
) ENGINE=InnoDB  COMMENT='存放一个jobDetail信息';

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS`
(
    `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `LOCK_NAME`  varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL,
    PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE=InnoDB  COMMENT='存储程序的悲观锁的信息(假如使用了悲观锁）';

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------
BEGIN;
INSERT INTO `QRTZ_LOCKS` (`SCHED_NAME`, `LOCK_NAME`)
VALUES ('schedulerName', 'STATE_ACCESS');
INSERT INTO `QRTZ_LOCKS` (`SCHED_NAME`, `LOCK_NAME`)
VALUES ('schedulerName', 'TRIGGER_ACCESS');
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS`
(
    `SCHED_NAME`    varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE=InnoDB  COMMENT='存放暂停掉的触发器';

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE`
(
    `SCHED_NAME`        varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `INSTANCE_NAME`     varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `LAST_CHECKIN_TIME` bigint                                                        NOT NULL,
    `CHECKIN_INTERVAL`  bigint                                                        NOT NULL,
    PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE=InnoDB  COMMENT='调度器状态';

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS`
(
    `SCHED_NAME`      varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `TRIGGER_NAME`    varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `TRIGGER_GROUP`   varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `REPEAT_COUNT`    bigint                                                        NOT NULL,
    `REPEAT_INTERVAL` bigint                                                        NOT NULL,
    `TIMES_TRIGGERED` bigint                                                        NOT NULL,
    PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
    CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB  COMMENT='简单触发器的信息';

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS`
(
    `SCHED_NAME`    varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `TRIGGER_NAME`  varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `STR_PROP_1`    varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `STR_PROP_2`    varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `STR_PROP_3`    varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `INT_PROP_1`    int                                                           DEFAULT NULL,
    `INT_PROP_2`    int                                                           DEFAULT NULL,
    `LONG_PROP_1`   bigint                                                        DEFAULT NULL,
    `LONG_PROP_2`   bigint                                                        DEFAULT NULL,
    `DEC_PROP_1`    decimal(13, 4)                                                DEFAULT NULL,
    `DEC_PROP_2`    decimal(13, 4)                                                DEFAULT NULL,
    `BOOL_PROP_1`   varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   DEFAULT NULL,
    `BOOL_PROP_2`   varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   DEFAULT NULL,
    PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
    CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB  COMMENT='存储CalendarlntervalTrigger和DailyTimelntervalTrigger两种类型的触发器';

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS`
(
    `SCHED_NAME`     varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `TRIGGER_NAME`   varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `TRIGGER_GROUP`  varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `JOB_NAME`       varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `JOB_GROUP`      varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `DESCRIPTION`    varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `NEXT_FIRE_TIME` bigint                                                        DEFAULT NULL,
    `PREV_FIRE_TIME` bigint                                                        DEFAULT NULL,
    `PRIORITY`       int                                                           DEFAULT NULL,
    `TRIGGER_STATE`  varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL,
    `TRIGGER_TYPE`   varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   NOT NULL,
    `START_TIME`     bigint                                                        NOT NULL,
    `END_TIME`       bigint                                                        DEFAULT NULL,
    `CALENDAR_NAME`  varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `MISFIRE_INSTR`  smallint                                                      DEFAULT NULL,
    `JOB_DATA`       blob,
    PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
    KEY              `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
    KEY              `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE,
    KEY              `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`) USING BTREE,
    KEY              `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE,
    KEY              `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`) USING BTREE,
    KEY              `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
    KEY              `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
    KEY              `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`) USING BTREE,
    KEY              `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`) USING BTREE,
    KEY              `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`) USING BTREE,
    KEY              `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`) USING BTREE,
    KEY              `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
    CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB  COMMENT='存储已配置的Trigger的信息';

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;


SET
FOREIGN_KEY_CHECKS = 1;
