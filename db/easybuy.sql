/*
Navicat MySQL Data Transfer

Source Server         : Localhost
Source Server Version : 50720
Source Host           : 127.0.0.1:6003
Source Database       : easybuy

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2018-01-04 19:10:34
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for easybuy_news
-- ----------------------------
DROP TABLE IF EXISTS `easybuy_news`;
CREATE TABLE `easybuy_news` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '标题',
  `content` varchar(1024) COLLATE utf8_bin NOT NULL COMMENT '内容',
  `creatTime` date NOT NULL COMMENT '录入日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
-- Table structure for easybuy_product_category
-- ----------------------------
DROP TABLE IF EXISTS `easybuy_product_category`;
CREATE TABLE `easybuy_product_category` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '名字',
  `parentId` int(10) NOT NULL COMMENT '父分类',
  `type` int(1) NOT NULL COMMENT '类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
  `type` int(1) NOT NULL COMMENT '1买家 2店家 3GM',
  PRIMARY KEY (`id`,`loginName`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for easybuy_user_address
-- ----------------------------
DROP TABLE IF EXISTS `easybuy_user_address`;
CREATE TABLE `easybuy_user_address` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `address` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '地址',
  `createTime` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '创建时间',
  `userId` int(10) NOT NULL COMMENT '用户主键',
  `isDefault` int(1) NOT NULL COMMENT '默认地址 1否 2是',
  `remark` varchar(18) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
