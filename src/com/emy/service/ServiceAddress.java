package com.emy.service;

/**
 * 用户业务的请求接口类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public interface ServiceAddress {
	/**
	 * 使用id获取收货地址
	 */
	public void getAddressById();
	
    /**
     * 修改收货地址
     */
    public void setAddress();

    /**
     * 删除收货地址
     */
    public void deleteAddress();

    /**
     * 设置默认收货地址
     */
    public void setDefaultAddress();

    /**
     * 添加收货地址
     */
    public void addAddress();

}
