/**
 * µÇÂ¼Ò³ÃæJQuery½Å±¾
 * @author Kinlon
 * @version 1.0.0
 */
$(function() {
	//S    ÃÜÂë¼ÓÃÜ
	$("#password").blur(function() {
		$("#passwordHide").val(MD5($(this).val()));
	});
	$("#password").keyup(function() {
		$("#passwordHide").val(MD5($(this).val()));			
	});
//E    ÃÜÂë¼ÓÃÜ
});