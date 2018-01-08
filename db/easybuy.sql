/*
Navicat MySQL Data Transfer

Source Server         : Localhost
Source Server Version : 50720
Source Host           : 127.0.0.1:6003
Source Database       : easybuy

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2018-01-09 02:23:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for easybuy_news
-- ----------------------------
DROP TABLE IF EXISTS `easybuy_news`;
CREATE TABLE `easybuy_news` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(2048) COLLATE utf8_bin NOT NULL COMMENT '标题',
  `content` varchar(8096) COLLATE utf8_bin NOT NULL COMMENT '内容',
  `creatTime` datetime NOT NULL COMMENT '录入日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of easybuy_news
-- ----------------------------
INSERT INTO `easybuy_news` VALUES ('7', '测试', '5rWL6K+V6LWE6K6v', '2018-01-08 15:35:15');
INSERT INTO `easybuy_news` VALUES ('8', '滚动资讯测试', '5rua5Yqo6LWE6K6v5rWL6K+V5YaF5a65', '2018-01-08 15:44:24');

-- ----------------------------
-- Table structure for easybuy_order
-- ----------------------------
DROP TABLE IF EXISTS `easybuy_order`;
CREATE TABLE `easybuy_order` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `userId` varchar(10) COLLATE utf8_bin NOT NULL COMMENT '用户ID',
  `loginName` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '登录用户名',
  `userAddress` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '用户地址',
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `cost` float(10,3) NOT NULL COMMENT '金额',
  `status` int(1) NOT NULL COMMENT '订单状态 1待审核 2审核通过 3配货 4卖家已发货 5已收获',
  `type` int(1) NOT NULL COMMENT '类型',
  `serialNumber` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '订单号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of easybuy_order
-- ----------------------------

-- ----------------------------
-- Table structure for easybuy_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `easybuy_order_detail`;
CREATE TABLE `easybuy_order_detail` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `orderId` int(10) NOT NULL COMMENT '订单ID',
  `productId` int(10) NOT NULL COMMENT '商品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `cost` float(10,3) NOT NULL COMMENT '金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of easybuy_order_detail
-- ----------------------------

-- ----------------------------
-- Table structure for easybuy_product
-- ----------------------------
DROP TABLE IF EXISTS `easybuy_product`;
CREATE TABLE `easybuy_product` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '商品名称',
  `description` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '商品描述',
  `price` float(10,3) NOT NULL COMMENT '商品价格',
  `stock` int(10) NOT NULL COMMENT '商品库存',
  `categoryLevel1` int(10) NOT NULL COMMENT '所属分类ID',
  `categoryLevel2` int(10) DEFAULT NULL COMMENT '所属二级分类ID',
  `categoryLevel3` int(10) DEFAULT NULL COMMENT '所属三级分类ID',
  `fileName` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '上传的文件名',
  `isDelete` int(1) NOT NULL COMMENT '2删除 1未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of easybuy_product
-- ----------------------------

-- ----------------------------
-- Table structure for easybuy_product_category
-- ----------------------------
DROP TABLE IF EXISTS `easybuy_product_category`;
CREATE TABLE `easybuy_product_category` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '名字',
  `id1` int(2) NOT NULL COMMENT '一级分类编号',
  `id2` int(3) NOT NULL COMMENT '二级分类编号',
  `id3` int(3) NOT NULL COMMENT '三级分类编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of easybuy_product_category
-- ----------------------------
INSERT INTO `easybuy_product_category` VALUES ('1', '手机专区', '1', '0', '0');
INSERT INTO `easybuy_product_category` VALUES ('2', '电脑专区', '2', '0', '0');
INSERT INTO `easybuy_product_category` VALUES ('3', '家电专区', '3', '0', '0');
INSERT INTO `easybuy_product_category` VALUES ('4', '苹果', '1', '1', '0');
INSERT INTO `easybuy_product_category` VALUES ('5', '安卓', '1', '2', '0');
INSERT INTO `easybuy_product_category` VALUES ('6', '功能机', '1', '3', '0');
INSERT INTO `easybuy_product_category` VALUES ('7', 'iPhoneX', '1', '1', '1');
INSERT INTO `easybuy_product_category` VALUES ('8', 'iPhone8', '1', '1', '2');
INSERT INTO `easybuy_product_category` VALUES ('9', '小米', '1', '2', '1');
INSERT INTO `easybuy_product_category` VALUES ('10', '华为', '1', '2', '2');
INSERT INTO `easybuy_product_category` VALUES ('11', '铱星', '1', '3', '1');
INSERT INTO `easybuy_product_category` VALUES ('12', '诺基亚', '1', '3', '2');
INSERT INTO `easybuy_product_category` VALUES ('13', '台式电脑', '2', '1', '0');
INSERT INTO `easybuy_product_category` VALUES ('14', '笔记本电脑', '2', '2', '0');
INSERT INTO `easybuy_product_category` VALUES ('15', '平板电脑', '2', '3', '0');
INSERT INTO `easybuy_product_category` VALUES ('16', '组装机', '2', '1', '1');
INSERT INTO `easybuy_product_category` VALUES ('17', '一体机', '2', '1', '2');
INSERT INTO `easybuy_product_category` VALUES ('18', '戴尔', '2', '2', '1');
INSERT INTO `easybuy_product_category` VALUES ('19', '联想', '2', '2', '2');
INSERT INTO `easybuy_product_category` VALUES ('20', '华硕', '2', '2', '3');
INSERT INTO `easybuy_product_category` VALUES ('21', 'iPad', '2', '3', '1');
INSERT INTO `easybuy_product_category` VALUES ('22', '酷比魔方', '2', '3', '2');
INSERT INTO `easybuy_product_category` VALUES ('23', 'surface', '2', '3', '3');
INSERT INTO `easybuy_product_category` VALUES ('24', '厨卫电器', '3', '1', '0');
INSERT INTO `easybuy_product_category` VALUES ('25', '客卧电器', '3', '2', '0');
INSERT INTO `easybuy_product_category` VALUES ('26', '热水器', '3', '1', '1');
INSERT INTO `easybuy_product_category` VALUES ('27', '冰箱', '3', '1', '2');
INSERT INTO `easybuy_product_category` VALUES ('28', '微波炉', '3', '1', '3');
INSERT INTO `easybuy_product_category` VALUES ('29', '空调', '3', '2', '1');
INSERT INTO `easybuy_product_category` VALUES ('30', '电视', '3', '2', '2');

-- ----------------------------
-- Table structure for easybuy_user
-- ----------------------------
DROP TABLE IF EXISTS `easybuy_user`;
CREATE TABLE `easybuy_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `userName` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '用户真实姓名',
  `loginName` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '用户登录用户名',
  `password` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '密码',
  `sex` int(1) NOT NULL COMMENT '性别 1男 2女',
  `identityCode` varchar(18) COLLATE utf8_bin DEFAULT NULL COMMENT '身份证',
  `email` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '电子邮箱',
  `mobile` varchar(11) COLLATE utf8_bin DEFAULT NULL COMMENT '手机',
  `type` int(1) NOT NULL COMMENT '1买家 2管理员',
  PRIMARY KEY (`id`,`loginName`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of easybuy_user
-- ----------------------------
INSERT INTO `easybuy_user` VALUES ('4', 'admin', 'admin', '5111c5fe578635b1a260ae155b284421', '1', '12345123412121234x', '', '', '2');

-- ----------------------------
-- Table structure for easybuy_user_address
-- ----------------------------
DROP TABLE IF EXISTS `easybuy_user_address`;
CREATE TABLE `easybuy_user_address` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `address` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '地址',
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `userId` int(10) NOT NULL COMMENT '用户主键',
  `isDefault` int(1) NOT NULL COMMENT '默认地址 1否 2是',
  `remark` varchar(18) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of easybuy_user_address
-- ----------------------------
INSERT INTO `easybuy_user_address` VALUES ('3', '山东', '2018-01-03 22:28:25', '3', '2', '1233');
INSERT INTO `easybuy_user_address` VALUES ('4', '河南', '2018-01-03 22:28:35', '3', '1', '123123');
INSERT INTO `easybuy_user_address` VALUES ('6', '湖南', '2018-01-07 19:30:59', '4', '2', '123');
INSERT INTO `easybuy_user_address` VALUES ('7', '上海', '2018-01-04 18:54:17', '4', '1', '12343434');
INSERT INTO `easybuy_user_address` VALUES ('8', '四川', '2018-01-04 22:18:37', '4', '1', '654');
