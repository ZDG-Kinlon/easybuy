/*
===================
JQuery���Ƽ���-ͷ��-��ʽ
===================
@author:kinlon
@version:1.0
-------------------
 */

/*S    ��������ť��λ����*/
$(function () {
    var $a = $(".header_nav>div:eq(0)>div");
    var n = $a.length - 1;
    var width = 0;
    for (var i = 0; i < n; i++) {
        $a.eq(i+1).css("left", $a[i].offsetWidth + $a[i].offsetLeft + 10);
    }
});
/*E    ��������ť��λ����*/


/*S    ��Ʒ����_�η���_��λ���ú����������߶�����*/
$(function () {
    //1.��ȡ���дη������Ԫ�صĸ���
    var $a=$(".menu_child_all");
    var n = $a.length;

    //2.��������������������ø߶ȣ����ɾ�������಻Ӱ������height=300
    var aHeight = Math.round(300 / n);
    $(".menu_father_list").height(aHeight);

    //3.���ôη����µ�λ�ú͸߶�
    for (var i = 0; i < n; i++) {
        $a.eq(i).css({
            top: aHeight * (-1) * i,
            height: 300
        });
    }
});
/*E    ��Ʒ����_�η���_��λ���ú����������߶�����*/

/*S    �����������ʾ������*/
$(function () {
    var $a = $(".menu_child_metro");
    function moveIn(e){
        e.find("div").toggle();
    }
    //������
    $a.mouseenter(function () {
        moveIn($(this));
    });
    //����뿪
    $a.mouseleave(function () {
        moveIn($(this));
    });
});
/*E    �����������ʾ������*/

/*S    ��������Metro�����Ⱦɫ*/
$(function () {
    //1.��ȡ����MetroԪ�ظ���
    var $a = $(".menu_child_metro");
    var n = $a.length;
    //2.�������������ʽ
    var color1, color2, color3 = 0;
    for (var i = 0; i < n; i++) {
        //����ǳɫ��
        color1 = Math.ceil(Math.random() * 255 + 127);
        color2 = Math.ceil(Math.random() * 255 + 127);
        color3 = Math.ceil(Math.random() * 255 + 127);
        //3.Ⱦɫ
        $a.eq(i).css("background-color", "rgba(" + color1 + "," + color2 + "," + color3 + ",.8)");
    }
    //4.����¼�
    var bg = "";//�ϴ�Ⱦɫ�Ĳ���
    $a.mouseenter(function () {
        //����
        bg = $(this).css("background-color");
        $(this).css("background-color", "rgba(0,0,0,.5)");
    });
    $a.mouseleave(function () {
        //��ȥ
        $(this).css("background-color", bg);
    });
});
/*E    ��������Metro�����Ⱦɫ*/
