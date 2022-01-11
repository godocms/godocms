layui.define(['layer', 'winui', 'laytpl', 'winuiInit', 'desklogin', 'desklock'], function (exports) {
    let $ = layui.$,
        layer = layui.layer,
        winuiInit = layui.winuiInit,
        desklogin = layui.desklogin,
        desklock = layui.desklock,
        //winui = layui.winui,
        laytpl = layui.laytpl;
    let loginOut = () => {
        winui.window.confirm('确认注销吗?', { icon: 3, title: '提示' }, function (index) {
            //winui.window.msg('执行注销操作，返回登录界面');
            layer.close(index);
            let token = getToken()
            if (!token) {
                layer.msg('token缺失！');
                return;
            }
            $.ajax({
                method: 'get',
                headers: getHeader(),
                url: apiUrl + 'admin/loginOut',
                success: (res) => {
                    let au = document.createElement("audio");
                    au.preload = "auto";
                    au.src = './component/winui/audio/out.mp3';
                    au.play();
                    winui.loginNum = 0;
                    desklogin.showBox();
                    loginOutToken();
                    winui.closeSocket && winui.closeSocket()
                    //localStorage.setItem('lockscreen', true);
                    //winui.lockScreen();
                    
                }
            })
        });
    }
    //注销登录
    $('.logout').on('click', function () {
        winui.hideStartMenu();
        loginOut();
    });

    if (window.localStorage.getItem("lockscreen") == "true") {
        desklock.showBox();
    }

    let toolsAction = {
        changeBg: () => {
            let id = parseInt(Math.random() * 21 + 1, 10);
            let bgSrc = '/admin/component/winui/images/bg/img' + id + '.webp';
            winui.resetBg(bgSrc);
        },
        fullScreen: () => {
            winui.fullScreen(document.documentElement);
        },
        devTools: () => {
            winui.window.open({
                id: 'godocmstools',
                type: 2,
                title: '开发工具集',
                shade: 0,
                moveOut: true,
                area: ['80%', '80%'],
                anim: 1,
                content: '/admin/tools/index.html',
                offset: 'auto'  //居中
                , min: true  //显示最小化按钮
                , max: true  //显示最大化按钮
                , refresh: true    //显示刷新按钮
            });
        },
        toolsTodo: () => {
            winui.window.open({
                id: 'godocmstodos',
                type: 2,
                title: '便签',
                shade: 0,
                moveOut: true,
                area: ['80%', '80%'],
                anim: 1,
                content: '/admin/tools/todo/index.html',
                offset: 'auto'  //居中
                , min: true  //显示最小化按钮
                , max: true  //显示最大化按钮
                , refresh: true    //显示刷新按钮
            });
        },
        toolsClock: () => {
            winui.window.open({
                id: 'godocmsclocks',
                type: 2,
                title: '番茄时钟',
                shade: 0,
                moveOut: true,
                area: ['580px', '400px'],
                anim: 1,
                content: '/admin/tools/clock/index.html',
                offset: 'auto'  //居中
                , min: true  //显示最小化按钮
                , max: true  //显示最大化按钮
                , refresh: true    //显示刷新按钮
            });
        },
        toolsBaiban: () => {
            winui.window.open({
                id: 'godocmsbaiban',
                type: 2,
                title: '办公白板',
                shade: 0,
                moveOut: true,
                area: ['90%', '90%'],
                anim: 1,
                content: '/admin/tools/baiban/index.html',
                offset: 'auto'  //居中
                , min: true  //显示最小化按钮
                , max: true  //显示最大化按钮
                , refresh: true    //显示刷新按钮
            });
        },
        toolsCaculater: () => {
            winui.window.open({
                id: 'godocmscalculater',
                type: 2,
                title: '计算器',
                shade: 0,
                moveOut: true,
                area: ['380px', '600px'],
                anim: 1,
                content: '/admin/tools/calculater/index.html',
                offset: 'auto'  //居中
                , min: true  //显示最小化按钮
                , max: true  //显示最大化按钮
                , refresh: true    //显示刷新按钮
            });
        },
        toolsCalendar: () => {
            winui.window.open({
                id: 'godocmstoolsCalendar',
                type: 2,
                title: '日历',
                shade: 0,
                moveOut: true,
                area: ['750px', '520px'],
                anim: 1,
                content: '/admin/tools/rili/index.html',
                offset: 'auto'  //居中
                , min: true  //显示最小化按钮
                , max: true  //显示最大化按钮
                , refresh: true    //显示刷新按钮
            });
        },
        changeTheme: () => {
            location.href = 'ui.html';
        },
        lockScreen: () => {
            desklock.showBox()
        },
        toolsFontEditor: () => {
            winui.window.open({
                id: 'godocmsfonteditor',
                type: 2,
                title: '字体编辑器',
                shade: 0,
                moveOut: true,
                area: ['90%', '90%'],
                anim: 1,
                content: '/admin/fontedit/index.html',
                offset: 'auto'  //居中
                , min: true  //显示最小化按钮
                , max: true  //显示最大化按钮
                , refresh: true    //显示刷新按钮
            });
        },
        toolshttpApi: () => {
            winui.window.open({
                id: 'godocmstoolshttpApi',
                type: 2,
                title: '接口工具',
                shade: 0,
                moveOut: true,
                area: ['750px', '520px'],
                anim: 1,
                content: '/admin/tools/http/index.html',
                offset: 'auto'  //居中
                , min: true  //显示最小化按钮
                , max: true  //显示最大化按钮
                , refresh: true    //显示刷新按钮
            });
        },
        toolsgifcap: () => {
            winui.window.open({
                id: 'godocmstoolsgifcap',
                type: 2,
                title: '录屏',
                shade: 0,
                moveOut: true,
                area: ['520px', '520px'],
                anim: 1,
                content: '/admin/tools/gifcap/index.html',
                offset: 'auto'  //居中
                , min: true  //显示最小化按钮
                , max: true  //显示最大化按钮
                , refresh: true    //显示刷新按钮
            });
        },
    }
    let toolsObj = [
        {
            tips: '日历',
            icon: 'fa-calendar',
            startcss: 'winui-tile-normal',
            clickActioin: toolsAction.toolsCalendar
        },
        {
            tips: '计算器',
            icon: 'fa-calculator',
            startcss: 'winui-tile-normal',
            clickActioin: toolsAction.toolsCaculater
        },
        {
            tips: '开发工具',
            icon: 'fa-gavel',
            startcss: 'winui-tile-normal',
            clickActioin: toolsAction.devTools
        },
        {
            tips: '切换风格',
            icon: 'fa-paper-plane-o',
            startcss: 'winui-tile-normal',
            clickActioin: toolsAction.changeTheme
        },
        {
            tips: '便签',
            icon: 'fa-clock-o',
            startcss: 'winui-tile-normal',
            clickActioin: toolsAction.toolsTodo
        },
        {
            tips: '番茄时钟',
            icon: 'fa-bell',
            startcss: 'winui-tile-normal',
            clickActioin: toolsAction.toolsClock
        },
        {
            tips: '接口工具',
            icon: 'fa-code',
            startcss: 'winui-tile-normal',
            clickActioin: toolsAction.toolshttpApi
        },
        {
            tips: '办公白板',
            icon: 'fa-file-archive-o',
            startcss: 'winui-tile-normal',
            //startcss: 'winui-tile-long',
            clickActioin: toolsAction.toolsBaiban

        },
        {
            tips: '字体编辑器',
            icon: 'fa-tint',
            startcss: 'winui-tile-normal',
            clickActioin: toolsAction.toolsFontEditor
        },
        {
            tips: '录屏',
            icon: 'fa-ravelry',
            startcss: 'winui-tile-normal',
            clickActioin: toolsAction.toolsgifcap
        },
    ];
    laytpl($('#startCenterTpl').html()).render(toolsObj, function (html) {
        $('#winui-tilebox-body').html(html)
        let clickAct = (obj) => {
            let id = $(obj).attr('data-id') * 1;
            //console.log(id)
            if (toolsObj[id])
                toolsObj[id]["clickActioin"]()
        }
        $('#winui-tilebox-body').on('click', e => {
            if ($(e.target).hasClass('winui-tile')) {
                clickAct(e.target)
            }
            else if ($(e.target).parent().hasClass('winui-tile')) {
                clickAct($(e.target).parent())
            }
        })
    });
    //扩展桌面助手工具
    let menutextList = [
        {
            tips: '全屏',
            icon: 'fa-clone',
            clickActioin: toolsAction.fullScreen
        },
        {
            tips: '锁屏',
            icon: 'fa-lock',
            clickActioin: toolsAction.lockScreen
        },
        {
            tips: '切换壁纸',
            icon: 'fa-television',
            clickActioin: toolsAction.changeBg
        },
        {
            tips: '注销登录',
            icon: 'fa-power-off',
            clickActioin: function (e) {
                loginOut();
            }
        }
    ];

    winui.helper.addTool(toolsObj.concat(menutextList));
    let isFullScreen = false;
    $('#rightmenu-screen').on('click', (e) => {
        if(!isFullScreen) {
            isFullScreen = true;
            toolsAction.fullScreen();
            $('#rightmenu-screen').text('退出全屏')
        }else{
            isFullScreen = true;
            winui.exitFullScreen();
            $('#rightmenu-screen').text('进入全屏')
        }
        
    });
    $('#rightmenu-loginout').on('click', (e) => {
        loginOut()
    });
    $('#rightmenu-lock').on('click', e => {
        desklock.showBox()
    });
    $('#rightmenu-refresh').on('click', e => {
        location.reload()
        //winuiInit()
    });
    $('#rightmenu-initpos').on('click', e => {
        winui.desktop.initPos()
    })
    $('#rightmenu-changeBg').on('click', e => {
        toolsAction.changeBg()
    })
    let showHelperKey = '_windowsHelperTips'
    let windowShowHelper = localStorage.getItem(showHelperKey);
    if (!windowShowHelper) {
        $('.layer-ext-winhelper').hide()
        $('#rightmenu-showhelper').text('显示助手')
    }
    $('#rightmenu-showhelper').on('click', () => {
        let windowShowHelper = localStorage.getItem(showHelperKey);
        if (!windowShowHelper) {
            $('.layer-ext-winhelper').show()
            localStorage.setItem(showHelperKey, 1)
            $('#rightmenu-showhelper').text('隐藏助手')
        } else {
            $('.layer-ext-winhelper').hide()
            localStorage.removeItem(showHelperKey)
            $('#rightmenu-showhelper').text('显示助手')
        }
    })
    exports('deskmenu', {});
})