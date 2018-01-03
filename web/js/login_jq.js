/**
 * 登录页面JQuery脚本
 * @author Kinlon
 * @version 1.0.0
 */
$(function() {
	//S    密码加密
	$("#password").blur(function() {
		$("#passwordHide").val(MD5($(this).val()));
	});
	$("#password").keyup(function() {
		$("#passwordHide").val(MD5($(this).val()));			
	});
//E    密码加密
});