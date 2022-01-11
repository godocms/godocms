layui.define(['layer', 'winui', 'dragmove', 'winchat'], function (exports) {
    let $ = layui.$,
        winchat = layui.winchat,
        dragmove = layui.dragmove;
    let initWindows = () => {
        winui.config({
            settings: layui.data('winui').settings || {
                color: 32,
                taskbarMode: 'bottom',
                startSize: 'sm',
                bgSrc: '/admin/component/winui/images/bg/img1.webp',
                lockBgSrc: '/admin/component/winui/images/bg/img2.webp'
            },  //如果本地配置为空则给默认值
            desktop: {
                options: {},    //可以为{}  默认 请求 json/desktopmenu.json
                done: function (desktopApp) {
                    desktopApp.ondblclick(function (id, elem) {
                    //desktopApp.onclick(function (id, elem) {
                        OpenWindow(elem);
                    });
                    try {
                        let selectable = new Selectable({
                            filter: ".winui-desktop-item"
                        });
                        dragmove.moveOne('.winui-desktop-item',selectable);
                        
                        selectable.on('end', (e, selected, unselected) => {
                            //console.log(selected)
                            if (selected.length > 0) {
                                dragmove.moveMore(selected, selectable);
                            }
                        });
                    } catch (error) {
                        console.log(error)
                    }
                    
                    desktopApp.contextmenu({
                        item: ["打开", "删除"],
                        item1: function (id, elem) {
                            OpenWindow(elem);
                        },
                        item2: function (id, elem, events) {
                            //winui.window.msg('删除回调');
                            $(elem).remove();
                            //从新排列桌面app
                            events.reLocaApp();
                        },
                        item3: function (id, elem, events) {
                            winui.window.msg('自定义回调');
                        }
                    });
                }
            },
            menu: {
                done: function (menuItem) {
                    //监听开始菜单点击
                    menuItem.onclick(function (elem) {
                        OpenWindow(elem);
                    });

                }
            }
        }).init({
            audioPlay: true, //是否播放音乐（开机音乐只会播放一次，第二次播放需要关闭当前页面从新打开，刷新无用）
            renderBg: true //是否渲染背景图 （由于js是写在页面底部，所以不太推荐使用这个来渲染，背景图应写在css或者页面头部的时候就开始加载）
        }, function () {
            //初始化完毕回调
            //this.render()
            //winui.startSocket && winui.startSocket();
            winui.hasSocket = false;
            winui.startSocket && winui.startSocket();
            winchat();

        });

        $('.startmenu').on('click', e => {
            //console.log($(e.target).parent())
            let id = $(e.target).parent().attr('data-id');
            //console.log(id)
            $('.winui-menu li').each((i, d) => {
                //console.log(d)
                $(d).hide();
            })
            $('.startareali_' + id).each((i, d) => {
                $(d).show();
            })
        })
        //开始菜单磁贴点击
        $('.winui-tile').on('click', function () {
            OpenWindow(this);
        });

        //开始菜单左侧主题按钮点击
        $('.winui-start-item.winui-start-individuation').on('click', function () {
            winui.window.openTheme();
        });

        //打开窗口的方法（可自己根据需求来写）
        function OpenWindow(menuItem) {
            var $this = $(menuItem);
            //console.log($this)
            var url = $this.attr('win-url');
            var title = $this.attr('win-title');
            var id = $this.attr('win-id');
            var type = parseInt($this.attr('win-opentype'));
            var maxOpen = parseInt($this.attr('win-maxopen')) || -1;
            if (url == 'theme') {
                winui.window.openTheme();
                return;
            }
            //console.log(url, title, id)
            if (!url || !title || !id) {
                //winui.window.msg('菜单配置错误（菜单链接、标题、id缺一不可）');
                return;
            }
            //核心方法（参数请看文档，config是全局配置 open是本次窗口配置 open优先级大于config）
            winui.window.config({
                anim: 0,
                miniAnim: 0,
                maxOpen: -1
            }).open({
                id: id,
                type: type,
                title: title,
                content: url
                //,area: ['70vw','80vh']
                //,offset: ['10vh', '15vw']
                , maxOpen: maxOpen
                //, max: false
                //, min: false
                , refresh: true
            });
        }
    }
    exports('winuiInit', initWindows);
})