
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
                                      `SCHED_NAME` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `TRIGGER_NAME` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `TRIGGER_GROUP` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `BLOB_DATA` blob,
                                      PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
                                      KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
                                      CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS` (
                                  `SCHED_NAME` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
                                  `CALENDAR_NAME` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                  `CALENDAR` blob NOT NULL,
                                  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
                                      `SCHED_NAME` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `TRIGGER_NAME` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `TRIGGER_GROUP` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `CRON_EXPRESSION` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `TIME_ZONE_ID` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                      PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
                                      CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
                                       `SCHED_NAME` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
                                       `ENTRY_ID` varchar(95) COLLATE utf8mb4_unicode_ci NOT NULL,
                                       `TRIGGER_NAME` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                       `TRIGGER_GROUP` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                       `INSTANCE_NAME` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                       `FIRED_TIME` bigint(20) NOT NULL,
                                       `SCHED_TIME` bigint(20) NOT NULL,
                                       `PRIORITY` int(11) NOT NULL,
                                       `STATE` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
                                       `JOB_NAME` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                       `JOB_GROUP` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                       `IS_NONCONCURRENT` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                       `REQUESTS_RECOVERY` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                       PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`) USING BTREE,
                                       KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`) USING BTREE,
                                       KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`) USING BTREE,
                                       KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
                                       KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE,
                                       KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
                                       KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS` (
                                    `SCHED_NAME` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
                                    `JOB_NAME` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                    `JOB_GROUP` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                    `DESCRIPTION` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                    `JOB_CLASS_NAME` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
                                    `IS_DURABLE` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
                                    `IS_NONCONCURRENT` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
                                    `IS_UPDATE_DATA` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
                                    `REQUESTS_RECOVERY` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
                                    `JOB_DATA` blob,
                                    PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
                                    KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`) USING BTREE,
                                    KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------
BEGIN;
INSERT INTO `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`, `DESCRIPTION`, `JOB_CLASS_NAME`, `IS_DURABLE`, `IS_NONCONCURRENT`, `IS_UPDATE_DATA`, `REQUESTS_RECOVERY`, `JOB_DATA`) VALUES ('schedulerName', 'accessLogCleanJob', 'DEFAULT', NULL, 'com.shulian.safe.drm.framework.quartz.core.handler.JobHandlerInvoker', '0', '1', '1', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C770800000010000000027400064A4F425F49447372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000197400104A4F425F48414E444C45525F4E414D457400116163636573734C6F67436C65616E4A6F627800);
INSERT INTO `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`, `DESCRIPTION`, `JOB_CLASS_NAME`, `IS_DURABLE`, `IS_NONCONCURRENT`, `IS_UPDATE_DATA`, `REQUESTS_RECOVERY`, `JOB_DATA`) VALUES ('schedulerName', 'errorLogCleanJob', 'DEFAULT', NULL, 'com.shulian.safe.drm.framework.quartz.core.handler.JobHandlerInvoker', '0', '1', '1', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C770800000010000000027400064A4F425F49447372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000001A7400104A4F425F48414E444C45525F4E414D457400106572726F724C6F67436C65616E4A6F627800);
INSERT INTO `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`, `DESCRIPTION`, `JOB_CLASS_NAME`, `IS_DURABLE`, `IS_NONCONCURRENT`, `IS_UPDATE_DATA`, `REQUESTS_RECOVERY`, `JOB_DATA`) VALUES ('schedulerName', 'jobLogCleanJob', 'DEFAULT', NULL, 'com.shulian.safe.drm.framework.quartz.core.handler.JobHandlerInvoker', '0', '1', '1', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C770800000010000000027400064A4F425F49447372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000001B7400104A4F425F48414E444C45525F4E414D4574000E6A6F624C6F67436C65616E4A6F627800);
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS` (
                              `SCHED_NAME` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
                              `LOCK_NAME` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
                              PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
                                            `SCHED_NAME` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
                                            `TRIGGER_GROUP` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                            PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
                                        `SCHED_NAME` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
                                        `INSTANCE_NAME` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                        `LAST_CHECKIN_TIME` bigint(20) NOT NULL,
                                        `CHECKIN_INTERVAL` bigint(20) NOT NULL,
                                        PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------
BEGIN;
INSERT INTO `QRTZ_SCHEDULER_STATE` (`SCHED_NAME`, `INSTANCE_NAME`, `LAST_CHECKIN_TIME`, `CHECKIN_INTERVAL`) VALUES ('schedulerName', 'bogon1730960702830', 1730961054192, 15000);
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
                                        `SCHED_NAME` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
                                        `TRIGGER_NAME` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                        `TRIGGER_GROUP` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                        `REPEAT_COUNT` bigint(20) NOT NULL,
                                        `REPEAT_INTERVAL` bigint(20) NOT NULL,
                                        `TIMES_TRIGGERED` bigint(20) NOT NULL,
                                        PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
                                        CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
                                         `SCHED_NAME` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
                                         `TRIGGER_NAME` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                         `TRIGGER_GROUP` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                         `STR_PROP_1` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                         `STR_PROP_2` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                         `STR_PROP_3` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                         `INT_PROP_1` int(11) DEFAULT NULL,
                                         `INT_PROP_2` int(11) DEFAULT NULL,
                                         `LONG_PROP_1` bigint(20) DEFAULT NULL,
                                         `LONG_PROP_2` bigint(20) DEFAULT NULL,
                                         `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
                                         `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
                                         `BOOL_PROP_1` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                         `BOOL_PROP_2` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                         PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
                                         CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS` (
                                 `SCHED_NAME` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `TRIGGER_NAME` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `TRIGGER_GROUP` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `JOB_NAME` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `JOB_GROUP` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `DESCRIPTION` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                 `NEXT_FIRE_TIME` bigint(20) DEFAULT NULL,
                                 `PREV_FIRE_TIME` bigint(20) DEFAULT NULL,
                                 `PRIORITY` int(11) DEFAULT NULL,
                                 `TRIGGER_STATE` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `TRIGGER_TYPE` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `START_TIME` bigint(20) NOT NULL,
                                 `END_TIME` bigint(20) DEFAULT NULL,
                                 `CALENDAR_NAME` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                 `MISFIRE_INSTR` smallint(6) DEFAULT NULL,
                                 `JOB_DATA` blob,
                                 PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
                                 KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
                                 KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE,
                                 KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`) USING BTREE,
                                 KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE,
                                 KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`) USING BTREE,
                                 KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
                                 KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
                                 KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`) USING BTREE,
                                 KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`) USING BTREE,
                                 KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`) USING BTREE,
                                 KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`) USING BTREE,
                                 KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
                                 CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for drm_demo01_contact
