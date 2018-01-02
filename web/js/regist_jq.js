/**
 * 注册页面JQuery脚本
 * @author Kinlon
 * @version 1.0.0
 */
$(function () {
    //S    同意条款
    //递交按钮初识化
    if ($(this).prop("checked")) {
        $("#reg_btn").prop("disabled", false);
    } else {
        $("#reg_btn").prop("disabled", true);
    }
    $("#chk_btn").click(function () {
        if ($(this).prop("checked")) {
            $("#reg_btn").prop("disabled", false);
        } else {
            $("#reg_btn").prop("disabled", true);
        }
    });
    //E    同意条款

    //S    身份证检测
    $("#identityCode").focus(function () {
        $("#identityCode_msg").text("");
    });
    $("#identityCode").blur(function () {
        var card = $(this).val().toLowerCase();
        var reg = /(^\d{18}$)|(^\d{17}(\d|x)$)/;
        if (reg.test(card) === false) {
            $("#identityCode_msg").text("输入有误");
        } else {
            $("#identityCode_msg").text("");
        }
    });
    //E    身份证检测

    //S    手机号检测
    $("#mobile").focus(function () {
        $("#mobile_msg").text("");
    });
    $("#mobile").blur(function () {
        var card = $(this).val().toLowerCase();
        var reg = /^\d{11}$/;
        if (reg.test(card) === false) {
            $("#mobile_msg").text("输入有误");
        } else {
            $("#mobile_msg").text("");
        }
    });
    //E    手机号检测

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
                $("#passwordHide").val(pwdE);
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
    $("#loginName").focus(function () {
        $("#loginName_msg").text("");
    });

    $("#loginName").blur(function () {
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
                var str;
                switch (data) {                
                    case "0":
                        str = "可以使用";
                        $("#loginNameHide").val($("#loginName").val());
                        break;
                    case "1":
                        str = "已经存在";
                        $("#loginNameHide").val("");
                        break;
                    default:
                        str = "检测异常";
                        $("#loginNameHide").val("");
                        break;
                }
                $("#loginName_msg").text(str);
            }
        });
    });
    //E    帐号存在性判断

});