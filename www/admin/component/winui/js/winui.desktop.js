/**

 @Name：winui.dektop 桌面模块
 @Author：Leo
 @License：MIT
    
 */
layui.define(['jquery', 'layer', 'winui'], function (exports) {
    "use strict";

    var $ = layui.jquery;

    //桌面构造函数
    var Desktop = function (options) {
        this.options = {};
        this.data = null;
    };

    //渲染HTML
    Desktop.prototype.render = function (callback) {
        if (!this.data) {
            let res = getRoute();
            this.data = res.desktops;
        };
        var html = '';
        //console.log($(this.data))
        $(this.data).each(function (index, item) {
            //console.log(item)
            var id = (item.id == '' || item.id == undefined) ? '' : 'win-id="' + item.id + '" id="winid_' + item.id + '"',
                url = (item.href == '' || item.href == undefined) ? '' : 'win-url="' + item.href + '"',
                title = (item.title == '' || item.title == undefined) ? '' : 'win-title="' + item.title + '"',
                //opentype = (item.openType == '' || item.openType == undefined) ? '' : 'win-opentype="' + item.openType + '"',
                opentype = 'win-opentype="2"',
                //maxOpen = (item.maxOpen == '' || item.maxOpen == undefined) ? '' : 'win-maxOpen="' + item.maxOpen + '"',
                maxOpen = 'win-maxOpen="-1"',
                //icon的算法存在纰漏，但出现错误几率较小
                //isFaIcon = (item.icon.indexOf('fa-') != -1 && item.icon.indexOf('.') == -1),
                //icon = isFaIcon ? '<i class="fa ' + item.icon + ' fa-fw"></i>' : '<img src="' + item.icon + '" />'
                icon = '<i class="layui-icon ' + item.icon + ' fa-fw"></i>';
            html += '<div class="winui-desktop-item" ' + id + ' ' + url + ' ' + title + ' ' + opentype + ' ' + maxOpen + ' draggable="true">';
            //html += '<div class="winui-icon ' + (isFaIcon ? 'winui-icon-font' : 'winui-icon-img') + '">';
            html += '<div class="winui-icon winui-icon-font">';
            html += icon;
            html += '</div>';
            html += '<p>' + item.title + '</p>';
            html += '</div>';
        });
        $('.winui-desktop').html(html);
        //定位应用
        this.locaApp();
        //调用渲染完毕的回调函数
        if (typeof callback === 'function')
            callback.call(this, desktopApp);
    };

    //设置数据
    Desktop.prototype.setData = function (callback) {
        let obj = this,
            res = getRoute();
        // if (!res) {
        //     winui.lockScreen();
        // }
        obj.data = res.desktops;
        callback.call(obj);
    };
    let menuPostionData = localStorage.getItem('_deskTopMenuPostion')
    //公共事件
    //let common = {
    //重置元素事件
    Desktop.prototype.resetEvent = function (selector, eventName, func) {
        if (typeof func != "function") return;
        $(selector).off(eventName).on(eventName, func);
    };
    //定位桌面应用
    Desktop.prototype.locaApp = function () {
        try {
            let posData = JSON.parse(menuPostionData);
            if (!posData) {
                this.initPos(this)
            } else {
                this.setPos(this, posData)
            }
        } catch (error) {
            this.initPos(this)
        }
        
        

    }
    Desktop.prototype.initPos = (that) => {
        //计算一竖排能容纳几个应用
        var appHeight = 96;
        var appWidth = 90;
        var maxCount = parseInt($('.winui-desktop').height() / 93);
        var oldTemp = 0;
        var rowspan = 0;
        var colspan = 0;
        //定位桌面应用
        let res = {};
        $('.winui-desktop>.winui-desktop-item').each(function (index, elem) {
            var newTemp = parseInt(index / maxCount);

            colspan = parseInt(index / maxCount);
            rowspan = oldTemp == newTemp ? rowspan : 0;

            if (rowspan == 0 && oldTemp != newTemp) oldTemp++;
            let topIndex = appHeight * rowspan + 'px',
                leftIndex = appWidth * colspan + 'px';
            $(this).css('top', topIndex).css('left', leftIndex);
            rowspan++;
            res[$(this).attr('id')] = { top: topIndex, left: leftIndex }
        });
        localStorage.setItem('_deskTopMenuPostion', JSON.stringify(res))
    };
    Desktop.prototype.setPos = (that, posData) => {
        
        //console.log(that)
        //console.log(posData)
        //console.log(that.data)
        if (Object.keys(posData).length == that.data.length) {
            for (let p in posData) {
                let el = posData[p];
                $('#' + p).css('top', el.top).css('left', el.left);
            }
        }
        //如果新增了则重置桌面
        else {
            that.initPos(that)
        }
        

    };
    //桌面应用构造函数
    var DesktopApp = function () {
        this.contextmenuOptions = {};
    };
    //桌面应用双击事件
    DesktopApp.prototype.ondblclick = function (callback) {
        if (typeof callback !== "function") return;
        //重置双击事件
        desktop.resetEvent('.winui-desktop-item', 'dblclick', function (event) {
            event.stopPropagation();
            callback.call(this, $(this).attr('win-id'), this);
            //移除选中状态
            $('.winui-desktop>.winui-desktop-item').removeClass('winui-this');
        });
    }
    
    //桌面应用右键菜单定义
    DesktopApp.prototype.contextmenu = function (options) {
        if (!options.item)
            return;
        //let that = DesktopApp.prototype;
        //重置右键事件
        desktop.resetEvent('.winui-desktop>.winui-desktop-item', 'mouseup', function (e) {
            if (!e) e = window.event;
            //console.log(e)
            var currentItem = this;
            if (e.button == 2) {
                var left = e.clientX;
                var top = e.clientY;

                var div = '<ul class="app-contextmenu" style="top:' + top + 'px;left:' + left + 'px;">';
                $(options.item).each(function (index, item) {
                    div += '<li>' + item + '</li>';
                });
                div += '</ul>';

                //移除之前右键菜单
                $('.app-contextmenu').remove();
                //渲染当前右键菜单
                $('body').append(div);
                //绑定单击回调函数
                $('ul.app-contextmenu li').on('click', function () {
                    var index = $(this).index();
                    if (typeof options['item' + (index + 1)] !== 'function')
                        return;
                    //调用回调函数
                    options['item' + (index + 1)].call(this, $(currentItem).attr('win-id'), $(currentItem), { reLocaApp: desktop.locaApp });

                    $('.app-contextmenu').remove();
                    //移除选中状态
                    $('.winui-desktop>.winui-desktop-item').removeClass('winui-this');
                });
                //阻止右键菜单冒泡
                $('.app-contextmenu li').on('click mousedown', call.sp);
            }
            $(currentItem).addClass('winui-this').siblings().removeClass('winui-this');
        });

        this.contextmenuOptions = options;
    }

    //桌面应用单击事件
    DesktopApp.prototype.onclick = function (callback) {
        if (typeof callback !== "function") return;
        //重置双击事件
        desktop.resetEvent('.winui-desktop-item', 'click', function (event) {
            event.stopPropagation();
            callback.call(this, $(this).attr('win-id'), this);
            //移除选中状态
            $('.winui-desktop>.winui-desktop-item').removeClass('winui-this');
        });
    }

    
    //DeskatopApp.prototype.onmousedown
    
    let desktopApp = new DesktopApp();
    

    //基础事件
    var call = {
        //阻止事件冒泡
        sp: function (event) {
            layui.stope(event);
        }
    };

    var desktop = new Desktop();
    //desktop.initPos = common.initPos;
    //配置
    desktop.config = function (options) {
        options = options || {};
        for (var key in options) {
            this.options[key] = options[key];
        }
        return this;
    };

    //初始化
    desktop.init = function (options, callback) {
        if (typeof options === 'object') {
            this.config(options);
        } else if (typeof options == 'fuction') {
            callback = options;
        }
        //缓存回调函数
        this.done = callback = callback || this.done;

        this.setData(function () {
            this.render(callback);
        });
    };

    winui.desktop = desktop;

    exports('desktop', desktop);

    delete layui.desktop;
});