/**
 * ע��ҳ��JQuery�ű�
 * @author Kinlon
 * @version 1.0.0
 */
$(function () {
    //S    ͬ������
    //�ݽ���ť��ʶ��
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
    //E    ͬ������

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

    //S    ����������֤
    $("#password").focus(function () {
        $("#passwordRe_msg").text("");
    });
    $("#passwordRe").focus(function () {
        $("#passwordRe_msg").text("");
    });
    $("#passwordRe").blur(function () {
        //1.��ȡ����������Ϣ
        var $pwd = $(":password");
        //2.�ǿ���֤
        if ($pwd.eq(0).val().trim() === "" || $pwd.eq(1).val().trim() === "") {
            //��Ϣ��ʾ
            $("#passwordRe_msg").text("����Ϊ��");
        } else {
            //3.������ܲ��Ƚ�
            var pwdE = MD5($pwd.eq(0).val().trim());
            if (pwdE === MD5($pwd.eq(1).val().trim())) {
                //д����ܺ������
                $("#passwordHide").val(pwdE);
                console.log(pwdE);
                $("#passwordRe_msg").text("");
            } else {
                //��Ϣ��ʾ
                $("#passwordRe_msg").text("���벻һ��");
                //���������
                $pwd.eq(0).val("");
                $pwd.eq(1).val("");
            }
        }
    });
    //E    ����������֤
    //S    �ʺŴ������ж�
    $("#loginName").focus(function () {
        $("#loginName_msg").text("");
    });

    $("#loginName").blur(function () {
        //1.��ȡ�û���
        var loginName = $(this).val().trim();
        //2.ʹ��JQuery�첽����
        $.ajax({
            url: "url?obj=user&act=registCheckLoginName",
            data: {"loginName": loginName},
            dataType: "text",
            type: "get",
            success: function (data) {
                //3.��Ϣ��ʾ
                var str;
                switch (data) {                
                    case "0":
                        str = "����ʹ��";
                        $("#loginNameHide").val($("#loginName").val());
                        break;
                    case "1":
                        str = "�Ѿ�����";
                        $("#loginNameHide").val("");
                        break;
                    default:
                        str = "����쳣";
                        $("#loginNameHide").val("");
                        break;
                }
                $("#loginName_msg").text(str);
            }
        });
    });
    //E    �ʺŴ������ж�

});