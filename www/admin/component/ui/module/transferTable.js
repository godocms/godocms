layui.define('table', function (exports) {
    var $ = layui.$
        , table = layui.table
        //字符常量
        , MOD_NAME = 'transferTable', ELEM = '.layui-transferTable'

        //外部接口
        , transferTable = {
            index: layui.transferTable ? (layui.transferTable.index + 10000) : 0
            //设置全局项
            , set: function (options) {
                var that = this;
                that.config = $.extend({}, that.config, options);
                return that;
            }
            , get: function (id) {
                if (this.config && this.config[id]) {
                    return this.config[id].data
                } else {
                    return []
                }
            }
            , reload: function (id, options) {
                table.reload(id, options)
            }

        }
        //操作当前实例
        , transfer = function () {
            var that = this
                , options = that.config
                , id = options.id || options.index;
            return {
                reload: function (options) {
                    that.reload.call(that, options);
                }
                , config: options
            }
        }
        //构造器
        , Class = function (options) {
            var that = this;
            that.index = ++transferTable.index;
            that.left_table_id = "left_table_" + that.index;
            that.rigth_table_id = "rigth_table_" + that.index;
            //表格重载ID 如果配置里面没有 自动分配一个ID
            that.reload_left = that.left_table_id;
            that.reload_right = that.rigth_table_id;
            if (options.id && options.id.length) {
                that.reload_left = options.id[0]
                that.reload_right = options.id[1] || options.id[0] + '_2'
            } else {
                //没有配置ID 默认给表格中添加ID 用于重载
                options.id = [that.reload_left, that.reload_right]
            }
            //全局设置
            if (options.id_name) {
                idName = options.id_name;
                if (options.where && options.where[idName]) {
                    var d = [];
                    var tableid = that.reload_right;
                    d[tableid] = {data: options.where[idName]}
                    transferTable.set(d)
                }
            }

            that.config = $.extend({}, that.config, transferTable.config, options);
            that.render();
        };


    Class.prototype.render = function () {
        //ID里面放表格样式
        this.tableHtml()
        // 配置表格参数
        this.loadTable()
        // 移动数据
        this.moveData()
        // 监听双击事件 并移动数据
        this.doubleData()
    }

    Class.prototype.tableHtml = function () {
        var that = this,
            options = that.config,
            left_table = '<table class="layui-hide" id="' + that.left_table_id + '" lay-filter="' + that.left_table_id + '"></table>',
            rigth_table = '<table class="layui-hide" id="' + that.rigth_table_id + '" lay-filter="' + that.rigth_table_id + '"></table>',
            html = '<div style="width:100%;margin:0 auto;overflow: hidden">' +
                '<div style="width:45%;float: left;">' + left_table + '</div>' +
                '<div style="width:10%;float: left;">' +
                '<div class="btns" style="text-align: center;">' +
                '<button  data-tid="' + that.left_table_id + '" class="' + that.left_table_id + ' layui-btn layui-btn-disabled btn left" style="margin-bottom: 15px;"><i class="layui-icon layui-icon-next"></i></button><br>' +
                '<button  data-tid="' + that.rigth_table_id + '" class="' + that.rigth_table_id + ' layui-btn layui-btn-disabled btn rigth"><i class="layui-icon layui-icon-prev"></i></button>' +
                '</div>' +
                '</div>' +
                '<div style="width:45%;float: left;">' + rigth_table + '</div>' +
                '<div>';
        $(options.elem).append(html)
    }
    Class.prototype.loadTable = function () {
        //传递的参数 table.render 表格
        var that = this,
            options = that.config,
            lt = [that.left_table_id, that.rigth_table_id]
        $.each(lt, function (k, id) {
            var config = {elem: '#' + id}
            $.each(options, function (key, val) {

                if (val[k] || val[k] === false) {
                    var value = val[k]
                } else {
                    var value = val[0]
                }
                if (typeof val == 'function') {
                    config[key] = options[key]
                } else if (key !== 'elem' && key !== 'id_name' && key !== 'where') {
                    config[key] = value
                }
            })
            if (options.where) {
                config.where = options.where
            }
            table.render(config);
        })
        //计算表格高度 居中中间按钮
        var th = $('#' + lt[0]).next('div').height() / 2;
        var bh = $('.btns').height() / 2;
        $('.btns').css('margin-top', th - bh)
        //监听表格选中
        table.on('checkbox(' + that.left_table_id + ')', function (obj) {
            //左边表格点击触发
            var checkStatus = table.checkStatus(that.reload_left)
                , data = checkStatus.data;
            if (data.length > 0) {
                $('.' + that.left_table_id).removeClass('layui-btn-disabled')
            } else {
                $('.' + that.left_table_id).addClass('layui-btn-disabled')
            }

        });
        table.on('checkbox(' + that.rigth_table_id + ')', function (obj) {
            //右边表格点击触发
            var checkStatus = table.checkStatus(that.reload_right)
                , data = checkStatus.data;
            if (data.length > 0) {
                $('.' + that.rigth_table_id).removeClass('layui-btn-disabled')
            } else {
                $('.' + that.rigth_table_id).addClass('layui-btn-disabled')
            }
        });

    }
    Class.prototype.moveData = function () {
        //绑定点击事件
        var that = this,
            idName = that.config.id_name;
        $('.' + that.left_table_id).on('click', function () {
            if (!$(this).hasClass('layui-btn-disabled')) {
                var checkStatus = table.checkStatus(that.reload_left)
                    , data = checkStatus.data;
                that.leftReload(that, data)
            }
            $(this).addClass('layui-btn-disabled')
        })
        $('.' + that.rigth_table_id).on('click', function () {
            if (!$(this).hasClass('layui-btn-disabled')) {
                var checkStatus = table.checkStatus(that.reload_right)
                    , data = checkStatus.data;
                that.rigthReload(that, data)
            }
            $(this).addClass('layui-btn-disabled')
        })

    }
    Class.prototype.doubleData = function () {
        var that = this;

        table.on('rowDouble(' + that.left_table_id + ')', function (obj) {
            //左边移动到右边
            var data = [];
            data.push(obj.data)
            that.leftReload(that, data)
        });
        table.on('rowDouble(' + that.rigth_table_id + ')', function (obj) {
            //右边移动到左边
            var data = [];
            data.push(obj.data)
            that.rigthReload(that, data)
        });
    }

    //重载表格
    Class.prototype.leftReload = function (that, data) {

        if (data && data.length > 0) {
            if (that.config.where && that.config.where[idName]) {
                var id_data = that.config.where[idName] + "";
                id_data = id_data.split(',')
            } else {
                var id_data = [];
            }

            $.each(data, function (k, v) {
                id_data.push('' + v[idName])
            })

            //全局存储
            id_data = $.unique(id_data);
            var ids_str = id_data.join(',')
            var d = [];
            var tableid = that.reload_right;
            d[tableid] = {data: ids_str}
            transferTable.set(d)
            //配置存储ID
            if (!that.config.where) {
                that.config.where = {}
            }
            this.config.where[idName] = ids_str
            //重载表格
            var reload_config = {
                page: {curr: 1},
                where: {}
            }
            if (that.config.done) {
                delete reload_config.page;
            }
            reload_config.where[idName] = ids_str
            table.reload(that.reload_left, reload_config)
            table.reload(that.reload_right, reload_config)
        }
    }
    Class.prototype.rigthReload = function (that, data) {
        if (data && data.length) {
            var sel_data = [];
            $.each(data, function (k, v) {
                sel_data.push('' + v[idName])
            })
            var id_data = that.config.where[idName] + "";
            id_data = id_data.split(',');
            var moveD = []; //移除后保留的ID集合
            $.each(id_data, function (k, v) {
                if ($.inArray(v, sel_data) == -1) moveD.push(v)
            })
            id_data = $.unique(moveD);
            var ids_str = id_data.join(',')
            var d = [];
            var tableid = that.reload_right;
            d[tableid] = {data: ids_str}
            transferTable.set(d)
            //配置存储ID
            this.config.where[idName] = ids_str
            //重载表格
            var reload_config = {
                page: {curr: 1},
                where: {}
            }
            if (that.config.done) {
                delete reload_config.page;
            }
            reload_config.where[idName] = ids_str
            table.reload(that.reload_left, reload_config)
            table.reload(that.reload_right, reload_config)
        }
    }

    transferTable.render = function (options) {
        var ins = new Class(options);
        return transfer.call(ins);
    };
    exports('transferTable', transferTable);
});
