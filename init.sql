CREATE DATABASE IF NOT EXISTS `hospital` DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;
use `hospital`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hospital_clinic
-- ----------------------------
DROP TABLE IF EXISTS `hospital_clinic`;
CREATE TABLE `hospital_clinic`  (
                                    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '诊室编号',
                                    `outpatient_id` bigint NOT NULL COMMENT '所属门诊',
                                    `address` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '诊室地址',
                                    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10008 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '诊室信息表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hospital_clinic
-- ----------------------------

-- ----------------------------
-- Table structure for hospital_doctor
-- ----------------------------
DROP TABLE IF EXISTS `hospital_doctor`;
CREATE TABLE `hospital_doctor`  (
                                    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '医生编号',
                                    `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '医生姓名',
                                    `gender` int NOT NULL DEFAULT 1 COMMENT '性别：1，男；2，女',
                                    `job_title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '医生职称',
                                    `specialty` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '医生专长',
                                    `special_id` bigint NOT NULL COMMENT '所属专科',
                                    `outpatient_id` bigint NOT NULL COMMENT '所属门诊',
                                    `gmt_create` datetime NOT NULL COMMENT '创建时间',
                                    `gmt_modified` datetime NOT NULL COMMENT '更新时间',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    INDEX `hospital_doctor_hospital_outpatient_id_fk`(`outpatient_id` ASC) USING BTREE,
                                    INDEX `hospital_doctor_hospital_special_id_fk`(`special_id` ASC) USING BTREE,
                                    CONSTRAINT `hospital_doctor_hospital_outpatient_id_fk` FOREIGN KEY (`outpatient_id`) REFERENCES `hospital_outpatient` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                    CONSTRAINT `hospital_doctor_hospital_special_id_fk` FOREIGN KEY (`special_id`) REFERENCES `hospital_special` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10009 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '医生信息表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hospital_doctor
-- ----------------------------
INSERT INTO `hospital_doctor` VALUES (10008, '儿童-张三', 1, '医师', '儿童专家', 10008, 10002, '2023-11-04 02:49:20', '2023-11-04 02:49:20');

-- ----------------------------
-- Table structure for hospital_info
-- ----------------------------
DROP TABLE IF EXISTS `hospital_info`;
CREATE TABLE `hospital_info`  (
                                  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '医院编号 从1001开始',
                                  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '医院名称',
                                  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '医院电话',
                                  `address` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '医院地址',
                                  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '医院简介',
                                  `picture` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '医院图片',
                                  `gmt_create` datetime NOT NULL COMMENT '创建时间',
                                  `gmt_modified` datetime NOT NULL COMMENT '更新时间',
                                  PRIMARY KEY (`id`) USING BTREE,
                                  UNIQUE INDEX `hospital_info_phone_uindex`(`phone` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1008 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '医院信息表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hospital_info
-- ----------------------------
INSERT INTO `hospital_info` VALUES (1000, '广东省中医院', '020-123452', '广州大学城', '广东省中医院', 'http://localhost:8080/hospital/img/hos1.png', '2023-11-04 13:06:55', '2023-11-04 13:06:55');
INSERT INTO `hospital_info` VALUES (1001, '顺德分院', '020-1234567', '广东省佛山市顺德区', '位于广东省佛山市顺德区', 'http://localhost:8080/hospital/img/hos2.png', '2023-11-04 13:06:55', '2023-11-04 13:06:55');
INSERT INTO `hospital_info` VALUES (1002, '白云分院', '020-1234568', '广东省广州市白云区', '位于广东省广州市白云区', 'http://localhost:8080/hospital/img/hos3.png', '2023-11-04 13:06:55', '2023-11-04 13:06:55');
INSERT INTO `hospital_info` VALUES (1007, '越秀分院', '020-1234563', '广东省越秀区', '位于广东省越秀区', 'http://localhost:8080/hospital/img/hos4.png', '2023-11-04 13:06:55', '2023-11-04 13:06:55');

-- ----------------------------
-- Table structure for hospital_outpatient
-- ----------------------------
DROP TABLE IF EXISTS `hospital_outpatient`;
CREATE TABLE `hospital_outpatient`  (
                                        `id` bigint NOT NULL AUTO_INCREMENT COMMENT '门诊编号',
                                        `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '门诊名称',
                                        `special_id` bigint NOT NULL COMMENT '所属专科',
                                        `gmt_create` datetime NOT NULL COMMENT '创建时间',
                                        `gmt_modified` datetime NOT NULL COMMENT '更新时间',
                                        PRIMARY KEY (`id`) USING BTREE,
                                        INDEX `hospital_outpatient_hospital_special_id_fk`(`special_id` ASC) USING BTREE,
                                        CONSTRAINT `hospital_outpatient_hospital_special_id_fk` FOREIGN KEY (`special_id`) REFERENCES `hospital_special` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10018 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '医院门诊表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hospital_outpatient
-- ----------------------------
INSERT INTO `hospital_outpatient` VALUES (10002, '儿童发热', 10008, '2023-11-04 13:06:55', '2023-11-04 13:06:55');
INSERT INTO `hospital_outpatient` VALUES (10003, '儿童牙科', 10008, '2023-11-04 13:06:55', '2023-11-04 13:06:55');
INSERT INTO `hospital_outpatient` VALUES (10004, '儿童外科擦伤', 10008, '2023-11-04 13:06:55', '2023-11-04 13:06:55');
INSERT INTO `hospital_outpatient` VALUES (10005, '普通门诊', 10000, '2023-11-04 13:06:55', '2023-11-04 13:06:55');
INSERT INTO `hospital_outpatient` VALUES (10006, '流产专科', 10000, '2023-11-04 13:06:55', '2023-11-04 13:06:55');
INSERT INTO `hospital_outpatient` VALUES (10007, '不孕症专科', 10000, '2023-11-04 13:06:55', '2023-11-04 13:06:55');
INSERT INTO `hospital_outpatient` VALUES (10008, '皮肤科', 10006, '2023-11-04 13:06:55', '2023-11-04 13:06:55');
INSERT INTO `hospital_outpatient` VALUES (10009, '脱发', 10006, '2023-11-04 13:06:55', '2023-11-04 13:06:55');
INSERT INTO `hospital_outpatient` VALUES (10010, '痤疮', 10006, '2023-11-04 13:06:55', '2023-11-04 13:06:55');
INSERT INTO `hospital_outpatient` VALUES (10011, '性病', 10006, '2023-11-04 13:06:55', '2023-11-04 13:06:55');
INSERT INTO `hospital_outpatient` VALUES (10012, '湿疹', 10006, '2023-11-04 13:06:55', '2023-11-04 13:06:55');
INSERT INTO `hospital_outpatient` VALUES (10013, '红斑狼疮', 10006, '2023-11-04 13:06:55', '2023-11-04 13:06:55');
INSERT INTO `hospital_outpatient` VALUES (10014, '妇科门诊', 10000, '2023-11-04 13:06:55', '2023-11-04 13:06:55');
INSERT INTO `hospital_outpatient` VALUES (10015, '普通眼科门诊', 10009, '2023-11-04 13:06:55', '2023-11-04 13:06:55');
INSERT INTO `hospital_outpatient` VALUES (10016, '近视眼', 10009, '2023-11-04 13:06:55', '2023-11-04 13:06:55');
INSERT INTO `hospital_outpatient` VALUES (10017, '青光眼', 10009, '2023-11-04 13:06:55', '2023-11-04 13:06:55');

-- ----------------------------
-- Table structure for hospital_outpatient_relation
-- ----------------------------
DROP TABLE IF EXISTS `hospital_outpatient_relation`;
CREATE TABLE `hospital_outpatient_relation`  (
                                                 `id` bigint NOT NULL AUTO_INCREMENT COMMENT '关系编号',
                                                 `hospital_id` bigint NOT NULL COMMENT '医院编号',
                                                 `outpatient_id` bigint NOT NULL COMMENT '门诊编号',
                                                 `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                                 `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                                 PRIMARY KEY (`id`) USING BTREE,
                                                 INDEX `hospital_outpatient_relation_hospital_info_id_fk`(`hospital_id` ASC) USING BTREE,
                                                 INDEX `hospital_outpatient_relation_hospital_outpatient_id_fk`(`outpatient_id` ASC) USING BTREE,
                                                 CONSTRAINT `hospital_outpatient_relation_hospital_info_id_fk` FOREIGN KEY (`hospital_id`) REFERENCES `hospital_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                                 CONSTRAINT `hospital_outpatient_relation_hospital_outpatient_id_fk` FOREIGN KEY (`outpatient_id`) REFERENCES `hospital_outpatient` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '医院门诊关系表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hospital_outpatient_relation
-- ----------------------------
INSERT INTO `hospital_outpatient_relation` VALUES (7, 1000, 10009, '2020-03-29 04:45:32', '2020-03-29 04:45:32');
INSERT INTO `hospital_outpatient_relation` VALUES (8, 1000, 10010, '2020-03-29 04:45:37', '2020-03-29 04:45:37');
INSERT INTO `hospital_outpatient_relation` VALUES (9, 1000, 10005, '2020-03-29 05:01:46', '2020-03-29 05:01:46');
INSERT INTO `hospital_outpatient_relation` VALUES (10, 1000, 10006, '2020-03-29 05:01:49', '2020-03-29 05:01:49');
INSERT INTO `hospital_outpatient_relation` VALUES (11, 1000, 10007, '2020-03-29 05:01:51', '2020-03-29 05:01:51');
INSERT INTO `hospital_outpatient_relation` VALUES (12, 1000, 10014, '2020-03-29 05:01:54', '2020-03-29 05:01:54');
INSERT INTO `hospital_outpatient_relation` VALUES (13, 1000, 10002, '2020-03-29 05:08:29', '2020-03-29 05:08:29');
INSERT INTO `hospital_outpatient_relation` VALUES (14, 1000, 10003, '2020-03-29 05:08:32', '2020-03-29 05:08:32');
INSERT INTO `hospital_outpatient_relation` VALUES (15, 1001, 10005, '2020-03-31 10:18:28', '2020-03-31 10:18:28');
INSERT INTO `hospital_outpatient_relation` VALUES (16, 1001, 10006, '2020-03-31 10:19:20', '2020-03-31 10:19:20');

-- ----------------------------
-- Table structure for hospital_special
-- ----------------------------
DROP TABLE IF EXISTS `hospital_special`;
CREATE TABLE `hospital_special`  (
                                     `id` bigint NOT NULL AUTO_INCREMENT COMMENT '专科编号',
                                     `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '专科名称',
                                     `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '专科简介',
                                     `gmt_create` datetime NOT NULL COMMENT '创建时间',
                                     `gmt_modified` datetime NOT NULL COMMENT '更新时间',
                                     PRIMARY KEY (`id`) USING BTREE,
                                     UNIQUE INDEX `hospital_special_name_uindex`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10011 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '医院专科表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hospital_special
-- ----------------------------
INSERT INTO `hospital_special` VALUES (10000, '妇科', '女性妇科相关智联', '2023-11-04 03:54:25', '2023-11-04 03:54:25');
INSERT INTO `hospital_special` VALUES (10006, '皮肤科', '皮肤相关治疗', '2023-11-04 03:54:25', '2023-11-04 03:54:25');
INSERT INTO `hospital_special` VALUES (10008, '儿科', '儿童相关治疗', '2023-11-04 03:54:25', '2023-11-04 03:54:25');
INSERT INTO `hospital_special` VALUES (10009, '眼科', '眼部相关治疗', '2023-11-04 03:54:25', '2023-11-04 03:54:25');
INSERT INTO `hospital_special` VALUES (10010, '内科', '甲状腺等内科治疗', '2023-11-04 03:54:25', '2023-11-04 03:54:25');

-- ----------------------------
-- Table structure for hospital_special_relation
-- ----------------------------
DROP TABLE IF EXISTS `hospital_special_relation`;
CREATE TABLE `hospital_special_relation`  (
                                              `id` bigint NOT NULL AUTO_INCREMENT COMMENT '关系编号',
                                              `hospital_id` bigint NOT NULL COMMENT '医院编号',
                                              `special_id` bigint NOT NULL COMMENT '专科编号',
                                              `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                              `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                              PRIMARY KEY (`id`) USING BTREE,
                                              INDEX `hospital_special_relation_hospital_info_id_fk`(`hospital_id` ASC) USING BTREE,
                                              INDEX `hospital_special_relation_hospital_special_id_fk`(`special_id` ASC) USING BTREE,
                                              CONSTRAINT `hospital_special_relation_hospital_info_id_fk` FOREIGN KEY (`hospital_id`) REFERENCES `hospital_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                              CONSTRAINT `hospital_special_relation_hospital_special_id_fk` FOREIGN KEY (`special_id`) REFERENCES `hospital_special` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = ' ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hospital_special_relation
-- ----------------------------
INSERT INTO `hospital_special_relation` VALUES (4, 1000, 10008, '2023-11-04 03:54:25', '2023-11-04 03:54:25');
INSERT INTO `hospital_special_relation` VALUES (5, 1000, 10000, '2023-11-04 03:54:25', '2023-11-04 03:54:25');
INSERT INTO `hospital_special_relation` VALUES (6, 1001, 10000, '2023-11-04 03:54:25', '2023-11-04 03:54:25');
INSERT INTO `hospital_special_relation` VALUES (8, 1000, 10006, '2023-11-04 03:54:25', '2023-11-04 03:54:25');
INSERT INTO `hospital_special_relation` VALUES (9, 1001, 10009, '2023-11-04 03:54:25', '2023-11-04 03:54:25');
INSERT INTO `hospital_special_relation` VALUES (10, 1001, 10010, '2023-11-04 03:54:25', '2023-11-04 03:54:25');
INSERT INTO `hospital_special_relation` VALUES (11, 1002, 10008, '2023-11-04 03:54:25', '2023-11-04 03:54:25');
INSERT INTO `hospital_special_relation` VALUES (12, 1002, 10010, '2023-11-04 03:54:25', '2023-11-04 03:54:25');

-- ----------------------------
-- Table structure for log_account_login
-- ----------------------------
DROP TABLE IF EXISTS `log_account_login`;
CREATE TABLE `log_account_login`  (
                                      `id` bigint NOT NULL AUTO_INCREMENT COMMENT '登录记录编号',
                                      `account_id` bigint NOT NULL COMMENT '账号编号',
                                      `account_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账号名称',
                                      `ip_address` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip地址',
                                      `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                      `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                      PRIMARY KEY (`id`) USING BTREE,
                                      INDEX `log_account_login_power_account_id_fk`(`account_id` ASC) USING BTREE,
                                      CONSTRAINT `log_account_login_power_account_id_fk` FOREIGN KEY (`account_id`) REFERENCES `power_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10063 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '账号登录记录表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of log_account_login
-- ----------------------------
INSERT INTO `log_account_login` VALUES (10059, 10000005, 'admin', '172.22.0.1', '2023-11-04 02:47:56', '2023-11-04 02:47:56');
INSERT INTO `log_account_login` VALUES (10060, 10000007, '10008', '172.22.0.1', '2023-11-04 02:51:16', '2023-11-04 02:51:16');
INSERT INTO `log_account_login` VALUES (10061, 10000008, '18100176437', '172.22.0.1', '2023-11-04 02:52:27', '2023-11-04 02:52:27');
INSERT INTO `log_account_login` VALUES (10062, 10000005, 'admin', '172.22.0.1', '2023-11-04 02:53:36', '2023-11-04 02:53:36');

-- ----------------------------
-- Table structure for log_operation
-- ----------------------------
DROP TABLE IF EXISTS `log_operation`;
CREATE TABLE `log_operation`  (
                                  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
                                  `account_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账号名称',
                                  `start_time` bigint NULL DEFAULT NULL COMMENT '开始时间',
                                  `spend_time` int NULL DEFAULT NULL COMMENT '消耗时间',
                                  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作描述',
                                  `base_path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '根路径',
                                  `uri` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'uri',
                                  `url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'url',
                                  `method` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求方法',
                                  `ip_address` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip地址',
                                  `parameter` varchar(3072) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求参数',
                                  `result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '请求结果',
                                  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                  PRIMARY KEY (`id`) USING BTREE,
                                  INDEX `log_operation_power_account_name_fk`(`account_name` ASC) USING BTREE,
                                  CONSTRAINT `log_operation_power_account_name_fk` FOREIGN KEY (`account_name`) REFERENCES `power_account` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 12041 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户操作记录表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of log_operation
-- ----------------------------
INSERT INTO `log_operation` VALUES (11924, NULL, 1699066075501, 394, '账号登录', 'http://localhost:8080', '/hospital/power/account/login', 'http://localhost:8080/hospital/power/account/login', 'GET', NULL, '[{name=admin}, {password=8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918}]', 'CommonResult{code=200, message=\'操作成功\', data=Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImNyZWF0ZWQiOjE2OTkwNjYwNzU3OTksImV4cCI6MTY5OTY3MDg3NX0.qhsVYIuBa682SzQatVfxPqA25TXRuaFe2rrGSnxbkLbR8MHtQgWuSf6dNfdTklTBPUV31vP-UxDdaunpYR2JWw}', '2023-11-04 02:47:56', '2023-11-04 02:47:56');
INSERT INTO `log_operation` VALUES (11925, 'admin', 1699066076072, 3, '获取当前账号信息', 'http://localhost:8080', '/hospital/power/account/info', 'http://localhost:8080/hospital/power/account/info', 'GET', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data={accountId=10000005, roles=[Ljava.lang.String;@3a22b767, menus=[], userName=admin}}', '2023-11-04 02:47:56', '2023-11-04 02:47:56');
INSERT INTO `log_operation` VALUES (11926, 'admin', 1699066081581, 39, '分页：通过专科编号，获取所属门诊信息', 'http://localhost:8080', '/hospital/hospital/special/list/outpatient', 'http://localhost:8080/hospital/hospital/special/list/outpatient', 'GET', NULL, '[{specialId=null}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=4, total=16, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=16, pages=4, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:48:02', '2023-11-04 02:48:02');
INSERT INTO `log_operation` VALUES (11927, 'admin', 1699066081581, 39, '分页：搜索专科信息', 'http://localhost:8080', '/hospital/hospital/special/list', 'http://localhost:8080/hospital/hospital/special/list', 'GET', NULL, '[{name=}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=5, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=5, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:48:02', '2023-11-04 02:48:02');
INSERT INTO `log_operation` VALUES (11928, 'admin', 1699066083856, 14, '获取门诊所属诊室信息', 'http://localhost:8080', '/hospital/hospital/outpatient/clinic/list/10002', 'http://localhost:8080/hospital/hospital/outpatient/clinic/list/10002', 'GET', NULL, '[{pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=0, total=0, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=0, pages=0, countSignal=true, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:48:04', '2023-11-04 02:48:04');
INSERT INTO `log_operation` VALUES (11929, 'admin', 1699066102459, 16, '添加诊室信息', 'http://localhost:8080', '/hospital/hospital/clinic', 'http://localhost:8080/hospital/hospital/clinic', 'POST', NULL, 'HospitalClinicParam(outpatientId=10002, address=儿童发热诊室-101)', 'CommonResult{code=200, message=\'操作成功\', data=null}', '2023-11-04 02:48:22', '2023-11-04 02:48:22');
INSERT INTO `log_operation` VALUES (11930, 'admin', 1699066102500, 4, '获取门诊所属诊室信息', 'http://localhost:8080', '/hospital/hospital/outpatient/clinic/list/10002', 'http://localhost:8080/hospital/hospital/outpatient/clinic/list/10002', 'GET', NULL, '[{pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=1, total=1, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=1, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:48:23', '2023-11-04 02:48:23');
INSERT INTO `log_operation` VALUES (11931, 'admin', 1699066113775, 7, '添加诊室信息', 'http://localhost:8080', '/hospital/hospital/clinic', 'http://localhost:8080/hospital/hospital/clinic', 'POST', NULL, 'HospitalClinicParam(outpatientId=10002, address=儿童发热诊室-102)', 'CommonResult{code=200, message=\'操作成功\', data=null}', '2023-11-04 02:48:34', '2023-11-04 02:48:34');
INSERT INTO `log_operation` VALUES (11932, 'admin', 1699066113804, 5, '获取门诊所属诊室信息', 'http://localhost:8080', '/hospital/hospital/outpatient/clinic/list/10002', 'http://localhost:8080/hospital/hospital/outpatient/clinic/list/10002', 'GET', NULL, '[{pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=1, total=2, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=2, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:48:34', '2023-11-04 02:48:34');
INSERT INTO `log_operation` VALUES (11933, 'admin', 1699066116023, 2, '分页：搜索专科信息', 'http://localhost:8080', '/hospital/hospital/special/list', 'http://localhost:8080/hospital/hospital/special/list', 'GET', NULL, '[{name=null}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=1, total=5, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=5, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:48:36', '2023-11-04 02:48:36');
INSERT INTO `log_operation` VALUES (11934, 'admin', 1699066116023, 11, '分页：搜索医院信息', 'http://localhost:8080', '/hospital/hospital/info/list', 'http://localhost:8080/hospital/hospital/info/list', 'GET', NULL, '[{name=null}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=1, total=4, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=4, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:48:36', '2023-11-04 02:48:36');
INSERT INTO `log_operation` VALUES (11935, 'admin', 1699066116058, 12, '获取医院，所属专科列表', 'http://localhost:8080', '/hospital/hospital/special/list/1000', 'http://localhost:8080/hospital/hospital/special/list/1000', 'GET', NULL, '[{pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=1, total=3, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=3, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:48:36', '2023-11-04 02:48:36');
INSERT INTO `log_operation` VALUES (11936, 'admin', 1699066117108, 3, '分页：通过专科编号，获取所属门诊信息', 'http://localhost:8080', '/hospital/hospital/special/list/outpatient', 'http://localhost:8080/hospital/hospital/special/list/outpatient', 'GET', NULL, '[{specialId=null}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=4, total=16, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=16, pages=4, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:48:37', '2023-11-04 02:48:37');
INSERT INTO `log_operation` VALUES (11937, 'admin', 1699066117108, 6, '分页：搜索专科信息', 'http://localhost:8080', '/hospital/hospital/special/list', 'http://localhost:8080/hospital/hospital/special/list', 'GET', NULL, '[{name=}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=5, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=5, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:48:37', '2023-11-04 02:48:37');
INSERT INTO `log_operation` VALUES (11938, 'admin', 1699066117525, 3, '分页：搜索医院信息', 'http://localhost:8080', '/hospital/hospital/info/list', 'http://localhost:8080/hospital/hospital/info/list', 'GET', NULL, '[{name=null}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=1, total=4, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=4, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:48:38', '2023-11-04 02:48:38');
INSERT INTO `log_operation` VALUES (11939, 'admin', 1699066117524, 4, '分页：搜索专科信息', 'http://localhost:8080', '/hospital/hospital/special/list', 'http://localhost:8080/hospital/hospital/special/list', 'GET', NULL, '[{name=null}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=1, total=5, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=5, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:48:38', '2023-11-04 02:48:38');
INSERT INTO `log_operation` VALUES (11940, 'admin', 1699066117551, 5, '获取医院，所属专科列表', 'http://localhost:8080', '/hospital/hospital/special/list/1000', 'http://localhost:8080/hospital/hospital/special/list/1000', 'GET', NULL, '[{pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=1, total=3, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=3, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:48:38', '2023-11-04 02:48:38');
INSERT INTO `log_operation` VALUES (11941, 'admin', 1699066117841, 2, '分页：搜索专科信息', 'http://localhost:8080', '/hospital/hospital/special/list', 'http://localhost:8080/hospital/hospital/special/list', 'GET', NULL, '[{name=}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=1, total=5, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=5, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:48:38', '2023-11-04 02:48:38');
INSERT INTO `log_operation` VALUES (11942, 'admin', 1699066119937, 3, '分页：搜索专科信息', 'http://localhost:8080', '/hospital/hospital/special/list', 'http://localhost:8080/hospital/hospital/special/list', 'GET', NULL, '[{name=}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=5, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=5, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:48:40', '2023-11-04 02:48:40');
INSERT INTO `log_operation` VALUES (11943, 'admin', 1699066119960, 4, '分页：通过专科编号，获取所属门诊信息', 'http://localhost:8080', '/hospital/hospital/special/list/outpatient', 'http://localhost:8080/hospital/hospital/special/list/outpatient', 'GET', NULL, '[{specialId=10000}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=4, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=4, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:48:40', '2023-11-04 02:48:40');
INSERT INTO `log_operation` VALUES (11944, 'admin', 1699066119985, 10, '分页：通过姓名、专科、门诊，搜索医生信息', 'http://localhost:8080', '/hospital/hospital/doctor/list/name', 'http://localhost:8080/hospital/hospital/doctor/list/name', 'GET', NULL, '[{name=}, {specialId=10000}, {outpatientId=10005}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=0, totalPage=1, total=0, list=[]}}', '2023-11-04 02:48:40', '2023-11-04 02:48:40');
INSERT INTO `log_operation` VALUES (11945, 'admin', 1699066132513, 2, '分页：搜索专科信息', 'http://localhost:8080', '/hospital/hospital/special/list', 'http://localhost:8080/hospital/hospital/special/list', 'GET', NULL, '[{name=}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=5, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=5, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:48:53', '2023-11-04 02:48:53');
INSERT INTO `log_operation` VALUES (11946, 'admin', 1699066132536, 5, '分页：通过专科编号，获取所属门诊信息', 'http://localhost:8080', '/hospital/hospital/special/list/outpatient', 'http://localhost:8080/hospital/hospital/special/list/outpatient', 'GET', NULL, '[{specialId=10000}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=4, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=4, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:48:53', '2023-11-04 02:48:53');
INSERT INTO `log_operation` VALUES (11947, 'admin', 1699066132559, 2, '分页：通过姓名、专科、门诊，搜索医生信息', 'http://localhost:8080', '/hospital/hospital/doctor/list/name', 'http://localhost:8080/hospital/hospital/doctor/list/name', 'GET', NULL, '[{name=}, {specialId=10000}, {outpatientId=10005}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=0, totalPage=1, total=0, list=[]}}', '2023-11-04 02:48:53', '2023-11-04 02:48:53');
INSERT INTO `log_operation` VALUES (11948, 'admin', 1699066143840, 2, '分页：通过专科编号，获取所属门诊信息', 'http://localhost:8080', '/hospital/hospital/special/list/outpatient', 'http://localhost:8080/hospital/hospital/special/list/outpatient', 'GET', NULL, '[{specialId=10008}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=3, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=3, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:49:04', '2023-11-04 02:49:04');
INSERT INTO `log_operation` VALUES (11949, 'admin', 1699066143869, 1, '分页：通过姓名、专科、门诊，搜索医生信息', 'http://localhost:8080', '/hospital/hospital/doctor/list/name', 'http://localhost:8080/hospital/hospital/doctor/list/name', 'GET', NULL, '[{name=}, {specialId=10008}, {outpatientId=10002}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=0, totalPage=1, total=0, list=[]}}', '2023-11-04 02:49:04', '2023-11-04 02:49:04');
INSERT INTO `log_operation` VALUES (11950, 'admin', 1699066160116, 11, '添加医生信息', 'http://localhost:8080', '/hospital/hospital/doctor', 'http://localhost:8080/hospital/hospital/doctor', 'POST', NULL, 'HospitalDoctorParam(name=儿童-张三, gender=1, jobTitle=医师, specialty=儿童专家, specialId=10008, outpatientId=10002)', 'CommonResult{code=200, message=\'操作成功\', data=null}', '2023-11-04 02:49:20', '2023-11-04 02:49:20');
INSERT INTO `log_operation` VALUES (11951, 'admin', 1699066162711, 2, '分页：搜索专科信息', 'http://localhost:8080', '/hospital/hospital/special/list', 'http://localhost:8080/hospital/hospital/special/list', 'GET', NULL, '[{name=}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=5, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=5, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:49:23', '2023-11-04 02:49:23');
INSERT INTO `log_operation` VALUES (11952, 'admin', 1699066162731, 3, '分页：通过专科编号，获取所属门诊信息', 'http://localhost:8080', '/hospital/hospital/special/list/outpatient', 'http://localhost:8080/hospital/hospital/special/list/outpatient', 'GET', NULL, '[{specialId=10000}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=4, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=4, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:49:23', '2023-11-04 02:49:23');
INSERT INTO `log_operation` VALUES (11953, 'admin', 1699066162752, 1, '分页：通过姓名、专科、门诊，搜索医生信息', 'http://localhost:8080', '/hospital/hospital/doctor/list/name', 'http://localhost:8080/hospital/hospital/doctor/list/name', 'GET', NULL, '[{name=}, {specialId=10000}, {outpatientId=10005}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=0, totalPage=1, total=0, list=[]}}', '2023-11-04 02:49:23', '2023-11-04 02:49:23');
INSERT INTO `log_operation` VALUES (11954, 'admin', 1699066165240, 2, '分页：通过专科编号，获取所属门诊信息', 'http://localhost:8080', '/hospital/hospital/special/list/outpatient', 'http://localhost:8080/hospital/hospital/special/list/outpatient', 'GET', NULL, '[{specialId=10008}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=3, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=3, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:49:25', '2023-11-04 02:49:25');
INSERT INTO `log_operation` VALUES (11955, 'admin', 1699066165262, 8, '分页：通过姓名、专科、门诊，搜索医生信息', 'http://localhost:8080', '/hospital/hospital/doctor/list/name', 'http://localhost:8080/hospital/hospital/doctor/list/name', 'GET', NULL, '[{name=}, {specialId=10008}, {outpatientId=10002}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=1, totalPage=1, total=1, list=[HospitalDoctorDTO(specialName=儿科, outpatientName=儿童发热)]}}', '2023-11-04 02:49:25', '2023-11-04 02:49:25');
INSERT INTO `log_operation` VALUES (11956, 'admin', 1699066166938, 71, '管理账号注册', 'http://localhost:8080', '/hospital/power/account/admin/register', 'http://localhost:8080/hospital/power/account/admin/register', 'POST', NULL, 'PowerAccountRegisterParam(name=10008, password=8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92)', 'CommonResult{code=200, message=\'操作成功\', data=null}', '2023-11-04 02:49:27', '2023-11-04 02:49:27');
INSERT INTO `log_operation` VALUES (11957, 'admin', 1699066275614, 73, '账号登录', 'http://localhost:8080', '/hospital/power/account/login', 'http://localhost:8080/hospital/power/account/login', 'GET', NULL, '[{name=10008}, {password=8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92}]', 'CommonResult{code=200, message=\'操作成功\', data=Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMDAwOCIsImNyZWF0ZWQiOjE2OTkwNjYyNzU2NzQsImV4cCI6MTY5OTY3MTA3NX0.B7LFugvUyVVfSGmoLLDBRzPWZaqC8OKuaXj_9-kGWt8xm49hGP_APPFSuXNN4Wx6EK1tzEImge_hl1byso3fRw}', '2023-11-04 02:51:16', '2023-11-04 02:51:16');
INSERT INTO `log_operation` VALUES (11958, '10008', 1699066275738, 1, '获取当前账号信息', 'http://localhost:8080', '/hospital/power/account/info', 'http://localhost:8080/hospital/power/account/info', 'GET', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data={accountId=10000007, roles=[Ljava.lang.String;@789b653d, menus=[], userName=10008}}', '2023-11-04 02:51:16', '2023-11-04 02:51:16');
INSERT INTO `log_operation` VALUES (11959, '10008', 1699066275742, 7, '获取医生信息', 'http://localhost:8080', '/hospital/hospital/doctor/10008', 'http://localhost:8080/hospital/hospital/doctor/10008', 'GET', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data=HospitalDoctorDTO(specialName=儿科, outpatientName=儿童发热)}', '2023-11-04 02:51:16', '2023-11-04 02:51:16');
INSERT INTO `log_operation` VALUES (11960, '10008', 1699066279483, 56, '查看用户预约情况', 'http://localhost:8080', '/hospital/visit/appointment/user', 'http://localhost:8080/hospital/visit/appointment/user', 'GET', NULL, '[{doctorId=10008}, {date=2023-11-04}, {time=1}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=0, pageSize=0, totalPage=0, total=0, list=null}}', '2023-11-04 02:51:20', '2023-11-04 02:51:20');
INSERT INTO `log_operation` VALUES (11961, '10008', 1699066280572, 9, '根据医生，获取出诊信息', 'http://localhost:8080', '/hospital/visit/plan/doctor', 'http://localhost:8080/hospital/visit/plan/doctor', 'GET', NULL, '[{doctorId=10008}, {startDate=2023-11-05}, {endDate=2023-11-11}]', 'CommonResult{code=200, message=\'操作成功\', data=VisitDoctorPlanDTO(doctorDTO=HospitalDoctorDTO(specialName=儿科, outpatientName=儿童发热), planListDTOList=[])}', '2023-11-04 02:51:21', '2023-11-04 02:51:21');
INSERT INTO `log_operation` VALUES (11962, '10008', 1699066280572, 9, '根据医生，获取出诊信息', 'http://localhost:8080', '/hospital/visit/plan/doctor', 'http://localhost:8080/hospital/visit/plan/doctor', 'GET', NULL, '[{doctorId=10008}, {startDate=2023-10-29}, {endDate=2023-11-04}]', 'CommonResult{code=200, message=\'操作成功\', data=VisitDoctorPlanDTO(doctorDTO=HospitalDoctorDTO(specialName=儿科, outpatientName=儿童发热), planListDTOList=[])}', '2023-11-04 02:51:21', '2023-11-04 02:51:21');
INSERT INTO `log_operation` VALUES (11963, NULL, 1699066301991, 3, '分页：搜索医院信息', 'http://localhost:8080', '/hospital/hospital/info/list', 'http://localhost:8080/hospital/hospital/info/list', 'GET', NULL, '[{name=null}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=4, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=4, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:51:42', '2023-11-04 02:51:42');
INSERT INTO `log_operation` VALUES (11964, NULL, 1699066328346, 467, '发送注册短信', 'http://localhost:8080', '/hospital/user/basic/message', 'http://localhost:8080/hospital/user/basic/message', 'GET', NULL, '{phone=18100176437}', 'CommonResult{code=500, message=\'服务器错误，请联系管理员！\', data=null}', '2023-11-04 02:52:09', '2023-11-04 02:52:09');
INSERT INTO `log_operation` VALUES (11965, NULL, 1699066341644, 12, '校验短信验证码', 'http://localhost:8080', '/hospital/user/basic/code', 'http://localhost:8080/hospital/user/basic/code', 'POST', NULL, '[{phone=18100176437}, {code=141276}]', 'CommonResult{code=200, message=\'操作成功\', data=true}', '2023-11-04 02:52:22', '2023-11-04 02:52:22');
INSERT INTO `log_operation` VALUES (11966, NULL, 1699066341674, 72, '用户账号注册', 'http://localhost:8080', '/hospital/user/basic/account/register', 'http://localhost:8080/hospital/user/basic/account/register', 'POST', NULL, 'UserRegisterParam(name=患者1, avatarUrl=http://localhost:8080/hospital/img/defalut_avatar.png, phone=18100176437, password=648ef899bd7f67e3a0899d4edfa670ff)', 'CommonResult{code=200, message=\'操作成功\', data=null}', '2023-11-04 02:52:22', '2023-11-04 02:52:22');
INSERT INTO `log_operation` VALUES (11967, NULL, 1699066347273, 76, '账号登录', 'http://localhost:8080', '/hospital/power/account/login', 'http://localhost:8080/hospital/power/account/login', 'GET', NULL, '[{name=18100176437}, {password=648ef899bd7f67e3a0899d4edfa670ff}]', 'CommonResult{code=200, message=\'操作成功\', data=Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxODEwMDE3NjQzNyIsImNyZWF0ZWQiOjE2OTkwNjYzNDczMzYsImV4cCI6MTY5OTY3MTE0N30.bAvu7Ar_e0GgHWb7NK37poQoDFsBVri6JaOgPf6i7pLEBhM8U8xkyJYPc8rC4lnKdVwjEAc-SAKIZ18T0M5Caw}', '2023-11-04 02:52:27', '2023-11-04 02:52:27');
INSERT INTO `log_operation` VALUES (11968, '18100176437', 1699066347374, 7, '获取当前用户信息', 'http://localhost:8080', '/hospital/user/basic/info', 'http://localhost:8080/hospital/user/basic/info', 'GET', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data=UserInfoDTO(account=PowerAccount [Hash = 9591878, id=10000008, name=18100176437, password=null, status=1, loginTime=Sat Nov 04 10:52:27 CST 2023, gmtCreate=Sat Nov 04 10:52:22 CST 2023, gmtModified=Sat Nov 04 10:52:22 CST 2023, serialVersionUID=1], basicInfo=UserBasicInfo [Hash = 1220183111, id=4, name=患者1, avatarUrl=http://localhost:8080/hospital/img/defalut_avatar.png, phone=18100176437, gmtCreate=Sat Nov 04 10:52:22 CST 2023, gmtModified=Sat Nov 04 10:52:22 CST 2023, serialVersionUID=1])}', '2023-11-04 02:52:27', '2023-11-04 02:52:27');
INSERT INTO `log_operation` VALUES (11969, '18100176437', 1699066347407, 12, '获取用户就诊卡', 'http://localhost:8080', '/hospital/user/card/list/10000008', 'http://localhost:8080/hospital/user/card/list/10000008', 'GET', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data=[]}', '2023-11-04 02:52:27', '2023-11-04 02:52:27');
INSERT INTO `log_operation` VALUES (11970, '18100176437', 1699066352334, 2, '获取用户就诊卡', 'http://localhost:8080', '/hospital/user/card/list/10000008', 'http://localhost:8080/hospital/user/card/list/10000008', 'GET', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data=[]}', '2023-11-04 02:52:32', '2023-11-04 02:52:32');
INSERT INTO `log_operation` VALUES (11971, '18100176437', 1699066354643, 3, '获取当前用户信息', 'http://localhost:8080', '/hospital/user/basic/info', 'http://localhost:8080/hospital/user/basic/info', 'GET', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data=UserInfoDTO(account=PowerAccount [Hash = 1273205822, id=10000008, name=18100176437, password=null, status=1, loginTime=Sat Nov 04 10:52:27 CST 2023, gmtCreate=Sat Nov 04 10:52:22 CST 2023, gmtModified=Sat Nov 04 10:52:22 CST 2023, serialVersionUID=1], basicInfo=UserBasicInfo [Hash = 628557869, id=4, name=患者1, avatarUrl=http://localhost:8080/hospital/img/defalut_avatar.png, phone=18100176437, gmtCreate=Sat Nov 04 10:52:22 CST 2023, gmtModified=Sat Nov 04 10:52:22 CST 2023, serialVersionUID=1])}', '2023-11-04 02:52:35', '2023-11-04 02:52:35');
INSERT INTO `log_operation` VALUES (11972, '18100176437', 1699066354665, 3, '获取用户就诊卡', 'http://localhost:8080', '/hospital/user/card/list/10000008', 'http://localhost:8080/hospital/user/card/list/10000008', 'GET', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data=[]}', '2023-11-04 02:52:35', '2023-11-04 02:52:35');
INSERT INTO `log_operation` VALUES (11973, '18100176437', 1699066355767, 3, '获取用户就诊卡', 'http://localhost:8080', '/hospital/user/card/list/10000008', 'http://localhost:8080/hospital/user/card/list/10000008', 'GET', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data=[]}', '2023-11-04 02:52:36', '2023-11-04 02:52:36');
INSERT INTO `log_operation` VALUES (11974, '18100176437', 1699066389018, 22, '添加就诊卡', 'http://localhost:8080', '/hospital/user/card/10000008', 'http://localhost:8080/hospital/user/card/10000008', 'POST', NULL, 'UserMedicalCardParam(type=0, name=患者1, gender=1, phone=18100176437, identificationNumber=310721199910122570, birthDate=Tue Oct 12 08:00:00 CST 1999)', 'CommonResult{code=200, message=\'操作成功\', data=null}', '2023-11-04 02:53:09', '2023-11-04 02:53:09');
INSERT INTO `log_operation` VALUES (11975, '18100176437', 1699066389058, 8, '获取用户就诊卡', 'http://localhost:8080', '/hospital/user/card/list/10000008', 'http://localhost:8080/hospital/user/card/list/10000008', 'GET', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data=[UserMedicalCardDTO(relationId=6, type=0, id=7000003, name=患者1, gender=1, phone=18100176437, identificationNumber=310721199910122570, birthDate=Tue Oct 12 08:00:00 CST 1999, gmtCreate=Sat Nov 04 10:53:09 CST 2023, gmtModified=Sat Nov 04 10:53:09 CST 2023)]}', '2023-11-04 02:53:09', '2023-11-04 02:53:09');
INSERT INTO `log_operation` VALUES (11976, '18100176437', 1699066389085, 2, '获取用户就诊卡', 'http://localhost:8080', '/hospital/user/card/list/10000008', 'http://localhost:8080/hospital/user/card/list/10000008', 'GET', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data=[UserMedicalCardDTO(relationId=6, type=0, id=7000003, name=患者1, gender=1, phone=18100176437, identificationNumber=310721199910122570, birthDate=Tue Oct 12 08:00:00 CST 1999, gmtCreate=Sat Nov 04 10:53:09 CST 2023, gmtModified=Sat Nov 04 10:53:09 CST 2023)]}', '2023-11-04 02:53:09', '2023-11-04 02:53:09');
INSERT INTO `log_operation` VALUES (11977, '18100176437', 1699066390923, 2, '获取当前用户信息', 'http://localhost:8080', '/hospital/user/basic/info', 'http://localhost:8080/hospital/user/basic/info', 'GET', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data=UserInfoDTO(account=PowerAccount [Hash = 688422449, id=10000008, name=18100176437, password=null, status=1, loginTime=Sat Nov 04 10:52:27 CST 2023, gmtCreate=Sat Nov 04 10:52:22 CST 2023, gmtModified=Sat Nov 04 10:52:22 CST 2023, serialVersionUID=1], basicInfo=UserBasicInfo [Hash = 1791634116, id=4, name=患者1, avatarUrl=http://localhost:8080/hospital/img/defalut_avatar.png, phone=18100176437, gmtCreate=Sat Nov 04 10:52:22 CST 2023, gmtModified=Sat Nov 04 10:52:22 CST 2023, serialVersionUID=1])}', '2023-11-04 02:53:11', '2023-11-04 02:53:11');
INSERT INTO `log_operation` VALUES (11978, '18100176437', 1699066390942, 3, '获取用户就诊卡', 'http://localhost:8080', '/hospital/user/card/list/10000008', 'http://localhost:8080/hospital/user/card/list/10000008', 'GET', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data=[UserMedicalCardDTO(relationId=6, type=0, id=7000003, name=患者1, gender=1, phone=18100176437, identificationNumber=310721199910122570, birthDate=Tue Oct 12 08:00:00 CST 1999, gmtCreate=Sat Nov 04 10:53:09 CST 2023, gmtModified=Sat Nov 04 10:53:09 CST 2023)]}', '2023-11-04 02:53:11', '2023-11-04 02:53:11');
INSERT INTO `log_operation` VALUES (11979, '18100176437', 1699066394071, 4, '获取医院，所属专科列表', 'http://localhost:8080', '/hospital/hospital/special/list/1000', 'http://localhost:8080/hospital/hospital/special/list/1000', 'GET', NULL, '[{pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=3, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=3, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:53:14', '2023-11-04 02:53:14');
INSERT INTO `log_operation` VALUES (11980, '18100176437', 1699066394095, 18, '分页：查找指定医院、专科的门诊列表', 'http://localhost:8080', '/hospital/hospital/outpatient/list', 'http://localhost:8080/hospital/hospital/outpatient/list', 'GET', NULL, '[{hospitalId=1000}, {specialId=10000}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=4, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=4, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:53:14', '2023-11-04 02:53:14');
INSERT INTO `log_operation` VALUES (11981, '18100176437', 1699066395235, 9, '分页：查找指定医院、专科的门诊列表', 'http://localhost:8080', '/hospital/hospital/outpatient/list', 'http://localhost:8080/hospital/hospital/outpatient/list', 'GET', NULL, '[{hospitalId=1000}, {specialId=10008}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=2, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=2, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:53:15', '2023-11-04 02:53:15');
INSERT INTO `log_operation` VALUES (11982, '18100176437', 1699066396475, 7, '搜索出诊计划', 'http://localhost:8080', '/hospital/visit/plan/list', 'http://localhost:8080/hospital/visit/plan/list', 'GET', NULL, '[{hospitalId=1000}, {specialId=10008}, {outpatientId=10002}, {day=2023-11-04}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=0, totalPage=1, total=0, list=[]}}', '2023-11-04 02:53:16', '2023-11-04 02:53:16');
INSERT INTO `log_operation` VALUES (11983, '18100176437', 1699066396474, 8, '分页：搜索医院信息', 'http://localhost:8080', '/hospital/hospital/info/list', 'http://localhost:8080/hospital/hospital/info/list', 'GET', NULL, '[{name=null}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=4, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=4, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:53:16', '2023-11-04 02:53:16');
INSERT INTO `log_operation` VALUES (11984, '18100176437', 1699066399767, 4, '搜索出诊计划', 'http://localhost:8080', '/hospital/visit/plan/list', 'http://localhost:8080/hospital/visit/plan/list', 'GET', NULL, '[{hospitalId=1000}, {specialId=10008}, {outpatientId=10002}, {day=2023-11-05}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=0, totalPage=1, total=0, list=[]}}', '2023-11-04 02:53:20', '2023-11-04 02:53:20');
INSERT INTO `log_operation` VALUES (11985, '18100176437', 1699066400270, 2, '搜索出诊计划', 'http://localhost:8080', '/hospital/visit/plan/list', 'http://localhost:8080/hospital/visit/plan/list', 'GET', NULL, '[{hospitalId=1000}, {specialId=10008}, {outpatientId=10002}, {day=2023-11-06}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=0, totalPage=1, total=0, list=[]}}', '2023-11-04 02:53:20', '2023-11-04 02:53:20');
INSERT INTO `log_operation` VALUES (11986, '18100176437', 1699066400586, 2, '搜索出诊计划', 'http://localhost:8080', '/hospital/visit/plan/list', 'http://localhost:8080/hospital/visit/plan/list', 'GET', NULL, '[{hospitalId=1000}, {specialId=10008}, {outpatientId=10002}, {day=2023-11-05}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=0, totalPage=1, total=0, list=[]}}', '2023-11-04 02:53:21', '2023-11-04 02:53:21');
INSERT INTO `log_operation` VALUES (11987, '18100176437', 1699066400836, 2, '搜索出诊计划', 'http://localhost:8080', '/hospital/visit/plan/list', 'http://localhost:8080/hospital/visit/plan/list', 'GET', NULL, '[{hospitalId=1000}, {specialId=10008}, {outpatientId=10002}, {day=2023-11-04}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=0, totalPage=1, total=0, list=[]}}', '2023-11-04 02:53:21', '2023-11-04 02:53:21');
INSERT INTO `log_operation` VALUES (11988, '10008', 1699066408194, 2, '获取当前账号信息', 'http://localhost:8080', '/hospital/power/account/info', 'http://localhost:8080/hospital/power/account/info', 'GET', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data={accountId=10000007, roles=[Ljava.lang.String;@451fd2c, menus=[], userName=10008}}', '2023-11-04 02:53:28', '2023-11-04 02:53:28');
INSERT INTO `log_operation` VALUES (11989, '10008', 1699066408194, 3, '获取医生信息', 'http://localhost:8080', '/hospital/hospital/doctor/10008', 'http://localhost:8080/hospital/hospital/doctor/10008', 'GET', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data=HospitalDoctorDTO(specialName=儿科, outpatientName=儿童发热)}', '2023-11-04 02:53:28', '2023-11-04 02:53:28');
INSERT INTO `log_operation` VALUES (11990, '10008', 1699066415646, 72, '账号登录', 'http://localhost:8080', '/hospital/power/account/login', 'http://localhost:8080/hospital/power/account/login', 'GET', NULL, '[{name=admin}, {password=8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918}]', 'CommonResult{code=200, message=\'操作成功\', data=Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImNyZWF0ZWQiOjE2OTkwNjY0MTU3MDYsImV4cCI6MTY5OTY3MTIxNX0.qCLPkn-AGi0uzTV9l00exab5Zyx_iFeKxJCPiFRuqlYETssXbNiZDkjBpJT2fdw7nJOpbb_zPaTmZ8ICsTalzg}', '2023-11-04 02:53:36', '2023-11-04 02:53:36');
INSERT INTO `log_operation` VALUES (11991, 'admin', 1699066415745, 2, '获取当前账号信息', 'http://localhost:8080', '/hospital/power/account/info', 'http://localhost:8080/hospital/power/account/info', 'GET', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data={accountId=10000005, roles=[Ljava.lang.String;@3d38eb25, menus=[], userName=admin}}', '2023-11-04 02:53:36', '2023-11-04 02:53:36');
INSERT INTO `log_operation` VALUES (11992, 'admin', 1699066419013, 2, '分页：通过专科编号，获取所属门诊信息', 'http://localhost:8080', '/hospital/hospital/special/list/outpatient', 'http://localhost:8080/hospital/hospital/special/list/outpatient', 'GET', NULL, '[{specialId=null}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=4, total=16, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=16, pages=4, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:53:39', '2023-11-04 02:53:39');
INSERT INTO `log_operation` VALUES (11993, 'admin', 1699066419014, 2, '分页：搜索专科信息', 'http://localhost:8080', '/hospital/hospital/special/list', 'http://localhost:8080/hospital/hospital/special/list', 'GET', NULL, '[{name=}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=5, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=5, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:53:39', '2023-11-04 02:53:39');
INSERT INTO `log_operation` VALUES (11994, 'admin', 1699066420761, 2, '分页：搜索医院信息', 'http://localhost:8080', '/hospital/hospital/info/list', 'http://localhost:8080/hospital/hospital/info/list', 'GET', NULL, '[{name=}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=4, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=4, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:53:41', '2023-11-04 02:53:41');
INSERT INTO `log_operation` VALUES (11995, 'admin', 1699066420782, 4, '获取医院，所属专科列表', 'http://localhost:8080', '/hospital/hospital/special/list/1000', 'http://localhost:8080/hospital/hospital/special/list/1000', 'GET', NULL, '[{pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=3, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=3, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:53:41', '2023-11-04 02:53:41');
INSERT INTO `log_operation` VALUES (11996, 'admin', 1699066420803, 5, '分页：查找指定医院、专科的门诊列表', 'http://localhost:8080', '/hospital/hospital/outpatient/list', 'http://localhost:8080/hospital/hospital/outpatient/list', 'GET', NULL, '[{hospitalId=1000}, {specialId=10000}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=4, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=4, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:53:41', '2023-11-04 02:53:41');
INSERT INTO `log_operation` VALUES (11997, 'admin', 1699066420828, 2, '搜索出诊计划', 'http://localhost:8080', '/hospital/visit/plan/list', 'http://localhost:8080/hospital/visit/plan/list', 'GET', NULL, '[{hospitalId=1000}, {specialId=10000}, {outpatientId=10005}, {day=2023-11-04}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=0, totalPage=1, total=0, list=[]}}', '2023-11-04 02:53:41', '2023-11-04 02:53:41');
INSERT INTO `log_operation` VALUES (11998, 'admin', 1699066420850, 1, '分页：通过姓名、专科、门诊，搜索医生信息', 'http://localhost:8080', '/hospital/hospital/doctor/list/name', 'http://localhost:8080/hospital/hospital/doctor/list/name', 'GET', NULL, '[{name=}, {specialId=10000}, {outpatientId=10005}, {pageNum=1}, {pageSize=100}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=0, totalPage=1, total=0, list=[]}}', '2023-11-04 02:53:41', '2023-11-04 02:53:41');
INSERT INTO `log_operation` VALUES (11999, 'admin', 1699066422968, 4, '分页：查找指定医院、专科的门诊列表', 'http://localhost:8080', '/hospital/hospital/outpatient/list', 'http://localhost:8080/hospital/hospital/outpatient/list', 'GET', NULL, '[{hospitalId=1000}, {specialId=10008}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=2, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=2, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:53:43', '2023-11-04 02:53:43');
INSERT INTO `log_operation` VALUES (12000, 'admin', 1699066422990, 1, '搜索出诊计划', 'http://localhost:8080', '/hospital/visit/plan/list', 'http://localhost:8080/hospital/visit/plan/list', 'GET', NULL, '[{hospitalId=1000}, {specialId=10008}, {outpatientId=10002}, {day=2023-11-04}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=0, totalPage=1, total=0, list=[]}}', '2023-11-04 02:53:43', '2023-11-04 02:53:43');
INSERT INTO `log_operation` VALUES (12001, 'admin', 1699066423007, 3, '分页：通过姓名、专科、门诊，搜索医生信息', 'http://localhost:8080', '/hospital/hospital/doctor/list/name', 'http://localhost:8080/hospital/hospital/doctor/list/name', 'GET', NULL, '[{name=}, {specialId=10008}, {outpatientId=10002}, {pageNum=1}, {pageSize=100}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=1, totalPage=1, total=1, list=[HospitalDoctorDTO(specialName=儿科, outpatientName=儿童发热)]}}', '2023-11-04 02:53:43', '2023-11-04 02:53:43');
INSERT INTO `log_operation` VALUES (12002, 'admin', 1699066423029, 2, '获取门诊所属诊室信息', 'http://localhost:8080', '/hospital/hospital/outpatient/clinic/list/10002', 'http://localhost:8080/hospital/hospital/outpatient/clinic/list/10002', 'GET', NULL, '[{pageNum=1}, {pageSize=100}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=100, totalPage=1, total=2, list=Page{count=true, pageNum=1, pageSize=100, startRow=0, endRow=100, total=2, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:53:43', '2023-11-04 02:53:43');
INSERT INTO `log_operation` VALUES (12003, 'admin', 1699066432509, 10, '添加出诊计划', 'http://localhost:8080', '/hospital/visit/plan', 'http://localhost:8080/hospital/visit/plan', 'POST', NULL, 'VisitPlanParam(hospitalId=1000, specialId=10008, outpatientId=10002, clinicId=10006, doctorId=10008, time=1, day=Sat Nov 04 10:53:40 CST 2023)', 'CommonResult{code=200, message=\'操作成功\', data=null}', '2023-11-04 02:53:53', '2023-11-04 02:53:53');
INSERT INTO `log_operation` VALUES (12004, 'admin', 1699066432540, 9, '搜索出诊计划', 'http://localhost:8080', '/hospital/visit/plan/list', 'http://localhost:8080/hospital/visit/plan/list', 'GET', NULL, '[{hospitalId=1000}, {specialId=10008}, {outpatientId=10002}, {day=2023-11-04}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=1, totalPage=1, total=1, list=[VisitPlanDTO(doctorName=儿童-张三, clinicName=儿童发热诊室-101, specialName=儿科, outpatientName=儿童发热, hospitalName=广东省中医院)]}}', '2023-11-04 02:53:53', '2023-11-04 02:53:53');
INSERT INTO `log_operation` VALUES (12005, 'admin', 1699066432576, 4, '分页：通过姓名、专科、门诊，搜索医生信息', 'http://localhost:8080', '/hospital/hospital/doctor/list/name', 'http://localhost:8080/hospital/hospital/doctor/list/name', 'GET', NULL, '[{name=}, {specialId=10008}, {outpatientId=10002}, {pageNum=1}, {pageSize=100}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=1, totalPage=1, total=1, list=[HospitalDoctorDTO(specialName=儿科, outpatientName=儿童发热)]}}', '2023-11-04 02:53:53', '2023-11-04 02:53:53');
INSERT INTO `log_operation` VALUES (12006, 'admin', 1699066432596, 3, '获取门诊所属诊室信息', 'http://localhost:8080', '/hospital/hospital/outpatient/clinic/list/10002', 'http://localhost:8080/hospital/hospital/outpatient/clinic/list/10002', 'GET', NULL, '[{pageNum=1}, {pageSize=100}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=100, totalPage=1, total=2, list=Page{count=true, pageNum=1, pageSize=100, startRow=0, endRow=100, total=2, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:53:53', '2023-11-04 02:53:53');
INSERT INTO `log_operation` VALUES (12007, '18100176437', 1699066450695, 3, '获取医院，所属专科列表', 'http://localhost:8080', '/hospital/hospital/special/list/1000', 'http://localhost:8080/hospital/hospital/special/list/1000', 'GET', NULL, '[{pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=3, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=3, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:11', '2023-11-04 02:54:11');
INSERT INTO `log_operation` VALUES (12008, '18100176437', 1699066450714, 5, '分页：查找指定医院、专科的门诊列表', 'http://localhost:8080', '/hospital/hospital/outpatient/list', 'http://localhost:8080/hospital/hospital/outpatient/list', 'GET', NULL, '[{hospitalId=1000}, {specialId=10000}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=4, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=4, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:11', '2023-11-04 02:54:11');
INSERT INTO `log_operation` VALUES (12009, '18100176437', 1699066452128, 5, '分页：查找指定医院、专科的门诊列表', 'http://localhost:8080', '/hospital/hospital/outpatient/list', 'http://localhost:8080/hospital/hospital/outpatient/list', 'GET', NULL, '[{hospitalId=1000}, {specialId=10008}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=2, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=2, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:12', '2023-11-04 02:54:12');
INSERT INTO `log_operation` VALUES (12010, '18100176437', 1699066452649, 2, '分页：搜索医院信息', 'http://localhost:8080', '/hospital/hospital/info/list', 'http://localhost:8080/hospital/hospital/info/list', 'GET', NULL, '[{name=null}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=4, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=4, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:13', '2023-11-04 02:54:13');
INSERT INTO `log_operation` VALUES (12011, '18100176437', 1699066452646, 7, '搜索出诊计划', 'http://localhost:8080', '/hospital/visit/plan/list', 'http://localhost:8080/hospital/visit/plan/list', 'GET', NULL, '[{hospitalId=1000}, {specialId=10008}, {outpatientId=10002}, {day=2023-11-04}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=1, totalPage=1, total=1, list=[VisitPlanDTO(doctorName=儿童-张三, clinicName=儿童发热诊室-101, specialName=儿科, outpatientName=儿童发热, hospitalName=广东省中医院)]}}', '2023-11-04 02:54:13', '2023-11-04 02:54:13');
INSERT INTO `log_operation` VALUES (12012, '18100176437', 1699066452677, 3, '获取医生信息', 'http://localhost:8080', '/hospital/hospital/doctor/10008', 'http://localhost:8080/hospital/hospital/doctor/10008', 'GET', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data=HospitalDoctorDTO(specialName=儿科, outpatientName=儿童发热)}', '2023-11-04 02:54:13', '2023-11-04 02:54:13');
INSERT INTO `log_operation` VALUES (12013, '18100176437', 1699066454325, 16, '根据医生编号、日期，获取出诊信息', 'http://localhost:8080', '/hospital/visit/plan/doctor/date', 'http://localhost:8080/hospital/visit/plan/doctor/date', 'GET', NULL, '[{hospitalId=1000}, {doctorId=10008}, {date=2023-11-04}]', 'CommonResult{code=200, message=\'操作成功\', data=[VisitPlanResiduesDTO(residues=[5, 5, 5, 5, 5, 5, 5])]}', '2023-11-04 02:54:14', '2023-11-04 02:54:14');
INSERT INTO `log_operation` VALUES (12014, '18100176437', 1699066461037, 5, '获取医院，所属专科列表', 'http://localhost:8080', '/hospital/hospital/special/list/1001', 'http://localhost:8080/hospital/hospital/special/list/1001', 'GET', NULL, '[{pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=3, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=3, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:21', '2023-11-04 02:54:21');
INSERT INTO `log_operation` VALUES (12015, '18100176437', 1699066461062, 4, '分页：查找指定医院、专科的门诊列表', 'http://localhost:8080', '/hospital/hospital/outpatient/list', 'http://localhost:8080/hospital/hospital/outpatient/list', 'GET', NULL, '[{hospitalId=1001}, {specialId=10000}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=2, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=2, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:21', '2023-11-04 02:54:21');
INSERT INTO `log_operation` VALUES (12016, '18100176437', 1699066462659, 4, '分页：查找指定医院、专科的门诊列表', 'http://localhost:8080', '/hospital/hospital/outpatient/list', 'http://localhost:8080/hospital/hospital/outpatient/list', 'GET', NULL, '[{hospitalId=1001}, {specialId=10009}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=0, total=0, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=0, pages=0, countSignal=true, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:23', '2023-11-04 02:54:23');
INSERT INTO `log_operation` VALUES (12017, '18100176437', 1699066463021, 2, '分页：查找指定医院、专科的门诊列表', 'http://localhost:8080', '/hospital/hospital/outpatient/list', 'http://localhost:8080/hospital/hospital/outpatient/list', 'GET', NULL, '[{hospitalId=1001}, {specialId=10010}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=0, total=0, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=0, pages=0, countSignal=true, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:23', '2023-11-04 02:54:23');
INSERT INTO `log_operation` VALUES (12018, 'admin', 1699066474509, 9, '删除出诊计划', 'http://localhost:8080', '/hospital/visit/plan/10042', 'http://localhost:8080/hospital/visit/plan/10042', 'DELETE', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data=null}', '2023-11-04 02:54:35', '2023-11-04 02:54:35');
INSERT INTO `log_operation` VALUES (12019, 'admin', 1699066476063, 2, '分页：搜索医院信息', 'http://localhost:8080', '/hospital/hospital/info/list', 'http://localhost:8080/hospital/hospital/info/list', 'GET', NULL, '[{name=}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=1, total=4, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=4, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:36', '2023-11-04 02:54:36');
INSERT INTO `log_operation` VALUES (12020, 'admin', 1699066478263, 2, '分页：通过专科编号，获取所属门诊信息', 'http://localhost:8080', '/hospital/hospital/special/list/outpatient', 'http://localhost:8080/hospital/hospital/special/list/outpatient', 'GET', NULL, '[{specialId=null}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=4, total=16, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=16, pages=4, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:38', '2023-11-04 02:54:38');
INSERT INTO `log_operation` VALUES (12021, 'admin', 1699066478265, 2, '分页：搜索专科信息', 'http://localhost:8080', '/hospital/hospital/special/list', 'http://localhost:8080/hospital/hospital/special/list', 'GET', NULL, '[{name=}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=5, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=5, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:38', '2023-11-04 02:54:38');
INSERT INTO `log_operation` VALUES (12022, 'admin', 1699066481045, 3, '获取门诊所属诊室信息', 'http://localhost:8080', '/hospital/hospital/outpatient/clinic/list/10002', 'http://localhost:8080/hospital/hospital/outpatient/clinic/list/10002', 'GET', NULL, '[{pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=1, total=2, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=2, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:41', '2023-11-04 02:54:41');
INSERT INTO `log_operation` VALUES (12023, 'admin', 1699066482428, 4, '删除诊室信息', 'http://localhost:8080', '/hospital/hospital/clinic/10006', 'http://localhost:8080/hospital/hospital/clinic/10006', 'DELETE', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data=null}', '2023-11-04 02:54:42', '2023-11-04 02:54:42');
INSERT INTO `log_operation` VALUES (12024, 'admin', 1699066483556, 4, '删除诊室信息', 'http://localhost:8080', '/hospital/hospital/clinic/10007', 'http://localhost:8080/hospital/hospital/clinic/10007', 'DELETE', NULL, NULL, 'CommonResult{code=200, message=\'操作成功\', data=null}', '2023-11-04 02:54:44', '2023-11-04 02:54:44');
INSERT INTO `log_operation` VALUES (12025, 'admin', 1699066485063, 2, '分页：通过专科编号，获取所属门诊信息', 'http://localhost:8080', '/hospital/hospital/special/list/outpatient', 'http://localhost:8080/hospital/hospital/special/list/outpatient', 'GET', NULL, '[{specialId=null}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=4, total=16, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=16, pages=4, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:45', '2023-11-04 02:54:45');
INSERT INTO `log_operation` VALUES (12026, 'admin', 1699066485063, 2, '分页：搜索专科信息', 'http://localhost:8080', '/hospital/hospital/special/list', 'http://localhost:8080/hospital/hospital/special/list', 'GET', NULL, '[{name=}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=5, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=5, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:45', '2023-11-04 02:54:45');
INSERT INTO `log_operation` VALUES (12027, 'admin', 1699066485651, 2, '分页：搜索专科信息', 'http://localhost:8080', '/hospital/hospital/special/list', 'http://localhost:8080/hospital/hospital/special/list', 'GET', NULL, '[{name=null}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=1, total=5, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=5, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:46', '2023-11-04 02:54:46');
INSERT INTO `log_operation` VALUES (12028, 'admin', 1699066485651, 2, '分页：搜索医院信息', 'http://localhost:8080', '/hospital/hospital/info/list', 'http://localhost:8080/hospital/hospital/info/list', 'GET', NULL, '[{name=null}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=1, total=4, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=4, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:46', '2023-11-04 02:54:46');
INSERT INTO `log_operation` VALUES (12029, 'admin', 1699066485670, 2, '获取医院，所属专科列表', 'http://localhost:8080', '/hospital/hospital/special/list/1000', 'http://localhost:8080/hospital/hospital/special/list/1000', 'GET', NULL, '[{pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=1, total=3, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=3, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:46', '2023-11-04 02:54:46');
INSERT INTO `log_operation` VALUES (12030, 'admin', 1699066486157, 1, '分页：搜索专科信息', 'http://localhost:8080', '/hospital/hospital/special/list', 'http://localhost:8080/hospital/hospital/special/list', 'GET', NULL, '[{name=}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=1, total=5, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=5, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:46', '2023-11-04 02:54:46');
INSERT INTO `log_operation` VALUES (12031, 'admin', 1699066486623, 3, '分页：搜索专科信息', 'http://localhost:8080', '/hospital/hospital/special/list', 'http://localhost:8080/hospital/hospital/special/list', 'GET', NULL, '[{name=}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=5, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=5, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:47', '2023-11-04 02:54:47');
INSERT INTO `log_operation` VALUES (12032, 'admin', 1699066486623, 3, '分页：通过专科编号，获取所属门诊信息', 'http://localhost:8080', '/hospital/hospital/special/list/outpatient', 'http://localhost:8080/hospital/hospital/special/list/outpatient', 'GET', NULL, '[{specialId=null}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=5, totalPage=4, total=16, list=Page{count=true, pageNum=1, pageSize=5, startRow=0, endRow=5, total=16, pages=4, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:47', '2023-11-04 02:54:47');
INSERT INTO `log_operation` VALUES (12033, 'admin', 1699066487558, 2, '分页：搜索专科信息', 'http://localhost:8080', '/hospital/hospital/special/list', 'http://localhost:8080/hospital/hospital/special/list', 'GET', NULL, '[{name=}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=5, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=5, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:48', '2023-11-04 02:54:48');
INSERT INTO `log_operation` VALUES (12034, 'admin', 1699066487575, 2, '分页：通过专科编号，获取所属门诊信息', 'http://localhost:8080', '/hospital/hospital/special/list/outpatient', 'http://localhost:8080/hospital/hospital/special/list/outpatient', 'GET', NULL, '[{specialId=10000}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=4, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=4, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:48', '2023-11-04 02:54:48');
INSERT INTO `log_operation` VALUES (12035, 'admin', 1699066487591, 1, '分页：通过姓名、专科、门诊，搜索医生信息', 'http://localhost:8080', '/hospital/hospital/doctor/list/name', 'http://localhost:8080/hospital/hospital/doctor/list/name', 'GET', NULL, '[{name=}, {specialId=10000}, {outpatientId=10005}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=0, totalPage=1, total=0, list=[]}}', '2023-11-04 02:54:48', '2023-11-04 02:54:48');
INSERT INTO `log_operation` VALUES (12036, 'admin', 1699066491632, 2, '分页：搜索医院信息', 'http://localhost:8080', '/hospital/hospital/info/list', 'http://localhost:8080/hospital/hospital/info/list', 'GET', NULL, '[{name=}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=4, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=4, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:52', '2023-11-04 02:54:52');
INSERT INTO `log_operation` VALUES (12037, 'admin', 1699066491649, 3, '获取医院，所属专科列表', 'http://localhost:8080', '/hospital/hospital/special/list/1000', 'http://localhost:8080/hospital/hospital/special/list/1000', 'GET', NULL, '[{pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=3, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=3, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:52', '2023-11-04 02:54:52');
INSERT INTO `log_operation` VALUES (12038, 'admin', 1699066491666, 3, '分页：查找指定医院、专科的门诊列表', 'http://localhost:8080', '/hospital/hospital/outpatient/list', 'http://localhost:8080/hospital/hospital/outpatient/list', 'GET', NULL, '[{hospitalId=1000}, {specialId=10000}, {pageNum=1}, {pageSize=50}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=50, totalPage=1, total=4, list=Page{count=true, pageNum=1, pageSize=50, startRow=0, endRow=50, total=4, pages=1, countSignal=false, orderBy=\'null\', orderByOnly=false, reasonable=false, pageSizeZero=false}}}', '2023-11-04 02:54:52', '2023-11-04 02:54:52');
INSERT INTO `log_operation` VALUES (12039, 'admin', 1699066491681, 1, '搜索出诊计划', 'http://localhost:8080', '/hospital/visit/plan/list', 'http://localhost:8080/hospital/visit/plan/list', 'GET', NULL, '[{hospitalId=1000}, {specialId=10000}, {outpatientId=10005}, {day=2023-11-04}, {pageNum=1}, {pageSize=5}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=0, totalPage=1, total=0, list=[]}}', '2023-11-04 02:54:52', '2023-11-04 02:54:52');
INSERT INTO `log_operation` VALUES (12040, 'admin', 1699066491695, 1, '分页：通过姓名、专科、门诊，搜索医生信息', 'http://localhost:8080', '/hospital/hospital/doctor/list/name', 'http://localhost:8080/hospital/hospital/doctor/list/name', 'GET', NULL, '[{name=}, {specialId=10000}, {outpatientId=10005}, {pageNum=1}, {pageSize=100}]', 'CommonResult{code=200, message=\'操作成功\', data=CommonPage{pageNum=1, pageSize=0, totalPage=1, total=0, list=[]}}', '2023-11-04 02:54:52', '2023-11-04 02:54:52');

-- ----------------------------
-- Table structure for power_account
-- ----------------------------
DROP TABLE IF EXISTS `power_account`;
CREATE TABLE `power_account`  (
                                  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
                                  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录账号 唯一',
                                  `password` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录密码 使用md5加密',
                                  `status` int NOT NULL DEFAULT 1 COMMENT '账号状态 1：正常，0：锁定',
                                  `login_time` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
                                  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                  PRIMARY KEY (`id`) USING BTREE,
                                  UNIQUE INDEX `power_account_name_uindex`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10000009 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '账号信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of power_account
-- ----------------------------
INSERT INTO `power_account` VALUES (10000005, 'admin', '$2a$10$l0dSGURNp2Q9z2m3jea37.CV9.OH76qprHxIDklyJPK2EzEIg4m2W', 1, '2023-11-04 02:53:36', '2023-11-04 08:04:14', '2023-11-04 02:57:48');
INSERT INTO `power_account` VALUES (10000007, '10008', '$2a$10$RDnx7tuS3RTCbtefhOOZde0yRl0pGXoKOPRp8zvW08r/Su.1YgaIm', 1, '2023-11-04 02:51:16', '2023-11-04 02:49:27', '2023-11-04 02:49:27');
INSERT INTO `power_account` VALUES (10000008, '18100176437', '$2a$10$hxjTwigiqX2jAo7bYtTC9eUXk8oMDQ2X30z6/l7vrI64fJdj9wtEG', 1, '2023-11-04 02:52:27', '2023-11-04 02:52:22', '2023-11-04 02:52:22');

-- ----------------------------
-- Table structure for power_account_role_relation
-- ----------------------------
DROP TABLE IF EXISTS `power_account_role_relation`;
CREATE TABLE `power_account_role_relation`  (
                                                `id` bigint NOT NULL AUTO_INCREMENT COMMENT '账号角色关系编号',
                                                `account_id` bigint NOT NULL COMMENT '账号编号',
                                                `role_id` bigint NOT NULL COMMENT '角色编号',
                                                `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                                `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                                PRIMARY KEY (`id`) USING BTREE,
                                                INDEX `power_account_role_relation_power_role_id_fk`(`role_id` ASC) USING BTREE,
                                                INDEX `power_account_role_relation_power_account_id_fk`(`account_id` ASC) USING BTREE,
                                                CONSTRAINT `power_account_role_relation_power_account_id_fk` FOREIGN KEY (`account_id`) REFERENCES `power_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                                CONSTRAINT `power_account_role_relation_power_role_id_fk` FOREIGN KEY (`role_id`) REFERENCES `power_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '账号角色关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of power_account_role_relation
-- ----------------------------

-- ----------------------------
-- Table structure for power_menu
-- ----------------------------
DROP TABLE IF EXISTS `power_menu`;
CREATE TABLE `power_menu`  (
                               `id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单编号',
                               `parent_id` bigint NULL DEFAULT NULL COMMENT '父级菜单',
                               `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
                               `level` int NOT NULL COMMENT '菜单级数',
                               `sort` int NOT NULL COMMENT '菜单排序',
                               `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '前端路径',
                               `icon` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '前端图标',
                               `hidden` int NOT NULL DEFAULT 1 COMMENT '前端隐藏 0：隐藏，1：显示',
                               `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                               `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                               PRIMARY KEY (`id`) USING BTREE,
                               UNIQUE INDEX `power_menu_name_uindex`(`name` ASC) USING BTREE,
                               UNIQUE INDEX `power_menu_title_uindex`(`title` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限菜单表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of power_menu
-- ----------------------------

-- ----------------------------
-- Table structure for power_resource
-- ----------------------------
DROP TABLE IF EXISTS `power_resource`;
CREATE TABLE `power_resource`  (
                                   `id` bigint NOT NULL AUTO_INCREMENT COMMENT '资源编号',
                                   `category_id` bigint NOT NULL COMMENT '资源分类编号',
                                   `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源名称',
                                   `url` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源URL',
                                   `description` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源描述',
                                   `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                   `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                   PRIMARY KEY (`id`) USING BTREE,
                                   UNIQUE INDEX `power_resource_url_uindex`(`url` ASC) USING BTREE,
                                   UNIQUE INDEX `power_resource_name_uindex`(`name` ASC) USING BTREE,
                                   INDEX `power_resource_power_resource_category_id_fk`(`category_id` ASC) USING BTREE,
                                   CONSTRAINT `power_resource_power_resource_category_id_fk` FOREIGN KEY (`category_id`) REFERENCES `power_resource_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限资源表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of power_resource
-- ----------------------------

-- ----------------------------
-- Table structure for power_resource_category
-- ----------------------------
DROP TABLE IF EXISTS `power_resource_category`;
CREATE TABLE `power_resource_category`  (
                                            `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类编号',
                                            `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类名称',
                                            `sort` int NOT NULL DEFAULT 1 COMMENT '分类排序 数值越小，越靠前',
                                            `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                            `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                            PRIMARY KEY (`id`) USING BTREE,
                                            UNIQUE INDEX `power_resource_category_name_uindex`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限资源分类表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of power_resource_category
-- ----------------------------

-- ----------------------------
-- Table structure for power_role
-- ----------------------------
DROP TABLE IF EXISTS `power_role`;
CREATE TABLE `power_role`  (
                               `id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色编号',
                               `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '英文名称',
                               `chinese_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '中文名称',
                               `admin_count` int NOT NULL DEFAULT 0 COMMENT '用户数目',
                               `sort` int NOT NULL DEFAULT 0 COMMENT '排序 越小越靠前',
                               `status` int NOT NULL DEFAULT 1 COMMENT '角色状态 1：启用，0：禁用',
                               `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                               `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                               PRIMARY KEY (`id`) USING BTREE,
                               UNIQUE INDEX `power_role_name_uindex`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of power_role
-- ----------------------------

-- ----------------------------
-- Table structure for power_role_menu_relation
-- ----------------------------
DROP TABLE IF EXISTS `power_role_menu_relation`;
CREATE TABLE `power_role_menu_relation`  (
                                             `id` bigint NOT NULL AUTO_INCREMENT COMMENT '关系编号',
                                             `role_id` bigint NOT NULL COMMENT '角色编号',
                                             `menu_id` bigint NOT NULL COMMENT '菜单编号',
                                             `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                             `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                             PRIMARY KEY (`id`) USING BTREE,
                                             INDEX `power_role_menu_relation_power_menu_id_fk`(`menu_id` ASC) USING BTREE,
                                             INDEX `power_role_menu_relation_power_role_id_fk`(`role_id` ASC) USING BTREE,
                                             CONSTRAINT `power_role_menu_relation_power_menu_id_fk` FOREIGN KEY (`menu_id`) REFERENCES `power_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                             CONSTRAINT `power_role_menu_relation_power_role_id_fk` FOREIGN KEY (`role_id`) REFERENCES `power_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色菜单关系表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of power_role_menu_relation
-- ----------------------------

-- ----------------------------
-- Table structure for power_role_resource_relation
-- ----------------------------
DROP TABLE IF EXISTS `power_role_resource_relation`;
CREATE TABLE `power_role_resource_relation`  (
                                                 `id` bigint NOT NULL AUTO_INCREMENT COMMENT '关系编号',
                                                 `role_id` bigint NOT NULL COMMENT '角色编号',
                                                 `resource_id` bigint NOT NULL COMMENT '资源编号',
                                                 `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                                 `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                                 PRIMARY KEY (`id`) USING BTREE,
                                                 INDEX `power_role_resource_relation_power_resource_id_fk`(`resource_id` ASC) USING BTREE,
                                                 INDEX `power_role_resource_relation_power_role_id_fk`(`role_id` ASC) USING BTREE,
                                                 CONSTRAINT `power_role_resource_relation_power_resource_id_fk` FOREIGN KEY (`resource_id`) REFERENCES `power_resource` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                                 CONSTRAINT `power_role_resource_relation_power_role_id_fk` FOREIGN KEY (`role_id`) REFERENCES `power_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色资源关系表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of power_role_resource_relation
-- ----------------------------

-- ----------------------------
-- Table structure for user_basic_info
-- ----------------------------
DROP TABLE IF EXISTS `user_basic_info`;
CREATE TABLE `user_basic_info`  (
                                    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
                                    `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓名',
                                    `avatar_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户头像',
                                    `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号',
                                    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    UNIQUE INDEX `user_basic_info_phone_uindex`(`phone` ASC) USING BTREE,
                                    CONSTRAINT `user_basic_info_power_account_name_fk` FOREIGN KEY (`phone`) REFERENCES `power_account` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户基础信息表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_basic_info
-- ----------------------------
INSERT INTO `user_basic_info` VALUES (4, '患者1', 'http://localhost:8080/hospital/img/defalut_avatar.png', '18100176437', '2023-11-04 02:52:22', '2023-11-04 02:52:22');

-- ----------------------------
-- Table structure for user_case
-- ----------------------------
DROP TABLE IF EXISTS `user_case`;
CREATE TABLE `user_case`  (
                              `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录编号',
                              `card_id` bigint NOT NULL COMMENT '就诊卡编号',
                              `appointment_id` bigint NOT NULL COMMENT '预约编号',
                              `doctor_id` bigint NOT NULL COMMENT '医生编号',
                              `content` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '病例详情',
                              `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                              `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                              PRIMARY KEY (`id`) USING BTREE,
                              INDEX `user_case_hospital_doctor_id_fk`(`doctor_id` ASC) USING BTREE,
                              INDEX `user_case_user_medical_card_id_fk`(`card_id` ASC) USING BTREE,
                              CONSTRAINT `user_case_hospital_doctor_id_fk` FOREIGN KEY (`doctor_id`) REFERENCES `hospital_doctor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                              CONSTRAINT `user_case_user_medical_card_id_fk` FOREIGN KEY (`card_id`) REFERENCES `user_medical_card` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户病例表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_case
-- ----------------------------

-- ----------------------------
-- Table structure for user_medical_card
-- ----------------------------
DROP TABLE IF EXISTS `user_medical_card`;
CREATE TABLE `user_medical_card`  (
                                      `id` bigint NOT NULL AUTO_INCREMENT COMMENT '就诊卡号',
                                      `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓名',
                                      `gender` int NOT NULL DEFAULT 1 COMMENT '性别 男：1，女：2',
                                      `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号',
                                      `identification_number` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '证件号',
                                      `birth_date` datetime NOT NULL COMMENT '出生日期',
                                      `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                      `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                      PRIMARY KEY (`id`) USING BTREE,
                                      UNIQUE INDEX `user_medical_card_identification_number_uindex`(`identification_number` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7000004 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户就诊卡信息表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_medical_card
-- ----------------------------
INSERT INTO `user_medical_card` VALUES (7000003, '患者1', 1, '18100176437', '310721199910122570', '1999-10-12 00:00:00', '2023-11-04 02:53:09', '2023-11-04 02:53:09');

-- ----------------------------
-- Table structure for user_medical_card_relation
-- ----------------------------
DROP TABLE IF EXISTS `user_medical_card_relation`;
CREATE TABLE `user_medical_card_relation`  (
                                               `id` bigint NOT NULL AUTO_INCREMENT COMMENT '关系编号',
                                               `type` int NOT NULL COMMENT '关系类型 0：本人，1：父母，2：兄弟/姐妹，3：伴侣，4：子女，5：同事/朋友，6：其他',
                                               `account_id` bigint NOT NULL COMMENT '账号编号',
                                               `card_id` bigint NOT NULL COMMENT '就诊卡编号',
                                               `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                               `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                               PRIMARY KEY (`id`) USING BTREE,
                                               INDEX `user_medical_card_relation_power_account_id_fk`(`account_id` ASC) USING BTREE,
                                               INDEX `user_medical_card_relation_user_medical_card_id_fk`(`card_id` ASC) USING BTREE,
                                               CONSTRAINT `user_medical_card_relation_power_account_id_fk` FOREIGN KEY (`account_id`) REFERENCES `power_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                               CONSTRAINT `user_medical_card_relation_user_medical_card_id_fk` FOREIGN KEY (`card_id`) REFERENCES `user_medical_card` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户就诊卡关系表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_medical_card_relation
-- ----------------------------
INSERT INTO `user_medical_card_relation` VALUES (6, 0, 10000008, 7000003, '2023-11-04 02:53:09', '2023-11-04 02:53:09');

-- ----------------------------
-- Table structure for visit_appointment
-- ----------------------------
DROP TABLE IF EXISTS `visit_appointment`;
CREATE TABLE `visit_appointment`  (
                                      `id` bigint NOT NULL AUTO_INCREMENT COMMENT '预约编号',
                                      `plan_id` bigint NOT NULL COMMENT '出诊编号',
                                      `card_id` bigint NOT NULL COMMENT '就诊卡号',
                                      `account_id` bigint NOT NULL COMMENT '账号编号',
                                      `time_period` int NOT NULL COMMENT '1： 8点半~9点，2： 9点~9点半，3： 9点半~10点，4： 10点~10点半，5： 11点~11点半，6： 11点半~12点，7：2点~2点半，8： 2点半~3点，9： 3点~3点半，10： 3点半~4点，11： 4点~4点半，12： 4点半~5点，13： 5点~5点半，14：5点半~6点',
                                      `status` int NOT NULL DEFAULT 0 COMMENT '预约状态 0：未开始，1：未按时就诊，2：取消预约挂号，3：已完成',
                                      `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                      `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                      PRIMARY KEY (`id`) USING BTREE,
                                      INDEX `visit_order_user_medical_card_id_fk`(`card_id` ASC) USING BTREE,
                                      INDEX `visit_order_visit_plan_id_fk`(`plan_id` ASC) USING BTREE,
                                      INDEX `visit_order_power_account_id_fk`(`account_id` ASC) USING BTREE,
                                      CONSTRAINT `visit_order_power_account_id_fk` FOREIGN KEY (`account_id`) REFERENCES `power_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                      CONSTRAINT `visit_order_user_medical_card_id_fk` FOREIGN KEY (`card_id`) REFERENCES `user_medical_card` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                      CONSTRAINT `visit_order_visit_plan_id_fk` FOREIGN KEY (`plan_id`) REFERENCES `visit_plan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出诊预约表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of visit_appointment
-- ----------------------------

-- ----------------------------
-- Table structure for visit_blacklist
-- ----------------------------
DROP TABLE IF EXISTS `visit_blacklist`;
CREATE TABLE `visit_blacklist`  (
                                    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '名单编号',
                                    `card_id` bigint NOT NULL COMMENT '就诊卡号',
                                    `status` int NOT NULL DEFAULT 1 COMMENT '禁封状态 1：生效，2：已解封',
                                    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    INDEX `visit_blacklist_user_medical_card_id_fk`(`card_id` ASC) USING BTREE,
                                    CONSTRAINT `visit_blacklist_user_medical_card_id_fk` FOREIGN KEY (`card_id`) REFERENCES `user_medical_card` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出诊黑名单 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of visit_blacklist
-- ----------------------------

-- ----------------------------
-- Table structure for visit_plan
-- ----------------------------
DROP TABLE IF EXISTS `visit_plan`;
CREATE TABLE `visit_plan`  (
                               `id` bigint NOT NULL AUTO_INCREMENT COMMENT '出诊编号',
                               `hospital_id` bigint NOT NULL COMMENT '医院编号',
                               `special_id` bigint NOT NULL COMMENT '专科编号',
                               `outpatient_id` bigint NOT NULL COMMENT '门诊编号',
                               `clinic_id` bigint NOT NULL COMMENT '诊室编号',
                               `doctor_id` bigint NOT NULL COMMENT '医生编号',
                               `time` int NOT NULL DEFAULT 1 COMMENT '时间段 1：上午，2：下午',
                               `day` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '出诊日期',
                               `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                               `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                               PRIMARY KEY (`id`) USING BTREE,
                               INDEX `visit_plan_hospital_clinic_id_fk`(`clinic_id` ASC) USING BTREE,
                               INDEX `visit_plan_hospital_doctor_id_fk`(`doctor_id` ASC) USING BTREE,
                               INDEX `visit_plan_hospital_info_id_fk`(`hospital_id` ASC) USING BTREE,
                               INDEX `visit_plan_hospital_special_id_fk`(`special_id` ASC) USING BTREE,
                               INDEX `visit_plan_hospital_outpatient_id_fk`(`outpatient_id` ASC) USING BTREE,
                               CONSTRAINT `visit_plan_hospital_clinic_id_fk` FOREIGN KEY (`clinic_id`) REFERENCES `hospital_clinic` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                               CONSTRAINT `visit_plan_hospital_doctor_id_fk` FOREIGN KEY (`doctor_id`) REFERENCES `hospital_doctor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                               CONSTRAINT `visit_plan_hospital_info_id_fk` FOREIGN KEY (`hospital_id`) REFERENCES `hospital_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                               CONSTRAINT `visit_plan_hospital_outpatient_id_fk` FOREIGN KEY (`outpatient_id`) REFERENCES `hospital_outpatient` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                               CONSTRAINT `visit_plan_hospital_special_id_fk` FOREIGN KEY (`special_id`) REFERENCES `hospital_special` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10043 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出诊信息表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of visit_plan
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;

