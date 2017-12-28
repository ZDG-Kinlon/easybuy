package com.emy.dao.product;

import com.emy.dao.publicClass.PublicFunctionDao;
import com.emy.entity.ProductCategory;

import java.util.List;

/**
 * 商品分类列表实现类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class ProductCategoryDaoImpl
        extends PublicFunctionDao
        implements ProductCategoryDao {

    /**
     * 向数据表增加一条记录
     *
     * @param obj 记录
     * @return 影响的记录个数
     */
    @Override
    public int add(ProductCategory pc) {
        String sql = "" +
                "INSERT INTO " +
                "easybuy_product_category(`name`,`parentId`,`type`) " +
                "VALUES(?,?,?)";
        return runSQL.sqlUpdate(sql,
                pc.getName(),
                pc.getParentId(),
                pc.getType());
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
                "DELETE FROM easybuy_product_category " +
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
                "DELETE FROM easybuy_product_category";
        return runSQL.sqlUpdate(sql);
    }


    /**
     * 修改数据表的一条记录
     *
     * @param obj 记录
     * @return 影响的记录个数
     */
    @Override
    public int set(ProductCategory pc) {
        String sql = "" +
                "UPDATE easybuy_product_category " +
                "SET `name`=?,`parentId`=?,`type`=? " +
                "WHERE `id`= ?";
        return runSQL.sqlUpdate(sql,
                pc.getName(),
                pc.getParentId(),
                pc.getType(),
                pc.getId());
    }

    /**
     * 查询数据表的一条记录
     *
     * @param id 记录的编号
     * @return 记录
     */
    @Override
    public ProductCategory getById(int id) {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`name`,`parentId`,`type` " +
                "FROM easybuy_product_category " +
                "WHERE `id` = " + id;
        //执行SQL语句，返回记录对象
        return runSQL.sqlQueryGetObject(sql, ProductCategory.class);
    }


    /**
     * 使用分页查询数据表记录
     *
     * @param pageIndex 页码
     * @param pageSize  每页的记录个数
     * @return 当前页码的记录List集合
     */
    @Override
    public List<ProductCategory> getByPages(int pageIndex, int pageSize) {
        String sql = "" +
                "SELECT `id`,`name`,`parentId`,`type` " +
                "FROM easybuy_product_category " +
                "LIMIT ?,?";
        return runSQL.sqlQueryGetList(sql, ProductCategory.class,
                (pageIndex - 1) * pageSize,
                pageSize);
    }

    /**
     * 查询数据表的全部记录
     *
     * @return 数据表的全部记录List集合
     */
    @Override
    public List<ProductCategory> getAll() {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`name`,`parentId`,`type` " +
                "FROM easybuy_product_category";
        //执行SQL语句，返回记录集合
        return runSQL.sqlQueryGetList(sql, ProductCategory.class);
    }


}
