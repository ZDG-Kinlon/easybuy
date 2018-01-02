/**
 * 注册页面JQuery脚本
 * @author Kinlon
 * @version 1.0.0
 */
$(function () {
    //递交按钮初识化
    if ($(this).prop("checked")) {
        $("#reg_btn").prop("disabled", false);
    } else {
        $("#reg_btn").prop("disabled", true);
    }

    //S    二次密码验证
    $("#password").focus(function () {
        $("#passwordRe_msg").text("");
    });
    $("#passwordRe").focus(function () {
        $("#passwordRe_msg").text("");
    });
    $("#passwordRe").blur(function () {
        //1.获取表单密码框的信息
        var $pwd = $(":password");
        //2.非空验证
        if ($pwd.eq(0).val().trim() === "" || $pwd.eq(1).val().trim() === "") {
            //消息提示
            $("#passwordRe_msg").text("密码为空");
        } else {
            //3.密码加密并比较
            var pwdE = MD5($pwd.eq(0).val().trim());
            if (pwdE === MD5($pwd.eq(1).val().trim())) {
                //写入加密后的密码
                $("[name='passwordHide']").val(pwdE);
                console.log(pwdE);
                $("#passwordRe_msg").text("");
            } else {
                //消息提示
                $("#passwordRe_msg").text("密码不一致");
                //重置密码框
                $pwd.eq(0).val("");
                $pwd.eq(1).val("");
            }
        }
    });
    //E    二次密码验证
    //S    帐号存在性判断
    $("[name='loginName']").focus(function () {
    	$("#loginName_msg").text("");
    });
    
    $("[name='loginName']").blur(function () {
        //1.获取用户名
        var loginName = $(this).val().trim();
        //2.使用JQuery异步交互
        $.ajax({
            url: "url?act=registCheckLoginName",
            data: {"loginName": loginName},
            dataType: "text", 
            type: "get",
            success: function (data) {
                //3.消息提示
                $("#loginName_msg").text(data);
            }            
        });
    });
    //E    帐号存在性判断
    //S    同意条款
    $("#chk_btn").click(function () {
        if ($(this).prop("checked")) {
            $("#reg_btn").prop("disabled", false);
        } else {
            $("#reg_btn").prop("disabled", true);
        }
    });
    //E    同意条款
});