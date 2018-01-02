/*
===================
JQuery控制集合-头部-样式
===================
@author:kinlon
@version:1.0
-------------------
 */

/*S    导航栏按钮定位处理*/
$(function () {
    var $a = $(".header_nav>div:eq(0)>div");
    var n = $a.length - 1;
    var width = 0;
    for (var i = 0; i < n; i++) {
        $a.eq(i+1).css("left", $a[i].offsetWidth + $a[i].offsetLeft + 10);
    }
});
/*E    导航栏按钮定位处理*/


/*S    商品分类_次分类_定位设置和主分类各项高度设置*/
$(function () {
    //1.获取所有次分类面板元素的个数
    var $a=$(".menu_child_all");
    var n = $a.length;

    //2.设置主分类面板各项的设置高度，添加删除主分类不影响整体height=300
    var aHeight = Math.round(300 / n);
    $(".menu_father_list").height(aHeight);

    //3.配置次分类新的位置和高度
    for (var i = 0; i < n; i++) {
        $a.eq(i).css({
            top: aHeight * (-1) * i,
            height: 300
        });
    }
});
/*E    商品分类_次分类_定位设置和主分类各项高度设置*/

/*S    三级分类的显示和隐藏*/
$(function () {
    var $a = $(".menu_child_metro");
    function moveIn(e){
        e.find("div").toggle();
    }
    //鼠标进入
    $a.mouseenter(function () {
        moveIn($(this));
    });
    //鼠标离开
    $a.mouseleave(function () {
        moveIn($(this));
    });
});
/*E    三级分类的显示和隐藏*/

/*S    三级分类Metro的随机染色*/
$(function () {
    //1.获取所有Metro元素个数
    var $a = $(".menu_child_metro");
    var n = $a.length;
    //2.随机生成类名样式
    var color1, color2, color3 = 0;
    for (var i = 0; i < n; i++) {
        //生成浅色调
        color1 = Math.ceil(Math.random() * 255 + 127);
        color2 = Math.ceil(Math.random() * 255 + 127);
        color3 = Math.ceil(Math.random() * 255 + 127);
        //3.染色
        $a.eq(i).css("background-color", "rgba(" + color1 + "," + color2 + "," + color3 + ",.8)");
    }
    //4.鼠标事件
    var bg = "";//上次染色的参数
    $a.mouseenter(function () {
        //进入
        bg = $(this).css("background-color");
        $(this).css("background-color", "rgba(0,0,0,.5)");
    });
    $a.mouseleave(function () {
        //出去
        $(this).css("background-color", bg);
    });
});
/*E    三级分类Metro的随机染色*/
