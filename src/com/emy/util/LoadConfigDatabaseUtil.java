package com.emy.util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * 读取数据源配置的类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class LoadConfigDatabaseUtil {
    //驱动
    private static String driver;
    //地址
    private static String url;
    //用户名
    private static String user;
    //密码
    private static String password;

    //启动项目自动执行读取配置
    static {
        try {
            init();
        } catch (IOException e) {
            //配置文件读取异常
            e.printStackTrace();
        }

        System.out.println("数据库初始化完毕");
    }

    /**
     * 读取配置文件的信息，初始化
     */
    private static void init() throws IOException {
        System.out.println("数据库配置加载");
        //1.创建Properties对象
        Properties properties = new Properties();
        //2.配置的文件名
        String configFileName = "config/database.properties";
        //3.载入配置信息
        properties.load(LoadConfigDatabaseUtil.class.getClassLoader().getResourceAsStream(configFileName));
        //4.配置转存
        driver = properties.getProperty("database.driver");
        url = properties.getProperty("database.url");
        user = properties.getProperty("database.user");
        password = properties.getProperty("database.password");
    }

    /**
     * 获取连接对象，前置执行init方法
     *
     * @return Connection
     */
    public static Connection creatConnection() throws SQLException {
        try {
            Class.forName(driver);
            return DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 关闭连接对象，传入Connection对象，非null
     * @param connection
     */
    public static void closeConnection(Connection connection){
        if(connection  != null){
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}
