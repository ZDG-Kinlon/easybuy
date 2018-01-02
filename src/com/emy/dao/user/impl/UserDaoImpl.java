package com.emy.dao.user.impl;

import com.emy.dao.publicClass.PublicFunctionDao;
import com.emy.dao.user.UserDao;
import com.emy.entity.User;

import java.util.List;

public class UserDaoImpl
        extends PublicFunctionDao
        implements UserDao {
    /**
     * 向数据表增加一条记录
     *
     * @param obj 记录
     * @return 影响的记录个数
     */
    @Override
    public int add(User obj) {
        String sql = "" +
                "INSERT INTO " +
                "easybuy_user(`userName`,`loginName`,`password`,`sex`,`identityCode`,`email`,`mobile`,`type`) " +
                "VALUES(?,?,?,?,?,?,?,?)";
        return runSQL.sqlUpdate(sql,
                obj.getUserName(),
                obj.getLoginName(),
                obj.getPassword(),
                obj.getSex(),
                obj.getIdentityCode(),
                obj.getEmail(),
                obj.getMobile(),
                obj.getType());
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
                "DELETE FROM easybuy_user " +
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
                "DELETE FROM easybuy_user";
        return runSQL.sqlUpdate(sql);
    }

    /**
     * 修改数据表的一条记录
     *
     * @param obj 记录
     * @return 影响的记录个数
     */
    @Override
    public int set(User obj) {
        String sql = "" +
                "UPDATE easybuy_user " +
                "SET `userName`=?,`loginName`=?,`password`=?,`sex`=?,`identityCode`=?,`email`=?,`mobile`=?,`type`=? " +
                "WHERE `id` = ?";
        return runSQL.sqlUpdate(sql,
                obj.getUserName(),
                obj.getLoginName(),
                obj.getPassword(),
                obj.getSex(),
                obj.getIdentityCode(),
                obj.getEmail(),
                obj.getMobile(),
                obj.getType(),
                obj.getId());
    }

    /**
     * 查询数据表的一条记录
     *
     * @param id 记录的编号
     * @return 记录
     */
    @Override
    public User getById(int id) {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`userName`,`loginName`,`password`,`sex`,`identityCode`,`email`,`mobile`,`type` " +
                "FROM easybuy_user " +
                "WHERE `id` = " + id;
        //执行SQL语句，返回记录对象
        return runSQL.sqlQueryGetObject(sql, User.class);
    }

    /**
     * 使用字段名查询数据表的记录
     *
     * @param tag 字段名
     * @param find 检索信息
     * @return 记录
     */
    @Override
    public List<User> getByField(String tag, String find) {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`userName`,`loginName`,`password`,`sex`,`identityCode`,`email`,`mobile`,`type` " +
                "FROM easybuy_user " +
                "WHERE ? = ?";
        //执行SQL语句，返回数据集合
        return runSQL.sqlQueryGetList(sql, User.class,tag,find);
    }

    /**
     * 使用分页查询数据表记录
     *
     * @param pageIndex 页码
     * @param pageSize  每页的记录个数
     * @return 当前页码的记录List集合
     */
    @Override
    public List<User> getByPages(int pageIndex, int pageSize) {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`userName`,`loginName`,`password`,`sex`,`identityCode`,`email`,`mobile`,`type` " +
                "FROM easybuy_user " +
                "LIMIT ?,?";
        //执行SQL语句，返回记录集合
        return runSQL.sqlQueryGetList(sql, User.class,
                (pageIndex - 1) * pageSize,
                pageSize);
    }

    /**
     * 查询数据表的全部记录
     *
     * @return 数据表的全部记录List集合
     */
    @Override
    public List<User> getAll() {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`userName`,`loginName`,`password`,`sex`,`identityCode`,`email`,`mobile`,`type` " +
                "FROM easybuy_user";
        //执行SQL语句，返回数据集合
        return runSQL.sqlQueryGetList(sql, User.class);

    }
}
