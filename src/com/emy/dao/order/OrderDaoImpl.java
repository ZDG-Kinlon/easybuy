package com.emy.dao.order;

import com.emy.dao.publicClass.PublicFunctionDao;
import com.emy.entity.Order;

import java.util.List;

/**
 * 订单表实现类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class OrderDaoImpl
        extends PublicFunctionDao
        implements OrderDao {
    /**
     * 向数据表增加一条记录
     *
     * @param obj 记录
     * @return 影响的记录个数
     */
    @Override
    public int add(Order obj) {
        String sql = "" +
                "INSERT INTO " +
                "easybuy_order(`userId`,`loginName`,`userAddress`,`createTime`,`cost`,`status`,`type`,`serialNumber`) " +
                "VALUES(?,?,?,?,?,?,?,?)";
        return runSQL.sqlUpdate(sql,
                obj.getUserId(),
                obj.getLoginName(),
                obj.getUserAddress(),
                obj.getCreateTime(),
                obj.getCost(),
                obj.getStatus(),
                obj.getType(),
                obj.getSerialNumber());
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
                "DELETE FROM easybuy_order " +
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
                "DELETE FROM easybuy_order";
        return runSQL.sqlUpdate(sql);
    }

    /**
     * 修改数据表的一条记录
     *
     * @param obj 记录
     * @return 影响的记录个数
     */
    @Override
    public int set(Order obj) {
        String sql = "" +
                "UPDATE easybuy_order " +
                "SET `userId`=?,`loginName`=?,`userAddress`=?,`createTime`=?,`cost`=?,`status`=?,`type`=?,`serialNumber`=? " +
                "WHERE `id`= ?";
        return runSQL.sqlUpdate(sql,
                obj.getUserId(),
                obj.getLoginName(),
                obj.getUserAddress(),
                obj.getCreateTime(),
                obj.getCost(),
                obj.getStatus(),
                obj.getType(),
                obj.getSerialNumber());
    }

    /**
     * 查询数据表的一条记录
     *
     * @param id 记录的编号
     * @return 记录
     */
    @Override
    public Order getById(int id) {
        String sql = "" +
                "SELECT `id`,`userId`,`loginName`,`userAddress`,`createTime`,`cost`,`status`,`type`,`serialNumber` " +
                "FROM easybuy_order " +
                "WHERE `id` = " + id;
        return runSQL.sqlQueryGetObject(sql, Order.class);
    }


    /**
     * 使用分页查询数据表记录
     *
     * @param pageIndex 页码
     * @param pageSize  每页的记录个数
     * @return 当前页码的记录List集合
     */
    @Override
    public List<Order> getByPages(int pageIndex, int pageSize) {
        String sql = "" +
                "SELECT `id`,`userId`,`loginName`,`userAddress`,`createTime`,`cost`,`status`,`type`,`serialNumber` " +
                "FROM easybuy_order " +
                "LIMIT ?,?";
        return runSQL.sqlQueryGetList(sql, Order.class,
                (pageIndex - 1) * pageSize,
                pageSize);
    }


    /**
     * 查询数据表的全部记录
     *
     * @return 数据表的全部记录List集合
     */
    @Override
    public List<Order> getAll() {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`userId`,`loginName`,`userAddress`,`createTime`,`cost`,`status`,`type`,`serialNumber` " +
                "FROM easybuy_order";
        //执行SQL语句，返回数据集合
        return runSQL.sqlQueryGetList(sql, Order.class);
    }


}
