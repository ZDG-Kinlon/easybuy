package com.emy.dao.user;

import com.emy.dao.publicClass.PublicFunctionDao;
import com.emy.entity.UserAddress;

import java.util.List;

/**
 * 用户地址实现类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class UserAddressDaoImpl
        extends PublicFunctionDao
        implements UserAddressDao {
    /**
     * 向数据表增加一条记录
     *
     * @param obj 记录
     * @return 影响的记录个数
     */
    @Override
    public int add(UserAddress obj) {
        String sql = "" +
                "INSERT INTO " +
                "easybuy_user_address(`address`,`createTime`,`userId`,`isDefault`,`remark`) " +
                "VALUES(?,?,?,?,?)";
        return runSQL.sqlUpdate(sql,
                obj.getAddress(),
                obj.getCreateTime(),
                obj.getUserID(),
                obj.getIsDefault(),
                obj.getRemark());
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
                "DELETE FROM easybuy_user_address " +
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
                "DELETE FROM easybuy_user_address";
        return runSQL.sqlUpdate(sql);
    }

    /**
     * 修改数据表的一条记录
     *
     * @param obj 记录
     * @return 影响的记录个数
     */
    @Override
    public int set(UserAddress obj) {
        String sql = "" +
                "UPDATE easybuy_user_address " +
                "SET `address`=?,`createTime`=?,`userId`=?,`isDefault`=?,`remark`=? " +
                "WHERE `id` = ?";
        return runSQL.sqlUpdate(sql,
                obj.getAddress(),
                obj.getCreateTime(),
                obj.getUserID(),
                obj.getIsDefault(),
                obj.getRemark());
    }

    /**
     * 查询数据表的一条记录
     *
     * @param id 记录的编号
     * @return 记录
     */
    @Override
    public UserAddress getById(int id) {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`address`,`createTime`,`userId`,`isDefault`,`remark` "+
                "FROM easybuy_user_address " +
                "WHERE `id` = " + id;
        //执行SQL语句，返回记录对象
        return runSQL.sqlQueryGetObject(sql, UserAddress.class);
    }

    /**
     * 使用分页查询数据表记录
     *
     * @param pageIndex 页码
     * @param pageSize  每页的记录个数
     * @return 当前页码的记录List集合
     */
    @Override
    public List<UserAddress> getByPages(int pageIndex, int pageSize) {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`address`,`createTime`,`userId`,`isDefault`,`remark` "+
                "FROM easybuy_user_address " +
                "LIMIT ?,?";
        //执行SQL语句，返回记录集合
        return runSQL.sqlQueryGetList(sql, UserAddress.class,
                (pageIndex - 1) * pageSize,
                pageSize);
    }

    /**
     * 查询数据表的全部记录
     *
     * @return 数据表的全部记录List集合
     */
    @Override
    public List<UserAddress> getAll() {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`address`,`createTime`,`userId`,`isDefault`,`remark` "+
                "FROM easybuy_user_address";
        //执行SQL语句，返回数据集合
        return runSQL.sqlQueryGetList(sql, UserAddress.class);

    }
}
