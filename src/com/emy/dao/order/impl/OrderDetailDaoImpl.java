package com.emy.dao.order.impl;

import com.emy.dao.order.OrderDetailDao;
import com.emy.dao.publicClass.PublicFunctionDao;
import com.emy.entity.OrderDetail;

import java.util.List;

/**
 * 订单详情表实现类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class OrderDetailDaoImpl
        extends PublicFunctionDao
        implements OrderDetailDao {
    /**
     * 向数据表增加一条记录
     *
     * @param obj 记录
     * @return 影响的记录个数
     */
    @Override
    public int add(OrderDetail obj) {
        String sql = "" +
                "INSERT INTO " +
                "easybuy_order_detail(`orderId`,`productId`,`quantity`,`cost`) " +
                "VALUES(?,?,?,?,?)";
        return runSQL.sqlUpdate(sql,
                obj.getOrderId(),
                obj.getProductId(),
                obj.getQuantity(),
                obj.getCost());
    }

    /**
     * 删除数据表的一条记录
     *
     * @param id 记录的编号
     * @return 影响的记录个数
     */
    @Override
    public int del(int id) {
        String sql = "" +
                "DELETE FROM easybuy_order_detail " +
                "WHERE `id` = " + id;
        return runSQL.sqlUpdate(sql);
    }

    /**
     * /清空数据表的全部记录
     *
     * @return 影响的记录个数
     */
    @Override
    public int clc() {
        String sql = "" +
                "DELETE FROM easybuy_order_detail";
        return runSQL.sqlUpdate(sql);
    }

    /**
     * 修改数据表的一条记录
     *
     * @param obj 记录
     * @return 影响的记录个数
     */
    @Override
    public int set(OrderDetail obj) {
        String sql = "" +
                "UPDATE easybuy_order_detail " +
                "SET `orderId`=?,`productId`=?,`quantity`=?,`cost`=? " +
                "WHERE `id`= ?";
        return runSQL.sqlUpdate(sql,
                obj.getOrderId(),
                obj.getProductId(),
                obj.getQuantity(),
                obj.getCost(),
                obj.getId());
    }

    /**
     * 查询数据表的一条记录
     *
     * @param id 记录的编号
     * @return 记录
     */
    @Override
    public OrderDetail getById(int id) {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`orderId`,`productId`,`quantity`,`cost` " +
                "FROM easybuy_order_detail " +
                "WHERE `id` = " + id;
        //执行SQL语句，返回记录对象
        return runSQL.sqlQueryGetObject(sql, OrderDetail.class);
    }

    /**
     * 使用字段名查询数据表的记录
     *
     * @param tag  字段名
     * @param find 检索信息
     * @return 记录
     */
    @Override
    public List<OrderDetail> getByField(String tag, String find) {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`orderId`,`productId`,`quantity`,`cost` " +
                "FROM easybuy_order_detail " +
                "WHERE ? = ?";
        //执行SQL语句，返回数据集合
        return runSQL.sqlQueryGetList(sql, OrderDetail.class,tag,find);
    }

    /**
     * 使用分页查询数据表记录
     *
     * @param pageIndex 页码
     * @param pageSize  每页的记录个数
     * @return 当前页码的记录List集合
     */
    @Override
    public List<OrderDetail> getByPages(int pageIndex, int pageSize) {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`orderId`,`productId`,`quantity`,`cost` " +
                "FROM easybuy_order_detail " +
                "LIMIT ?,?";
        //执行SQL语句，返回记录集合
        return runSQL.sqlQueryGetList(sql, OrderDetail.class,
                (pageIndex - 1) * pageSize,
                pageSize);
    }

    /**
     * 查询数据表的全部记录
     *
     * @return 数据表的全部记录List集合
     */
    @Override
    public List<OrderDetail> getAll() {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`orderId`,`productId`,`quantity`,`cost` " +
                "FROM easybuy_order_detail";
        //执行SQL语句，返回数据集合
        return runSQL.sqlQueryGetList(sql, OrderDetail.class);
    }
}
