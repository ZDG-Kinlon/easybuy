package com.emy.util;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

/**
 * Json工具类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class JsonUtil {
    /**
     * 将ResultSet转为Json格式的字符串
     *
     * @param rs ResultSet
     * @return Json
     */
    public String resultSetToJsonString(ResultSet rs) throws SQLException {
        //1.创建Json数组
        JSONArray jsonArray=new JSONArray();
        //2.获取列数
        ResultSetMetaData metaData =rs.getMetaData();
        int columnCount=metaData.getColumnCount();
        //3.遍历ResultSet
        while (rs.next()){
            //创建Object对象，存储记录
            JSONObject jsonObject=new JSONObject();
            //遍历列
            for(int i=1;i<=columnCount;i++){
                //获取字段名
                String columnName=metaData.getColumnLabel(i);
                //获取记录
                String value=rs.getString(columnName);
                //添加到Json
                jsonObject.put(columnName,value);
            }
            //将记录存入JsonArray
            jsonArray.add(jsonObject);
        }
        //4.返回Json
        return jsonArray.toString();
    }
}
