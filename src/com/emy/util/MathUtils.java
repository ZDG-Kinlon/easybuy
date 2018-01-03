package com.emy.util;

/**
 * 数学工具类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class MathUtils {

    /**
     * 字符转整数
     *
     * @param num 字符串
     * @return 整数，不能转换默认为0
     */
    public static int stringToInteger(String num) {
        Log.logToConsole("输出",num);
        if (num == null) {
            return 0;
        } else if (RegexUtils.isInteger(num)) {
            return Integer.parseInt(num);
        } else {
            return 0;
        }
    }

    public static double stringToDouble(String num) {
        if (num == null) {
            return 0;
        } else if (RegexUtils.isDouble(num)) {
            return Integer.parseInt(num);
        } else {
            return 0.0;
        }
    }
}
