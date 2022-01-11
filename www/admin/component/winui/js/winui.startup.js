layui.define(['layer', 'winui', 'desklogin'], function (exports) {
    let layer = layui.layer,
        $ = layui.$,
        desklogin = layui.desklogin,
        powerOnBox = $(".powerOnBox");
    let showBox = () => {
        //powerOnBox.css('display','flex');
        $('#powerOnBtn').on("click", _ => {
            let au = document.createElement("audio");
            au.preload = "auto";
            //au.autoplay = "autoplay";
            au.src = './component/winui/audio/startup.mp3';
            //au.muted = true;
            au.play();
            setTimeout(() => {
                powerOnBox.remove();
                layer.closeAll();
                winui.loginNum = 0;
                desklogin.showBox();
            }, 2000);
        })
    }
    let init = () => {
        return new Promise((resolve) => {
            //$('.winui-taskbar').css('zIndex', '0');
            
            
            __get('index/isLogin', res => {
                //console.log(res)
                if (res.data && res.data === 'ok') {
                    powerOnBox.remove();
                    //console.log(res)
                    resolve()
                } else {
                    showBox()
                }
            })
        })
       
    }
    exports('deskstartUp', { showBox,init });
})