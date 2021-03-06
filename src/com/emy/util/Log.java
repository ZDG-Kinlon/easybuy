package com.emy.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 日志类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class Log {
    public static void logToConsole(String logType, String logInfo) {
        System.out.println(
                new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(new Date()) + " [" +
                        logType + "] " + logInfo
        );
    }
    public static String getTimeByFormat(String format){
        return new SimpleDateFormat(format).format(new Date());
    }

}
