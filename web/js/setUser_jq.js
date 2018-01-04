/**
 * �޸��û���ϢJQuery�ű�
 * @author Kinlon
 * @version 1.0.0
 */
$(function () {
    //S    �����������������
    $("#password").focus(function () {
        $("#passwordNewHide").val("");
    });
    $("#password").blur(function () {
        $("#passwordNewHide").val(MD5($(this).val()));
    });
    //E    �����������������
    //S    ���֤���
    $("#identityCode").focus(function () {
        $("#identityCode_msg").text("");
    });
    $("#identityCode").blur(function () {
        var card = $(this).val().toLowerCase();
        var reg = /(^\d{18}$)|(^\d{17}(\d|x)$)/;
        if (reg.test(card) === false) {
            $("#identityCode_msg").text("��������");
        } else {
            $("#identityCode_msg").text("");
        }
    });
    //E    ���֤���
    //S    �ֻ��ż��
    $("#mobile").focus(function () {
        $("#mobile_msg").text("");
    });
    $("#mobile").blur(function () {
        var card = $(this).val().toLowerCase();
        var reg = /^\d{11}$/;
        if (reg.test(card) === false) {
            $("#mobile_msg").text("��������");
        } else {
            $("#mobile_msg").text("");
        }
    });
    //E    �ֻ��ż��

});