/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1 MySQL
 Source Server Type    : MySQL
 Source Server Version : 80200 (8.2.0)
 Source Host           : 127.0.0.1:3306
 Source Schema         : ruoyi-vue-pro

 Target Server Type    : MySQL
 Target Server Version : 80200 (8.2.0)
 File Encoding         : 65001

 Date: 24/07/2024 08:52:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS`
(
    `SCHED_NAME`    varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `TRIGGER_NAME`  varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `BLOB_DATA`     blob                                                          NULL,
    PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
    INDEX `SCHED_NAME` (`SCHED_NAME` ASC, `TRIGGER_NAME` ASC, `TRIGGER_GROUP` ASC) USING BTREE,
    CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
    COMMENT ='以Blob 类型存储的触发器'
  COLLATE = utf8mb4_unicode_ci;

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
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
    COMMENT ='存放日历信息，quartz可配置一个日历来指定一个时间范围'
  COLLATE = utf8mb4_unicode_ci;

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
    `TIME_ZONE_ID`    varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NULL DEFAULT NULL,
    PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
    CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
    COMMENT ='存放cron类型的触发器'
  COLLATE = utf8mb4_unicode_ci;


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
    `JOB_NAME`          varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `JOB_GROUP`         varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `IS_NONCONCURRENT`  varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   NULL DEFAULT NULL,
    `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   NULL DEFAULT NULL,
    PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE,
    INDEX `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME` ASC, `INSTANCE_NAME` ASC) USING BTREE,
    INDEX `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME` ASC, `INSTANCE_NAME` ASC, `REQUESTS_RECOVERY` ASC) USING BTREE,
    INDEX `IDX_QRTZ_FT_J_G` (`SCHED_NAME` ASC, `JOB_NAME` ASC, `JOB_GROUP` ASC) USING BTREE,
    INDEX `IDX_QRTZ_FT_JG` (`SCHED_NAME` ASC, `JOB_GROUP` ASC) USING BTREE,
    INDEX `IDX_QRTZ_FT_T_G` (`SCHED_NAME` ASC, `TRIGGER_NAME` ASC, `TRIGGER_GROUP` ASC) USING BTREE,
    INDEX `IDX_QRTZ_FT_TG` (`SCHED_NAME` ASC, `TRIGGER_GROUP` ASC) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
    COMMENT ='存放已触发的触发器'
  COLLATE = utf8mb4_unicode_ci;

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
    `DESCRIPTION`       varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `JOB_CLASS_NAME`    varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `IS_DURABLE`        varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   NOT NULL,
    `IS_NONCONCURRENT`  varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   NOT NULL,
    `IS_UPDATE_DATA`    varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   NOT NULL,
    `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   NOT NULL,
    `JOB_DATA`          blob                                                          NULL,
    PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
    INDEX `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME` ASC, `REQUESTS_RECOVERY` ASC) USING BTREE,
    INDEX `IDX_QRTZ_J_GRP` (`SCHED_NAME` ASC, `JOB_GROUP` ASC) USING BTREE
) ENGINE = InnoDB
    comment = '存放一个jobDetail信息'
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS`
(
    `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `LOCK_NAME`  varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL,
    PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB
    comment = '存储程序的悲观锁的信息(假如使用了悲观锁）'
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS`
(
    `SCHED_NAME`    varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB
    comment = '存放暂停掉的触发器'
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

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
) ENGINE = InnoDB
    comment ='调度器状态'
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;


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
) ENGINE = InnoDB
    comment = '简单触发器的信息'
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

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
    `STR_PROP_1`    varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `STR_PROP_2`    varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `STR_PROP_3`    varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `INT_PROP_1`    int                                                           NULL DEFAULT NULL,
    `INT_PROP_2`    int                                                           NULL DEFAULT NULL,
    `LONG_PROP_1`   bigint                                                        NULL DEFAULT NULL,
    `LONG_PROP_2`   bigint                                                        NULL DEFAULT NULL,
    `DEC_PROP_1`    decimal(13, 4)                                                NULL DEFAULT NULL,
    `DEC_PROP_2`    decimal(13, 4)                                                NULL DEFAULT NULL,
    `BOOL_PROP_1`   varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   NULL DEFAULT NULL,
    `BOOL_PROP_2`   varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   NULL DEFAULT NULL,
    PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
    CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
    comment = '存储CalendarlntervalTrigger和DailyTimelntervalTrigger两种类型的触发器'
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

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
    `DESCRIPTION`    varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `NEXT_FIRE_TIME` bigint                                                        NULL DEFAULT NULL,
    `PREV_FIRE_TIME` bigint                                                        NULL DEFAULT NULL,
    `PRIORITY`       int                                                           NULL DEFAULT NULL,
    `TRIGGER_STATE`  varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL,
    `TRIGGER_TYPE`   varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   NOT NULL,
    `START_TIME`     bigint                                                        NOT NULL,
    `END_TIME`       bigint                                                        NULL DEFAULT NULL,
    `CALENDAR_NAME`  varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `MISFIRE_INSTR`  smallint                                                      NULL DEFAULT NULL,
    `JOB_DATA`       blob                                                          NULL,
    PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
    INDEX `IDX_QRTZ_T_J` (`SCHED_NAME` ASC, `JOB_NAME` ASC, `JOB_GROUP` ASC) USING BTREE,
    INDEX `IDX_QRTZ_T_JG` (`SCHED_NAME` ASC, `JOB_GROUP` ASC) USING BTREE,
    INDEX `IDX_QRTZ_T_C` (`SCHED_NAME` ASC, `CALENDAR_NAME` ASC) USING BTREE,
    INDEX `IDX_QRTZ_T_G` (`SCHED_NAME` ASC, `TRIGGER_GROUP` ASC) USING BTREE,
    INDEX `IDX_QRTZ_T_STATE` (`SCHED_NAME` ASC, `TRIGGER_STATE` ASC) USING BTREE,
    INDEX `IDX_QRTZ_T_N_STATE` (`SCHED_NAME` ASC, `TRIGGER_NAME` ASC, `TRIGGER_GROUP` ASC, `TRIGGER_STATE`
                                ASC) USING BTREE,
    INDEX `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME` ASC, `TRIGGER_GROUP` ASC, `TRIGGER_STATE` ASC) USING BTREE,
    INDEX `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME` ASC, `NEXT_FIRE_TIME` ASC) USING BTREE,
    INDEX `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME` ASC, `TRIGGER_STATE` ASC, `NEXT_FIRE_TIME` ASC) USING BTREE,
    INDEX `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME` ASC, `MISFIRE_INSTR` ASC, `NEXT_FIRE_TIME` ASC) USING BTREE,
    INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME` ASC, `MISFIRE_INSTR` ASC, `NEXT_FIRE_TIME` ASC, `TRIGGER_STATE`
                                       ASC) USING BTREE,
    INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME` ASC, `MISFIRE_INSTR` ASC, `NEXT_FIRE_TIME` ASC, `TRIGGER_GROUP`
                                           ASC, `TRIGGER_STATE` ASC) USING BTREE,
    CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
    comment = '存储已配置的Trigger的信息'
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
