package com.emy.dao.news;

import com.emy.dao.publicClass.PublicFunctionDao;
import com.emy.entity.News;

import java.util.List;

/**
 * 资讯实现类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class NewsDaoImpl
        extends PublicFunctionDao
        implements NewsDao {


    /**
     * 向数据表增加一条记录
     *
     * @param obj 记录
     * @return 影响的记录个数
     */
    @Override
    public int add(News obj) {
        String sql = "" +
                "INSERT INTO " +
                "easybuy_news(`title`,`content`,`creatTime`) " +
                "VALUES(?,?,?)";
        return runSQL.sqlUpdate(sql,
                obj.getTitle(),
                obj.getContent(),
                obj.getCreatTime());
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
                "DELETE FROM easybuy_news " +
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
                "DELETE FROM easybuy_news";
        return runSQL.sqlUpdate(sql);
    }


    /**
     * 修改数据表的一条记录
     *
     * @param obj 记录
     * @return 影响的记录个数
     */
    @Override
    public int set(News obj) {
        String sql = "" +
                "UPDATE easybuy_news " +
                "SET `title`=?,`content`=?,`creatTime`=? " +
                "WHERE `id`= ?";
        return runSQL.sqlUpdate(sql,
                obj.getTitle(),
                obj.getContent(),
                obj.getCreatTime(),
                obj.getId());
    }


    /**
     * 查询数据表的一条记录
     *
     * @param id 记录的编号
     * @return 记录
     */
    @Override
    public News getById(int id) {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`title`,`content`,`creatTime` " +
                "FROM easybuy_news " +
                "WHERE `id` = " + id;
        //执行SQL语句，返回记录对象
        return runSQL.sqlQueryGetObject(sql, News.class);
    }


    /**
     * 使用分页查询数据表记录
     *
     * @param pageIndex 页码
     * @param pageSize  每页的记录个数
     * @return 当前页码的记录List集合
     */
    @Override
    public List<News> getByPages(int pageIndex, int pageSize) {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`title`,`content`,`creatTime` " +
                "FROM easybuy_news " +
                "LIMIT ?,?";
        //执行SQL语句，返回记录集合
        return runSQL.sqlQueryGetList(sql, News.class,
                (pageIndex - 1) * pageSize,
                pageSize);
    }


    /**
     * 查询数据表的全部记录
     *
     * @return 数据表的全部记录List集合
     */
    @Override
    public List<News> getAll() {
        //SQL语句
        String sql = "" +
                "SELECT `id`,`title`,`content`,`creatTime` " +
                "FROM easybuy_news";
        //执行SQL语句，返回数据集合
        return runSQL.sqlQueryGetList(sql, News.class);
    }
}
