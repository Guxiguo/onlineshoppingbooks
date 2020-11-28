/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50150
Source Host           : localhost:3306
Source Database       : dbcourse

Target Server Type    : MYSQL
Target Server Version : 50150
File Encoding         : 65001

Date: 2019-02-17 14:13:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for dtproperties
-- ----------------------------
DROP TABLE IF EXISTS `dtproperties`;
CREATE TABLE `dtproperties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `objectid` int(11) DEFAULT '0',
  `property` varchar(64) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `uvalue` varchar(255) DEFAULT NULL,
  `lvalue` longblob,
  `version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`property`),
  KEY `IDX_AUTOFIELD` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gb2312 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of dtproperties
-- ----------------------------

-- ----------------------------
-- Table structure for my_book
-- ----------------------------
DROP TABLE IF EXISTS `my_book`;
CREATE TABLE `my_book` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `BookName` varchar(40) NOT NULL,
  `BookClass` int(11) NOT NULL DEFAULT '0',
  `Author` varchar(25) DEFAULT NULL,
  `Publish` varchar(150) DEFAULT NULL,
  `BookNo` varchar(30) DEFAULT NULL,
  `Content` varchar(4000) DEFAULT NULL,
  `Prince` double DEFAULT NULL,
  `Amount` int(11) DEFAULT '0',
  `Leav_number` int(11) DEFAULT '0',
  `RegTime` datetime NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IDX_AUTOFIELD` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of my_book
-- ----------------------------
INSERT INTO `my_book` VALUES ('1', '毛泽东的一生', '1', '王维', '上海出版社', 'ISBN 7-302-12054-4/TP・7803', '本书介绍了毛泽东一生的丰功伟绩', '88.6', '100', '98', '2015-12-30 22:55:00');
INSERT INTO `my_book` VALUES ('2', '使用jsp开发web应用', '3', '王永茂', '清华大学出版社', 'ISBN 1-1-1-1', '本书介绍jsp用法', '50', '100', '79', '2016-12-30 10:00:00');
INSERT INTO `my_book` VALUES ('3', '王永庆全传', '1', '丁志可', '中国广播电视出版社', 'ISBN 7504348910', '塑胶巨子的创业实录，台湾首富的成功秘诀', '28', '100', '50', '2017-12-30 10:00:00');
INSERT INTO `my_book` VALUES ('4', '使用SQL', '3', '王五', '北大出版社', 'ISBN 1-1-1-2', '本书介绍SQL用法', '50', '100', '50', '2018-10-30 10:00:00');
INSERT INTO `my_book` VALUES ('5', '生命的亲吻', '2', '刘海涛', '九州出版社', 'ISBN 7510800242', '让孩子们在感动中一路前行，一路成长', '10', '100', '80', '2018-10-30 10:00:00');
INSERT INTO `my_book` VALUES ('6', '杜拉拉升职记', '2', '李可', '陕西师范大学出版社', 'ISBN bkbk918212', '一本中国白领必读的职场修炼小说', '60', '100', '78', '2018-12-30 10:00:00');

-- ----------------------------
-- Table structure for my_bookadminuser
-- ----------------------------
DROP TABLE IF EXISTS `my_bookadminuser`;
CREATE TABLE `my_bookadminuser` (
  `AdminUser` varchar(20) DEFAULT NULL,
  `AdminPass` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of my_bookadminuser
-- ----------------------------
INSERT INTO `my_bookadminuser` VALUES ('admin', 'admin');

-- ----------------------------
-- Table structure for my_bookclass
-- ----------------------------
DROP TABLE IF EXISTS `my_bookclass`;
CREATE TABLE `my_bookclass` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` varchar(30) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IDX_AUTOFIELD` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of my_bookclass
-- ----------------------------
INSERT INTO `my_bookclass` VALUES ('1', '传记');
INSERT INTO `my_bookclass` VALUES ('2', '小说');
INSERT INTO `my_bookclass` VALUES ('3', '计算机图书');

-- ----------------------------
-- Table structure for my_indent
-- ----------------------------
DROP TABLE IF EXISTS `my_indent`;
CREATE TABLE `my_indent` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `IndentNo` varchar(20) NOT NULL,
  `UserId` int(11) NOT NULL DEFAULT '0',
  `SubmitTime` datetime NOT NULL,
  `ConsignmentTime` varchar(20) DEFAULT NULL,
  `TotalPrice` double DEFAULT NULL,
  `content` varchar(400) DEFAULT NULL,
  `IPAddress` varchar(20) DEFAULT NULL,
  `IsPayoff` int(11) DEFAULT '0',
  `IsSales` int(11) DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `IDX_AUTOFIELD` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of my_indent
-- ----------------------------
INSERT INTO `my_indent` VALUES ('3', 'HYD32', '3', '2010-05-23 12:29:14', '05 30 2010 12:29PM', '60', '附言：', '127.0.0.1', '1', '1');
INSERT INTO `my_indent` VALUES ('4', 'HYD33', '3', '2010-05-23 12:38:10', '05 30 2010 12:38PM', '110', '附言：', '127.0.0.1', '1', '1');

-- ----------------------------
-- Table structure for my_indentlist
-- ----------------------------
DROP TABLE IF EXISTS `my_indentlist`;
CREATE TABLE `my_indentlist` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `IndentNo` int(11) NOT NULL DEFAULT '0',
  `BookNo` int(11) NOT NULL DEFAULT '0',
  `Amount` int(11) DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `IDX_AUTOFIELD` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of my_indentlist
-- ----------------------------
INSERT INTO `my_indentlist` VALUES ('1', '1', '1', '1');
INSERT INTO `my_indentlist` VALUES ('2', '2', '1', '1');
INSERT INTO `my_indentlist` VALUES ('3', '3', '6', '1');
INSERT INTO `my_indentlist` VALUES ('4', '4', '6', '1');
INSERT INTO `my_indentlist` VALUES ('5', '4', '2', '1');

-- ----------------------------
-- Table structure for my_users
-- ----------------------------
DROP TABLE IF EXISTS `my_users`;
CREATE TABLE `my_users` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(20) NOT NULL,
  `PassWord` varchar(50) NOT NULL,
  `Names` varchar(20) DEFAULT NULL,
  `Sex` varchar(2) DEFAULT NULL,
  `Address` varchar(150) DEFAULT NULL,
  `Phone` varchar(25) DEFAULT NULL,
  `Post` varchar(8) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `RegTime` datetime DEFAULT NULL,
  `RegIpAddress` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IDX_AUTOFIELD` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of my_users
-- ----------------------------
INSERT INTO `my_users` VALUES ('1', 'dajiege', '87254086', '刘佳杰', '男', '北京朝阳', '13811683724', '100022', 'liujiajie41@hotmail.com', '2018-12-30 12:22:42', '222.12.31.55');
INSERT INTO `my_users` VALUES ('3', 'wym', '123', '王永茂', '男', '北京海淀', '01051108888', '065001', 'wym@126.com.cn', '2018-05-22 22:59:37', '127.0.0.1');
INSERT INTO `my_users` VALUES ('4', 'zhangsan', '123', '张三', '男', '北京大学', '01051106666', '065001', 'zhangsan@pku.edu.cn', '2018-12-23 09:09:57', '127.0.0.1');
INSERT INTO `my_users` VALUES ('5', 'a', 'a', 'a', '男', 'a', 'a', 'a', 'a', '2018-08-11 11:42:24', '127.0.0.1');
