package com.emy.service.impl;

import com.emy.dao.user.impl.UserDaoImpl;
import com.emy.util.Log;
import com.emy.entity.User;
import com.emy.service.Service;

public class ServiceImpl
        implements Service {
    /**
     * 检测帐号和密码是否匹配
     *
     * @param id   帐号编号
     * @param name 帐号
     * @param pwd  密码
     * @return 比对结果
     */
    @Override
    public boolean checkUserPwd(int id, String name, String pwd) {
        Log.logToConsole("请求", "帐号与密码检测");
        Log.logToConsole("参数", id + "|" + name + "|" + pwd);
        if (id == 0) {        	
            return false;
        } else {
            User user = new UserDaoImpl().getById(id);
            return user != null && name != null && pwd != null && user.getLoginName().equals(name)
                    && user.getPassword().equals(pwd);
        }
    }
}
