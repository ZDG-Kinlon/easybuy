package com.emy.util;

import com.alibaba.fastjson.JSON;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

/**
 * 执行SQL语句的工具类
 * 需加载fastjson-1.2.7.jar
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class RunSQL {
    //数据库访问相关对象
    private Connection connection;
    private Statement statement;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    //Json工具对象
    private JsonUtil jsonUtil = new JsonUtil();

    //构造方法获取数据库连接对象
    public RunSQL(Connection connection) {
        this.connection = connection;
    }

    /**
     * 执行DML语句
     *
     * @param sql  SQL语句
     * @param strs SQL模板?参数替换，缺省直接执行完整SQL语句
     * @return 影响数据表的记录个数
     */
    public synchronized int sqlUpdate(String sql, Object... strs) {
        int length = strs.length;
        if (length == 0) {
            //正常SQL语句
            try {
                this.statement = this.connection.createStatement();
                int result = this.statement.executeUpdate(sql);
                return result;
            } catch (SQLException e) {
                e.printStackTrace();
                return 0;
            } finally {
                close();
            }
        } else {
            //预编译SQL语句
            try {
                this.preparedStatement = this.connection.prepareStatement(sql);
                while (length > 0)
                    this.preparedStatement.setObject(length, strs[length-- - 1]);
                int result = this.preparedStatement.executeUpdate();
                return result;
            } catch (SQLException e) {
                e.printStackTrace();
                return 0;
            } finally {
                close();
            }
        }
    }

    /**
     * 执行DQL语句
     *
     * @param sql SQL语句
     * @param clazz 获得的对象类型
     * @param strs SQL预编译语句参数
     * @param <T> List集合的泛型
     * @return List集合
     */
    public <T> List<T> sqlQueryGetList(String sql, Class<T> clazz,Object... strs){
        int length = strs.length;
        if (length == 0) {
            //正常SQL语句
            try {
                this.statement = this.connection.createStatement();
                this.resultSet = this.statement.executeQuery(sql);
                //得到json格式的数据
                String jsonString=jsonUtil.resultSetToJsonString(this.resultSet);
                //转换json数据，传入List集合，并返回
                return JSON.parseArray(jsonString,clazz);
            } catch (SQLException e) {
                e.printStackTrace();
                return null;
            }finally {
                close();
            }
        } else {
            //预编译SQL语句
            try {
                this.preparedStatement = this.connection.prepareStatement(sql);
                //替换SQL语句预编译参数
                while (length > 0)
                    this.preparedStatement.setObject(length, strs[length-- - 1]);
                this.resultSet = this.preparedStatement.executeQuery();
                //得到json格式的数据
                String jsonString=jsonUtil.resultSetToJsonString(this.resultSet);
                //转换json数据，传入List集合，并返回
                return JSON.parseArray(jsonString,clazz);
            } catch (SQLException e) {
                e.printStackTrace();
                return null;
            }finally {
                close();
            }
        }
    }

    /**
     * 获取查询到的第一个记录
     *
     * @param sql SQL语句
     * @param clazz 获得的对象类型
     * @param strs SQL预编译语句参数
     * @param <T> List集合的泛型
     * @return List集合
     */
    public <T> T sqlQueryGetObject(String sql, Class<T> clazz,Object... strs){
        return sqlQueryGetList(sql,clazz,strs).get(0);
    }

    /**
     * 关闭数据库相关对象，执行SQL语句后必须执行
     * 1.resultSet
     * 2.statement
     * 3.preparedStatement
     * 4.connection
     */
    private void close() {
        try {
            if (this.resultSet != null)
                this.resultSet.close();
            if (this.statement != null)
                this.statement.close();
            if (this.preparedStatement != null)
                this.preparedStatement.close();
            if (this.connection != null)
                this.connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}

