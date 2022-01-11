layui.config({
    base: '/admin/component/winui/' //指定 winui 路径
    , version: '1.0.0'
}).extend({  //指定js别名
    window: 'js/winui.window',
    desktop: 'js/winui.desktop',
    start: 'js/winui.start',
    helper: 'js/winui.helper',
    deskmenu: 'js/winui.deskmenu',
    deskstartUp: 'js/winui.startup',
    winuiInit: 'js/winui.init',
    desklogin: 'js/winui.login',
    desklock: 'js/winui.lock',
    dragmove: 'js/dragmove',
    winuisocket : 'js/winui.socket',
    //layim: 'js/layim',
    winchat : 'js/winui.chat'
}).define(['window', 'desktop', 'start', 'helper', 'layer', 'laytpl', 'deskmenu', 'deskstartUp', 'winuiInit', 'desklogin', 'desklock', 'dragmove', 'winuisocket', 'winchat'], function (exports) {
    var $ = layui.jquery,
        laytpl = layui.laytpl,
        layer = layui.layer,
        deskstartUp = layui.deskstartUp,
        winuiInit = layui.winuiInit,
        desklogin = layui.desklogin,
        desklock = layui.desklock;
    //console.log(winuiInit)
    deskstartUp.init().then(res => {
        winuiInit()
        winui.desklock = desklock;
        winui.desklogin = desklogin;
    })

    
    
    layui.admin = {};
    layui.admin.addTab = (id, title, content) => {
        //console.log(id)
        winui.window.open({
            id: id.toString(),
            type: 2,
            title: title,
            content: content,
            shade: 0,
            offset: 'auto',
            area: ['90%', '90%'],
            anim: 1,
            moveOut: true,
            maxmin: true,
            refresh: true
            //zIndex: layer.zIndex + 10

        });
    }
    
    //$(document).contextmenu(function() {return false;}); 
      
    
    exports('index', {});
});