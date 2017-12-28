package com.emy.util;

import java.util.regex.Pattern;

/**
 * 正则表达式工具类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class RegexUtils {
    /**
     * 自定义匹配验证
     *
     * @param regex 正则表达式
     * @param str   待验证字符串
     * @return 结果
     */
    public static boolean isCheck(String regex, String str) {
        return Pattern.matches(regex, str);
    }

    /**
     * 正整数验证
     *
     * @param digit 待验证字符串
     * @return 结果
     */
    public static boolean isIntegerZ(String digit) {
        String regex = "^\\+{0,1}[1-9]\\d*";
        return Pattern.matches(regex, digit);
    }

    /**
     * 负整数验证
     *
     * @param digit 待验证字符串
     * @return 结果
     */
    public static boolean isIntegerF(String digit) {
        String regex = "^-[1-9]\\d*";
        return Pattern.matches(regex, digit);
    }

    /**
     * 整数验证
     *
     * @param digit 待验证字符串
     * @return 结果
     */
    public static boolean isInteger(String digit) {
        return isIntegerZ(digit) | isIntegerF(digit);
    }


    /**
     * 正浮点数验证
     *
     * @param digit 待验证字符串
     * @return 结果
     */
    public static boolean isDoubleZ(String digit) {
        String regex = "^\\+{0,1}[1-9]\\d*";
        return Pattern.matches(regex, digit);
    }

    /**
     * 负浮点数验证
     *
     * @param digit 待验证字符串
     * @return 结果
     */
    public static boolean isDoubleF(String digit) {
        String regex = "^-[1-9]\\d*";
        return Pattern.matches(regex, digit);
    }

    /**
     * 浮点数验证
     *
     * @param digit 待验证字符串
     * @return 结果
     */
    public static boolean isDouble(String digit) {
        return isDoubleZ(digit) | isDoubleF(digit);
    }

    /**
     * 实数验证
     *
     * @param digit 待验证字符串
     * @return 结果
     */
    public static boolean isNumber(String digit) {
        return isInteger(digit) | isDouble(digit);
    }

}
