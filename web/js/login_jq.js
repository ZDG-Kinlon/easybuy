/**
 * ��¼ҳ��JQuery�ű�
 * @author Kinlon
 * @version 1.0.0
 */
$(function() {
	//S    �������
	$("#password").blur(function() {
		$("#passwordHide").val(MD5($(this).val()));
	});
	$("#password").keyup(function() {
		$("#passwordHide").val(MD5($(this).val()));			
	});
//E    �������
});