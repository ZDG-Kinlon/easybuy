package com.emy.service.impl;

import com.emy.dao.user.UserDao;
import com.emy.dao.user.impl.UserDaoImpl;
import com.emy.entity.Log;
import com.emy.entity.User;
import com.emy.service.Method_url;
import com.emy.servlet.Servlet_url;
import com.emy.util.MathUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * 页面act指向的操作请求实现类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class MethodImpl_url
        extends Servlet_url
        implements Method_url {
    private String functions;
    private HttpServletRequest req;
    private HttpServletResponse res;

    /**
     * 构造方法
     *
     * @param functions
     */
    public MethodImpl_url(String functions, HttpServletRequest req, HttpServletResponse res) {
        this.functions = functions;
        this.req = req;
        this.res = res;
    }
    
    /**
     * 根据name获取表单的value信息
     * @param name
     * @return
     */
    public String getVal(String name){
    	return req.getParameter(name);
    }

    /**
     * 处理Servlet请求的总调度
     *
     * @throws Exception
     */
    public void run() throws Exception {
        switch (this.functions) { 
            case "regist":
                regist();
                break;
            case "registCheckLoginName":
            	registCheckLoginName();
                break;     
            case "login":
            	login();
            	break;
            default:
            	//参数方法不存在
            	runInfo(req, res,"参数act的值不存在");
        }
    }
    
    private void login(){
    	//1.获取登录信息
    	String loginName=getVal("loginName");
    	String password=getVal("password");
    	Log.logToConsole("信息", password);
    	//2.获取数据库密码
    	UserDao userDao=new UserDaoImpl();
    	List<User> list=userDao.getByField("loginName", loginName);
    	if (list.size()==1){
    		//帐号存在
    		User user=list.get(0);
    		if(user.getPassword().equals(password)){
    			HttpSession session = req.getSession();    			
    			session.setAttribute("loginName", loginName);	
    			Log.logToConsole("结果", loginName+" 登录成功");
    			runInfo(req,res,loginName+" 登录成功"); 
    		}else{
    			Log.logToConsole("结果", loginName+" 密码错误");
    			runInfo(req,res,loginName+" 密码错误"); 
    		}
    	}else{
    		//帐号不存在
    		Log.logToConsole("结果", loginName+" 不存在");
    		runInfo(req,res,loginName+" 帐号不存在"); 
    	}   	
    }
    
    /**
     * 注册帐号
     */
    private void regist(){
    	//1.获取注册信息
        User user=new User();
        user.setLoginName(getVal("loginName"));
        user.setPassword(getVal("password"));
        user.setUserName(getVal("userName"));
        user.setSex(MathUtils.stringToInteger(getVal("sex")));
        user.setIdentityCode(getVal("identityCode"));
        user.setEmail(getVal("email"));
        user.setMobile(getVal("mobile"));
        user.setType(MathUtils.stringToInteger(getVal("type")));
        if(user.chack()){
            //全部参数获取到值
            UserDao userDao=new UserDaoImpl();
            userDao.add(user);
            Log.logToConsole("结果", user.getLoginName()+" 添加成功");
            runInfo(req,res,"注册成功");            
        }else{
            //存在未赋值的参数
        	Log.logToConsole("结果", user.getLoginName()+" 添加失败");
            runInfo(req, res,"参数不完整");
        }
    }
    
    /**
     * 注册_帐号可用性检测
     */
    private void registCheckLoginName(){
    	//1.获取待检测的帐号
        String loginName = getVal("loginName");
        //2.检查帐号的存在性
        UserDao userDao = new UserDaoImpl();
        int i = userDao.getByField("loginName", loginName).size();
		Log.logToConsole("结果", loginName + " " + i);
        //3.回传结果
        PrintWriter out;
		try {
			out = res.getWriter();
			out.write(String.valueOf(i));
		} catch (IOException e) {
			e.printStackTrace();
		}        
    }
    

    /**
     * 转发至页面
     * 
     * @param request
     * @param response
     * @param page
     * @param msg
     */
    private  void rePage(HttpServletRequest request, HttpServletResponse response,
                         String page, String msg) {
        try {
            request.setAttribute(page, msg);
            request.getRequestDispatcher(page).forward(request, response);
        } catch (IOException | ServletException e) {
            e.printStackTrace();
        }
    }
}