layui.define(['layer', 'winui','form'], function (exports) {
    let layer = layui.layer,
        $ = layui.$,
        form = layui.form,
        lockKey = '_godocmsLockScreenPassword';
    
    let showBox = () => {
        //layer.closeAll();
        let lockData = localStorage.getItem(lockKey);
        $('.winui-taskbar').css('zIndex', '0');
        if (!lockData) {
            layer.msg('请设置锁屏密码');
            setTimeout(() => {
                winui.window.openTheme();
            }, 2000);
            
            return;
        }
        $.get(winui.path + 'html/system/lockscreen.html', {}, function (content) {
            let bgimg = winui.settings.lockBgSrc || '/admin/component/winui/images/bg/img5.webp';
            layer.open({
                id: 'winui-lockscreen',
                type: 1,
                title: false,
                skin: 'lockscreen',
                closeBtn: 0,
                shade: 0,
                anim: -1,
                isOutAnim: false,
                zIndex: layer.zIndex,
                content: content,
                success: function (layero, layerindex) {
                    winui.closeSocket && winui.closeSocket()
                    $('.lock-body').css('background-image', 'url(' + bgimg + ')');
                    window.localStorage.setItem("lockscreen", true);
                    var index = winui.sysTime('#date_time', '<p id="time">!HH:!mm</p><p id="date">!M月!d日,星期!w</p>');
                    var showUnlockDiv = function () {
                        winui.stopSysTime(index);
                        $('#date_time').toggleClass('layui-hide');
                        $('#login_div').toggleClass('layui-hide');
                        //解绑旧的鼠标键盘事件
                        $(document).off('mouseup', docMouseup);
                        $(document).off('keydown', docKeydown);
                        //绑定新的键盘事件
                        $(document).on('keydown', function (e) {
                            var ev = document.all ? window.event : e;
                            if (ev.keyCode == 27) {
                                //按下ESC
                                showTimeDiv();
                            }
                        });
                        let au = document.createElement("audio");
                        au.preload = "auto";
                        au.src = './component/winui/audio/unlock.mp3';
                        au.play();
                        $('#password').focus();
                    }, showTimeDiv = function () {
                        index = winui.sysTime('#date_time', '<p id="time">!HH:!mm</p><p id="date">!M月!d日,星期!w</p>')
                        $('#date_time').toggleClass('layui-hide');
                        $('#login_div').toggleClass('layui-hide');
                        //解绑旧的鼠标键盘事件
                        $(document).off('keydown');
                        //绑定新事件
                        $(document).on('mouseup', docMouseup);
                        $(document).on('keydown', docKeydown);
                    }, docMouseup = function (e) {
                        if (!e) e = window.event;
                        if (e.button == 0) {
                            //左键
                            showUnlockDiv();
                        }
                    }, docKeydown = function (e) {
                        var ev = document.all ? window.event : e;
                        if (ev.keyCode == 13) {
                            //按下回车
                            showUnlockDiv();
                        }
                    }
                    $(document).on('mouseup', docMouseup);
                    $(document).on('keydown', docKeydown);
                    
                    //解锁点击
                    let setDown = (e) => {
                        if (e.keyCode == 13) {
                            $("#unlock").trigger("click");
                            return false
                        }
                    }
                    let showOk = () =>  {
                        let au = document.createElement("audio");
                        au.preload = "auto";
                        au.src = './component/winui/audio/login.mp3';
                        au.play();
                        layer.close(layerindex);
                        window.localStorage.setItem("lockscreen", false);
                        winui.initLockScreen();
                        winui.hasSocket = false;
                        winui.startSocket && winui.startSocket();
                    }
                    $('#password').on('keydown', setDown);
                    $('#password').on('keyup', e => {
                        if ($('#password').val() == lockData) {
                            showOk()
                        }
                    })
                    
                    $('#unlock').click(e => {
                        let pwd = $('#password');
                        if (!pwd || pwd == '') {
                            layer.msg('请输入锁屏密码')
                            return false;
                        }
                        if ($('#password').val() == lockData) {
                            showOk()
                        } else {
                            layer.msg('密码错误')
                        }
                        return false;
                    });
                }
            });
        });
    }

    exports('desklock', { showBox });
})