package com.emy.dao.publicClass;

import java.util.List;

/**
 * 操作数据表实体的公共接口类
 *
 * @param <T> 实体类型
 * @author Kinlon
 * @version 1.0.0
 */
public interface PublicDao<T> {
    /**
     * 向数据表增加一条记录
     *
     * @param obj 记录
     * @return 影响的记录个数
     */
    public int add(T obj);

    /**
     * 删除数据表的一条记录
     *
     * @param id 记录的编号
     * @return 影响的记录个数
     */
    public int del(int id);

    /**
     * /清空数据表的全部记录
     *
     * @return 影响的记录个数
     */
    public int clc();

    /**
     * 修改数据表的一条记录
     *
     * @param obj 记录
     * @return 影响的记录个数
     */
    public int set(T obj);

    /**
     * 查询数据表的一条记录
     *
     * @param id 记录的编号
     * @return 记录
     */
    public T getById(int id);

    /**
     * 使用字段名查询数据表的记录
     *
     * @param fieId 字段名
     * @param find 检索信息
     * @return 记录
     */
    public List<T> getByField(String fieId,String find);

    /**
     * 使用分页查询数据表记录
     *
     * @param pageIndex 页码
     * @param pageSize  每页的记录个数
     * @return 当前页码的记录List集合
     */
    public List<T> getByPages(int pageIndex, int pageSize);

    /**
     * 查询数据表的全部记录
     *
     * @return 数据表的全部记录List集合
     */
    public List<T> getAll();


}