-- ----------------------------
DROP TABLE IF EXISTS `drm_demo01_contact`;
CREATE TABLE `drm_demo01_contact` (
                                      `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                      `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名字',
                                      `sex` tinyint(1) NOT NULL COMMENT '性别',
                                      `birthday` datetime NOT NULL COMMENT '出生年',
                                      `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '简介',
                                      `avatar` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
                                      `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                      `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                      `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                      `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                      `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                      `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='示例联系人表';

-- ----------------------------
-- Records of drm_demo01_contact
-- ----------------------------
BEGIN;
INSERT INTO `drm_demo01_contact` (`id`, `name`, `sex`, `birthday`, `description`, `avatar`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1, '土豆', 2, '2023-11-07 00:00:00', '<p>天蚕土豆！呀</p>', 'http://127.0.0.1:48080/admin-api/infra/file/4/get/46f8fa1a37db3f3960d8910ff2fe3962ab3b2db87cf2f8ccb4dc8145b8bdf237.jpeg', '1', '2023-11-15 23:34:30', '1', '2023-11-15 23:47:39', b'0', 1);
COMMIT;

-- ----------------------------
-- Table structure for drm_demo02_category
-- ----------------------------
DROP TABLE IF EXISTS `drm_demo02_category`;
CREATE TABLE `drm_demo02_category` (
                                       `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                       `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名字',
                                       `parent_id` bigint(20) NOT NULL COMMENT '父级编号',
                                       `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                       `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                       `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                       `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                       `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                       `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='示例分类表';

-- ----------------------------
-- Records of drm_demo02_category
-- ----------------------------
BEGIN;
INSERT INTO `drm_demo02_category` (`id`, `name`, `parent_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1, '土豆', 0, '1', '2023-11-15 23:34:30', '1', '2023-11-16 20:24:23', b'0', 1);
INSERT INTO `drm_demo02_category` (`id`, `name`, `parent_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2, '番茄', 0, '1', '2023-11-16 20:24:00', '1', '2023-11-16 20:24:15', b'0', 1);
INSERT INTO `drm_demo02_category` (`id`, `name`, `parent_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3, '怪怪', 0, '1', '2023-11-16 20:24:32', '1', '2023-11-16 20:24:32', b'0', 1);
INSERT INTO `drm_demo02_category` (`id`, `name`, `parent_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (4, '小番茄', 2, '1', '2023-11-16 20:24:39', '1', '2023-11-16 20:24:39', b'0', 1);
INSERT INTO `drm_demo02_category` (`id`, `name`, `parent_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5, '大番茄', 2, '1', '2023-11-16 20:24:46', '1', '2023-11-16 20:24:46', b'0', 1);
INSERT INTO `drm_demo02_category` (`id`, `name`, `parent_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6, '11', 3, '1', '2023-11-24 19:29:34', '1', '2023-11-24 19:29:34', b'0', 1);
COMMIT;

-- ----------------------------
-- Table structure for drm_demo03_course
-- ----------------------------
DROP TABLE IF EXISTS `drm_demo03_course`;
CREATE TABLE `drm_demo03_course` (
                                     `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                     `student_id` bigint(20) NOT NULL COMMENT '学生编号',
                                     `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名字',
                                     `score` tinyint(4) NOT NULL COMMENT '分数',
                                     `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                     `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                     `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                     `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                     `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                     `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                     PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生课程表';

-- ----------------------------
-- Records of drm_demo03_course
-- ----------------------------
BEGIN;
INSERT INTO `drm_demo03_course` (`id`, `student_id`, `name`, `score`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2, 2, '语文', 66, '1', '2023-11-16 23:21:49', '1', '2023-11-16 23:21:49', b'0', 1);
INSERT INTO `drm_demo03_course` (`id`, `student_id`, `name`, `score`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3, 2, '数学', 22, '1', '2023-11-16 23:21:49', '1', '2023-11-16 23:21:49', b'0', 1);
INSERT INTO `drm_demo03_course` (`id`, `student_id`, `name`, `score`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (10, 5, '体育', 23, '1', '2023-11-16 23:22:46', '1', '2023-11-16 23:47:10', b'0', 1);
INSERT INTO `drm_demo03_course` (`id`, `student_id`, `name`, `score`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (11, 5, '计算机', 11, '1', '2023-11-16 23:22:46', '1', '2023-11-16 23:47:10', b'0', 1);
INSERT INTO `drm_demo03_course` (`id`, `student_id`, `name`, `score`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (13, 9, '滑雪', 12, '1', '2023-11-17 13:13:20', '1', '2023-11-17 13:13:20', b'0', 1);
COMMIT;

-- ----------------------------
-- Table structure for drm_demo03_grade
-- ----------------------------
DROP TABLE IF EXISTS `drm_demo03_grade`;
CREATE TABLE `drm_demo03_grade` (
                                    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                    `student_id` bigint(20) NOT NULL COMMENT '学生编号',
                                    `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名字',
                                    `teacher` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '班主任',
                                    `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                    `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生班级表';

-- ----------------------------
-- Records of drm_demo03_grade
-- ----------------------------
BEGIN;
INSERT INTO `drm_demo03_grade` (`id`, `student_id`, `name`, `teacher`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (7, 2, '三年 2 班', '周杰伦', '1', '2023-11-16 23:21:49', '1', '2023-11-16 23:21:49', b'0', 1);
INSERT INTO `drm_demo03_grade` (`id`, `student_id`, `name`, `teacher`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (8, 5, '华为', '遥遥领先', '1', '2023-11-16 23:22:46', '1', '2023-11-16 23:47:10', b'0', 1);
INSERT INTO `drm_demo03_grade` (`id`, `student_id`, `name`, `teacher`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (9, 9, '小图', '小娃111', '1', '2023-11-17 13:10:23', '1', '2023-11-17 13:10:23', b'0', 1);
COMMIT;

-- ----------------------------
-- Table structure for drm_demo03_student
-- ----------------------------
DROP TABLE IF EXISTS `drm_demo03_student`;
CREATE TABLE `drm_demo03_student` (
                                      `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                      `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名字',
                                      `sex` tinyint(4) NOT NULL COMMENT '性别',
                                      `birthday` datetime NOT NULL COMMENT '出生日期',
                                      `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '简介',
                                      `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                      `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                      `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                      `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                      `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                      `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生表';

-- ----------------------------
-- Records of drm_demo03_student
-- ----------------------------
BEGIN;
INSERT INTO `drm_demo03_student` (`id`, `name`, `sex`, `birthday`, `description`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2, '小白', 1, '2023-11-16 00:00:00', '<p>厉害</p>', '1', '2023-11-16 23:21:49', '1', '2023-11-17 16:49:06', b'0', 1);
INSERT INTO `drm_demo03_student` (`id`, `name`, `sex`, `birthday`, `description`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5, '大黑', 2, '2023-11-13 00:00:00', '<p>你在教我做事?</p>', '1', '2023-11-16 23:22:46', '1', '2023-11-17 16:49:07', b'0', 1);
INSERT INTO `drm_demo03_student` (`id`, `name`, `sex`, `birthday`, `description`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (9, '小花', 1, '2023-11-07 00:00:00', '<p>哈哈哈</p>', '1', '2023-11-17 00:04:47', '1', '2023-11-17 16:49:08', b'0', 1);
COMMIT;

-- ----------------------------
-- Table structure for infra_api_access_log
-- ----------------------------
DROP TABLE IF EXISTS `infra_api_access_log`;
CREATE TABLE `infra_api_access_log` (
                                        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
                                        `trace_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '链路追踪编号',
                                        `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户编号',
                                        `user_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户类型',
                                        `application_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
                                        `request_method` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '请求方法名',
                                        `request_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '请求地址',
                                        `request_params` text COLLATE utf8mb4_unicode_ci COMMENT '请求参数',
                                        `response_body` text COLLATE utf8mb4_unicode_ci COMMENT '响应结果',
                                        `user_ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户 IP',
                                        `user_agent` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '浏览器 UA',
                                        `operate_module` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作模块',
                                        `operate_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作名',
                                        `operate_type` tinyint(4) DEFAULT '0' COMMENT '操作分类',
                                        `begin_time` datetime NOT NULL COMMENT '开始请求时间',
                                        `end_time` datetime NOT NULL COMMENT '结束请求时间',
                                        `duration` int(11) NOT NULL COMMENT '执行时长',
                                        `result_code` int(11) NOT NULL DEFAULT '0' COMMENT '结果码',
                                        `result_msg` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '结果提示',
                                        `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                        `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                        `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                        `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                        `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                        `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                        PRIMARY KEY (`id`) USING BTREE,
                                        KEY `idx_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='API 访问日志表';

-- ----------------------------
-- Records of infra_api_access_log
-- ----------------------------
BEGIN;
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1, '', 0, 2, 'system-server', 'GET', '/admin-api/system/tenant/get-by-website', '{\"query\":\"{\\\"website\\\":\\\"10.0.3.163:8090\\\"}\",\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 租户', '使用域名，获得租户信息', 1, '2024-11-07 14:27:04', '2024-11-07 14:27:04', 120, 0, '', NULL, '2024-11-07 14:27:05', NULL, '2024-11-07 14:27:05', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2, '', 0, 2, 'system-server', 'POST', '/admin-api/system/captcha/get', '{\"query\":null,\"body\":\"{\\\"captchaType\\\":\\\"blockPuzzle\\\"}\"}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 验证码', '获得验证码', 2, '2024-11-07 14:27:04', '2024-11-07 14:27:04', 333, 0, '', NULL, '2024-11-07 14:27:05', NULL, '2024-11-07 14:27:05', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3, '', 0, 2, 'system-server', 'GET', '/admin-api/system/tenant/get-by-website', '{\"query\":\"{\\\"website\\\":\\\"10.0.3.163:8090\\\"}\",\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 租户', '使用域名，获得租户信息', 1, '2024-11-07 14:27:09', '2024-11-07 14:27:09', 4, 0, '', NULL, '2024-11-07 14:27:09', NULL, '2024-11-07 14:27:09', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (4, '', 0, 2, 'system-server', 'POST', '/admin-api/system/captcha/get', '{\"query\":null,\"body\":\"{\\\"captchaType\\\":\\\"blockPuzzle\\\"}\"}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 验证码', '获得验证码', 2, '2024-11-07 14:27:09', '2024-11-07 14:27:09', 580, 0, '', NULL, '2024-11-07 14:27:09', NULL, '2024-11-07 14:27:09', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5, '', 0, 2, 'system-server', 'POST', '/admin-api/system/captcha/check', '{\"query\":null,\"body\":\"{\\\"captchaType\\\":\\\"blockPuzzle\\\",\\\"pointJson\\\":\\\"7qP323YdB+XbSGlBwGVNzUas5SI4f87FL/C9tYbvRPE=\\\"}\"}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 验证码', '校验验证码', 2, '2024-11-07 14:27:14', '2024-11-07 14:27:14', 35, 0, '', NULL, '2024-11-07 14:27:14', NULL, '2024-11-07 14:27:14', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6, '', 0, 2, 'system-server', 'GET', '/admin-api/system/tenant/get-id-by-name', '{\"query\":\"{\\\"name\\\":\\\"数可安\\\"}\",\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 租户', '使用租户名，获得租户编号', 1, '2024-11-07 14:27:15', '2024-11-07 14:27:15', 5, 0, '', NULL, '2024-11-07 14:27:15', NULL, '2024-11-07 14:27:15', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (7, '', 0, 2, 'system-server', 'POST', '/admin-api/system/auth/login', '{\"query\":null,\"body\":\"{\\\"tenantName\\\":\\\"数可安\\\",\\\"username\\\":\\\"admin\\\",\\\"captchaVerification\\\":\\\"8wEa+s1zS9x+JjA4seFmGAHu73e8rSZ475uAFGiQIkqmznTiAipvBfk57CKl92aEbmf4ZQunDoi+07QxSTBMfg==\\\",\\\"rememberMe\\\":true}\"}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 认证', '使用账号密码登录', 2, '2024-11-07 14:27:15', '2024-11-07 14:27:16', 473, 0, '', NULL, '2024-11-07 14:27:16', NULL, '2024-11-07 14:27:16', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (8, '', 0, 2, 'system-server', 'POST', '/admin-api/system/captcha/get', '{\"query\":null,\"body\":\"{\\\"captchaType\\\":\\\"blockPuzzle\\\"}\"}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 验证码', '获得验证码', 2, '2024-11-07 14:27:16', '2024-11-07 14:27:16', 47, 0, '', NULL, '2024-11-07 14:27:16', NULL, '2024-11-07 14:27:16', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (9, '', 1, 2, 'system-server', 'GET', '/admin-api/system/dict-data/simple-list', '{\"query\":null,\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 字典数据', '获得全部字典数据列表', 1, '2024-11-07 14:27:16', '2024-11-07 14:27:16', 74, 0, '', NULL, '2024-11-07 14:27:16', NULL, '2024-11-07 14:27:16', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (10, '', 1, 2, 'system-server', 'GET', '/admin-api/system/auth/get-permission-info', '{\"query\":null,\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 认证', '获取登录用户的权限信息', 1, '2024-11-07 14:27:16', '2024-11-07 14:27:16', 174, 0, '', NULL, '2024-11-07 14:27:16', NULL, '2024-11-07 14:27:16', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (11, '', 1, 2, 'system-server', 'GET', '/admin-api/system/dept/list', '{\"query\":\"{\\\"pageNo\\\":\\\"1\\\",\\\"pageSize\\\":\\\"100\\\"}\",\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 部门', '获取部门列表', 1, '2024-11-07 14:27:20', '2024-11-07 14:27:20', 137, 0, '', NULL, '2024-11-07 14:27:20', NULL, '2024-11-07 14:27:20', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (12, '', 1, 2, 'system-server', 'GET', '/admin-api/system/user/simple-list', '{\"query\":null,\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 用户', '获取用户精简信息列表', 1, '2024-11-07 14:27:20', '2024-11-07 14:27:20', 42, 0, '', NULL, '2024-11-07 14:27:20', NULL, '2024-11-07 14:27:20', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (13, '', 1, 2, 'system-server', 'GET', '/admin-api/system/post/page', '{\"query\":\"{\\\"code\\\":\\\"\\\",\\\"pageNo\\\":\\\"1\\\",\\\"name\\\":\\\"\\\",\\\"pageSize\\\":\\\"10\\\"}\",\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 岗位', '获得岗位分页列表', 1, '2024-11-07 14:27:23', '2024-11-07 14:27:23', 115, 0, '', NULL, '2024-11-07 14:27:23', NULL, '2024-11-07 14:27:23', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (14, '', 1, 2, 'system-server', 'GET', '/admin-api/system/dept/simple-list', '{\"query\":null,\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 部门', '获取部门精简信息列表', 1, '2024-11-07 14:27:24', '2024-11-07 14:27:24', 23, 0, '', NULL, '2024-11-07 14:27:24', NULL, '2024-11-07 14:27:24', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (15, '', 1, 2, 'system-server', 'GET', '/admin-api/system/user/page', '{\"query\":\"{\\\"pageNo\\\":\\\"1\\\",\\\"pageSize\\\":\\\"10\\\"}\",\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 用户', '获得用户分页列表', 1, '2024-11-07 14:27:24', '2024-11-07 14:27:24', 66, 0, '', NULL, '2024-11-07 14:27:24', NULL, '2024-11-07 14:27:24', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (16, '', 1, 2, 'dmap-server', 'GET', '/admin-api/dmap/v1/dmap/index/queryTotal', '{\"query\":null,\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '资产概览', '查询总数据量', 1, '2024-11-07 14:27:27', '2024-11-07 14:27:27', 10, 0, '', NULL, '2024-11-07 14:27:27', NULL, '2024-11-07 14:27:27', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (17, '', 1, 2, 'dmap-server', 'GET', '/admin-api/dmap/v1/dmap/index/dsRatio', '{\"query\":null,\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '资产概览', '数据库类别占比 饼图', 1, '2024-11-07 14:27:27', '2024-11-07 14:27:27', 14, 0, '', NULL, '2024-11-07 14:27:27', NULL, '2024-11-07 14:27:27', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (18, '', 1, 2, 'dmap-server', 'GET', '/admin-api/dmap/v1/dmap/index/queryScan', '{\"query\":\"{\\\"end\\\":\\\"2024-11-06\\\",\\\"begin\\\":\\\"2024-10-08\\\"}\",\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '资产概览', '查询扫描指标', 1, '2024-11-07 14:27:27', '2024-11-07 14:27:27', 12, 0, '', NULL, '2024-11-07 14:27:27', NULL, '2024-11-07 14:27:27', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (19, '', 1, 2, 'dmap-server', 'GET', '/admin-api/dmap/v1/dmap/index/dbTypeTop5', '{\"query\":null,\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '资产概览', '数据库统计Top5', 1, '2024-11-07 14:27:27', '2024-11-07 14:27:27', 18, 0, '', NULL, '2024-11-07 14:27:27', NULL, '2024-11-07 14:27:27', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (20, '', 1, 2, 'dmap-server', 'GET', '/admin-api/dmap/v1/dmap/index/queryDbService', '{\"query\":\"{\\\"type\\\":\\\"engine\\\"}\",\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '资产概览', '查询实例分布饼图', 1, '2024-11-07 14:27:27', '2024-11-07 14:27:27', 27, 0, '', NULL, '2024-11-07 14:27:27', NULL, '2024-11-07 14:27:27', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (21, '', 1, 2, 'dmap-server', 'GET', '/admin-api/dmap/v1/dmap/index/queryDbTypeTrend', '{\"query\":\"{\\\"end\\\":\\\"2024-11-06\\\",\\\"begin\\\":\\\"2024-10-08\\\"}\",\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '资产概览', '查询数据库类型每日的变化趋势 [{\'类型\':[{\'日期\':\'数据\'}]}]', 1, '2024-11-07 14:27:27', '2024-11-07 14:27:27', 12, 0, '', NULL, '2024-11-07 14:27:27', NULL, '2024-11-07 14:27:27', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (22, '', 1, 2, 'dmap-server', 'GET', '/admin-api/dmap/v1/dmap/index/dbTypeInfo', '{\"query\":\"{\\\"type\\\":\\\"mysql\\\"}\",\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '资产概览', '查询类型详情', 1, '2024-11-07 14:27:27', '2024-11-07 14:27:27', 18, 0, '', NULL, '2024-11-07 14:27:27', NULL, '2024-11-07 14:27:27', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (23, '', 1, 2, 'dmap-server', 'GET', '/admin-api/dmap/v1/dmap/index/queryDbTrend', '{\"query\":\"{\\\"end\\\":\\\"2024-11-06\\\",\\\"begin\\\":\\\"2024-10-08\\\"}\",\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '资产概览', '查询数据库资产总量每日的变化趋势', 1, '2024-11-07 14:27:27', '2024-11-07 14:27:27', 18, 0, '', NULL, '2024-11-07 14:27:27', NULL, '2024-11-07 14:27:27', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (24, '', 1, 2, 'dmap-server', 'GET', '/admin-api/dmap/v1/dmap/index/queryProperty', '{\"query\":null,\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '资产概览', '查询资源概览数', 1, '2024-11-07 14:27:27', '2024-11-07 14:27:27', 49, 0, '', NULL, '2024-11-07 14:27:27', NULL, '2024-11-07 14:27:27', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (25, '', 1, 2, 'system-server', 'GET', '/admin-api/system/role/page', '{\"query\":\"{\\\"code\\\":\\\"\\\",\\\"pageNo\\\":\\\"1\\\",\\\"name\\\":\\\"\\\",\\\"pageSize\\\":\\\"10\\\"}\",\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 角色', '获得角色分页', 1, '2024-11-07 14:29:33', '2024-11-07 14:29:33', 61, 0, '', NULL, '2024-11-07 14:29:33', NULL, '2024-11-07 14:29:33', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (26, '', 1, 2, 'system-server', 'GET', '/admin-api/system/menu/list', '{\"query\":null,\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 菜单', '获取菜单列表', 1, '2024-11-07 14:29:34', '2024-11-07 14:29:34', 59, 0, '', NULL, '2024-11-07 14:29:34', NULL, '2024-11-07 14:29:34', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (27, '', 1, 2, 'system-server', 'GET', '/admin-api/system/dict-data/simple-list', '{\"query\":null,\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 字典数据', '获得全部字典数据列表', 1, '2024-11-07 14:29:37', '2024-11-07 14:29:37', 17, 0, '', NULL, '2024-11-07 14:29:37', NULL, '2024-11-07 14:29:37', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (28, '', 1, 2, 'system-server', 'GET', '/admin-api/system/auth/get-permission-info', '{\"query\":null,\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 认证', '获取登录用户的权限信息', 1, '2024-11-07 14:29:37', '2024-11-07 14:29:37', 30, 0, '', NULL, '2024-11-07 14:29:37', NULL, '2024-11-07 14:29:37', b'0', 0);
INSERT INTO `infra_api_access_log` (`id`, `trace_id`, `user_id`, `user_type`, `application_name`, `request_method`, `request_url`, `request_params`, `response_body`, `user_ip`, `user_agent`, `operate_module`, `operate_name`, `operate_type`, `begin_time`, `end_time`, `duration`, `result_code`, `result_msg`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (29, '', 1, 2, 'system-server', 'GET', '/admin-api/system/menu/list', '{\"query\":null,\"body\":null}', NULL, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', '管理后台 - 菜单', '获取菜单列表', 1, '2024-11-07 14:29:37', '2024-11-07 14:29:37', 16, 0, '', NULL, '2024-11-07 14:29:37', NULL, '2024-11-07 14:29:37', b'0', 0);
COMMIT;

-- ----------------------------
-- Table structure for infra_api_error_log
-- ----------------------------
DROP TABLE IF EXISTS `infra_api_error_log`;
CREATE TABLE `infra_api_error_log` (
                                       `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                       `trace_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '链路追踪编号',
                                       `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户编号',
                                       `user_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户类型',
                                       `application_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
                                       `request_method` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求方法名',
                                       `request_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求地址',
                                       `request_params` varchar(8000) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求参数',
                                       `user_ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户 IP',
                                       `user_agent` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '浏览器 UA',
                                       `exception_time` datetime NOT NULL COMMENT '异常发生时间',
                                       `exception_name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '异常名',
                                       `exception_message` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常导致的消息',
                                       `exception_root_cause_message` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常导致的根消息',
                                       `exception_stack_trace` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常的栈轨迹',
                                       `exception_class_name` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常发生的类全名',
                                       `exception_file_name` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常发生的类文件',
                                       `exception_method_name` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常发生的方法名',
                                       `exception_line_number` int(11) NOT NULL COMMENT '异常发生的方法所在行',
                                       `process_status` tinyint(4) NOT NULL COMMENT '处理状态',
                                       `process_time` datetime DEFAULT NULL COMMENT '处理时间',
                                       `process_user_id` int(11) DEFAULT '0' COMMENT '处理用户编号',
                                       `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                       `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                       `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                       `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                       `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                       `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统异常日志';

-- ----------------------------
-- Records of infra_api_error_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for infra_codegen_column
-- ----------------------------
DROP TABLE IF EXISTS `infra_codegen_column`;
CREATE TABLE `infra_codegen_column` (
                                        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                        `table_id` bigint(20) NOT NULL COMMENT '表编号',
                                        `column_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字段名',
                                        `data_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字段类型',
                                        `column_comment` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字段描述',
                                        `nullable` bit(1) NOT NULL COMMENT '是否允许为空',
                                        `primary_key` bit(1) NOT NULL COMMENT '是否主键',
                                        `ordinal_position` int(11) NOT NULL COMMENT '排序',
                                        `java_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Java 属性类型',
                                        `java_field` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Java 属性名',
                                        `dict_type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '字典类型',
                                        `example` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据示例',
                                        `create_operation` bit(1) NOT NULL COMMENT '是否为 Create 创建操作的字段',
                                        `update_operation` bit(1) NOT NULL COMMENT '是否为 Update 更新操作的字段',
                                        `list_operation` bit(1) NOT NULL COMMENT '是否为 List 查询操作的字段',
                                        `list_operation_condition` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '=' COMMENT 'List 查询操作的条件类型',
                                        `list_operation_result` bit(1) NOT NULL COMMENT '是否为 List 查询操作的返回字段',
                                        `html_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '显示类型',
                                        `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                        `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                        `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                        `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                        `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                        PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2470 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='代码生成表字段定义';

-- ----------------------------
-- Records of infra_codegen_column
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for infra_codegen_table
-- ----------------------------
DROP TABLE IF EXISTS `infra_codegen_table`;
CREATE TABLE `infra_codegen_table` (
                                       `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                       `data_source_config_id` bigint(20) NOT NULL COMMENT '数据源配置的编号',
                                       `scene` tinyint(4) NOT NULL DEFAULT '1' COMMENT '生成场景',
                                       `table_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '表名称',
                                       `table_comment` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '表描述',
                                       `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                       `module_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模块名',
                                       `business_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '业务名',
                                       `class_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '类名称',
                                       `class_comment` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '类描述',
                                       `author` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '作者',
                                       `template_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '模板类型',
                                       `front_type` tinyint(4) NOT NULL COMMENT '前端类型',
                                       `parent_menu_id` bigint(20) DEFAULT NULL COMMENT '父菜单编号',
                                       `master_table_id` bigint(20) DEFAULT NULL COMMENT '主表的编号',
                                       `sub_join_column_id` bigint(20) DEFAULT NULL COMMENT '子表关联主表的字段编号',
                                       `sub_join_many` bit(1) DEFAULT NULL COMMENT '主表与子表是否一对多',
                                       `tree_parent_column_id` bigint(20) DEFAULT NULL COMMENT '树表的父字段编号',
                                       `tree_name_column_id` bigint(20) DEFAULT NULL COMMENT '树表的名字字段编号',
                                       `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                       `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                       `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                       `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                       `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='代码生成表定义';

-- ----------------------------
-- Records of infra_codegen_table
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for infra_config
-- ----------------------------
DROP TABLE IF EXISTS `infra_config`;
CREATE TABLE `infra_config` (
                                `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
                                `category` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数分组',
                                `type` tinyint(4) NOT NULL COMMENT '参数类型',
                                `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数名称',
                                `config_key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数键名',
                                `value` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数键值',
                                `visible` bit(1) NOT NULL COMMENT '是否可见',
                                `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='参数配置表';

-- ----------------------------
-- Records of infra_config
-- ----------------------------
BEGIN;
INSERT INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2, 'biz', 1, '用户管理-账号初始密码', 'system.user.init-password', '123456', b'0', '初始化密码 123456', 'admin', '2021-01-05 17:03:48', '1', '2024-07-20 17:22:47', b'0');
INSERT INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (8, 'url', 2, 'SkyWalking 监控的地址', 'url.skywalking', '', b'1', '', '1', '2023-04-07 13:41:16', '1', '2023-04-07 14:57:03', b'0');
INSERT INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (9, 'url', 2, 'Spring Boot Admin 监控的地址', 'url.spring-boot-admin', '', b'1', '', '1', '2023-04-07 13:41:16', '1', '2023-04-07 14:52:07', b'0');
INSERT INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (10, 'url', 2, 'Swagger 接口文档的地址', 'url.swagger', '', b'1', '', '1', '2023-04-07 13:41:16', '1', '2023-04-07 14:59:00', b'0');
COMMIT;

-- ----------------------------
-- Table structure for infra_data_source_config
-- ----------------------------
DROP TABLE IF EXISTS `infra_data_source_config`;
CREATE TABLE `infra_data_source_config` (
                                            `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键编号',
                                            `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数名称',
                                            `url` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '数据源连接',
                                            `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
                                            `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
                                            `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                            `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                            `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                            `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                            `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                            PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='数据源配置表';

-- ----------------------------
-- Records of infra_data_source_config
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for infra_file
-- ----------------------------
DROP TABLE IF EXISTS `infra_file`;
CREATE TABLE `infra_file` (
                              `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '文件编号',
                              `config_id` bigint(20) DEFAULT NULL COMMENT '配置编号',
                              `name` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件名',
                              `path` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件路径',
                              `url` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件 URL',
                              `type` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件类型',
                              `size` int(11) NOT NULL COMMENT '文件大小',
                              `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                              `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                              `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                              `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                              `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                              PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1447 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文件表';

-- ----------------------------
-- Records of infra_file
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for infra_file_config
-- ----------------------------
DROP TABLE IF EXISTS `infra_file_config`;
CREATE TABLE `infra_file_config` (
                                     `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                     `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置名',
                                     `storage` tinyint(4) NOT NULL COMMENT '存储器',
                                     `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                     `master` bit(1) NOT NULL COMMENT '是否为主配置',
                                     `config` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '存储配置',
                                     `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                     `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                     `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                     `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                     `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                     PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文件配置表';

-- ----------------------------
-- Records of infra_file_config
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for infra_file_content
-- ----------------------------
DROP TABLE IF EXISTS `infra_file_content`;
CREATE TABLE `infra_file_content` (
                                      `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                      `config_id` bigint(20) NOT NULL COMMENT '配置编号',
                                      `path` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件路径',
                                      `content` mediumblob NOT NULL COMMENT '文件内容',
                                      `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                      `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                      `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                      `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                      `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=283 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文件表';

-- ----------------------------
-- Records of infra_file_content
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for infra_job
-- ----------------------------
DROP TABLE IF EXISTS `infra_job`;
CREATE TABLE `infra_job` (
                             `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务编号',
                             `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务名称',
                             `status` tinyint(4) NOT NULL COMMENT '任务状态',
                             `handler_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '处理器的名字',
                             `handler_param` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '处理器的参数',
                             `cron_expression` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'CRON 表达式',
                             `retry_count` int(11) NOT NULL DEFAULT '0' COMMENT '重试次数',
                             `retry_interval` int(11) NOT NULL DEFAULT '0' COMMENT '重试间隔',
                             `monitor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '监控超时时间',
                             `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                             `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                             `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                             `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                             `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='定时任务表';

-- ----------------------------
-- Records of infra_job
-- ----------------------------
BEGIN;
INSERT INTO `infra_job` (`id`, `name`, `status`, `handler_name`, `handler_param`, `cron_expression`, `retry_count`, `retry_interval`, `monitor_timeout`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (25, '访问日志清理 Job', 2, 'accessLogCleanJob', '', '0 0 0 * * ?', 3, 0, 0, '1', '2023-10-03 10:59:41', '1', '2024-10-30 14:12:22', b'0');
INSERT INTO `infra_job` (`id`, `name`, `status`, `handler_name`, `handler_param`, `cron_expression`, `retry_count`, `retry_interval`, `monitor_timeout`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (26, '错误日志清理 Job', 2, 'errorLogCleanJob', '', '0 0 0 * * ?', 3, 0, 0, '1', '2023-10-03 11:00:43', '1', '2023-10-03 11:01:12', b'0');
INSERT INTO `infra_job` (`id`, `name`, `status`, `handler_name`, `handler_param`, `cron_expression`, `retry_count`, `retry_interval`, `monitor_timeout`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (27, '任务日志清理 Job', 2, 'jobLogCleanJob', '', '0 0 0 * * ?', 3, 0, 0, '1', '2023-10-03 11:01:33', '1', '2023-10-03 11:01:42', b'0');
COMMIT;

-- ----------------------------
-- Table structure for infra_job_log
-- ----------------------------
DROP TABLE IF EXISTS `infra_job_log`;
CREATE TABLE `infra_job_log` (
                                 `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志编号',
                                 `job_id` bigint(20) NOT NULL COMMENT '任务编号',
                                 `handler_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '处理器的名字',
                                 `handler_param` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '处理器的参数',
                                 `execute_index` tinyint(4) NOT NULL DEFAULT '1' COMMENT '第几次执行',
                                 `begin_time` datetime NOT NULL COMMENT '开始执行时间',
                                 `end_time` datetime DEFAULT NULL COMMENT '结束执行时间',
                                 `duration` int(11) DEFAULT NULL COMMENT '执行时长',
                                 `status` tinyint(4) NOT NULL COMMENT '任务状态',
                                 `result` varchar(4000) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '结果数据',
                                 `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                 `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                 `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=395 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='定时任务日志表';

-- ----------------------------
-- Records of infra_job_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for system_dept
-- ----------------------------
DROP TABLE IF EXISTS `system_dept`;
CREATE TABLE `system_dept` (
                               `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
                               `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '部门名称',
                               `parent_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '父部门id',
                               `sort` int(11) NOT NULL DEFAULT '0' COMMENT '显示顺序',
                               `leader_user_id` bigint(20) DEFAULT NULL COMMENT '负责人',
                               `phone` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
                               `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
                               `status` tinyint(4) NOT NULL COMMENT '部门状态（0正常 1停用）',
                               `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                               `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                               `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                               `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                               `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                               `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='部门表';

-- ----------------------------
-- Records of system_dept
-- ----------------------------
BEGIN;
INSERT INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (100, '数可安', 0, 0, 1, '15888888888', 'qq@qq.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2024-10-30 14:06:35', b'0', 1);
INSERT INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (101, '北京总公司', 100, 1, 104, '15888888888', 'qq@qq.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2024-10-30 14:07:32', b'0', 1);
INSERT INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (102, '上海分公司', 100, 2, NULL, '15888888888', 'qq@qq.com', 0, 'admin', '2021-01-05 17:03:47', '', '2024-10-30 14:07:32', b'0', 1);
INSERT INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (103, '研发部门', 101, 1, 104, '15888888888', 'qq@qq.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2024-10-30 14:07:32', b'0', 1);
INSERT INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (104, '市场部门', 101, 2, NULL, '15888888888', 'qq@qq.com', 0, 'admin', '2021-01-05 17:03:47', '', '2024-10-30 14:07:32', b'0', 1);
INSERT INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (105, '测试部门', 101, 3, NULL, '15888888888', 'qq@qq.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2024-10-30 14:07:32', b'0', 1);
INSERT INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (106, '财务部门', 101, 4, 103, '15888888888', 'qq@qq.com', 0, 'admin', '2021-01-05 17:03:47', '103', '2024-10-30 14:07:32', b'0', 1);
INSERT INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (107, '运维部门', 101, 5, 1, '15888888888', 'qq@qq.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2024-10-30 14:07:32', b'0', 1);
INSERT INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (108, '市场部门', 102, 1, NULL, '15888888888', 'qq@qq.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2024-10-30 14:07:32', b'0', 1);
INSERT INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (109, '财务部门', 102, 2, NULL, '15888888888', 'qq@qq.com', 0, 'admin', '2021-01-05 17:03:47', '', '2024-10-30 14:07:32', b'0', 1);
INSERT INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (110, '产品部门', 101, 100, 1, NULL, 'qq@qq.com', 1, '1', '2023-12-02 09:45:13', '1', '2024-10-30 14:07:32', b'0', 1);
INSERT INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (111, '支持部门', 102, 3, 104, NULL, 'qq@qq.com', 1, '1', '2023-12-02 09:47:38', '1', '2024-10-30 14:07:32', b'0', 1);
COMMIT;

-- ----------------------------
-- Table structure for system_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `system_dict_data`;
CREATE TABLE `system_dict_data` (
                                    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
                                    `sort` int(11) NOT NULL DEFAULT '0' COMMENT '字典排序',
                                    `label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典标签',
                                    `value` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典键值',
                                    `dict_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典类型',
                                    `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
                                    `color_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '颜色类型',
                                    `css_class` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'css 样式',
                                    `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                    `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1588 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='字典数据表';

-- ----------------------------
-- Records of system_dict_data
-- ----------------------------
BEGIN;
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1, 1, '男', '1', 'system_user_sex', 0, 'default', 'A', '性别男', 'admin', '2021-01-05 17:03:48', '1', '2022-03-29 00:14:39', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2, 2, '女', '2', 'system_user_sex', 0, 'success', '', '性别女', 'admin', '2021-01-05 17:03:48', '1', '2023-11-15 23:30:37', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (8, 1, '正常', '1', 'infra_job_status', 0, 'success', '', '正常状态', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 19:33:38', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (9, 2, '暂停', '2', 'infra_job_status', 0, 'danger', '', '停用状态', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 19:33:45', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (12, 1, '系统内置', '1', 'infra_config_type', 0, 'danger', '', '参数类型 - 系统内置', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 19:06:02', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (13, 2, '自定义', '2', 'infra_config_type', 0, 'primary', '', '参数类型 - 自定义', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 19:06:07', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (14, 1, '通知', '1', 'system_notice_type', 0, 'success', '', '通知', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 13:05:57', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (15, 2, '公告', '2', 'system_notice_type', 0, 'info', '', '公告', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 13:06:01', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (16, 0, '其它', '0', 'infra_operate_type', 0, 'default', '', '其它操作', 'admin', '2021-01-05 17:03:48', '1', '2024-03-14 12:44:19', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (17, 1, '查询', '1', 'infra_operate_type', 0, 'info', '', '查询操作', 'admin', '2021-01-05 17:03:48', '1', '2024-03-14 12:44:20', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (18, 2, '新增', '2', 'infra_operate_type', 0, 'primary', '', '新增操作', 'admin', '2021-01-05 17:03:48', '1', '2024-03-14 12:44:21', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (19, 3, '修改', '3', 'infra_operate_type', 0, 'warning', '', '修改操作', 'admin', '2021-01-05 17:03:48', '1', '2024-03-14 12:44:22', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (20, 4, '删除', '4', 'infra_operate_type', 0, 'danger', '', '删除操作', 'admin', '2021-01-05 17:03:48', '1', '2024-03-14 12:44:23', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (22, 5, '导出', '5', 'infra_operate_type', 0, 'default', '', '导出操作', 'admin', '2021-01-05 17:03:48', '1', '2024-03-14 12:44:24', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (23, 6, '导入', '6', 'infra_operate_type', 0, 'default', '', '导入操作', 'admin', '2021-01-05 17:03:48', '1', '2024-03-14 12:44:25', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (27, 1, '开启', '0', 'common_status', 0, 'primary', '', '开启状态', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 08:00:39', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (28, 2, '关闭', '1', 'common_status', 0, 'info', '', '关闭状态', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 08:00:44', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (29, 1, '目录', '1', 'system_menu_type', 0, '', '', '目录', 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:43:45', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (30, 2, '菜单', '2', 'system_menu_type', 0, '', '', '菜单', 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:43:41', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (31, 3, '按钮', '3', 'system_menu_type', 0, '', '', '按钮', 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:43:39', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (32, 1, '内置', '1', 'system_role_type', 0, 'danger', '', '内置角色', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 13:02:08', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (33, 2, '自定义', '2', 'system_role_type', 0, 'primary', '', '自定义角色', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 13:02:12', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (34, 1, '全部数据权限', '1', 'system_data_scope', 0, '', '', '全部数据权限', 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:47:17', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (35, 2, '指定部门数据权限', '2', 'system_data_scope', 0, '', '', '指定部门数据权限', 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:47:18', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (36, 3, '本部门数据权限', '3', 'system_data_scope', 0, '', '', '本部门数据权限', 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:47:16', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (37, 4, '本部门及以下数据权限', '4', 'system_data_scope', 0, '', '', '本部门及以下数据权限', 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:47:21', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (38, 5, '仅本人数据权限', '5', 'system_data_scope', 0, '', '', '仅本人数据权限', 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:47:23', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (39, 0, '成功', '0', 'system_login_result', 0, 'success', '', '登陆结果 - 成功', '', '2021-01-18 06:17:36', '1', '2022-02-16 13:23:49', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (40, 10, '账号或密码不正确', '10', 'system_login_result', 0, 'primary', '', '登陆结果 - 账号或密码不正确', '', '2021-01-18 06:17:54', '1', '2022-02-16 13:24:27', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (41, 20, '用户被禁用', '20', 'system_login_result', 0, 'warning', '', '登陆结果 - 用户被禁用', '', '2021-01-18 06:17:54', '1', '2022-02-16 13:23:57', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (42, 30, '验证码不存在', '30', 'system_login_result', 0, 'info', '', '登陆结果 - 验证码不存在', '', '2021-01-18 06:17:54', '1', '2022-02-16 13:24:07', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (43, 31, '验证码不正确', '31', 'system_login_result', 0, 'info', '', '登陆结果 - 验证码不正确', '', '2021-01-18 06:17:54', '1', '2022-02-16 13:24:11', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (44, 100, '未知异常', '100', 'system_login_result', 0, 'danger', '', '登陆结果 - 未知异常', '', '2021-01-18 06:17:54', '1', '2022-02-16 13:24:23', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (45, 1, '是', 'true', 'infra_boolean_string', 0, 'danger', '', 'Boolean 是否类型 - 是', '', '2021-01-19 03:20:55', '1', '2022-03-15 23:01:45', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (46, 1, '否', 'false', 'infra_boolean_string', 0, 'info', '', 'Boolean 是否类型 - 否', '', '2021-01-19 03:20:55', '1', '2022-03-15 23:09:45', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (50, 1, '单表（增删改查）', '1', 'infra_codegen_template_type', 0, '', '', NULL, '', '2021-02-05 07:09:06', '', '2022-03-10 16:33:15', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (51, 2, '树表（增删改查）', '2', 'infra_codegen_template_type', 0, '', '', NULL, '', '2021-02-05 07:14:46', '', '2022-03-10 16:33:19', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (53, 0, '初始化中', '0', 'infra_job_status', 0, 'primary', '', NULL, '', '2021-02-07 07:46:49', '1', '2022-02-16 19:33:29', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (57, 0, '运行中', '0', 'infra_job_log_status', 0, 'primary', '', 'RUNNING', '', '2021-02-08 10:04:24', '1', '2022-02-16 19:07:48', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (58, 1, '成功', '1', 'infra_job_log_status', 0, 'success', '', NULL, '', '2021-02-08 10:06:57', '1', '2022-02-16 19:07:52', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (59, 2, '失败', '2', 'infra_job_log_status', 0, 'warning', '', '失败', '', '2021-02-08 10:07:38', '1', '2022-02-16 19:07:56', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (60, 1, '会员', '1', 'user_type', 0, 'primary', '', NULL, '', '2021-02-26 00:16:27', '1', '2022-02-16 10:22:19', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (61, 2, '管理员', '2', 'user_type', 0, 'success', '', NULL, '', '2021-02-26 00:16:34', '1', '2022-02-16 10:22:22', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (62, 0, '未处理', '0', 'infra_api_error_log_process_status', 0, 'primary', '', NULL, '', '2021-02-26 07:07:19', '1', '2022-02-16 20:14:17', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (63, 1, '已处理', '1', 'infra_api_error_log_process_status', 0, 'success', '', NULL, '', '2021-02-26 07:07:26', '1', '2022-02-16 20:14:08', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (64, 2, '已忽略', '2', 'infra_api_error_log_process_status', 0, 'danger', '', NULL, '', '2021-02-26 07:07:34', '1', '2022-02-16 20:14:14', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (66, 1, '阿里云', 'ALIYUN', 'system_sms_channel_code', 0, 'primary', '', NULL, '1', '2021-04-05 01:05:26', '1', '2024-07-22 22:23:25', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (67, 1, '验证码', '1', 'system_sms_template_type', 0, 'warning', '', NULL, '1', '2021-04-05 21:50:57', '1', '2022-02-16 12:48:30', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (68, 2, '通知', '2', 'system_sms_template_type', 0, 'primary', '', NULL, '1', '2021-04-05 21:51:08', '1', '2022-02-16 12:48:27', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (69, 0, '营销', '3', 'system_sms_template_type', 0, 'danger', '', NULL, '1', '2021-04-05 21:51:15', '1', '2022-02-16 12:48:22', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (70, 0, '初始化', '0', 'system_sms_send_status', 0, 'primary', '', NULL, '1', '2021-04-11 20:18:33', '1', '2022-02-16 10:26:07', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (71, 1, '发送成功', '10', 'system_sms_send_status', 0, 'success', '', NULL, '1', '2021-04-11 20:18:43', '1', '2022-02-16 10:25:56', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (72, 2, '发送失败', '20', 'system_sms_send_status', 0, 'danger', '', NULL, '1', '2021-04-11 20:18:49', '1', '2022-02-16 10:26:03', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (73, 3, '不发送', '30', 'system_sms_send_status', 0, 'info', '', NULL, '1', '2021-04-11 20:19:44', '1', '2022-02-16 10:26:10', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (74, 0, '等待结果', '0', 'system_sms_receive_status', 0, 'primary', '', NULL, '1', '2021-04-11 20:27:43', '1', '2022-02-16 10:28:24', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (75, 1, '接收成功', '10', 'system_sms_receive_status', 0, 'success', '', NULL, '1', '2021-04-11 20:29:25', '1', '2022-02-16 10:28:28', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (76, 2, '接收失败', '20', 'system_sms_receive_status', 0, 'danger', '', NULL, '1', '2021-04-11 20:29:31', '1', '2022-02-16 10:28:32', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (77, 0, '调试(钉钉)', 'DEBUG_DING_TALK', 'system_sms_channel_code', 0, 'info', '', NULL, '1', '2021-04-13 00:20:37', '1', '2022-02-16 10:10:00', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (80, 100, '账号登录', '100', 'system_login_type', 0, 'primary', '', '账号登录', '1', '2021-10-06 00:52:02', '1', '2022-02-16 13:11:34', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (81, 101, '社交登录', '101', 'system_login_type', 0, 'info', '', '社交登录', '1', '2021-10-06 00:52:17', '1', '2022-02-16 13:11:40', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (83, 200, '主动登出', '200', 'system_login_type', 0, 'primary', '', '主动登出', '1', '2021-10-06 00:52:58', '1', '2022-02-16 13:11:49', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (85, 202, '强制登出', '202', 'system_login_type', 0, 'danger', '', '强制退出', '1', '2021-10-06 00:53:41', '1', '2022-02-16 13:11:57', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1145, 1, '管理后台', '1', 'infra_codegen_scene', 0, '', '', '代码生成的场景枚举 - 管理后台', '1', '2022-02-02 13:15:06', '1', '2022-03-10 16:32:59', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1146, 2, '用户 APP', '2', 'infra_codegen_scene', 0, '', '', '代码生成的场景枚举 - 用户 APP', '1', '2022-02-02 13:15:19', '1', '2022-03-10 16:33:03', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1150, 1, '数据库', '1', 'infra_file_storage', 0, 'default', '', NULL, '1', '2022-03-15 00:25:28', '1', '2022-03-15 00:25:28', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1151, 10, '本地磁盘', '10', 'infra_file_storage', 0, 'default', '', NULL, '1', '2022-03-15 00:25:41', '1', '2022-03-15 00:25:56', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1152, 11, 'FTP 服务器', '11', 'infra_file_storage', 0, 'default', '', NULL, '1', '2022-03-15 00:26:06', '1', '2022-03-15 00:26:10', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1153, 12, 'SFTP 服务器', '12', 'infra_file_storage', 0, 'default', '', NULL, '1', '2022-03-15 00:26:22', '1', '2022-03-15 00:26:22', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1154, 20, 'S3 对象存储', '20', 'infra_file_storage', 0, 'default', '', NULL, '1', '2022-03-15 00:26:31', '1', '2022-03-15 00:26:45', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1155, 103, '短信登录', '103', 'system_login_type', 0, 'default', '', NULL, '1', '2022-05-09 23:57:58', '1', '2022-05-09 23:58:09', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1156, 1, 'password', 'password', 'system_oauth2_grant_type', 0, 'default', '', '密码模式', '1', '2022-05-12 00:22:05', '1', '2022-05-11 16:26:01', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1157, 2, 'authorization_code', 'authorization_code', 'system_oauth2_grant_type', 0, 'primary', '', '授权码模式', '1', '2022-05-12 00:22:59', '1', '2022-05-11 16:26:02', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1158, 3, 'implicit', 'implicit', 'system_oauth2_grant_type', 0, 'success', '', '简化模式', '1', '2022-05-12 00:23:40', '1', '2022-05-11 16:26:05', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1159, 4, 'client_credentials', 'client_credentials', 'system_oauth2_grant_type', 0, 'default', '', '客户端模式', '1', '2022-05-12 00:23:51', '1', '2022-05-11 16:26:08', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1160, 5, 'refresh_token', 'refresh_token', 'system_oauth2_grant_type', 0, 'info', '', '刷新模式', '1', '2022-05-12 00:24:02', '1', '2022-05-11 16:26:11', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1194, 10, '微信小程序', '10', 'terminal', 0, 'default', '', '终端 - 微信小程序', '1', '2022-12-10 10:51:11', '1', '2022-12-10 10:51:57', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1195, 20, 'H5 网页', '20', 'terminal', 0, 'default', '', '终端 - H5 网页', '1', '2022-12-10 10:51:30', '1', '2022-12-10 10:51:59', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1196, 11, '微信公众号', '11', 'terminal', 0, 'default', '', '终端 - 微信公众号', '1', '2022-12-10 10:54:16', '1', '2022-12-10 10:52:01', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1197, 31, '苹果 App', '31', 'terminal', 0, 'default', '', '终端 - 苹果 App', '1', '2022-12-10 10:54:42', '1', '2022-12-10 10:52:18', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1198, 32, '安卓 App', '32', 'terminal', 0, 'default', '', '终端 - 安卓 App', '1', '2022-12-10 10:55:02', '1', '2022-12-10 10:59:17', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1223, 0, '初始化', '0', 'system_mail_send_status', 0, 'primary', '', '邮件发送状态 - 初始化\n', '1', '2023-01-26 09:53:49', '1', '2023-01-26 16:36:14', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1224, 10, '发送成功', '10', 'system_mail_send_status', 0, 'success', '', '邮件发送状态 - 发送成功', '1', '2023-01-26 09:54:28', '1', '2023-01-26 16:36:22', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1225, 20, '发送失败', '20', 'system_mail_send_status', 0, 'danger', '', '邮件发送状态 - 发送失败', '1', '2023-01-26 09:54:50', '1', '2023-01-26 16:36:26', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1226, 30, '不发送', '30', 'system_mail_send_status', 0, 'info', '', '邮件发送状态 -  不发送', '1', '2023-01-26 09:55:06', '1', '2023-01-26 16:36:36', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1227, 1, '通知公告', '1', 'system_notify_template_type', 0, 'primary', '', '站内信模版的类型 - 通知公告', '1', '2023-01-28 10:35:59', '1', '2023-01-28 10:35:59', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1228, 2, '系统消息', '2', 'system_notify_template_type', 0, 'success', '', '站内信模版的类型 - 系统消息', '1', '2023-01-28 10:36:20', '1', '2023-01-28 10:36:25', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1231, 10, 'Vue2 Element UI 标准模版', '10', 'infra_codegen_front_type', 0, '', '', '', '1', '2023-04-13 00:03:55', '1', '2023-04-13 00:03:55', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1232, 20, 'Vue3 Element Plus 标准模版', '20', 'infra_codegen_front_type', 0, '', '', '', '1', '2023-04-13 00:04:08', '1', '2023-04-13 00:04:08', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1233, 21, 'Vue3 Element Plus Schema 模版', '21', 'infra_codegen_front_type', 0, '', '', '', '1', '2023-04-13 00:04:26', '1', '2023-04-13 00:04:26', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1234, 30, 'Vue3 vben 模版', '30', 'infra_codegen_front_type', 0, '', '', '', '1', '2023-04-13 00:04:26', '1', '2023-04-13 00:04:26', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1435, 10, 'Gitee', '10', 'system_social_type', 0, '', '', '', '1', '2023-11-04 13:04:42', '1', '2023-11-04 13:04:42', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1436, 20, '钉钉', '20', 'system_social_type', 0, '', '', '', '1', '2023-11-04 13:04:54', '1', '2023-11-04 13:04:54', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1437, 30, '企业微信', '30', 'system_social_type', 0, '', '', '', '1', '2023-11-04 13:05:09', '1', '2023-11-04 13:05:09', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1438, 31, '微信公众平台', '31', 'system_social_type', 0, '', '', '', '1', '2023-11-04 13:05:18', '1', '2023-11-04 13:05:18', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1439, 32, '微信开放平台', '32', 'system_social_type', 0, '', '', '', '1', '2023-11-04 13:05:30', '1', '2023-11-04 13:05:30', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1440, 34, '微信小程序', '34', 'system_social_type', 0, '', '', '', '1', '2023-11-04 13:05:38', '1', '2023-11-04 13:07:16', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1443, 15, '子表', '15', 'infra_codegen_template_type', 0, 'default', '', '', '1', '2023-11-13 23:06:16', '1', '2023-11-13 23:06:16', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1444, 10, '主表（标准模式）', '10', 'infra_codegen_template_type', 0, 'default', '', '', '1', '2023-11-14 12:32:49', '1', '2023-11-14 12:32:49', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1445, 11, '主表（ERP 模式）', '11', 'infra_codegen_template_type', 0, 'default', '', '', '1', '2023-11-14 12:33:05', '1', '2023-11-14 12:33:05', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1446, 12, '主表（内嵌模式）', '12', 'infra_codegen_template_type', 0, '', '', '', '1', '2023-11-14 12:33:31', '1', '2023-11-14 12:33:31', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1529, 1, '天', '1', 'date_interval', 0, '', '', '', '1', '2024-03-29 22:50:26', '1', '2024-03-29 22:50:26', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1530, 2, '周', '2', 'date_interval', 0, '', '', '', '1', '2024-03-29 22:50:36', '1', '2024-03-29 22:50:36', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1531, 3, '月', '3', 'date_interval', 0, '', '', '', '1', '2024-03-29 22:50:46', '1', '2024-03-29 22:50:54', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1532, 4, '季度', '4', 'date_interval', 0, '', '', '', '1', '2024-03-29 22:51:01', '1', '2024-03-29 22:51:01', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1533, 5, '年', '5', 'date_interval', 0, '', '', '', '1', '2024-03-29 22:51:07', '1', '2024-03-29 22:51:07', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1586, 2, '腾讯云', 'TENCENT', 'system_sms_channel_code', 0, '', '', '', '1', '2024-07-22 22:23:16', '1', '2024-07-22 22:23:16', b'0');
INSERT INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1587, 3, '华为云', 'HUAWEI', 'system_sms_channel_code', 0, '', '', '', '1', '2024-07-22 22:23:46', '1', '2024-07-22 22:23:53', b'0');
COMMIT;

-- ----------------------------
-- Table structure for system_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `system_dict_type`;
CREATE TABLE `system_dict_type` (
                                    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
                                    `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典名称',
                                    `type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典类型',
                                    `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
                                    `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                    `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                    `deleted_time` datetime DEFAULT NULL COMMENT '删除时间',
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=629 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='字典类型表';

-- ----------------------------
-- Records of system_dict_type
-- ----------------------------
BEGIN;
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (1, '用户性别', 'system_user_sex', 0, NULL, 'admin', '2021-01-05 17:03:48', '1', '2022-05-16 20:29:32', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (6, '参数类型', 'infra_config_type', 0, NULL, 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:36:54', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (7, '通知类型', 'system_notice_type', 0, NULL, 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:35:26', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (9, '操作类型', 'infra_operate_type', 0, NULL, 'admin', '2021-01-05 17:03:48', '1', '2024-03-14 12:44:01', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (10, '系统状态', 'common_status', 0, NULL, 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:21:28', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (11, 'Boolean 是否类型', 'infra_boolean_string', 0, 'boolean 转是否', '', '2021-01-19 03:20:08', '', '2022-02-01 16:37:10', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (104, '登陆结果', 'system_login_result', 0, '登陆结果', '', '2021-01-18 06:17:11', '', '2022-02-01 16:36:00', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (106, '代码生成模板类型', 'infra_codegen_template_type', 0, NULL, '', '2021-02-05 07:08:06', '1', '2022-05-16 20:26:50', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (107, '定时任务状态', 'infra_job_status', 0, NULL, '', '2021-02-07 07:44:16', '', '2022-02-01 16:51:11', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (108, '定时任务日志状态', 'infra_job_log_status', 0, NULL, '', '2021-02-08 10:03:51', '', '2022-02-01 16:50:43', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (109, '用户类型', 'user_type', 0, NULL, '', '2021-02-26 00:15:51', '', '2021-02-26 00:15:51', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (110, 'API 异常数据的处理状态', 'infra_api_error_log_process_status', 0, NULL, '', '2021-02-26 07:07:01', '', '2022-02-01 16:50:53', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (111, '短信渠道编码', 'system_sms_channel_code', 0, NULL, '1', '2021-04-05 01:04:50', '1', '2022-02-16 02:09:08', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (112, '短信模板的类型', 'system_sms_template_type', 0, NULL, '1', '2021-04-05 21:50:43', '1', '2022-02-01 16:35:06', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (113, '短信发送状态', 'system_sms_send_status', 0, NULL, '1', '2021-04-11 20:18:03', '1', '2022-02-01 16:35:09', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (114, '短信接收状态', 'system_sms_receive_status', 0, NULL, '1', '2021-04-11 20:27:14', '1', '2022-02-01 16:35:14', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (116, '登陆日志的类型', 'system_login_type', 0, '登陆日志的类型', '1', '2021-10-06 00:50:46', '1', '2022-02-01 16:35:56', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (144, '代码生成的场景枚举', 'infra_codegen_scene', 0, '代码生成的场景枚举', '1', '2022-02-02 13:14:45', '1', '2022-03-10 16:33:46', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (145, '角色类型', 'system_role_type', 0, '角色类型', '1', '2022-02-16 13:01:46', '1', '2022-02-16 13:01:46', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (146, '文件存储器', 'infra_file_storage', 0, '文件存储器', '1', '2022-03-15 00:24:38', '1', '2022-03-15 00:24:38', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (147, 'OAuth 2.0 授权类型', 'system_oauth2_grant_type', 0, 'OAuth 2.0 授权类型（模式）', '1', '2022-05-12 00:20:52', '1', '2022-05-11 16:25:49', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (160, '终端', 'terminal', 0, '终端', '1', '2022-12-10 10:50:50', '1', '2022-12-10 10:53:11', b'0', NULL);
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (166, '邮件发送状态', 'system_mail_send_status', 0, '邮件发送状态', '1', '2023-01-26 09:53:13', '1', '2023-01-26 09:53:13', b'0', '1970-01-01 00:00:00');
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (167, '站内信模版的类型', 'system_notify_template_type', 0, '站内信模版的类型', '1', '2023-01-28 10:35:10', '1', '2023-01-28 10:35:10', b'0', '1970-01-01 00:00:00');
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (168, '代码生成的前端类型', 'infra_codegen_front_type', 0, '', '1', '2023-04-12 23:57:52', '1', '2023-04-12 23:57:52', b'0', '1970-01-01 00:00:00');
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (601, '社交类型', 'system_social_type', 0, '', '1', '2023-11-04 13:03:54', '1', '2023-11-04 13:03:54', b'0', '1970-01-01 00:00:00');
INSERT INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (616, '时间间隔', 'date_interval', 0, '', '1', '2024-03-29 22:50:09', '1', '2024-03-29 22:50:09', b'0', '1970-01-01 00:00:00');
COMMIT;

-- ----------------------------
-- Table structure for system_login_log
-- ----------------------------
DROP TABLE IF EXISTS `system_login_log`;
CREATE TABLE `system_login_log` (
                                    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
                                    `log_type` bigint(20) NOT NULL COMMENT '日志类型',
                                    `trace_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '链路追踪编号',
                                    `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户编号',
                                    `user_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户类型',
                                    `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户账号',
                                    `result` tinyint(4) NOT NULL COMMENT '登陆结果',
                                    `user_ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户 IP',
                                    `user_agent` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '浏览器 UA',
                                    `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                    `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统访问记录';

-- ----------------------------
-- Records of system_login_log
-- ----------------------------
BEGIN;
INSERT INTO `system_login_log` (`id`, `log_type`, `trace_id`, `user_id`, `user_type`, `username`, `result`, `user_ip`, `user_agent`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1, 100, '', 1, 2, 'admin', 0, '172.16.30.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', NULL, '2024-11-07 14:27:16', NULL, '2024-11-07 14:27:16', b'0', 0);
COMMIT;

-- ----------------------------
-- Table structure for system_mail_account
-- ----------------------------
DROP TABLE IF EXISTS `system_mail_account`;
CREATE TABLE `system_mail_account` (
                                       `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
                                       `mail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
                                       `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
                                       `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
                                       `host` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'SMTP 服务器域名',
                                       `port` int(11) NOT NULL COMMENT 'SMTP 服务器端口',
                                       `ssl_enable` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否开启 SSL',
                                       `starttls_enable` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否开启 STARTTLS',
                                       `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                       `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                       `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                       `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                       `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='邮箱账号表';

-- ----------------------------
-- Records of system_mail_account
-- ----------------------------
BEGIN;
INSERT INTO `system_mail_account` (`id`, `mail`, `username`, `password`, `host`, `port`, `ssl_enable`, `starttls_enable`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1, '123@qq.com', '123@qq.com', '1234576', '127.0.0.1', 8080, b'0', b'0', '1', '2023-01-25 17:39:52', '1', '2024-10-30 11:19:40', b'0');
INSERT INTO `system_mail_account` (`id`, `mail`, `username`, `password`, `host`, `port`, `ssl_enable`, `starttls_enable`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2, 'test@163.com', 'test@163.com', 'testtesttesttesttest', 'smtp.163.com', 465, b'1', b'0', '1', '2023-01-26 01:26:03', '1', '2024-10-30 11:19:26', b'0');
COMMIT;

-- ----------------------------
-- Table structure for system_mail_log
-- ----------------------------
DROP TABLE IF EXISTS `system_mail_log`;
CREATE TABLE `system_mail_log` (
                                   `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                   `user_id` bigint(20) DEFAULT NULL COMMENT '用户编号',
                                   `user_type` tinyint(4) DEFAULT NULL COMMENT '用户类型',
                                   `to_mail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '接收邮箱地址',
                                   `account_id` bigint(20) NOT NULL COMMENT '邮箱账号编号',
                                   `from_mail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发送邮箱地址',
                                   `template_id` bigint(20) NOT NULL COMMENT '模板编号',
                                   `template_code` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
                                   `template_nickname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模版发送人名称',
                                   `template_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮件标题',
                                   `template_content` varchar(10240) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮件内容',
                                   `template_params` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮件参数',
                                   `send_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '发送状态',
                                   `send_time` datetime DEFAULT NULL COMMENT '发送时间',
                                   `send_message_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发送返回的消息 ID',
                                   `send_exception` varchar(4096) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发送异常',
                                   `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                   `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                   `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                   `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                   `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=356 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='邮件日志表';

-- ----------------------------
-- Records of system_mail_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for system_mail_template
-- ----------------------------
DROP TABLE IF EXISTS `system_mail_template`;
CREATE TABLE `system_mail_template` (
                                        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                        `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板名称',
                                        `code` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
                                        `account_id` bigint(20) NOT NULL COMMENT '发送的邮箱账号编号',
                                        `nickname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发送人名称',
                                        `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板标题',
                                        `content` varchar(10240) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板内容',
                                        `params` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数数组',
                                        `status` tinyint(4) NOT NULL COMMENT '开启状态',
                                        `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                        `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                        `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                        `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                        `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                        `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                        PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='邮件模版表';

-- ----------------------------
-- Records of system_mail_template
-- ----------------------------
BEGIN;
INSERT INTO `system_mail_template` (`id`, `name`, `code`, `account_id`, `nickname`, `title`, `content`, `params`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (13, '后台用户短信登录', 'admin-sms-login', 1, '奥特曼', '你猜我猜', '<p>您的验证码是{code}，名字是{name}</p>', '[\"code\",\"name\"]', 0, '3', '1', '2021-10-11 08:10:00', '1', '2023-12-02 19:51:14', b'0');
INSERT INTO `system_mail_template` (`id`, `name`, `code`, `account_id`, `nickname`, `title`, `content`, `params`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (14, '测试模版', 'test_01', 2, '芋艿', '一个标题', '<p>你是 {key01} 吗？</p><p><br></p><p>是的话，赶紧 {key02} 一下！</p>', '[\"key01\",\"key02\"]', 0, NULL, '1', '2023-01-26 01:27:40', '1', '2023-01-27 10:32:16', b'0');
INSERT INTO `system_mail_template` (`id`, `name`, `code`, `account_id`, `nickname`, `title`, `content`, `params`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (15, '3', '2', 2, '7', '4', '<p>45</p>', '[]', 1, '80', '1', '2023-01-27 15:50:35', '1', '2023-01-27 16:34:49', b'0');
COMMIT;

-- ----------------------------
-- Table structure for system_menu
-- ----------------------------
DROP TABLE IF EXISTS `system_menu`;
CREATE TABLE `system_menu` (
                               `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
                               `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单名称',
                               `permission` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '权限标识',
                               `type` tinyint(4) NOT NULL COMMENT '菜单类型',
                               `sort` int(11) NOT NULL DEFAULT '0' COMMENT '显示顺序',
                               `parent_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '父菜单ID',
                               `path` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '路由地址',
                               `icon` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '#' COMMENT '菜单图标',
                               `component` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组件路径',
                               `component_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组件名',
                               `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '菜单状态',
                               `visible` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否可见',
                               `keep_alive` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否缓存',
                               `always_show` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否总是显示',
                               `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                               `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                               `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                               `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                               `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2823 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜单权限表';

-- ----------------------------
-- Records of system_menu
-- ----------------------------
BEGIN;
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1, '系统管理', '', 1, 10, 0, '/system', 'ep:tools', NULL, NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2024-06-18 01:19:41', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2, '基础设施', '', 1, 20, 0, '/infra', 'ep:monitor', NULL, NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2024-03-01 08:28:40', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (100, '用户管理', 'system:user:list', 2, 3, 1, 'user', 'ep:avatar', 'system/user/index', 'SystemUser', 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2024-10-30 11:13:34', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (101, '角色管理', '', 2, 4, 1, 'role', 'ep:user', 'system/role/index', 'SystemRole', 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2024-10-30 11:13:35', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (102, '菜单管理', '', 2, 5, 1, 'menu', 'ep:menu', 'system/menu/index', 'SystemMenu', 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2024-10-30 11:13:38', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (103, '部门管理', '', 2, 1, 1, 'dept', 'fa:address-card', 'system/dept/index', 'SystemDept', 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2024-10-30 11:13:28', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (104, '岗位管理', '', 2, 2, 1, 'post', 'fa:address-book-o', 'system/post/index', 'SystemPost', 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2024-10-30 11:13:31', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (116, 'API 接口', 'infra:swagger:list', 2, 3, 2, 'swagger', 'fa:fighter-jet', 'infra/swagger/index', 'InfraSwagger', 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2024-04-23 00:01:24', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1001, '用户查询', 'system:user:query', 3, 1, 100, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1002, '用户新增', 'system:user:create', 3, 2, 100, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1003, '用户修改', 'system:user:update', 3, 3, 100, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1004, '用户删除', 'system:user:delete', 3, 4, 100, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1005, '用户导出', 'system:user:export', 3, 5, 100, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1006, '用户导入', 'system:user:import', 3, 6, 100, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1007, '重置密码', 'system:user:update-password', 3, 7, 100, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1008, '角色查询', 'system:role:query', 3, 1, 101, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1009, '角色新增', 'system:role:create', 3, 2, 101, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1010, '角色修改', 'system:role:update', 3, 3, 101, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1011, '角色删除', 'system:role:delete', 3, 4, 101, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1012, '角色导出', 'system:role:export', 3, 5, 101, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1013, '菜单查询', 'system:menu:query', 3, 1, 102, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1014, '菜单新增', 'system:menu:create', 3, 2, 102, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1015, '菜单修改', 'system:menu:update', 3, 3, 102, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1016, '菜单删除', 'system:menu:delete', 3, 4, 102, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1017, '部门查询', 'system:dept:query', 3, 1, 103, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1018, '部门新增', 'system:dept:create', 3, 2, 103, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1019, '部门修改', 'system:dept:update', 3, 3, 103, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1020, '部门删除', 'system:dept:delete', 3, 4, 103, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1021, '岗位查询', 'system:post:query', 3, 1, 104, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1022, '岗位新增', 'system:post:create', 3, 2, 104, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1023, '岗位修改', 'system:post:update', 3, 3, 104, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1024, '岗位删除', 'system:post:delete', 3, 4, 104, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1025, '岗位导出', 'system:post:export', 3, 5, 104, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1063, '设置角色菜单权限', 'system:permission:assign-role-menu', 3, 6, 101, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-01-06 17:53:44', '', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1064, '设置角色数据权限', 'system:permission:assign-role-data-scope', 3, 7, 101, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-01-06 17:56:31', '', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1065, '设置用户角色', 'system:permission:assign-user-role', 3, 8, 101, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-01-07 10:23:28', '', '2022-04-20 17:03:10', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2798, '数据风险地图', '', 1, 1, 0, '/dataRiskMap', 'ep:aim', '', '', 0, b'1', b'1', b'1', '1', '2024-10-14 09:46:27', '1', '2024-10-15 14:22:34', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2801, '数据资产总览', '', 1, 1, 2798, 'dataAssets', 'ep:aim', '', '', 0, b'1', b'1', b'1', '1', '2024-10-15 14:24:55', '1', '2024-10-15 14:24:55', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2802, '资产探查', '', 2, 2, 2798, 'exploration', 'ep:aim', 'dataRiskMap/exploration/index', 'AssetExploration', 0, b'1', b'1', b'1', '1', '2024-10-15 14:30:28', '1', '2024-10-18 14:32:08', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2803, '资产管理', '', 2, 3, 2798, 'manage', 'ep:aim', 'dataRiskMap/manage/index', 'AssetManage', 0, b'1', b'1', b'1', '1', '2024-10-15 14:31:39', '1', '2024-10-18 14:32:26', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2804, '资产调度日志', 'dmap:scan:instance:query', 2, 4, 2798, 'exploration/log', '', 'dataRiskMap/exploration/logger/index', 'ExplorationLog', 0, b'0', b'1', b'0', '1', '2024-10-18 14:16:07', '1', '2024-10-30 15:34:32', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2805, '数据表', '', 2, 5, 2798, 'sheet', 'ep:aim', 'dataRiskMap/sheet/index', '', 0, b'1', b'1', b'1', '1', '2024-10-19 16:32:48', '1', '2024-10-19 16:32:48', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2806, '数据列', '', 2, 6, 2798, 'list', 'ep:aim', 'dataRiskMap/list/index', '', 0, b'1', b'1', b'1', '1', '2024-10-19 16:33:20', '1', '2024-10-19 16:33:20', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2807, '数据资产视图', '', 2, 1, 2801, 'dataAssets/preview', 'ep:aim', 'dataRiskMap/dataAssets/preview/index', 'DataPreview', 0, b'1', b'1', b'1', '1', '2024-10-15 14:26:31', '1', '2024-10-18 14:33:04', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2808, '数据风险视图', '', 2, 2, 2801, 'dataAssets/risk', 'ep:aim', 'dataRiskMap/dataAssets/risk/index', 'DataRisk', 0, b'1', b'1', b'1', '1', '2024-10-15 14:28:00', '1', '2024-10-18 14:33:12', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2809, '资产查询', 'dmap:database:query', 3, 1, 2803, '', '', '', '', 0, b'1', b'1', b'1', '1', '2024-10-30 15:18:00', '1', '2024-10-30 15:25:03', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2810, '资产新增', 'dmap:database:create', 3, 2, 2803, '', '', '', '', 0, b'1', b'1', b'1', '1', '2024-10-30 15:18:32', '1', '2024-10-30 15:18:32', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2811, ' 资产修改', 'dmap:database:update', 3, 3, 2803, '', '', '', '', 0, b'1', b'1', b'1', '1', '2024-10-30 15:18:50', '1', '2024-10-30 15:18:50', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2812, ' 资产删除', 'dmap:database:delete', 3, 4, 2803, '', '', '', '', 0, b'1', b'1', b'1', '1', '2024-10-30 15:19:12', '1', '2024-10-30 15:19:12', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2813, ' 资产同步', 'dmap:database:sync', 3, 5, 2803, '', '', '', '', 0, b'1', b'1', b'1', '1', '2024-10-30 15:19:28', '1', '2024-10-30 15:19:28', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2814, '数据表查询', 'dmap:table:query', 3, 1, 2805, '', '', '', '', 0, b'1', b'1', b'1', '1', '2024-10-30 15:20:34', '1', '2024-10-30 15:20:34', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2815, '字段列查询', 'dmap:column:query', 3, 1, 2806, '', '', '', '', 0, b'1', b'1', b'1', '1', '2024-10-30 15:21:57', '1', '2024-10-30 15:21:57', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2816, '探查任务查询', 'dmap:scan:query', 3, 1, 2802, '', '', '', '', 0, b'1', b'1', b'1', '1', '2024-10-30 15:27:08', '1', '2024-10-30 15:27:08', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2817, '探查任务新增', 'dmap:scan:create', 3, 2, 2802, '', '', '', '', 0, b'1', b'1', b'1', '1', '2024-10-30 15:27:27', '1', '2024-10-30 15:27:27', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2818, '探查任务修改', 'dmap:scan:update', 3, 3, 2802, '', '', '', '', 0, b'1', b'1', b'1', '1', '2024-10-30 15:28:09', '1', '2024-10-30 15:28:09', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2819, '探查状态修改', 'dmap:scan:update', 3, 4, 2802, '', '', '', '', 0, b'1', b'1', b'1', '1', '2024-10-30 15:28:24', '1', '2024-10-30 15:28:24', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2820, '探查任务删除', 'dmap:scan:delete', 3, 5, 2802, '', '', '', '', 0, b'1', b'1', b'1', '1', '2024-10-30 15:29:01', '1', '2024-10-30 15:29:01', b'0');
INSERT INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2821, '探查任务触发', 'dmap:scan:trigger', 3, 6, 2802, '', '', '', '', 0, b'1', b'1', b'1', '1', '2024-10-30 15:29:43', '1', '2024-10-30 15:29:43', b'0');
COMMIT;

-- ----------------------------
-- Table structure for system_notice
-- ----------------------------
DROP TABLE IF EXISTS `system_notice`;
CREATE TABLE `system_notice` (
                                 `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
                                 `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告标题',
                                 `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告内容',
                                 `type` tinyint(4) NOT NULL COMMENT '公告类型（1通知 2公告）',
                                 `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
                                 `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                 `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                 `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                 `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通知公告表';

-- ----------------------------
-- Records of system_notice
-- ----------------------------
BEGIN;
INSERT INTO `system_notice` (`id`, `title`, `content`, `type`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1, '测试标题', '<p>新版本内容133</p>', 1, 0, 'admin', '2021-01-05 17:03:48', '1', '2024-10-30 11:20:31', b'0', 1);
INSERT INTO `system_notice` (`id`, `title`, `content`, `type`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2, '维护通知：2018-07-01 系统凌晨维护', '<p><img src=\"http://test.yudao.iocoder.cn/b7cb3cf49b4b3258bf7309a09dd2f4e5.jpg\" alt=\"\" data-href=\"\" style=\"\"/>11112222</p>', 2, 1, 'admin', '2021-01-05 17:03:48', '1', '2023-12-02 20:07:26', b'0', 1);
INSERT INTO `system_notice` (`id`, `title`, `content`, `type`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (4, '我是测试标题', '<p>哈哈哈哈123</p>', 1, 0, '110', '2022-02-22 01:01:25', '110', '2022-02-22 01:01:46', b'0', 121);
COMMIT;

-- ----------------------------
-- Table structure for system_notify_message
-- ----------------------------
DROP TABLE IF EXISTS `system_notify_message`;
CREATE TABLE `system_notify_message` (
                                         `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
                                         `user_id` bigint(20) NOT NULL COMMENT '用户id',
                                         `user_type` tinyint(4) NOT NULL COMMENT '用户类型',
                                         `template_id` bigint(20) NOT NULL COMMENT '模版编号',
                                         `template_code` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
                                         `template_nickname` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版发送人名称',
                                         `template_content` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版内容',
                                         `template_type` int(11) NOT NULL COMMENT '模版类型',
                                         `template_params` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版参数',
                                         `read_status` bit(1) NOT NULL COMMENT '是否已读',
                                         `read_time` datetime DEFAULT NULL COMMENT '阅读时间',
                                         `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                         `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                         `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                         `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                         `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                         `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                         PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站内信消息表';

-- ----------------------------
-- Records of system_notify_message
-- ----------------------------
BEGIN;
INSERT INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2, 1, 2, 1, 'test', '123', '我是 1，我开始 2 了', 1, '{\"name\":\"1\",\"what\":\"2\"}', b'1', '2023-02-10 00:47:04', '1', '2023-01-28 11:44:08', '1', '2023-02-10 00:47:04', b'0', 1);
INSERT INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3, 1, 2, 1, 'test', '123', '我是 1，我开始 2 了', 1, '{\"name\":\"1\",\"what\":\"2\"}', b'1', '2023-02-10 00:47:04', '1', '2023-01-28 11:45:04', '1', '2023-02-10 00:47:04', b'0', 1);
INSERT INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (4, 103, 2, 2, 'register', '系统消息', '你好，欢迎 哈哈 加入大家庭！', 2, '{\"name\":\"哈哈\"}', b'0', NULL, '1', '2023-01-28 21:02:20', '1', '2023-01-28 21:02:20', b'0', 1);
COMMIT;

-- ----------------------------
-- Table structure for system_notify_template
-- ----------------------------
DROP TABLE IF EXISTS `system_notify_template`;
CREATE TABLE `system_notify_template` (
                                          `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
                                          `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板名称',
                                          `code` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版编码',
                                          `nickname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发送人名称',
                                          `content` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版内容',
                                          `type` tinyint(4) NOT NULL COMMENT '类型',
                                          `params` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数数组',
                                          `status` tinyint(4) NOT NULL COMMENT '状态',
                                          `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                          `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                          `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                          `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                          `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                          `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                          PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站内信模板表';

-- ----------------------------
-- Records of system_notify_template
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for system_oauth2_access_token
-- ----------------------------
DROP TABLE IF EXISTS `system_oauth2_access_token`;
CREATE TABLE `system_oauth2_access_token` (
                                              `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                              `user_id` bigint(20) NOT NULL COMMENT '用户编号',
                                              `user_type` tinyint(4) NOT NULL COMMENT '用户类型',
                                              `user_info` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户信息',
                                              `access_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '访问令牌',
                                              `refresh_token` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '刷新令牌',
                                              `client_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
                                              `scopes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '授权范围',
                                              `expires_time` datetime NOT NULL COMMENT '过期时间',
                                              `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                              `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                              `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                              `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                              `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                              `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                              PRIMARY KEY (`id`) USING BTREE,
                                              KEY `idx_access_token` (`access_token`) USING BTREE,
                                              KEY `idx_refresh_token` (`refresh_token`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 访问令牌';

-- ----------------------------
-- Records of system_oauth2_access_token
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for system_oauth2_approve
-- ----------------------------
DROP TABLE IF EXISTS `system_oauth2_approve`;
CREATE TABLE `system_oauth2_approve` (
                                         `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                         `user_id` bigint(20) NOT NULL COMMENT '用户编号',
                                         `user_type` tinyint(4) NOT NULL COMMENT '用户类型',
                                         `client_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
                                         `scope` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '授权范围',
                                         `approved` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否接受',
                                         `expires_time` datetime NOT NULL COMMENT '过期时间',
                                         `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                         `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                         `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                         `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                         `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                         `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                         PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 批准表';

-- ----------------------------
-- Records of system_oauth2_approve
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for system_oauth2_client
-- ----------------------------
DROP TABLE IF EXISTS `system_oauth2_client`;
CREATE TABLE `system_oauth2_client` (
                                        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                        `client_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
                                        `secret` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端密钥',
                                        `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
                                        `logo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用图标',
                                        `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '应用描述',
                                        `status` tinyint(4) NOT NULL COMMENT '状态',
                                        `access_token_validity_seconds` int(11) NOT NULL COMMENT '访问令牌的有效期',
                                        `refresh_token_validity_seconds` int(11) NOT NULL COMMENT '刷新令牌的有效期',
                                        `redirect_uris` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '可重定向的 URI 地址',
                                        `authorized_grant_types` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '授权类型',
                                        `scopes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '授权范围',
                                        `auto_approve_scopes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自动通过的授权范围',
                                        `authorities` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '权限',
                                        `resource_ids` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '资源',
                                        `additional_information` varchar(4096) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附加信息',
                                        `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                        `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                        `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                        `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                        `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                        PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 客户端表';

-- ----------------------------
-- Records of system_oauth2_client
-- ----------------------------
BEGIN;
INSERT INTO `system_oauth2_client` (`id`, `client_id`, `secret`, `name`, `logo`, `description`, `status`, `access_token_validity_seconds`, `refresh_token_validity_seconds`, `redirect_uris`, `authorized_grant_types`, `scopes`, `auto_approve_scopes`, `authorities`, `resource_ids`, `additional_information`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1, 'default', 'admin123', '系统源码', 'https://ww3.sinaimg.cn/mw690/006qavWfly1hrtfbb4jtvj312c11uq82.jpg', '我是描述', 0, 7776000, 15552000, '[\"http://127.0.0.1:48080\"]', '[\"password\",\"authorization_code\",\"implicit\",\"refresh_token\"]', '[\"user.read\",\"user.write\"]', '[]', '[\"user.read\",\"user.write\"]', '[]', '{}', '1', '2022-05-11 21:47:12', '1', '2024-10-30 11:33:12', b'0');
INSERT INTO `system_oauth2_client` (`id`, `client_id`, `secret`, `name`, `logo`, `description`, `status`, `access_token_validity_seconds`, `refresh_token_validity_seconds`, `redirect_uris`, `authorized_grant_types`, `scopes`, `auto_approve_scopes`, `authorities`, `resource_ids`, `additional_information`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (41, 'system-sso-demo-by-code', 'test', '基于授权码模式，如何实现 SSO 单点登录？', 'https://img2.baidu.com/it/u=1504791015,2700524207&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500', NULL, 0, 1800, 43200, '[\"http://127.0.0.1:18080\"]', '[\"authorization_code\",\"refresh_token\"]', '[\"user.read\",\"user.write\"]', '[]', '[]', '[]', NULL, '1', '2022-09-29 13:28:31', '1', '2024-10-30 11:37:05', b'0');
INSERT INTO `system_oauth2_client` (`id`, `client_id`, `secret`, `name`, `logo`, `description`, `status`, `access_token_validity_seconds`, `refresh_token_validity_seconds`, `redirect_uris`, `authorized_grant_types`, `scopes`, `auto_approve_scopes`, `authorities`, `resource_ids`, `additional_information`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (42, 'system-sso-demo-by-password', 'test', '基于密码模式，如何实现 SSO 单点登录？', 'https://img1.baidu.com/it/u=1845072333,2740626071&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500', NULL, 0, 1800, 43200, '[\"http://127.0.0.1:18080\"]', '[\"password\",\"refresh_token\"]', '[\"user.read\",\"user.write\"]', '[]', '[]', '[]', NULL, '1', '2022-10-04 17:40:16', '1', '2024-10-30 11:35:04', b'0');
COMMIT;

-- ----------------------------
-- Table structure for system_oauth2_code
-- ----------------------------
DROP TABLE IF EXISTS `system_oauth2_code`;
CREATE TABLE `system_oauth2_code` (
                                      `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                      `user_id` bigint(20) NOT NULL COMMENT '用户编号',
                                      `user_type` tinyint(4) NOT NULL COMMENT '用户类型',
                                      `code` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '授权码',
                                      `client_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
                                      `scopes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '授权范围',
                                      `expires_time` datetime NOT NULL COMMENT '过期时间',
                                      `redirect_uri` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '可重定向的 URI 地址',
                                      `state` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '状态',
                                      `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                      `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                      `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                      `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                      `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                      `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 授权码表';

-- ----------------------------
-- Records of system_oauth2_code
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for system_oauth2_refresh_token
-- ----------------------------
DROP TABLE IF EXISTS `system_oauth2_refresh_token`;
CREATE TABLE `system_oauth2_refresh_token` (
                                               `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                               `user_id` bigint(20) NOT NULL COMMENT '用户编号',
                                               `refresh_token` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '刷新令牌',
                                               `user_type` tinyint(4) NOT NULL COMMENT '用户类型',
                                               `client_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
                                               `scopes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '授权范围',
                                               `expires_time` datetime NOT NULL COMMENT '过期时间',
                                               `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                               `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                               `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                               `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                               `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                               `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                               PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1603 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 刷新令牌';

-- ----------------------------
-- Records of system_oauth2_refresh_token
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for system_operate_log
-- ----------------------------
DROP TABLE IF EXISTS `system_operate_log`;
CREATE TABLE `system_operate_log` (
                                      `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
                                      `trace_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '链路追踪编号',
                                      `user_id` bigint(20) NOT NULL COMMENT '用户编号',
                                      `user_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户类型',
                                      `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作模块类型',
                                      `sub_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作名',
                                      `biz_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作数据模块编号',
                                      `action` varchar(2000) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作内容',
                                      `extra` varchar(2000) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '拓展字段',
                                      `request_method` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '请求方法名',
                                      `request_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '请求地址',
                                      `user_ip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户 IP',
                                      `user_agent` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '浏览器 UA',
                                      `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                      `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                      `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                      `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                      `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                      `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作日志记录 V2 版本';

-- ----------------------------
-- Records of system_operate_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for system_post
-- ----------------------------
DROP TABLE IF EXISTS `system_post`;
CREATE TABLE `system_post` (
                               `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
                               `code` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位编码',
                               `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位名称',
                               `sort` int(11) NOT NULL COMMENT '显示顺序',
                               `status` tinyint(4) NOT NULL COMMENT '状态（0正常 1停用）',
                               `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                               `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                               `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                               `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                               `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                               `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                               `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='岗位信息表';

-- ----------------------------
-- Records of system_post
-- ----------------------------
BEGIN;
INSERT INTO `system_post` (`id`, `code`, `name`, `sort`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1, 'ceo', '董事长', 1, 0, '', 'admin', '2021-01-06 17:03:48', '1', '2023-02-11 15:19:04', b'0', 1);
INSERT INTO `system_post` (`id`, `code`, `name`, `sort`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2, 'se', '项目经理', 2, 0, '', 'admin', '2021-01-05 17:03:48', '1', '2023-11-15 09:18:20', b'0', 1);
INSERT INTO `system_post` (`id`, `code`, `name`, `sort`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (4, 'user', '普通员工', 4, 0, '111', 'admin', '2021-01-05 17:03:48', '1', '2023-12-02 10:04:37', b'0', 1);
INSERT INTO `system_post` (`id`, `code`, `name`, `sort`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5, 'HR', '人力资源', 5, 0, '', '1', '2024-03-24 20:45:40', '1', '2024-03-24 20:45:40', b'0', 1);
COMMIT;

-- ----------------------------
-- Table structure for system_role
-- ----------------------------
DROP TABLE IF EXISTS `system_role`;
CREATE TABLE `system_role` (
                               `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
                               `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
                               `code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色权限字符串',
                               `sort` int(11) NOT NULL COMMENT '显示顺序',
                               `data_scope` tinyint(4) NOT NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
                               `data_scope_dept_ids` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据范围(指定部门数组)',
                               `status` tinyint(4) NOT NULL COMMENT '角色状态（0正常 1停用）',
                               `type` tinyint(4) NOT NULL COMMENT '角色类型',
                               `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                               `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                               `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                               `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                               `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                               `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                               `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色信息表';

-- ----------------------------
-- Records of system_role
-- ----------------------------
BEGIN;
INSERT INTO `system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1, '超级管理员', 'super_admin', 1, 1, '', 0, 1, '超级管理员', 'admin', '2021-01-05 17:03:48', '', '2022-02-22 05:08:21', b'0', 1);
INSERT INTO `system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2, '普通角色', 'common', 2, 2, '', 0, 1, '普通角色', 'admin', '2021-01-05 17:03:48', '', '2022-02-22 05:08:20', b'0', 1);
INSERT INTO `system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (101, '数据安全人员', 'data safe', 0, 3, '[]', 0, 2, '', '', '2021-01-06 13:49:35', '1', '2024-10-30 14:10:37', b'0', 1);
INSERT INTO `system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (153, 'aa', 'aa', 12, 1, '', 0, 2, '', '1', '2024-10-30 17:13:01', '1', '2024-10-30 17:13:01', b'0', 0);
COMMIT;

-- ----------------------------
-- Table structure for system_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `system_role_menu`;
CREATE TABLE `system_role_menu` (
                                    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增编号',
                                    `role_id` bigint(20) NOT NULL COMMENT '角色ID',
                                    `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
                                    `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                    `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5936 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色和菜单关联表';

-- ----------------------------
-- Records of system_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (263, 109, 1, '1', '2022-02-22 00:56:14', '1', '2022-02-22 00:56:14', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (434, 2, 1, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (477, 2, 100, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (478, 2, 101, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (479, 2, 102, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (481, 2, 103, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (483, 2, 104, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (675, 2, 2, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1296, 110, 1, '110', '2022-02-23 00:23:55', '110', '2022-02-23 00:23:55', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1578, 111, 1, '1', '2022-03-07 21:37:58', '1', '2022-03-07 21:37:58', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1729, 109, 100, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1730, 109, 101, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1731, 109, 1063, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1732, 109, 1064, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1733, 109, 1001, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1734, 109, 1065, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1735, 109, 1002, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1736, 109, 1003, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1737, 109, 1004, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1738, 109, 1005, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1739, 109, 1006, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1740, 109, 1007, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1741, 109, 1008, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1742, 109, 1009, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1743, 109, 1010, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1744, 109, 1011, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1745, 109, 1012, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1746, 111, 100, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1747, 111, 101, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1748, 111, 1063, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1749, 111, 1064, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1750, 111, 1001, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1751, 111, 1065, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1752, 111, 1002, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1753, 111, 1003, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1754, 111, 1004, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1755, 111, 1005, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1756, 111, 1006, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1757, 111, 1007, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1758, 111, 1008, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1759, 111, 1009, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1760, 111, 1010, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1761, 111, 1011, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1762, 111, 1012, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1763, 109, 100, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1764, 109, 101, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1765, 109, 1063, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1766, 109, 1064, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1767, 109, 1001, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1768, 109, 1065, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1769, 109, 1002, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1770, 109, 1003, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1771, 109, 1004, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1772, 109, 1005, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1773, 109, 1006, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1774, 109, 1007, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1775, 109, 1008, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1776, 109, 1009, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1777, 109, 1010, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1778, 109, 1011, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1779, 109, 1012, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1780, 111, 100, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1781, 111, 101, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1782, 111, 1063, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1783, 111, 1064, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1784, 111, 1001, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1785, 111, 1065, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1786, 111, 1002, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1787, 111, 1003, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1788, 111, 1004, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1789, 111, 1005, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1790, 111, 1006, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1791, 111, 1007, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1792, 111, 1008, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1793, 111, 1009, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1794, 111, 1010, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1795, 111, 1011, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1796, 111, 1012, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1797, 109, 100, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1798, 109, 101, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1799, 109, 1063, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1800, 109, 1064, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1801, 109, 1001, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1802, 109, 1065, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1803, 109, 1002, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1804, 109, 1003, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1805, 109, 1004, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1806, 109, 1005, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1807, 109, 1006, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1808, 109, 1007, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1809, 109, 1008, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1810, 109, 1009, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1811, 109, 1010, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1812, 109, 1011, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1813, 109, 1012, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1814, 111, 100, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1815, 111, 101, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1816, 111, 1063, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1817, 111, 1064, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1818, 111, 1001, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1819, 111, 1065, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1820, 111, 1002, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1821, 111, 1003, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1822, 111, 1004, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1823, 111, 1005, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1824, 111, 1006, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1825, 111, 1007, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1826, 111, 1008, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1827, 111, 1009, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1828, 111, 1010, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1829, 111, 1011, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1830, 111, 1012, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1831, 109, 103, '1', '2022-09-21 22:43:23', '1', '2022-09-21 22:43:23', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1832, 109, 1017, '1', '2022-09-21 22:43:23', '1', '2022-09-21 22:43:23', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1833, 109, 1018, '1', '2022-09-21 22:43:23', '1', '2022-09-21 22:43:23', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1834, 109, 1019, '1', '2022-09-21 22:43:23', '1', '2022-09-21 22:43:23', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1835, 109, 1020, '1', '2022-09-21 22:43:23', '1', '2022-09-21 22:43:23', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1836, 111, 103, '1', '2022-09-21 22:43:24', '1', '2022-09-21 22:43:24', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1837, 111, 1017, '1', '2022-09-21 22:43:24', '1', '2022-09-21 22:43:24', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1838, 111, 1018, '1', '2022-09-21 22:43:24', '1', '2022-09-21 22:43:24', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1839, 111, 1019, '1', '2022-09-21 22:43:24', '1', '2022-09-21 22:43:24', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1840, 111, 1020, '1', '2022-09-21 22:43:24', '1', '2022-09-21 22:43:24', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1991, 2, 1024, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1992, 2, 1025, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2024, 2, 1063, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2025, 2, 1064, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2026, 2, 1065, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2076, 2, 116, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2129, 2, 1001, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2130, 2, 1002, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2131, 2, 1003, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2132, 2, 1004, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2133, 2, 1005, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2134, 2, 1006, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2135, 2, 1007, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2136, 2, 1008, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2137, 2, 1009, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2138, 2, 1010, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2139, 2, 1011, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2140, 2, 1012, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2141, 2, 1013, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2142, 2, 1014, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2143, 2, 1015, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2144, 2, 1016, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2145, 2, 1017, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2146, 2, 1018, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2147, 2, 1019, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2148, 2, 1020, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2149, 2, 1021, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2150, 2, 1022, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2151, 2, 1023, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', b'0', 1);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2993, 109, 2, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3034, 109, 116, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3069, 111, 2, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3110, 111, 116, '1', '2023-12-02 23:41:02', '1', '2023-12-02 23:41:02', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3221, 109, 102, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3222, 109, 1013, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3223, 109, 1014, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3224, 109, 1015, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3225, 109, 1016, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', b'0', 121);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3226, 111, 102, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3227, 111, 1013, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3228, 111, 1014, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3229, 111, 1015, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3230, 111, 1016, '1', '2023-12-30 11:42:36', '1', '2023-12-30 11:42:36', b'0', 122);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5793, 1, 1024, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5794, 1, 1, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5795, 1, 1025, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5797, 1, 2, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5823, 1, 1063, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5824, 1, 1064, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5825, 1, 1065, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5870, 1, 100, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5872, 1, 101, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5874, 1, 102, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5876, 1, 103, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5878, 1, 104, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5886, 1, 116, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5896, 1, 1001, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5897, 1, 1002, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5898, 1, 1003, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5899, 1, 1004, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5900, 1, 1005, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5902, 1, 1006, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5903, 1, 1007, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5905, 1, 1008, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5907, 1, 1009, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5909, 1, 1010, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5911, 1, 1011, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5913, 1, 1012, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5915, 1, 1013, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5917, 1, 1014, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5918, 1, 1015, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5919, 1, 1016, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5920, 1, 1017, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5921, 1, 1018, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5922, 1, 1019, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5923, 1, 1020, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5924, 1, 1021, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5925, 1, 1022, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5926, 1, 1023, '1', '2024-10-30 11:49:28', '1', '2024-10-30 11:49:28', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5927, 101, 2801, '1', '2024-10-30 14:10:32', '1', '2024-10-30 14:10:32', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5928, 101, 2802, '1', '2024-10-30 14:10:32', '1', '2024-10-30 14:10:32', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5929, 101, 2803, '1', '2024-10-30 14:10:32', '1', '2024-10-30 14:10:32', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5930, 101, 2804, '1', '2024-10-30 14:10:32', '1', '2024-10-30 14:10:32', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5931, 101, 2805, '1', '2024-10-30 14:10:32', '1', '2024-10-30 14:10:32', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5932, 101, 2806, '1', '2024-10-30 14:10:32', '1', '2024-10-30 14:10:32', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5933, 101, 2807, '1', '2024-10-30 14:10:32', '1', '2024-10-30 14:10:32', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5934, 101, 2808, '1', '2024-10-30 14:10:32', '1', '2024-10-30 14:10:32', b'0', 0);
INSERT INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5935, 101, 2798, '1', '2024-10-30 14:10:32', '1', '2024-10-30 14:10:32', b'0', 0);
COMMIT;

-- ----------------------------
-- Table structure for system_sms_channel
-- ----------------------------
DROP TABLE IF EXISTS `system_sms_channel`;
CREATE TABLE `system_sms_channel` (
                                      `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                      `signature` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信签名',
                                      `code` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '渠道编码',
                                      `status` tinyint(4) NOT NULL COMMENT '开启状态',
                                      `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                      `api_key` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信 API 的账号',
                                      `api_secret` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信 API 的秘钥',
                                      `callback_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信发送回调 URL',
                                      `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                      `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                      `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                      `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                      `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='短信渠道';

-- ----------------------------
-- Records of system_sms_channel
-- ----------------------------
BEGIN;
INSERT INTO `system_sms_channel` (`id`, `signature`, `code`, `status`, `remark`, `api_key`, `api_secret`, `callback_url`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2, 'Ballcat', 'ALIYUN', 0, '你要改哦，只有我可以用！！！！', 'LTAI5tCnKso2uG3kJ5gRav88', 'fGJ5SNXL7P1NHNRmJ7DJaMJGPyE55C', NULL, '', '2021-03-31 11:53:10', '1', '2023-12-02 22:10:17', b'0');
INSERT INTO `system_sms_channel` (`id`, `signature`, `code`, `status`, `remark`, `api_key`, `api_secret`, `callback_url`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (4, '测试渠道', 'DEBUG_DING_TALK', 0, '123', '696b5d8ead48071237e4aa5861ff08dbadb2b4ded1c688a7b7c9afc615579859', 'SEC5c4e5ff888bc8a9923ae47f59e7ccd30af1f14d93c55b4e2c9cb094e35aeed67', NULL, '1', '2021-04-13 00:23:14', '1', '2022-03-27 20:29:49', b'0');
INSERT INTO `system_sms_channel` (`id`, `signature`, `code`, `status`, `remark`, `api_key`, `api_secret`, `callback_url`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (6, '测试演示', 'DEBUG_DING_TALK', 0, '仅测试', '696b5d8ead48071237e4aa5861ff08dbadb2b4ded1c688a7b7c9afc615579859', 'SEC5c4e5ff888bc8a9923ae47f59e7ccd30af1f14d93c55b4e2c9cb094e35aeed67', NULL, '1', '2022-04-10 23:07:59', '1', '2023-12-02 22:10:08', b'0');
COMMIT;

-- ----------------------------
-- Table structure for system_sms_code
-- ----------------------------
DROP TABLE IF EXISTS `system_sms_code`;
CREATE TABLE `system_sms_code` (
                                   `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                   `mobile` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号',
                                   `code` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '验证码',
                                   `create_ip` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建 IP',
                                   `scene` tinyint(4) NOT NULL COMMENT '发送场景',
                                   `today_index` tinyint(4) NOT NULL COMMENT '今日发送的第几条',
                                   `used` tinyint(4) NOT NULL COMMENT '是否使用',
                                   `used_time` datetime DEFAULT NULL COMMENT '使用时间',
                                   `used_ip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '使用 IP',
                                   `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                   `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                   `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                   `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                   `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                   `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                   PRIMARY KEY (`id`) USING BTREE,
                                   KEY `idx_mobile` (`mobile`) USING BTREE COMMENT '手机号'
) ENGINE=InnoDB AUTO_INCREMENT=628 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='手机验证码';

-- ----------------------------
-- Records of system_sms_code
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for system_sms_log
-- ----------------------------
DROP TABLE IF EXISTS `system_sms_log`;
CREATE TABLE `system_sms_log` (
                                  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                  `channel_id` bigint(20) NOT NULL COMMENT '短信渠道编号',
                                  `channel_code` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信渠道编码',
                                  `template_id` bigint(20) NOT NULL COMMENT '模板编号',
                                  `template_code` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
                                  `template_type` tinyint(4) NOT NULL COMMENT '短信类型',
                                  `template_content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信内容',
                                  `template_params` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信参数',
                                  `api_template_id` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信 API 的模板编号',
                                  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号',
                                  `user_id` bigint(20) DEFAULT NULL COMMENT '用户编号',
                                  `user_type` tinyint(4) DEFAULT NULL COMMENT '用户类型',
                                  `send_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '发送状态',
                                  `send_time` datetime DEFAULT NULL COMMENT '发送时间',
                                  `api_send_code` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信 API 发送结果的编码',
                                  `api_send_msg` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信 API 发送失败的提示',
                                  `api_request_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信 API 发送返回的唯一请求 ID',
                                  `api_serial_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信 API 发送返回的序号',
                                  `receive_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '接收状态',
                                  `receive_time` datetime DEFAULT NULL COMMENT '接收时间',
                                  `api_receive_code` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'API 接收结果的编码',
                                  `api_receive_msg` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'API 接收结果的说明',
                                  `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                  `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=987 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='短信日志';

-- ----------------------------
-- Records of system_sms_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for system_sms_template
-- ----------------------------
DROP TABLE IF EXISTS `system_sms_template`;
CREATE TABLE `system_sms_template` (
                                       `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                       `type` tinyint(4) NOT NULL COMMENT '模板类型',
                                       `status` tinyint(4) NOT NULL COMMENT '开启状态',
                                       `code` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
                                       `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板名称',
                                       `content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板内容',
                                       `params` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数数组',
                                       `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                       `api_template_id` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信 API 的模板编号',
                                       `channel_id` bigint(20) NOT NULL COMMENT '短信渠道编号',
                                       `channel_code` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信渠道编码',
                                       `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                       `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                       `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                       `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                       `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='短信模板';

-- ----------------------------
-- Records of system_sms_template
-- ----------------------------
BEGIN;
INSERT INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2, 1, 0, 'test_01', '测试验证码短信', '正在进行登录操作{operation}，您的验证码是{code}', '[\"operation\",\"code\"]', '测试备注', '4383920', 6, 'DEBUG_DING_TALK', '', '2021-03-31 10:49:38', '1', '2023-12-02 22:32:47', b'0');
INSERT INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3, 1, 0, 'test_02', '公告通知', '您的验证码{code}，该验证码5分钟内有效，请勿泄漏于他人！', '[\"code\"]', NULL, 'SMS_207945135', 2, 'ALIYUN', '', '2021-03-31 11:56:30', '1', '2021-04-10 01:22:02', b'0');
INSERT INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (6, 3, 0, 'test-01', '测试模板', '哈哈哈 {name}', '[\"name\"]', 'f哈哈哈', '4383920', 6, 'DEBUG_DING_TALK', '1', '2021-04-10 01:07:21', '1', '2022-12-10 21:26:09', b'0');
INSERT INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (8, 1, 0, 'user-sms-login', '前台用户短信登录', '您的验证码是{code}', '[\"code\"]', NULL, '4372216', 6, 'DEBUG_DING_TALK', '1', '2021-10-11 08:10:00', '1', '2022-12-10 21:25:59', b'0');
COMMIT;

-- ----------------------------
-- Table structure for system_social_client
-- ----------------------------
DROP TABLE IF EXISTS `system_social_client`;
CREATE TABLE `system_social_client` (
                                        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                        `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
                                        `social_type` tinyint(4) NOT NULL COMMENT '社交平台的类型',
                                        `user_type` tinyint(4) NOT NULL COMMENT '用户类型',
                                        `client_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
                                        `client_secret` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端密钥',
                                        `agent_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '代理编号',
                                        `status` tinyint(4) NOT NULL COMMENT '状态',
                                        `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                        `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                        `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                        `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                        `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                        `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                        PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='社交客户端表';

-- ----------------------------
-- Records of system_social_client
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for system_social_user
-- ----------------------------
DROP TABLE IF EXISTS `system_social_user`;
CREATE TABLE `system_social_user` (
                                      `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键(自增策略)',
                                      `type` tinyint(4) NOT NULL COMMENT '社交平台的类型',
                                      `openid` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '社交 openid',
                                      `token` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '社交 token',
                                      `raw_token_info` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '原始 Token 数据，一般是 JSON 格式',
                                      `nickname` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户昵称',
                                      `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户头像',
                                      `raw_user_info` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '原始用户数据，一般是 JSON 格式',
                                      `code` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '最后一次的认证 code',
                                      `state` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '最后一次的认证 state',
                                      `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                      `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                      `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                      `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                      `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                      `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='社交用户表';

-- ----------------------------
-- Records of system_social_user
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for system_social_user_bind
-- ----------------------------
DROP TABLE IF EXISTS `system_social_user_bind`;
CREATE TABLE `system_social_user_bind` (
                                           `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键(自增策略)',
                                           `user_id` bigint(20) NOT NULL COMMENT '用户编号',
                                           `user_type` tinyint(4) NOT NULL COMMENT '用户类型',
                                           `social_type` tinyint(4) NOT NULL COMMENT '社交平台的类型',
                                           `social_user_id` bigint(20) NOT NULL COMMENT '社交用户的编号',
                                           `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                           `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                           `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                           `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                           `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                           `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                           PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='社交绑定表';

-- ----------------------------
-- Records of system_social_user_bind
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for system_tenant
-- ----------------------------
DROP TABLE IF EXISTS `system_tenant`;
CREATE TABLE `system_tenant` (
                                 `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '租户编号',
                                 `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '租户名',
                                 `contact_user_id` bigint(20) DEFAULT NULL COMMENT '联系人的用户编号',
                                 `contact_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系人',
                                 `contact_mobile` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系手机',
                                 `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '租户状态（0正常 1停用）',
                                 `website` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '绑定域名',
                                 `package_id` bigint(20) NOT NULL COMMENT '租户套餐编号',
                                 `expire_time` datetime NOT NULL COMMENT '过期时间',
                                 `account_count` int(11) NOT NULL COMMENT '账号数量',
                                 `creator` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                 `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                 `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='租户表';

-- ----------------------------
-- Records of system_tenant
-- ----------------------------
BEGIN;
INSERT INTO `system_tenant` (`id`, `name`, `contact_user_id`, `contact_name`, `contact_mobile`, `status`, `website`, `package_id`, `expire_time`, `account_count`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1, '系统源码', NULL, '系统源码', '17321315478', 0, 'www.iocoder.cn', 0, '2099-02-19 17:14:16', 9999, '1', '2021-01-05 17:03:47', '1', '2024-10-30 11:38:48', b'0');
INSERT INTO `system_tenant` (`id`, `name`, `contact_user_id`, `contact_name`, `contact_mobile`, `status`, `website`, `package_id`, `expire_time`, `account_count`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (121, '小租户', 110, '小王2', '15601691300', 0, 'zsxq.iocoder.cn', 111, '2025-03-11 00:00:00', 20, '1', '2022-02-22 00:56:14', '1', '2024-07-20 22:21:53', b'0');
INSERT INTO `system_tenant` (`id`, `name`, `contact_user_id`, `contact_name`, `contact_mobile`, `status`, `website`, `package_id`, `expire_time`, `account_count`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (122, '测试租户', 113, '测试', '15601691300', 0, 'test.iocoder.cn', 111, '2022-04-29 00:00:00', 50, '1', '2022-03-07 21:37:58', '1', '2024-10-30 11:38:51', b'0');
COMMIT;

-- ----------------------------
-- Table structure for system_tenant_package
-- ----------------------------
DROP TABLE IF EXISTS `system_tenant_package`;
CREATE TABLE `system_tenant_package` (
                                         `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '套餐编号',
                                         `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '套餐名',
                                         `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '租户状态（0正常 1停用）',
                                         `remark` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注',
                                         `menu_ids` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '关联的菜单编号',
                                         `creator` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建者',
                                         `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                         `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                         `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                         `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                         PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='租户套餐表';

-- ----------------------------
-- Records of system_tenant_package
-- ----------------------------
BEGIN;
INSERT INTO `system_tenant_package` (`id`, `name`, `status`, `remark`, `menu_ids`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (111, '普通套餐', 0, '小功能', '[1,2,5,1031,1032,1033,1034,1035,1036,1037,1038,1039,1050,1051,1052,1053,1054,1056,1057,1058,1059,1060,1063,1064,1065,1066,1067,1070,1075,1077,1078,1082,1083,1084,1085,1086,1087,1088,1089,1090,1091,1092,1118,1119,1120,100,101,102,103,106,107,110,111,112,113,1138,114,1139,115,1140,116,1141,1142,1143,2713,2714,2715,2716,2717,2718,2720,1185,2721,1186,2722,1187,2723,1188,2724,1189,2725,1190,2726,1191,2727,2472,1192,2728,1193,2729,1194,2730,1195,2731,1196,2732,1197,2733,2478,1198,2734,2479,1199,2735,2480,1200,2481,1201,2482,1202,2483,2739,2484,2740,2485,2486,2487,1207,2488,1208,2489,1209,2490,1210,2491,1211,2492,1212,2493,1213,2494,2495,1215,1216,2497,1217,1218,1219,1220,1221,1222,1224,1225,1226,1227,1228,1229,1237,1238,1239,1240,1241,1242,1243,2525,1255,1256,1001,1257,1002,1258,1003,1259,1004,1260,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1016,1017,1018,1019,1020]', '1', '2022-02-22 00:54:00', '1', '2024-07-13 22:37:24', b'0');
COMMIT;

-- ----------------------------
-- Table structure for system_user_post
-- ----------------------------
DROP TABLE IF EXISTS `system_user_post`;
CREATE TABLE `system_user_post` (
                                    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                    `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户ID',
                                    `post_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '岗位ID',
                                    `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                    `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户岗位表';

-- ----------------------------
-- Records of system_user_post
-- ----------------------------
BEGIN;
INSERT INTO `system_user_post` (`id`, `user_id`, `post_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (112, 1, 1, 'admin', '2022-05-02 07:25:24', 'admin', '2022-05-02 07:25:24', b'0', 1);
INSERT INTO `system_user_post` (`id`, `user_id`, `post_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (115, 104, 1, '1', '2022-05-16 19:36:28', '1', '2022-05-16 19:36:28', b'0', 1);
INSERT INTO `system_user_post` (`id`, `user_id`, `post_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (116, 117, 2, '1', '2022-07-09 17:40:26', '1', '2022-07-09 17:40:26', b'0', 1);
INSERT INTO `system_user_post` (`id`, `user_id`, `post_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (125, 1, 2, '1', '2024-07-13 22:31:39', '1', '2024-07-13 22:31:39', b'0', 1);
COMMIT;

-- ----------------------------
-- Table structure for system_user_role
-- ----------------------------
DROP TABLE IF EXISTS `system_user_role`;
CREATE TABLE `system_user_role` (
                                    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增编号',
                                    `user_id` bigint(20) NOT NULL COMMENT '用户ID',
                                    `role_id` bigint(20) NOT NULL COMMENT '角色ID',
                                    `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                    `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                    `deleted` bit(1) DEFAULT b'0' COMMENT '是否删除',
                                    `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户和角色关联表';

-- ----------------------------
-- Records of system_user_role
-- ----------------------------
BEGIN;
INSERT INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1, 1, 1, '', '2022-01-11 13:19:45', '', '2022-05-12 12:35:17', b'0', 1);
INSERT INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2, 2, 2, '', '2022-01-11 13:19:45', '', '2022-05-12 12:35:13', b'0', 1);
INSERT INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (14, 110, 109, '1', '2022-02-22 00:56:14', '1', '2022-02-22 00:56:14', b'0', 121);
INSERT INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (15, 111, 110, '110', '2022-02-23 13:14:38', '110', '2022-02-23 13:14:38', b'0', 121);
INSERT INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (16, 113, 111, '1', '2022-03-07 21:37:58', '1', '2022-03-07 21:37:58', b'0', 122);
INSERT INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (18, 1, 2, '1', '2022-05-12 20:39:29', '1', '2022-05-12 20:39:29', b'0', 1);
INSERT INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (20, 104, 101, '1', '2022-05-28 15:43:57', '1', '2022-05-28 15:43:57', b'0', 1);
INSERT INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (46, 117, 101, '1', '2024-10-30 14:27:40', '1', '2024-10-30 14:27:40', b'0', 0);
COMMIT;

-- ----------------------------
-- Table structure for system_users
-- ----------------------------
DROP TABLE IF EXISTS `system_users`;
CREATE TABLE `system_users` (
                                `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
                                `username` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户账号',
                                `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
                                `nickname` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户昵称',
                                `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
                                `post_ids` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '岗位编号数组',
                                `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '用户邮箱',
                                `mobile` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '手机号码',
                                `sex` tinyint(4) DEFAULT '0' COMMENT '用户性别',
                                `avatar` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '头像地址',
                                `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
                                `login_ip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '最后登录IP',
                                `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
                                `creator` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                `updater` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                `tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '租户编号',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息表';

-- ----------------------------
-- Records of system_users
-- ----------------------------
BEGIN;
INSERT INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1, 'admin', '$2a$10$mRMIYLDtRHlf6.9ipiqH1.Z.bh/R9dO9d5iHiGYPigi6r5KOoR2Wm', '系统用户', '管理员', 103, '[1,2]', 'qq@126.com', '15888888888', 2, 'http://test.yudao.iocoder.cn/bf2002b38950c904243be7c825d3f82e29f25a44526583c3fde2ebdff3a87f75.png', 0, '172.16.30.66', '2024-11-07 14:27:16', 'admin', '2021-01-05 17:03:47', NULL, '2024-11-07 14:27:16', b'0', 1);
INSERT INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (104, 'test', '$2a$04$jDFLttgfik0QqJKAbfhMa.2A9xXoZmAIxakdFJUzkX.MgBKT6ddo6', '测试号', NULL, 107, '[1,2]', '111@qq.com', '15601691200', 1, '', 0, '0:0:0:0:0:0:0:1', '2024-07-13 23:13:16', '', '2021-01-21 02:13:53', NULL, '2024-07-13 23:13:16', b'0', 1);
INSERT INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (117, 'admin123', '$2a$04$aatf.HMwWTgCAnj4cR39eeiX8uRQJEPAF38FiYzy9GiEUj1Op9G82', '测试号', '1111', 100, '[2]', '', '15601691234', 1, '', 0, '127.0.0.1', '2024-10-30 14:27:58', '1', '2022-07-09 17:40:26', NULL, '2024-10-30 14:27:58', b'0', 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
