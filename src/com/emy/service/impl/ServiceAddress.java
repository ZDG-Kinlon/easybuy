package com.emy.service.impl;

import com.emy.dao.user.UserAddressDao;
import com.emy.dao.user.impl.UserAddressDaoImpl;
import com.emy.entity.UserAddress;
import com.emy.util.Log;
import com.emy.util.MathUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 收货地址业务的请求实现类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class ServiceAddress
        extends PublicService{
    private UserAddress userAddress = null;
    private UserAddressDao userAddressDao = new UserAddressDaoImpl();

    /**
     * 构造方法，不允许无参数
     */
    public ServiceAddress(HttpServletRequest req, HttpServletResponse res) {
        super(req, res);
    }

    /**
     * 检测地址编号和用户编号匹配
     *
     * @param addressId 地址变厚啊
     * @return true匹配
     */
    private boolean checkAddress(int addressId) {
        int userId = this.user.getId();
        if (userId == 0 | addressId == 0) {
            return false;
        } else {
            UserAddressDao userAddressDao = new UserAddressDaoImpl();
            this.userAddress = userAddressDao.getById(addressId);
            if (this.userAddress != null && userId == this.userAddress.getUserId()) {
                return true;
            } else {
                return false;
            }
        }
    }

    /**
     * 修改收货地址
     */
    public void setAddress() {
        switch (checkIsLogin()) {
            case 0:
                Log.logToConsole("请求", "修改收货地址");
                if (checkAddress(MathUtils.stringToInteger(getStr("addressId")))) {
                    String value;
                    //修改地址
                    value = getStr("address");
                    if (value != null && !value.equals("")) this.userAddress.setAddress(value);
                    //修改备注
                    value = getStr("remark");
                    if (value != null) userAddress.setRemark(value);
                    if (this.userAddress.check() && this.userAddressDao.set(this.userAddress) == 1) {
                        toInfoPage("修改成功");
                        Log.logToConsole("结果", "修改成功");
                    } else {
                        toInfoPage("参数异常");
                        Log.logToConsole("结果", "修改失败");
                    }
                } else {
                    toInfoPage("修改的地址不属于当前用户");
                    Log.logToConsole("结果", "修改失败，没有用户编号不匹配");
                }
                break;
            case 1:
                toInfoPage("参数异常");
                break;
            case 2:
                toInfoPage("请先登录");
                break;
            default:
                break;
        }
    }

    /**
     * 删除收货地址
     */
    public void deleteAddress() {
        switch (checkIsLogin()) {
            case 0:
                Log.logToConsole("请求", "删除收货地址");
                if (checkAddress(MathUtils.stringToInteger(getStr("addressId")))) {
                    //验证匹配
                    if (this.userAddressDao.del(this.userAddress.getId()) == 1) {
                        Log.logToConsole("结果", "删除成功");
                        toInfoPage("删除成功");
                    } else {
                        Log.logToConsole("结果", "删除失败");
                        toInfoPage("删除失败");
                    }
                } else {
                    //不是当前用户的地址
                    toInfoPage("删除的地址不属于当前用户");
                    Log.logToConsole("结果", "删除失败");
                }
                break;
            case 1:
                toInfoPage("参数异常");
                break;
            case 2:
                toInfoPage("请先登录");
                break;
            default:
                break;
        }
    }

    /**
     * 设置默认收货地址
     */
    public void setDefaultAddress() {
        switch (checkIsLogin()) {
            case 0:
                Log.logToConsole("请求", "修改收货地址");
                if (checkAddress(MathUtils.stringToInteger(getStr("addressId")))) {
                    this.userAddressDao.setDefaultAddress(this.user.getId(), this.userAddress.getId());
                    toInfoPage("修改地址" + this.userAddress.getId() + "为默认地址");
                    Log.logToConsole("结果", "修改默认地址成功");
                } else {
                    toInfoPage("修改的地址不属于当前用户");
                    Log.logToConsole("结果", "修改默认地址失败，不用于当前用户");
                }
                break;
            case 1:
                toInfoPage("参数异常");
                break;
            case 2:
                toInfoPage("请先登录");
                break;
            default:
                break;
        }
    }

    /**
     * 添加收货地址
     */
    public void addAddress() {
        switch (checkIsLogin()) {
            case 0:
                //参数传入
                Log.logToConsole("请求", "添加收货地址");
                UserAddress userAddress = new UserAddress();
                userAddress.setAddress(getStr("address"));
                userAddress.setUserId(this.user.getId());
                userAddress.setIsDefault(1);
                userAddress.setRemark(getStr("remark"));
                if (userAddress.check() && this.userAddressDao.add(userAddress) == 1) {
                    Log.logToConsole("结果", "添加成功");
                    toInfoPage("添加成功");
                } else {
                    //存在未赋值的参数
                    Log.logToConsole("结果", "添加失败");
                    toInfoPage("参数不完整");
                }
                break;
            case 1:
                toInfoPage("参数异常");
                break;
            case 2:
                toInfoPage("请先登录");
                break;
            default:
                break;
        }
    }
}