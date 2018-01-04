/**
 * 修改用户信息JQuery脚本
 * @author Kinlon
 * @version 1.0.0
 */
$(function () {
    //S    密码加密填入隐藏域
    $("#password").focus(function () {
        $("#passwordNewHide").val("");
    });
    $("#password").blur(function () {
        $("#passwordNewHide").val(MD5($(this).val()));
    });
    //E    密码加密填入隐藏域
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

});