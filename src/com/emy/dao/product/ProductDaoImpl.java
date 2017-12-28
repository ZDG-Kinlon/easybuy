package com.emy.dao.product;

import com.emy.dao.publicClass.PublicFunctionDao;
import com.emy.entity.Product;

import java.util.List;

/**
 * 商品表实现类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class ProductDaoImpl
        extends PublicFunctionDao
        implements ProductDao{
    /**
     * 向数据表增加一条记录
     *
     * @param obj 记录
     * @return 影响的记录个数
     */
    @Override
    public int add(Product obj) {
        String sql ="" +
                "INSERT INTO " +
                "easybuy_product(`name`,`description`,`price`,`stock`,`categoryLevel1`,`categoryLevel2`,`categoryLevel3`,`fileName`,`isDelete`) " +
                "VALUES(?,?,?,?,?,?,?,?,?)";
        return runSQL.sqlUpdate(sql,
                obj.getName(),
                obj.getDescription(),
                obj.getPrice(),
                obj.getStock(),
                obj.getCategoryLevel1(),
                obj.getCategoryLevel2(),
                obj.getCategoryLevel3(),
                obj.getFileName(),
                obj.getIsDelete());
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
                "DELETE FROM easybuy_product " +
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
                "DELETE FROM easybuy_product";
        return runSQL.sqlUpdate(sql);
    }

    /**
     * 修改数据表的一条记录
     *
     * @param obj 记录
     * @return 影响的记录个数
     */
    @Override
    public int set(Product obj) {
        String sql="" +
                "UPDATE easybuy_product " +
                "SET `name`=?,`description`=?,`price`=?,`stock`=?,`categoryLevel1`=?,`categoryLevel2`=?,`categoryLevel3`=?,`fileName`=?,`isDelete`=? " +
                "WHERE `id` = ?";
        return runSQL.sqlUpdate(sql,
                obj.getName(),
                obj.getDescription(),
                obj.getPrice(),
                obj.getStock(),
                obj.getCategoryLevel1(),
                obj.getCategoryLevel2(),
                obj.getCategoryLevel3(),
                obj.getFileName(),
                obj.getIsDelete(),
                obj.getId());
    }

    /**
     * 查询数据表的一条记录
     *
     * @param id 记录的编号
     * @return 记录
     */
    @Override
    public Product getById(int id) {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`name`,`description`,`price`,`stock`,`categoryLevel1`,`categoryLevel2`,`categoryLevel3`,`fileName`,`isDelete` "+
                "FROM easybuy_product " +
                "WHERE `id` = " + id;
        //执行SQL语句，返回记录对象
        return runSQL.sqlQueryGetObject(sql, Product.class);
    }

    /**
     * 使用分页查询数据表记录
     *
     * @param pageIndex 页码
     * @param pageSize  每页的记录个数
     * @return 当前页码的记录List集合
     */
    @Override
    public List<Product> getByPages(int pageIndex, int pageSize) {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`name`,`description`,`price`,`stock`,`categoryLevel1`,`categoryLevel2`,`categoryLevel3`,`fileName`,`isDelete` "+
                "FROM easybuy_product " +
                "LIMIT ?,?";
        //执行SQL语句，返回记录集合
        return runSQL.sqlQueryGetList(sql, Product.class,
                (pageIndex - 1) * pageSize,
                pageSize);
    }

    /**
     * 查询数据表的全部记录
     *
     * @return 数据表的全部记录List集合
     */
    @Override
    public List<Product> getAll() {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`name`,`description`,`price`,`stock`,`categoryLevel1`,`categoryLevel2`,`categoryLevel3`,`fileName`,`isDelete` "+
                "FROM easybuy_product";
        //执行SQL语句，返回数据集合
        return runSQL.sqlQueryGetList(sql, Product.class);
    }
}
