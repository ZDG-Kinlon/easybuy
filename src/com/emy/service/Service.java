package com.emy.service;

/**
 * 后台功能业务接口类
 * @author Kinlon
 * @version 1.0.0
 */
public interface Service {
    /**
     * 检测帐号和密码是否匹配
     * @param id 帐号编号
     * @param name 帐号
     * @param pwd 密码
     * @return 比对结果
     */
    public boolean checkUserPwd(int id,String name,String pwd);
}
