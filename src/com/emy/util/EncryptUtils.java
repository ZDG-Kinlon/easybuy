package com.emy.util;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;//Java1.8时出现

/**
 * 加密解密工具类
 *
 * @author Kinlon
 * @version 1.0.0
 */

public class EncryptUtils {
    /**
     * 进行BASE64加密
     *
     * @param str 原文
     * @return 密文
     */
    public String encryptToBase64(String str) {
        //将原文按照UTF-8转二进制字节数组
        Base64.Encoder encoder = Base64.getEncoder();
        try {
            return encoder.encodeToString(str.getBytes("UTF-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 进行BASE64解密
     *
     * @param str 密文
     * @return 原文
     */
    public String decodeByBase64(String str) {
        Base64.Decoder decoder = Base64.getDecoder();
        try {
            return new String(decoder.decode(str), "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return null;
        }
    }


    /**
     * 进行MD5加密
     *
     * @param info 要加密的信息
     * @return String 加密后的字符串
     */
    public String encryptToMD5(String info) {
        byte[] digesta = null;
        try {
            // 得到一个md5的消息摘要
            MessageDigest alga = MessageDigest.getInstance("MD5");
            // 添加要进行计算摘要的信息
            alga.update(info.getBytes());
            // 得到该摘要
            digesta = alga.digest();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        // 将摘要转为字符串
        String rs = byte2hex(digesta);
        return rs;
    }

    /**
     * 进行SHA-1加密
     *
     * @param info 要加密的信息
     * @return String 加密后的字符串
     */
    public String encryptToSHA1(String info) {
        byte[] digesta = null;
        try {
            // 得到一个SHA-1的消息摘要
            MessageDigest alga = MessageDigest.getInstance("SHA-1");
            // 添加要进行计算摘要的信息
            alga.update(info.getBytes());
            // 得到该摘要
            digesta = alga.digest();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        // 将摘要转为字符串
        String rs = byte2hex(digesta);
        return rs;
    }


    /**
     * 进行SHA-256加密
     *
     * @param info 要加密的信息
     * @return String 加密后的字符串
     */
    public String encryptToSHA256(String info) {
        byte[] digesta = null;
        try {
            // 得到一个SHA-1的消息摘要
            MessageDigest alga = MessageDigest.getInstance("SHA-256");
            // 添加要进行计算摘要的信息
            alga.update(info.getBytes());
            // 得到该摘要
            digesta = alga.digest();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        // 将摘要转为字符串
        String rs = byte2hex(digesta);
        return rs;
    }


    /**
     * 根据一定的算法得到相应的key
     *
     * @param algorithm 加密方式，AES，DES
     * @param src       加密公钥
     * @return 加密后的密钥
     */
    public String getKey(String algorithm, String src) {
        if (algorithm.equals("AES")) {
            return src.substring(0, 16);
        } else if (algorithm.equals("DES")) {
            return src.substring(0, 8);
        } else {
            return null;
        }
    }

    /**
     * 得到AES加密的key
     *
     * @param src 加密公钥
     * @return 加密后的密钥
     */
    public String getAESKey(String src) {
        return this.getKey("AES", src);
    }

    /**
     * 得到DES加密的key
     *
     * @param src 加密公钥
     * @return 加密后的密钥
     */
    public String getDESKey(String src) {
        return this.getKey("DES", src);
    }

    /**
     * 创建密匙
     *
     * @param algorithm 加密算法,可用 AES,DES,DESede,Blowfish
     *                  AES (128) DES (56) DESede (168) HmacSHA1 HmacSHA256
     * @return SecretKey 秘密（对称）密钥
     */
    public SecretKey createSecretKey(String algorithm) {
        // 声明KeyGenerator对象
        KeyGenerator keygen;
        // 声明 密钥对象
        SecretKey deskey = null;
        try {
            // 返回生成指定算法的秘密密钥的 KeyGenerator 对象
            keygen = KeyGenerator.getInstance(algorithm);
            // 生成一个密钥
            deskey = keygen.generateKey();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        // 返回密钥
        return deskey;
    }

    /**
     * 创建一个AES的密钥
     *
     * @return
     */
    public SecretKey createSecretAESKey() {
        return createSecretKey("AES");
    }

    /**
     * 创建一个DES的密钥
     *
     * @return
     */
    public SecretKey createSecretDESKey() {
        return createSecretKey("DES");
    }

    /**
     * 根据相应的加密算法、密钥、源文件进行加密，返回加密后的文件
     *
     * @param Algorithm 加密算法:DES,AES
     * @param key       加密用的密钥
     * @param info      原文
     * @return 密文
     */
    public String encrypt(String Algorithm, SecretKey key, String info) {
        // 定义要生成的密文
        byte[] cipherByte = null;
        try {
            // 得到加密/解密器
            Cipher c1 = Cipher.getInstance(Algorithm);
            // 用指定的密钥和模式初始化Cipher对象
            // 参数:(ENCRYPT_MODE, DECRYPT_MODE, WRAP_MODE,UNWRAP_MODE)
            c1.init(Cipher.ENCRYPT_MODE, key);
            // 对要加密的内容进行编码处理,
            cipherByte = c1.doFinal(info.getBytes());
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 返回密文的十六进制形式
        return byte2hex(cipherByte);
    }

    /**
     * 根据相应的解密算法、密钥和需要解密的文本进行解密，返回解密后的文本内容
     *
     * @param Algorithm 加密算法:DES,AES
     * @param key       解密用的密钥
     * @param sInfo     密文
     * @return 原文
     */
    public String decrypt(String Algorithm, SecretKey key, String sInfo) {
        byte[] cipherByte = null;
        try {
            // 得到加密/解密器
            Cipher c1 = Cipher.getInstance(Algorithm);
            // 用指定的密钥和模式初始化Cipher对象
            c1.init(Cipher.DECRYPT_MODE, key);
            // 对要解密的内容进行编码处理
            cipherByte = c1.doFinal(hex2byte(sInfo));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new String(cipherByte);
    }

    /**
     * 根据相应的解密算法、指定的密钥和需要解密的文本进行解密，返回解密后的文本内容
     *
     * @param Algorithm 加密算法:DES,AES
     * @param sSrc      密文
     * @param sKey      这个key可以由用户自己指定 注意AES的长度为16位,DES的长度为8位
     * @return 原文
     * @throws Exception 参数异常
     */
    public static String decrypt(String Algorithm, String sSrc, String sKey) throws Exception {
        try {
            // 判断Key是否正确
            if (sKey == null) {
                throw new Exception("Key为空null");
            }
            // 判断采用AES加解密方式的Key是否为16位
            if (Algorithm.equals("AES") && sKey.length() != 16) {
                throw new Exception("Key长度不是16位");
            }
            // 判断采用DES加解密方式的Key是否为8位
            if (Algorithm.equals("DES") && sKey.length() != 8) {
                throw new Exception("Key长度不是8位");
            }
            byte[] raw = sKey.getBytes("ASCII");
            SecretKeySpec skeySpec = new SecretKeySpec(raw, Algorithm);
            Cipher cipher = Cipher.getInstance(Algorithm);
            cipher.init(Cipher.DECRYPT_MODE, skeySpec);
            byte[] encrypted1 = hex2byte(sSrc);
            try {
                byte[] original = cipher.doFinal(encrypted1);
                String originalString = new String(original);
                return originalString;
            } catch (Exception e) {
                throw e;
            }
        } catch (Exception ex) {
            throw ex;
        }
    }

    /**
     * 根据相应的加密算法、指定的密钥、源文件进行加密，返回加密后的文件
     *
     * @param Algorithm 加密算法:DES,AES
     * @param sSrc      原文
     * @param sKey      这个key可以由用户自己指定 注意AES的长度为16位,DES的长度为8位
     * @return 密文
     * @throws Exception 参数异常
     */
    public static String encrypt(String Algorithm, String sSrc, String sKey) throws Exception {
        // 判断Key是否正确
        if (sKey == null) {
            throw new Exception("Key为空null");
        }
        // 判断采用AES加解密方式的Key是否为16位
        if (Algorithm.equals("AES") && sKey.length() != 16) {
            throw new Exception("Key长度不是16位");
        }
        // 判断采用DES加解密方式的Key是否为8位
        if (Algorithm.equals("DES") && sKey.length() != 8) {
            throw new Exception("Key长度不是8位");
        }
        byte[] raw = sKey.getBytes("ASCII");
        SecretKeySpec skeySpec = new SecretKeySpec(raw, Algorithm);
        Cipher cipher = Cipher.getInstance(Algorithm);
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
        byte[] encrypted = cipher.doFinal(sSrc.getBytes());
        return byte2hex(encrypted);
    }

    /**
     * 采用DES随机生成的密钥进行加密
     *
     * @param key  密钥
     * @param info 原文
     * @return 密文
     */
    public String encryptToDES(SecretKey key, String info) {
        return encrypt("DES", key, info);
    }

    /**
     * 采用DES指定密钥的方式进行加密
     *
     * @param key  密钥
     * @param info 密文
     * @return 原文
     * @throws Exception 参数异常
     */
    public String encryptToDES(String key, String info) throws Exception {
        return encrypt("DES", info, key);
    }

    /**
     * 采用DES随机生成密钥的方式进行解密，密钥需要与加密的生成的密钥一样
     *
     * @param key   密钥
     * @param sInfo 密文
     * @return 原文
     */
    public String decryptByDES(SecretKey key, String sInfo) {
        return decrypt("DES", key, sInfo);
    }

    /**
     * 采用DES用户指定密钥的方式进行解密，密钥需要与加密时指定的密钥一样
     *
     * @param key   密钥
     * @param sInfo 密文
     * @return 原文
     */
    public String decryptByDES(String key, String sInfo) throws Exception {
        return decrypt("DES", sInfo, key);
    }

    /**
     * 采用AES随机生成的密钥进行加密
     *
     * @param key  密钥
     * @param info 原文
     * @return 密文
     */
    public String encryptToAES(SecretKey key, String info) {
        return encrypt("AES", key, info);
    }

    /**
     * 采用AES指定密钥的方式进行加密
     *
     * @param key  密钥
     * @param info 原文
     * @return 密文
     * @throws Exception 参数异常
     */
    public String encryptToAES(String key, String info) throws Exception {
        return encrypt("AES", info, key);
    }

    /**
     * 采用AES随机生成密钥的方式进行解密，密钥需要与加密的生成的密钥一样
     *
     * @param key   密钥
     * @param sInfo 密文
     * @return 原文
     */
    public String decryptByAES(SecretKey key, String sInfo) {
        return decrypt("AES", key, sInfo);
    }

    /**
     * 采用AES用户指定密钥的方式进行解密，密钥需要与加密时指定的密钥一样
     *
     * @param key   密钥
     * @param sInfo 密文
     * @return 原文
     */
    public String decryptByAES(String key, String sInfo) throws Exception {
        return decrypt("AES", sInfo, key);
    }

    /**
     * 十六进制字符串转化为2进制
     *
     * @param strhex 十六进制字符串
     * @return 二进制字节数组
     */
    public static byte[] hex2byte(String strhex) {
        if (strhex == null) {
            return null;
        }
        int l = strhex.length();
        if (l % 2 == 1) {
            return null;
        }
        byte[] b = new byte[l / 2];
        for (int i = 0; i != l / 2; i++) {
            b[i] = (byte) Integer.parseInt(strhex.substring(i * 2, i * 2 + 2), 16);
        }
        return b;
    }

    /**
     * 将二进制转化为16进制字符串
     *
     * @param b 二进制字节数组
     * @return String 十六进制字符串
     */
    public static String byte2hex(byte[] b) {
        String hs = "";
        String stmp = "";
        for (int n = 0; n < b.length; n++) {
            stmp = (java.lang.Integer.toHexString(b[n] & 0XFF));
            if (stmp.length() == 1) {
                hs = hs + "0" + stmp;
            } else {
                hs = hs + stmp;
            }
        }
        return hs.toUpperCase();
    }


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
        System.out.println("经过SHA256:" + encryptUtils.encryptToSHA256(source));
        System.out.println("========随机生成Key进行加解密==============");
        // 生成一个DES算法的密匙
        SecretKey key = encryptUtils.createSecretDESKey();
        String str1 = encryptUtils.encryptToDES(key, source);
        System.out.println("DES加密后为:" + str1);
        // 使用这个密匙解密
        String str2 = encryptUtils.decryptByDES(key, str1);
        System.out.println("DES解密后为：" + str2);

        // 生成一个AES算法的密匙
        SecretKey key1 = encryptUtils.createSecretAESKey();
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