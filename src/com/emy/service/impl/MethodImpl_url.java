package com.emy.service.impl;

import com.emy.dao.user.UserDao;
import com.emy.dao.user.impl.UserDaoImpl;
import com.emy.entity.User;
import com.emy.service.Method_url;
import com.emy.servlet.Servlet_url;
import com.emy.util.MathUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

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
            default:
            	//参数方法不存在
            	runInfo(req, res,"参数act的值不存在");
        }

    }
    
    /**
     * 注册帐号
     */
    private void regist(){
    	//1.获取注册信息
        User user=new User();
        user.setLoginName(req.getParameter("loginName"));
        user.setPassword(req.getParameter("passwordHide"));
        user.setUserName(req.getParameter("userName"));
        user.setSex(MathUtils.stringToInteger(req.getParameter("sex")));
        user.setIdentityCode(req.getParameter("identityCode"));
        user.setEmail(req.getParameter("email"));
        user.setMobile(req.getParameter("mobile"));
        user.setType(MathUtils.stringToInteger(req.getParameter("type")));
        if(user.chack()){
            //全部参数获取到值
            UserDao userDao=new UserDaoImpl();
            userDao.add(user);
            runInfo(req,res,"注册成功");
        }else{
            //存在未赋值的参数
            runInfo(req, res,"参数不完整");
        }
    }
    
    /**
     * 注册_帐号可用性检测
     */
    private void registCheckLoginName(){
    	//1.获取待检测的帐号
        String loginName = req.getParameter("loginName");
        //2.检查帐号的存在性
        UserDao userDao = new UserDaoImpl();
        int i = userDao.getByField("loginName", loginName).size();
        //3.判断帐号的状态
        String msg;
        if (i > 0) {
            msg = "已经存在";
        } else if (i == 0) {
            msg = "可用使用";
        } else {
            msg = "帐号异常";
        }
        //4.回传结果
        PrintWriter out;
		try {
			out = res.getWriter();
			out.write(msg);
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