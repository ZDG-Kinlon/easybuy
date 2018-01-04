package com.emy.service.impl;

import com.emy.dao.user.UserAddressDao;
import com.emy.dao.user.impl.UserAddressDaoImpl;
import com.emy.entity.UserAddress;
import com.emy.service.ServiceAddress;
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
public class ServiceAddressImpl
        extends PublicFunction
        implements ServiceAddress {
    private String actice;
    private UserAddress userAddress=null;
    private UserAddressDao userAddressDao = new UserAddressDaoImpl();

    public String getActice() {
        return actice;
    }

    /**
     * 构造方法，不允许无参数
     *
     * @param functions
     */
    public ServiceAddressImpl(String functions, HttpServletRequest req, HttpServletResponse res) {
        super(req,res);
        this.actice = functions;
        this.req = req;
        this.res = res;
    }

    /**
     * 检测地址编号和用户编号匹配
     *
     * @param addressId 地址变厚啊
     * @return true匹配
     */
    private boolean checkAddress(int addressId){
        int userId = this.user.getId();
        if(userId==0 | addressId==0){
            return false;
        }else{
            UserAddressDao userAddressDao = new UserAddressDaoImpl();
            this.userAddress = userAddressDao.getById(addressId);
            if (this.userAddress!=null && userId == this.userAddress.getUserId()) {
                return true;
            } else {
                return false;
            }
        }
    }

    /**
     * 修改收货地址
     */
    @Override
    public void setAddress(){
        switch (checkIsLogin()) {
            case 0:
                Log.logToConsole("请求", "修改收货地址");
                if(checkAddress(MathUtils.stringToInteger(getStr("addressId")))) {
                    String value;
                    //修改地址
                    value = getStr("address");
                    if (value != null && !value.equals("")) this.userAddress.setAddress(value);
                    //修改备注
                    value = getStr("remark");
                    if (value != null) userAddress.setRemark(value);
                    this.userAddress.setCreateTime(Log.getTimeByFormat("yyyy-MM-dd HH:mm:ss"));
                    //更新
                    this.userAddressDao.set(this.userAddress);
                    toPage("user.jsp");
                    Log.logToConsole("结果", "修改成功");
                }else{
                    toInfoPage("修改的地址不属于当前用户");
                    Log.logToConsole("结果", "修改失败");
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
    @Override
    public void deleteAddress() {
        switch (checkIsLogin()) {
            case 0:
                Log.logToConsole("请求", "删除收货地址");
                if(checkAddress(MathUtils.stringToInteger(getStr("addressId")))){
                    //验证匹配
                    this.userAddressDao.del(this.userAddress.getId());
                    flushPage();
                    Log.logToConsole("结果", "删除成功");
                }else{
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
    @Override
    public void setDefaultAddress() {
        switch (checkIsLogin()) {
            case 0:
                Log.logToConsole("请求", "修改收货地址");
                if(checkAddress(MathUtils.stringToInteger(getStr("addressId")))){
                    this.userAddressDao.setDefaultAddress(this.user.getId(), this.userAddress.getId());
                    flushPage();
                    Log.logToConsole("结果", "设置成功");
                }else{
                    toInfoPage("修改的地址不属于当前用户");
                    Log.logToConsole("结果", "设置失败");
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
    @Override
    public void addAddress() {
        switch (checkIsLogin()) {
            case 0:
                //参数传入
                Log.logToConsole("请求", "添加收货地址");
                UserAddress userAddress = new UserAddress();
                userAddress.setAddress(getStr("address"));
                userAddress.setCreateTime(Log.getTimeByFormat("yyyy-MM-dd HH:mm:ss"));
                userAddress.setUserId(this.user.getId());
                userAddress.setIsDefault(1);
                userAddress.setRemark(getStr("remark"));
                if (userAddress.check()) {
                    this.userAddressDao.add(userAddress);
                    flushPage();
                } else {
                    //存在未赋值的参数
                    Log.logToConsole("结果", getStr("address") + " 添加失败");
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

	/**
	 * 使用id获取收货地址
	 */
	@Override
	public void getAddressById() {
        switch (checkIsLogin()) {
            case 0:
                Log.logToConsole("请求", "获取收货地址");
                if(checkAddress(MathUtils.stringToInteger(getStr("addressId")))){
                    UserAddress userAddress = this.userAddressDao.getById(this.userAddress.getId());
                    rePageObj("setAddress.jsp","getAddressById",userAddress);
                    Log.logToConsole("结果", "获取成功");
                }else{
                    toInfoPage("修改的地址不属于当前用户");
                    Log.logToConsole("结果", "获取失败");
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