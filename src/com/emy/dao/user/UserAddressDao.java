package com.emy.dao.user;

import com.emy.dao.publicClass.PublicDao;
import com.emy.entity.UserAddress;

/**
 * 用户地址表接口
 */
public interface UserAddressDao
        extends PublicDao<UserAddress> {

    /**
     * 设置默认地址
     *
     * @param userId 用户编号
     * @param id     用户地址编号
     * @return 影响的记录个数
     */
    public int setDefaultAddress(int userId, int id);

}
