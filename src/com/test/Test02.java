package com.test;

import com.emy.util.EncryptUtils;

import javax.crypto.SecretKey;

public class Test02 {
    /**
     * 调用示例
     *
     * @param args
     */
    public static void main(String[] args) {
        EncryptUtils encryptUtils = new EncryptUtils();
        String source = "原文内容私は原文です";
        System.out.println("原文:" + source);
        String source1 = encryptUtils.encryptToBase64(source);
        System.out.println("经过BASE64加密:" + source1);
        System.out.println("经过BASE64解密:" + encryptUtils.decodeByBase64(source1));
        System.out.println("经过MD5:" + encryptUtils.encryptToMD5(source));
        System.out.println("经过SHA1:" + encryptUtils.encryptToSHA1(source));
        System.out.println("经过SHA224:" + encryptUtils.encryptToSHA224(source));
        System.out.println("经过SHA256:" + encryptUtils.encryptToSHA256(source));
        System.out.println("经过SHA384:" + encryptUtils.encryptToSHA384(source));
        System.out.println("经过SHA512:" + encryptUtils.encryptToSHA512(source));
        System.out.println("========随机生成Key进行加解密==============");
        // 生成一个DES算法的密匙
        SecretKey key = encryptUtils.creatSecretKeyByDES();
        String str1 = encryptUtils.encryptToDES(key, source);
        System.out.println("DES加密后为:" + str1);
        // 使用这个密匙解密
        String str2 = encryptUtils.decryptByDES(key, str1);
        System.out.println("DES解密后为：" + str2);

        // 生成一个AES算法的密匙
        SecretKey key1 = encryptUtils.creatSecretKeyByAES();
        String stra = encryptUtils.encryptToAES(key1, source);
        System.out.println("AES加密后为:" + stra);
        // 使用这个密匙解密
        String strb = encryptUtils.decryptByAES(key1, stra);
        System.out.println("AES解密后为：" + strb);
        System.out.println("========指定Key进行加解密==============");
        try {
            String AESKey = encryptUtils.getAESKey(encryptUtils.encryptToSHA1(source));
            String DESKey = encryptUtils.getDESKey(encryptUtils.encryptToSHA1(source));
            System.out.println(AESKey);
            System.out.println(DESKey);
            String str11 = encryptUtils.encryptToDES(DESKey, source);
            System.out.println("DES加密后为:" + str11);
            // 使用这个密匙解密
            String str12 = encryptUtils.decryptByDES(DESKey, str11);
            System.out.println("DES解密后为：" + str12);

            // 生成一个AES算法的密匙
            String strc = encryptUtils.encryptToAES(AESKey, source);
            System.out.println("AES加密后为:" + strc);
            // 使用这个密匙解密
            String strd = encryptUtils.decryptByAES(AESKey, strc);
            System.out.println("AES解密后为：" + strd);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
