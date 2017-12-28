package com.emy.dao.publicClass;

import com.alibaba.fastjson.JSONArray;
import com.emy.util.LoadConfigDatabaseUtil;
import com.emy.util.RunSQL;

import java.sql.ResultSet;
import java.sql.SQLException;

public class PublicFunctionDao {
    //执行SQL语句的对象
    public RunSQL runSQL;
    //Json工具对象
    public JSONArray jsonArray;

    public PublicFunctionDao() {
        //初始化数据库连接配置
        try {
            jsonArray = new JSONArray();
            runSQL = new RunSQL(LoadConfigDatabaseUtil.creatConnection());
        } catch (SQLException e) {
            //数据库访问异常
            e.printStackTrace();
        }
    }

    /**
     * 关闭资源
     * 1.ResultSet
     * 2.Statement
     * 3.PreparedStatement
     * 4.Connection
     *
     * @param rs
     */
    public void closeRS(ResultSet rs) {
        try {
            if (rs != null)
                rs.close();
        } catch (SQLException e) {
            //关闭异常
            e.printStackTrace();
        }
    }




}
