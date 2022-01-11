layui.define(["laydate","laytpl","table","layer","tableEdit","form"],function(exports) {
    "use strict";
    var moduleName = 'tableTree'
        ,_layui = layui
        ,laytpl = _layui.laytpl
        ,$ = _layui.$
        ,table = _layui.table
        ,layer = _layui.layer
        ,tableEdit = _layui.tableEdit
        ,editEntity = tableEdit.callbackFn('tableEdit(getEntity)')
        ,form = _layui.form;
    //组件用到的css样式
    var thisCss = [];
    thisCss.push('.layui-tableEdit-checked i{background-color:#60b979!important;}');
    thisCss.push('.layui-tableEdit-edit{position:absolute;right:2px;font-size:18px;bottom:8px;z-index:199109084;}');
    thisCss.push('.layui-tableEdit-edge{position:absolute;left:8px;bottom:0;font-size:15x;z-index:19910908445;}');
    thisCss.push('.layui-tableEdit-tab{position:absolute;left:25px;bottom:0;font-size:15px;z-index:19910908445;}');
    thisCss.push('.layui-tableEdit-span {position:absolute;left:25px;bottom:0;}');
    var thisStyle = document.createElement('style');
    thisStyle.innerHTML = thisCss.join('\n'),document.getElementsByTagName('head')[0].appendChild(thisStyle);

    var configs = {
        callbacks:{}
        ,tableTreeCache:{}
        ,isEmpty:function(data){
            return typeof data === 'undefined' || data === null || data.length <= 0;
        }
        ,parseConfig:function (cols,field) {
            var type,data,enabled,dateType,csField;
            cols.forEach(function (ite) {
                ite.forEach(function (item) {
                    if(field !== item.field || !item.config)return;
                    var config = item.config;
                    type = config.type;
                    data = config.data;
                    enabled = config.enabled;
                    dateType = config.dateType;
                    csField = config.cascadeSelectField;
                });
            });
            return {type:type,data:data,enabled:enabled,dateType:dateType,cascadeSelectField:csField};
        }
    };


    var TableTree = function () {this.config = {}};
    TableTree.prototype = {
        /**
         * 表格树渲染
         * @param options 表格参数
         * @param isFirstRender 是否首次渲染
         */
        render:function (options,isFirstRender) {
            var that = this;
            if(isFirstRender){
                that._done = options.done;
                $.extend(that.config,options);
                var treeConfig = that.config['treeConfig'];
                var done = function(result){
                    if(!result.data) result.data = table.cache[that.config.id] = [];
                    configs.tableTreeCache[$(this.elem).attr('id')] = result.data;
                    var params = {field:treeConfig.showField,element:this.elem};
                    that.initTree(params);
                    if(that._done){
                        that._done.call(this,result);
                    }
                };
                that.config.done = done;
            }else {
                that.config = options;
            }
            that.tableEntity = table.render(that.config);
        }
        /**
         * 初始化表格树及为表格树注册相关事件
         * @param options
         */
        ,initTree:function (options) {
            var data = configs.tableTreeCache[$(options.element).attr('id')];
            this.doInitTree(data,options.field,null,0);
            this.closeAllTreeNodes();
            this.parseColsConfig();
            //先注销事件
            this.off();
            //注册事件
            this.events();
        }
        /**
         * 初始化表格树
         * @param arr 表格数据data
         * @param field 树状单元格字段
         * @param tr 初始化当前tr元素
         * @param lvl 当前行等级
         */
        ,doInitTree:function(arr,field,tr,lvl){
            var that = this;
            var tableBody = $(that.config.elem).next().find('div.layui-table-body');
            _layui.each(arr,function (key,item) {
                if(lvl === 0){
                    tr = tableBody.find('tr[data-index="'+key+'"]');
                    $(tr).attr('tree-id',item[that.config.treeConfig.treeid]);
                    var td = $(tr).find('td[data-field="'+field+'"]');
                    var _div = td.find('div.layui-table-cell');
                    var span = _div.find('span.layui-tableEdit-span');
                    var text = item[that.config.treeConfig.showField];text = configs.isEmpty(text) ? "" : text;
                    !span[0] && (_div.text(''),_div.prepend('<div class="layui-tableTree-div"><span class="layui-tableEdit-span">'+text+'</span></div>'));
                    if(!td.find('i.layui-tableEdit-edge')[0])that.addIcon(tr,td,lvl);
                }else {
                    that.addTreeRow(tr,item);
                }
                if(item.treeList){
                    var nextTr = lvl === 0 ? tr : $(tr).next();
                    that.doInitTree(item.treeList,field,nextTr,lvl+1)
                }
            });
        },
        parseColsConfig:function () {
            var that = this;that.config.colsConfig = {};
            that.config.cols.forEach(function (ite) {
                ite.forEach(function (item) {
                    if(!item.config)return;
                    that.config.colsConfig[item.field] = item.config;
                });
            });
        }
        /**
         *给当前tr新增子节点
         * @param tr 当前节点
         * @param data 子节点数据
         */
        ,addTreeRow:function (tr,data) {
            var that = this,lvl = tr.data('lvl');
            lvl = configs.isEmpty(lvl) ? 0 : parseInt(lvl);
            var treeid = that.config.treeConfig.treeid;
            if(configs.isEmpty(data[treeid])){
                data[treeid] = Number(Math.random().toString().substr(3, 3) + Date.now()).toString(36);
            }
            var newTr = $('<tr data-lvl="'+(lvl+1)+'" tree-id="'+data[treeid]+'"></tr>');
            tr.after(newTr);
            that.addElementToTr(data,tr,newTr,lvl+1);
        }
        /**
         * 根据当前treeid获取相关数据
         * @param arr 表格树数据
         * @param uniqueTreeid 当前treeid值
         * @returns {*}
         */
        ,getDataByTreeId:function (arr,uniqueTreeid) {
            var treeid = this.config.treeConfig.treeid;
            for(var i=0;i<arr.length;i++){
                var item = arr[i];
                if(uniqueTreeid+"" === item[treeid]+""){
                    return item;
                }else {
                    if (item.treeList && item.treeList.length>0) {
                        var data = this.getDataByTreeId(item.treeList, uniqueTreeid);
                        if(data) return  data;
                    }
                }
            }
        }
        /**
         * 给当前行添加图标按钮
         * @param tr 当前tr
         * @param td 树状单元格
         * @param lvl 当前tr等级
         */
        ,addIcon:function(tr,td,lvl) {
            var iconClass = this.config.treeConfig.iconClass;
            iconClass = configs.isEmpty(iconClass) ? 'layui-icon-triangle-r' : iconClass;
            var that = this
                ,icon = $('<i class="layui-icon layui-tableEdit-edge '+iconClass+'"></i>')
                ,div = td.find('div.layui-tableTree-div')
                ,_div = $('<div class="layui-tableTree-edit"></div>')
                ,span = div.children('span.layui-tableEdit-span');
            if(lvl>0){
                var spanLeft = lvl*21 + 25,iconLeft = lvl*21+5;
                span.css('left',spanLeft+'px');
                icon.css('left',iconLeft+'px');
            }
            div.append(icon),$(td).append(_div);
            var add = $('<i class="layui-icon layui-icon-add-1 layui-tableEdit-edit"></i>');_div.append(add);
            var update = $('<i class="layui-icon layui-icon-edit layui-tableEdit-edit"></i>');_div.append(update)
            var remove = $('<i class="layui-icon layui-icon-delete layui-tableEdit-edit"></i>');_div.append(remove);
            var sort = $('<i class="layui-icon layui-icon-return layui-tableEdit-edit asc" style="font-size: 16px"></i>');_div.append(sort);
            _div.hide();sort.css('transform','rotate(90deg)');
            var heightStyle = that.config.size;
            heightStyle = heightStyle ? heightStyle : '';
            if(heightStyle === 'sm'){  //兼容table的size类型
                span.css('bottom','0px');
                icon.css('bottom','0px');
                update.css('bottom','4px');
                add.css('bottom','4px');
                remove.css('bottom','4px');
                sort.css('bottom','4px');
            }
            if(heightStyle === 'lg'){
                span.css('bottom','-1px');
                icon.css('bottom','-1px');
                update.css('bottom','15px');
                add.css('bottom','15px');
                remove.css('bottom','15px');
                sort.css('bottom','15px');
            }
            sort.css('right','3px'),remove.css('right','24px'),update.css('right','48px'),add.css('right','72px');
        }
        /**
         * 事件注册
         */
        ,events:function () {
            var that = this,filter = $(that.config.elem).attr('lay-filter')
                ,tableBody = $(this.config.elem).next().find('div.layui-table-body')
                ,tableTreeid = $(that.config.elem).attr('id')
                ,iconClass = this.config.treeConfig.iconClass
                ,showField = that.config.treeConfig.showField;

            //编辑图标事件注册
            tableBody.on('click','i.layui-tableEdit-edit',function (e) {
                //_layui.stope(e);
                var isAdd = $(this).hasClass('layui-icon-add-1')
                    ,isUpdate = $(this).hasClass('layui-icon-edit')
                    ,treeData = configs.tableTreeCache[tableTreeid]
                    ,isDelete = $(this).hasClass('layui-icon-delete')
                    ,isSort = $(this).hasClass('layui-icon-return');
                var tr = $(this).parents('tr');
                var td = $(this).parents('td'),field = td.data('field');
                var treeid = tr.attr('tree-id');
                var data = that.getDataByTreeId(treeData,treeid);
                var lvl = tr.data('lvl');
                lvl = lvl ? lvl : 0;
                if(isAdd){//新增
                    //回调tool(lay-filter)对应的方法 异步/同步获取数据后回调add方法进行新增行
                    var thisObj = {value:null,data:data,field:field,add:function (newTree) {
                            !newTree && (newTree = []);
                            newTree = that.removeRepeatData(newTree);//treeid去重
                            if(newTree.length <=0){
                                var thisData = {};
                                that.config.cols.forEach(function (item1) {
                                    item1.forEach(function (item) {
                                        if(item.field){
                                            if(!(item.field in data)){
                                                thisData[item.field] = null;
                                            }
                                        }
                                    });
                                });
                                newTree.push(thisData);
                            }
                            that.asyncAddTree(newTree,data,tr,lvl);
                            var treeList = data.treeList;
                            if(!treeList) treeList = data.treeList = [];
                            var count= 0;
                            while (count<newTree.length){
                                treeList.push(newTree[count]);count++;
                            }
                            that.openTreeNode(tr)
                        },event:'add'};
                    active.callbackFn.call(td[0],'tool('+filter+')',thisObj);
                }

                //修改
                if(isUpdate){
                    var oldValue = that.parseTempletData(data,field);
                    oldValue = oldValue ? oldValue : '';
                    editEntity.input({element:td[0],oldValue:oldValue,callback:function (res) {
                            var thisObj = {value:res,data:data,field:field,update:function (fields) {
                                    if(!fields)return;
                                    for(var key in fields){
                                        data[key] = fields[key];
                                        var showValue = that.parseTempletData(data,key);
                                        showValue = showValue ? showValue : '';
                                        td.find('div.layui-table-cell span.layui-tableEdit-span').text(showValue)
                                    }
                                },event:'edit'};
                            active.callbackFn.call(td[0],'tool('+filter+')',thisObj);
                        }});
                }

                //删除
                if(isDelete){
                    layer.confirm('<div style="color: red;text-align: center;">确定删除吗？</div>', function(index){
                        var thisObj = {value:null,data:data,field:field,event:'del',del:function () {
                                var lvl = tr.data('lvl');lvl = lvl ? lvl : 0;
                                //删除页面隐藏的树
                                that.removeChildren(tr,lvl);
                                //清楚缓存中的数据
                                that.clearCacheData(data);
                                tr.remove();
                            }};
                        active.callbackFn.call(td[0],'tool('+filter+')',thisObj);
                        layer.close(index);
                    });
                }

                //排序 => 根据tree-id进行排序
                if(isSort){
                    var icon = $(this);
                    var isAsc = icon.hasClass('asc');
                    isAsc ? (icon.removeClass('asc'),icon.css('transform','rotate(-90deg)'),icon.addClass('desc'))
                        : (icon.removeClass('desc'),icon.css('transform','rotate(90deg)'),icon.addClass('asc'));
                    that.exeTreeNodesSort(tr,that.config.treeConfig.treeid,isAsc);
                }
            });


            table.on('checkbox('+filter+')', function(obj){
                var thisInput = this
                    ,treeData = configs.tableTreeCache[tableTreeid];
                var tr = $(thisInput).parents('tr'),lvl = tr.data('lvl');
                lvl = lvl ? lvl : 0;
                obj.type === 'one' && function(){
                    that.setChildNodeChecked(tr,lvl,obj.checked);
                    that.setSupperNodeChecked(tr,obj.checked);
                }();
                var _treeid = tr.attr("tree-id");
                //注意
                //layui组件获取的obj.data可能不正确
                //所以在此直接以此方式获取 保证取到相对应节点数据
                obj.data = that.getDataByTreeId(treeData,_treeid);
                active.callbackFn.call(this,'checkbox('+filter+')',obj);
            });

            //showField字段单元格点击事件，展开子叶节点
            var SPAN_SELECTOR = 'div.layui-tableTree-div span.layui-tableEdit-span';
            tableBody.on('click',SPAN_SELECTOR,function (e) {
                _layui.stope(e);
                var thisTreeElem = $(this).parents('tr');
                var lvl = thisTreeElem.data('lvl');lvl = lvl ? lvl : 0;
                var icon = $(this).parents('td').find('i.layui-tableEdit-edge');
                var isShow = icon.hasClass('layui-tableEdit-clicked');
                //关闭或者展开子元素
                that.showOrHideChildrenNodes(thisTreeElem,lvl,!isShow);
                //选择三角图标
                that.rotateFunc(icon,!isShow);
            });

            //展示工具栏
            if(this.config.treeConfig.showToolbar){
                //操作栏鼠标经过事件
                tableBody.on("mouseenter ",'td[data-field="'+showField+'"]',function (e) {
                    _layui.stope(e)
                    tableBody.find('div.layui-tableTree-edit').hide();
                    $(this).find('div.layui-tableTree-edit').show();
                });
                tableBody.on("mouseleave",'td[data-field="'+showField+'"]',function (e) {
                    _layui.stope(e)
                    tableBody.find('div.layui-tableTree-edit').hide();
                });
            }

            var INPUT_SELECTOR = 'td[data-field="'+showField+'"] input.layui-tableEdit-input';
            tableBody.on('blur',INPUT_SELECTOR,function () {
                $(this).remove();
            });

            var toolEvent = 'tool('+filter+')';
            table.on(toolEvent,function (obj) {
                var zthis = this
                    ,field = $(zthis).data('field')
                    ,config = that.config.colsConfig[field]
                    ,treeData = configs.tableTreeCache[tableTreeid];
                obj.field = field;
                if(!config){
                    active.callbackFn.call(zthis,toolEvent,obj);return;
                }
                var callbackFn = function (res) {
                    obj.value = Array.isArray(res) ? (res.length>0 ? res : [{name:'',value:''}]) : res;
                    active.callbackFn.call(zthis,toolEvent,obj);
                };
                var _treeid = $(zthis.parentNode).attr("tree-id");
                //子节点或表格树删除最上级节点后，layui组件得到的数据就不对了。
                //因此直接用getDataByTreeId函数获取
                obj.data = that.getDataByTreeId(treeData,_treeid);
                obj.update = function (fields) {
                    if(!fields)return;
                    for(var key in fields){
                        obj.data[key] = fields[key];
                        var showValue = that.parseTempletData(obj.data,key);
                        showValue = showValue ? showValue : '';
                        $(zthis).find('div.layui-table-cell').text(showValue)
                    }
                };
                if(config.type === 'select'){
                    editEntity.register({data:config.data,element:zthis,enabled:config.enabled,selectedData:obj.data[field],callback:callbackFn});
                }else if(config.type === 'date'){
                    editEntity.date({dateType:config.dateType,element:zthis,callback:callbackFn});
                }else if(config.type === 'input'){
                    editEntity.input({element:zthis,oldValue:obj.data[field],callback:callbackFn});
                }else if(config.type === 'signedInput'){
                    editEntity.signedInput({element:zthis,oldValue:obj.data[field],callback:callbackFn});
                }else active.callbackFn.call(zthis,toolEvent,obj);
            });

            var SELECTOR='div.layui-tableTree-div i.'+iconClass;
            tableBody.on('click',SELECTOR,function (e) {
                _layui.stope(e);
                var tr = $(this).parents('tr')
                    ,treeData = configs.tableTreeCache[tableTreeid];
                var lvl = tr.data('lvl');lvl = lvl ? lvl : 0;
                var td = $(this).parents('td')
                    ,field = td.data('field')
                    ,treeid = tr.attr('tree-id')
                    ,data = that.getDataByTreeId(treeData,treeid)
                    ,thisObj = {value:null,data:data,field:field,async:function (asyncTree) {
                        that.openTreeNode(tr);
                        if(!asyncTree || asyncTree.length === 0)return;
                        asyncTree = that.removeRepeatData(asyncTree);
                        if(asyncTree.length === 0)return;
                        that.asyncAddTree(asyncTree,data,tr,lvl);
                        if(!data.treeList)data.treeList = [];
                        var count= 0;
                        while (count<asyncTree.length){
                            data.treeList.push(asyncTree[count]);count++;
                        }
                        //图标改回来
                        that.openTreeNode(tr);
                    },event:'async'};
                active.callbackFn.call(td[0],'tool('+filter+')',thisObj);
            });
        },off:function () {
            var tableBody = $(this.config.elem).next().find('div.layui-table-body');
            tableBody.off('click','i.layui-tableEdit-edit');
            var SPAN_SELECTOR = 'div.layui-tableTree-div span.layui-tableEdit-span';
            tableBody.off('click',SPAN_SELECTOR);
            var showField = this.config.treeConfig.showField;
            tableBody.off("mouseleave",'td[data-field="'+showField+'"]');
            var INPUT_SELECTOR = 'td[data-field="'+showField+'"] input.layui-tableEdit-input';
            tableBody.off('blur',INPUT_SELECTOR);
            var iconClass = this.config.treeConfig.iconClass;
            var SELECTOR='div.layui-tableTree-div i.'+iconClass;
            tableBody.off('click',SELECTOR);
        }
        /**
         * 过滤treeid重复的节点数据
         * @param data 被过滤的数据
         * @returns {Array}
         */
        ,removeRepeatData:function (data) {
            var noRepeatData = [],that = this;
            data.forEach(function (e) {
                if(that.checkedRepeatData(e))return;//treeid重复则直接过滤
                noRepeatData.push(e);
            });
            return noRepeatData;
        }
        /**
         * 根据obj数据给当前节点新增子叶节点
         * @param obj Array类型 子叶节点数据
         * @param data 当前节点数据
         * @param tr 当前节点tr
         * @param lvl 当前节点等级
         */
        ,asyncAddTree:function (obj,data,tr,lvl) {
            var that = this;
            var _treeid_ = that.config.treeConfig.treeid;
            var treepid = that.config.treeConfig.treepid;
            !obj && (obj = []);
            obj.forEach(function (e) {
                e[treepid] = data[_treeid_];
                that.addTreeRow(tr,e);
                if(e.treeList && e.treeList.length>0){
                    that.asyncAddTree(e.treeList,e,tr.next(),lvl+1);
                }
            });
            var nextIcon = tr.find('td[data-field="'+that.config.treeConfig.showField+'"] i.layui-tableEdit-edge');
            that.rotateFunc(nextIcon,true);
        }
        /**
         * 按table表格列模板(templet)解析数据
         * @param d 当前节点数据
         * @param field 列字段
         * @returns {*}
         */
        ,parseTempletData:function (d,field) {
            var rs = null;
            this.config.cols.forEach(function (item1) {
                item1.forEach(function (item2) {
                    if(item2.field === field){
                        var templet = item2.templet;
                        if(templet){
                            if(typeof templet === 'string'){
                                rs = laytpl($(templet).html()).render(d);
                            }else {
                                rs = templet(d,field);
                            }
                        }else {
                            rs = d[field];
                        }
                    }
                });
            });
            return rs;
        }
        /**
         * 清除当前数据
         * @param data 当前数据
         */
        ,clearCacheData:function (data) {
            if(!data)return
            var treeid = this.config.treeConfig.treeid;
            var tableTreeid = $(this.config.elem).attr('id');
            var treeData = configs.tableTreeCache[tableTreeid];
            this.clearChildCacheData(treeData,data[treeid]);
        }
        /**
         * 清除当前数据的子叶节点数据
         * @param list 表格树数据
         * @param uniqueTreeid 当前节点treeid字段值
         */
        ,clearChildCacheData:function (list,uniqueTreeid) {
            var treeid = this.config.treeConfig.treeid;
            for(var i=0;i<list.length;i++){
                var item = list[i];
                if((uniqueTreeid+"") === (item[treeid]+"")) {
                    list.splice(i,1);break;
                }else{
                    if(item.treeList && item.treeList.length > 0){
                        this.clearChildCacheData(item.treeList,uniqueTreeid)
                    }
                }
            }
        }
        /**
         * 旋转三角图标
         * @param icon 当前三角图标
         * @param isOpen true为关闭 false打开
         */
        ,rotateFunc:function (icon,isOpen) {
            if(!isOpen){
                icon.css('transform','');
                icon.removeClass('layui-tableEdit-clicked');
            }else {
                icon.css('transform','rotate(90deg)');
                icon.addClass('layui-tableEdit-clicked');
            }
        }
        /**
         * 展开或者关闭当前节点及其叶子节点
         * @param elemTree 当前节点tr
         * @param lvl 当前节点等级
         * @param isShow true打开 false关闭
         */
        ,showOrHideChildrenNodes:function (elemTree,lvl,isShow) {
            var nextTreeElem = elemTree.next(),nextlvl = nextTreeElem.data('lvl');
            nextlvl = nextlvl ? nextlvl : 0;
            if(nextTreeElem[0] && nextlvl > lvl){
                if(isShow){
                    if((nextlvl-lvl) === 1){
                        nextTreeElem.show();
                        var nextIcon = nextTreeElem.find('td[data-field="'+this.config.treeConfig.showField+'"] i.layui-tableEdit-edge');
                        if(nextIcon.hasClass('layui-tableEdit-clicked')){
                            nextTreeElem.show();
                            this.showTreeNodes(nextTreeElem,nextlvl);
                        }
                    }
                }else {
                    nextTreeElem.hide();
                }
                this.showOrHideChildrenNodes(nextTreeElem,lvl,isShow);
            }
        }
        /**
         * 展开当前节点及其叶子节点
         * @param elemTree 当前节点tr
         * @param lvl 当前节点等级
         */
        ,showTreeNodes:function (elemTree,lvl) {
            var nextTreeElem = elemTree.next(),nextlvl = nextTreeElem.data('lvl');
            nextlvl = nextlvl ? nextlvl : 0;
            if(nextTreeElem[0] && nextlvl > lvl){
                if((nextlvl-lvl) === 1){
                    nextTreeElem.show();
                    var nextIcon = nextTreeElem.find('td[data-field="'+this.config.treeConfig.showField+'"] i.layui-tableEdit-edge');
                    if(nextIcon.hasClass('layui-tableEdit-clicked')){
                        nextTreeElem.show();
                        this.showTreeNodes(nextTreeElem,nextlvl);
                    }
                }
                this.showTreeNodes(nextTreeElem,lvl);
            }
        }
        /**
         * 获取当前节点的父节点
         * @param elem 当前节点tr
         * @param lvl 当前节点等级
         * @returns {null|*|jQuery|*}
         */
        ,getParentNode:function (elem,lvl) {
            if(lvl===0)return null;
            var tr = $(elem)
                ,prevElem = tr.prev()
                ,prevLvl = prevElem.data('lvl');
            prevLvl = prevLvl ? prevLvl : 0;
            if(lvl-prevLvl === 1) return prevElem;
            return this.getParentNode(prevElem,lvl);
        }
        /**
         * 删除当前节点的叶子节点
         * @param elemTree 当前节点tr
         * @param lvl 当前节点等级
         */
        ,removeChildren:function (elemTree,lvl) {
            var nextTreeElem = elemTree.next(),nextlvl = nextTreeElem.data('lvl');
            nextlvl = nextlvl ? nextlvl : 0;
            if(nextTreeElem[0] && nextlvl > lvl){
                nextTreeElem.remove();
                this.removeChildren(elemTree,lvl);
            }
        }
        /**
         * 判断当前节点数据的treeid是否重复
         * @param data 当前节点数据
         * @returns {boolean}
         */
        ,checkedRepeatData:function (data) {
            var treeid = this.config.treeConfig.treeid;
            var tableTreeid = $(this.config.elem).attr('id');
            var treeData = configs.tableTreeCache[tableTreeid];
            var ckeckData = this.getDataByTreeId(treeData,data[treeid]);
            return ckeckData ? true : false;
        }
        /**
         * 	获取选中节点数据
         * @returns {*}
         */
        ,getCheckedTreeNodeData:function () {
            var that = this;
            var tableBody = $(this.config.elem).next().find('div.layui-table-body');
            var tableTreeid = $(that.config.elem).attr('id');
            var treeData = configs.tableTreeCache[tableTreeid];
            var checkedElem = tableBody.find('td.layui-table-col-special div.layui-form-checked');
            var dataSet = new Set();
            checkedElem.each(function () {
                var tr = $(this).parents('tr').eq(0);
                var treeid = tr.attr('tree-id');
                var data = that.getDataByTreeId(treeData,treeid);
                dataSet.add(data);
            });
            return Array.from(dataSet);
        }
        /**
         * 获取当前节点的最顶级节点
         * @param elem 当前节点
         * @returns {*}
         */
        ,getTopNode:function (elem) {
            var lvl = elem.data('lvl')
                ,prevTr = elem.prev();
            lvl = lvl ? lvl : 0;
            if(lvl === 0) return elem;
            return this.getTopNode(prevTr);
        }
        /**
         * 重载表格树
         * @param options
         */
        ,reload:function (options) {
            if(options && options.done){
                this._done = options.done;
            }
            this.render(this.config);
        }
        /**
         * 指定节点或节点id展开节点
         * @param params 节点或节点id
         */
        ,openTreeNode:function (params) {
            var that = this;
            var treeid,tr;
            if(typeof params === 'string' || Object.prototype.toString.call(params) === '[object Number]'){
                treeid = params;
                tr = $(that.config.elem).next().find('div.layui-table-body tr[tree-id="'+treeid+'"]');
            }else {
                tr = $(params);
            }
            tr.show();
            var icon = tr.find('td[data-field="'+that.config.treeConfig.showField+'"] i.layui-tableEdit-edge');
            var lvl = tr.data('lvl');
            lvl = lvl ? lvl : 0;
            that.showOrHideChildrenNodes(tr,lvl,true);
            that.rotateFunc(icon,true);
            var parentNode = that.getParentNode(tr,lvl);
            while(parentNode && parentNode[0]){
                parentNode.show();
                icon = parentNode.find('td[data-field="'+that.config.treeConfig.showField+'"] i.layui-tableEdit-edge');
                lvl = parentNode.data('lvl');
                lvl = lvl ? lvl : 0;
                that.rotateFunc(icon,true);
                parentNode = that.getParentNode(parentNode,lvl);
            }
            var topNode = that.getTopNode(tr);
            that.showOrHideChildrenNodes(topNode,0,true);
        }
        /**
         * 指定节点或节点id折叠节点
         * @param params 节点或节点id
         */
        ,closeTreeNode:function (params) {
            var that = this;
            var treeid,tr;
            if(typeof params === 'string' || Object.prototype.toString.call(params) === '[object Number]'){
                treeid = params;
                tr = $(that.config.elem).next().find('div.layui-table-body tr[tree-id="'+treeid+'"]');
            }else {
                tr = $(params);
            }
            var icon = tr.find('td[data-field="'+that.config.treeConfig.showField+'"] i.layui-tableEdit-edge');
            var lvl = tr.data('lvl');
            lvl = lvl ? lvl : 0;
            that.showOrHideChildrenNodes(tr,lvl,false);
            that.rotateFunc(icon,false);
        }
        /**
         * 展开所有节点
         */
        ,openAllTreeNodes:function () {
            var that = this;
            var tableBody = $(this.config.elem).next().find('div.layui-table-body');
            tableBody.find('tr').each(function (e) {
                var tr = $(this);
                var icon = tr.find('td[data-field="'+that.config.treeConfig.showField+'"] i.layui-tableEdit-edge');
                $(this).show();
                that.rotateFunc(icon,true);
            });
        }
        /**
         * 折叠所有节点
         */
        ,closeAllTreeNodes:function () {
            var that = this;
            var tableBody = $(this.config.elem).next().find('div.layui-table-body');
            tableBody.find('tr').each(function (e) {
                var tr = $(this);
                var icon = tr.find('td[data-field="'+that.config.treeConfig.showField+'"] i.layui-tableEdit-edge');
                var lvl = tr.data('lvl');
                lvl = lvl ? lvl : 0;
                if(lvl > 0)$(this).hide();
                that.rotateFunc(icon,false);
            });
        }
        /**
         * 表格树节点逐级排序
         * @param options {field:'xxx',desc:true} field：排序字段 desc => true降序、false升序
         * @param treeData 表格树数据
         */
        ,sort:function (options,treeData) {
            var that = this;
            treeData.sort(function(o1, o2){
                var isNum = /(^[-+]?\d+$)|(^[-+]?\d+\.\d+$)/
                    ,v1 = o1[options.field]
                    ,v2 = o2[options.field];
                if(isNum.test(v1) && isNum.test(v2)){
                    v1 = parseFloat(v1);
                    v2 = parseFloat(v2);
                    if(v1 > v2){
                        return 1;
                    } else if (v1 < v2) {
                        return -1;
                    } else {
                        return 0;
                    }
                }else {
                    if(v1 && !v2){
                        return 1;
                    } else if(!v1 && v2){
                        return -1;
                    }
                    (v1+'').localeCompare(v2+'','zh-CN')
                }
            });
            if(options.desc){
                treeData.reverse();
            }
            treeData.forEach(function (e) {
                if(e.treeList && e.treeList.length>0){
                    that.sort(options,e.treeList);
                }
            });
        }
        /**
         * 获取表格树参数配置
         * @returns {*}
         */
        ,getTableTreeData:function () {
            var tableTreeid = $(this.config.elem).attr('id');
            var treeData = configs.tableTreeCache[tableTreeid];
            return treeData;
        }
        /**
         * 增加最上级节点 => 单个节点
         * @param data object类型
         */
        ,addTopTreeNode:function (data) {
            var that = this;
            var treeid = that.config.treeConfig.treeid;
            var treepid = that.config.treeConfig.treepid;
            var tableTreeid = $(that.config.elem).attr('id')
                ,treeData = configs.tableTreeCache[tableTreeid];
            if(treeData.length<=0){
                if(!data){
                    data = {};
                }
                that.config.cols.forEach(function (item1) {
                    item1.forEach(function (item) {
                        if(item.field){
                            if(!(item.field in data)){
                                data[item.field] = null;
                            }
                        }
                    });
                });
                delete data[treepid]; //最上级行不能有treepid
                var url = that.config.url;
                var hasUrl = !configs.isEmpty(url);
                hasUrl && delete that.config.url;
                if(!data[treeid]){
                    data[treeid] = Number(Math.random().toString().substr(3, 3) + Date.now()).toString(36)
                }
                treeData.push(data);
                that.config.data = treeData;
                that.render(that.config);
                if(hasUrl){
                    delete that.config.data;
                    that.config.url = url;
                }
                return;
            }

            if(!data || (data && typeof  data !== 'object')){
                data = {};
                for(var key in  treeData[0]){
                    data[key] = null;
                }
            }
            delete data[treepid]; //最上级行不能有treepid
            var tr = $(that.config.elem).next().find('div.layui-table-body tr').eq(0);
            if(configs.isEmpty(data[treeid]) || that.checkedRepeatData(data)){
                data[treeid] = Number(Math.random().toString().substr(3, 3) + Date.now()).toString(36)
            }
            var newTr = $('<tr data-index="'+treeData.length+'" tree-id="'+data[treeid]+'"></tr>');
            tr.before(newTr);
            data['LAY_TABLE_INDEX'] = treeData.length;
            treeData.push(data);
            that.addElementToTr(data,tr,newTr,0);
            that.rotateFunc( newTr.find('td[data-field="'+that.config.treeConfig.showField+'"] i.layui-tableEdit-edge'),true);
        }
        /**
         * 新增行tr
         * @param data 当前行数据
         * @param tr newTr的前一行的tr
         * @param newTr 新增行tr
         * @param lvl 新增行等级
         */
        ,addElementToTr:function (data,tr,newTr,lvl) {
            var that = this;
            tr.children('td').each(function () {
                var field = $(this).data('field'),td = null;
                if(field+"" === '0'){
                    td = $('<td data-field="0" data-key="1-0-0" class="layui-table-col-special"></td>');
                    td.append(this.innerHTML);
                }else {
                    var attrsStr = []
                        ,_divclass = $(this).children('div.layui-table-cell').attr("class")
                        ,attrs = this.attributes;
                    for(var i=0;i<attrs.length;i++){
                        attrsStr.push(attrs[i].nodeName+'="'+attrs[i].nodeValue+'"');
                    }
                    var text = that.parseTempletData(data,field); //按模板进行解析
                    text = text ? text : '';
                    if(field === that.config.treeConfig.showField ){
                        td = $('<td '+attrsStr.join(" ")+'><div class="'+_divclass+'"><div class="layui-tableTree-div"><span class="layui-tableEdit-span">'+text+'</span></div></div></td>');
                        that.addIcon(newTr,td,lvl);
                    }else {
                        newTr.append('<td '+attrsStr.join(" ")+'><div class="'+_divclass+'">'+text+'</div></td>');
                    }
                }
                newTr.append(td);
            });
            form.render('checkbox');
        }
        /**
         * 指定节点或节点id删除节点及其叶子节点
         * @param params
         */
        ,delTreeNode:function (params) {
            if(!params)return;
            var that = this;
            var tableTreeid = $(that.config.elem).attr('id');
            var treeData = configs.tableTreeCache[tableTreeid];
            var treeid,tr;
            if(typeof params === 'string' || Object.prototype.toString.call(params) === '[object Number]'){
                treeid = params;
                tr = $(that.config.elem).next().find('div.layui-table-body tr[tree-id="'+treeid+'"]');
            }else {
                tr = $(params);
                treeid = tr.attr("tree-id");
            }
            var data = that.getDataByTreeId(treeData,treeid);
            var lvl = tr.data('lvl');lvl = lvl ? lvl : 0;
            //删除页面隐藏的树
            that.removeChildren(tr,lvl);
            //清楚缓存中的数据
            that.clearCacheData(data);
            tr.remove();
        }
        /**
         * 判断当前节点的叶子节点是否有被选中的
         * @param elem 当前节点tr
         * @param lvl 当前节点等级
         * @returns {boolean|*}
         */
        ,childNodeHasChecked:function (elem,lvl) {
            var nextTreeElem = elem.next(),nextlvl = nextTreeElem.data('lvl');
            nextlvl = nextlvl ? nextlvl : 0;
            if(nextTreeElem[0] && nextlvl > lvl){
                var div = $(nextTreeElem).find('td.layui-table-col-special div.layui-form-checkbox');
                return div.hasClass('layui-form-checked') ? true : this.childNodeHasChecked(nextTreeElem,lvl);
            }else {
                return false;
            }
        }
        /**
         * 设置当前节点及其叶子节点为被选中状态
         * @param elem 当前节点
         * @param lvl 当前节点等级
         * @param isChecked true为选中 false为取消选中
         */
        ,setChildNodeChecked:function (elem,lvl,isChecked) {
            var nextTreeElem = elem.next(),nextlvl = nextTreeElem.data('lvl');
            nextlvl = nextlvl ? nextlvl : 0;
            if(nextTreeElem[0] && nextlvl > lvl){
                this.setCheckboxInfo(nextTreeElem,isChecked);
                this.setChildNodeChecked(nextTreeElem,lvl,isChecked);
            }
        }
        /**
         * 设置当前节点的祖辈节点为被选中状态
         * @param elem 当前节点
         * @param isChecked true为选中 false为取消选中
         */
        ,setSupperNodeChecked:function (elem,isChecked) {
            var that = this;
            var thisTreeid = $(elem).attr("tree-id")
                ,treepid = that.config.treeConfig.treepid
                ,tableTreeid = $(that.config.elem).attr('id')
                ,treeData = configs.tableTreeCache[tableTreeid]
                ,data = that.getDataByTreeId(treeData,thisTreeid)
                ,thisTreepid = data[treepid]
                ,tableBody = $(that.config.elem).next().find('div.layui-table-body')
                ,ptr = tableBody.find('tr[tree-id="'+thisTreepid+'"]');
            var lvl = ptr.data('lvl');
            lvl = lvl ? lvl : 0;
            if(!isChecked){
                if(!that.childNodeHasChecked(ptr,lvl)){
                    that.setCheckboxInfo(ptr,isChecked);
                }
            }else {
                that.setCheckboxInfo(ptr,isChecked);
            }
            if(lvl === 0)return;
            that.setSupperNodeChecked(ptr,isChecked);
        }
        /**
         * 设置当前节点的选中状态
         * @param elem 当前节点
         * @param isChecked true为选中 false为取消选中
         */
        ,setCheckboxInfo:function (elem,isChecked) {
            var div = elem.find('td.layui-table-col-special div.layui-form-checkbox')
                ,input = elem.find('td.layui-table-col-special input[type="checkbox"]');
            isChecked ? (div.addClass('layui-form-checked'),input.prop('checked',true))
                : (div.removeClass('layui-form-checked'),input.prop('checked',false));
        }
        /**
         * 关键词检索相关节点
         * @param value 关键词参数
         */
        ,keywordSearch:function (value) {
            var that = this;
            var tableBody = $(this.config.elem).next().find('div.layui-table-body');
            var spans = tableBody.find('td[data-field="'+this.config.treeConfig.showField+'"] span.layui-tableEdit-span');
            var tableTreeid = $(that.config.elem).attr('id');
            var treeData = configs.tableTreeCache[tableTreeid];
            var treepid = that.config.treeConfig.treepid;
            that.clearSearch();//每次搜索前都清除标记 然后再进行标记
            tableBody.find("tr").each(function () {
                var tr = $(this);
                if(!tr.is(":hidden")){
                    tr.addClass("layui-tableTree-search");
                }
            });
            var showArr = new Set();
            spans.each(function () {
                var thisValue = this.innerText;
                var tr = $(this).parents('tr').eq(0);
                if(thisValue.indexOf(value)>-1){
                    tr.show();
                    var icon = tr.find('td[data-field="'+that.config.treeConfig.showField+'"] i.layui-tableEdit-edge')
                    tr.hasClass('layui-tableTree-search')
                    && !icon.hasClass('layui-tableEdit-clicked')
                    && (that.rotateFunc(icon,true),icon.addClass('layui-tableTree-search'));
                    var treeid = tr.attr('tree-id');
                    showArr.add(treeid)
                    var data = that.getDataByTreeId(treeData,treeid);
                    var _treepid = data[treepid];
                    var parentNode = tableBody.find('tr[tree-id="'+_treepid+'"]');
                    while (parentNode[0]) {
                        parentNode.show();
                        treeid = parentNode.attr('tree-id');
                        data = that.getDataByTreeId(treeData,treeid);
                        if(data){
                            showArr.add(treeid);
                            icon = parentNode.find('td[data-field="'+that.config.treeConfig.showField+'"] i.layui-tableEdit-edge')
                            parentNode.hasClass('layui-tableTree-search')
                            && !icon.hasClass('layui-tableEdit-clicked')
                            && (that.rotateFunc(icon,true),icon.addClass('layui-tableTree-search'));
                        }
                        _treepid = data[treepid];
                        parentNode = tableBody.find('tr[tree-id="'+_treepid+'"]');
                    }
                }else {
                    var treeid = tr.attr('tree-id');
                    !showArr.has(treeid) && tr.hide();
                }
            });
        }
        /**
         * 重置表格树到检索前折叠状态
         */
        ,clearSearch:function () {
            var that = this;
            var tableBody = $(this.config.elem).next().find('div.layui-table-body');
            var searchTrs = tableBody.find("tr.layui-tableTree-search");
            if(searchTrs.length<=0) return;
            tableBody.find("tr").each(function () {
                var tr = $(this);
                if(tr.hasClass("layui-tableTree-search")){
                    tr.show();
                    var icon = tr.find('td[data-field="'+that.config.treeConfig.showField+'"] i.layui-tableEdit-edge.layui-tableTree-search');
                    if(icon[0]){
                        that.rotateFunc(icon,false);
                        icon.removeClass('layui-tableTree-search');
                        icon.removeClass('layui-tableEdit-clicked');
                    }
                }else {
                    tr.hide();
                }
                tr.removeClass("layui-tableTree-search");
            });
        }
        /**
         * 刷新当前表格树 => 局部刷新
         * @param data 表格树数据
         * @param tr 当前节点tr
         * @param lvl 当前节点等级
         * @param isFirst 当前节点是否为表格树的第一个节点
         */
        ,refreshTableBody:function (data,tr,lvl,isFirst) {
            var that = this;
            var treeid = that.config.treeConfig.treeid;
            var tbody = $(that.config.elem).next().find('div.layui-table-body tbody');
            _layui.each(data,function (index,item) {
                var newTr;
                if(!isFirst)tr = tbody.children(':last-child');
                newTr = lvl<=0 ? $('<tr data-index="'+index+'" tree-id="'+item[treeid]+'"></tr>')
                    : $('<tr data-lvl="'+lvl+'" tree-id="'+item[treeid]+'"></tr>');
                !isFirst ? tr.after(newTr) : (tbody.html(''),tbody.append(newTr));
                isFirst = false;
                that.addElementToTr(item,tr,newTr,lvl);
                if(item.treeList){
                    that.refreshTableBody(item.treeList,newTr,lvl+1,false);
                }
            });
        }
        /**
         * 刷新当前表格树 => 局部刷新
         * @param data 表格树数据
         */
        ,refresh:function (data) {
            var tableTreeid = $(this.config.elem).attr('id');
            var treeid= this.config.treeConfig.treeid;
            var treeData = configs.tableTreeCache[tableTreeid];
            if(data){
                treeData.splice(0,treeData.length);
                data.forEach(function (e) {
                    if(!e[treeid]){
                        e[treeid]  = Number(Math.random().toString().substr(3, 3) + Date.now()).toString(36)
                    }
                    treeData.push(e);
                })
            }
            this.sort({field:this.config.treeConfig.treeid},treeData);
            if(treeData.length<-0) return;
            _layui.each(treeData,function (index,item) {
                item['LAY_TABLE_INDEX'] = index;
            });
            var tr = $(this.config.elem).next().find('div.layui-table-body tr').eq(0);
            this.refreshTableBody(treeData,tr,0,true);
            this.openAllTreeNodes();
            form.render('checkbox');
        }
        /**
         * 根据当前节点id获取叶子节点数据
         * @param treeData 表格树数据
         * @param treeid 当前节点id
         * @param childArr 获取的子节点数据
         */
        ,findChildTreeNodes:function (treeData,treeid,childArr) {
            var that = this;
            var treepid = this.config.treeConfig.treepid;
            treeData.forEach(function (item) {
                if(treepid in item){
                    if(item[treepid]+"" === treeid+""){
                        childArr.push(item);
                    }else {
                        if(item.treeList){
                            that.findChildTreeNodes(item.treeList,treeid,childArr);
                        }
                    }
                }else {
                    if(item.treeList){
                        that.findChildTreeNodes(item.treeList,treeid,childArr);
                    }
                }
            });
        }
        /**
         * 指定节点/节点id逐级排序
         * @param params 节点/节点id
         * @param field 排序字段
         * @param isAsc true升序 false降序
         */
        ,sortByTreeNode:function (params,field,isAsc) {
            if(!params)return;
            if(typeof params === 'string' || Object.prototype.toString.call(params) === '[object Number]'){
                params = $(this.config.elem).next().find('div.layui-table-body tr[tree-id="'+params+'"]');
            }
            var tr = $(params);tr.show();
            this.exeTreeNodesSort(tr,field,isAsc);
            var lvl = tr.data('lvl'),icon;lvl = lvl ? lvl : 0;
            var parentNode = this.getParentNode(tr,lvl);
            while(parentNode && parentNode[0]){
                parentNode.show();
                icon = parentNode.find('td[data-field="'+this.config.treeConfig.showField+'"] i.layui-tableEdit-edge');
                lvl = parentNode.data('lvl');
                lvl = lvl ? lvl : 0;
                this.rotateFunc(icon,true);
                parentNode = this.getParentNode(parentNode,lvl);
            }
            var topNode = this.getTopNode(tr);
            this.showOrHideChildrenNodes(topNode,0,true);
        }
        /**
         * 当前节点叶子节点逐级排序
         * @param tr 当前节点
         * @param field 排序字段
         * @param isAsc true升序 false降序
         */
        ,exeTreeNodesSort:function (tr,field,isAsc) {
            var that = this;
            var tableTreeid = $(that.config.elem).attr('id');
            var treeData = configs.tableTreeCache[tableTreeid];
            var lvl = tr.data('lvl');lvl = lvl ? lvl : 0;
            var brotherArr = [];
            that.findChildTreeNodes(treeData,tr.attr('tree-id'),brotherArr);
            var $treeid = that.config.treeConfig.treeid;
            if(brotherArr.length>0){
                that.sort({field:field,desc:isAsc},brotherArr);
                brotherArr.forEach(function (item) {
                    var ztr = $('tr[tree-id="'+item[$treeid]+'"]'),zlvl = ztr.data('lvl');
                    zlvl = zlvl ? zlvl : 0;
                    that.removeChildren(ztr,zlvl);
                    ztr.remove();
                });
                var sortData = that.getDataByTreeId(treeData,tr.attr('tree-id'));
                that.asyncAddTree(brotherArr,sortData,tr,lvl);
            }
        }
    };

    var active = {
        on:function (event,callback) {
            var filter = event.match(/\((.*)\)$/),eventName = (filter ? (event.replace(filter[0],'')+'_'+ filter[1]) : event);
            configs.callbacks[moduleName+'_'+eventName]=callback;
        },
        callbackFn:function (event,params) {
            var filter = event.match(/\((.*)\)$/),eventName = (filter ? (event.replace(filter[0],'')+'_'+ filter[1]) : event);
            var key = moduleName+'_'+eventName,func = configs.callbacks[key];
            if(!func) return;
            return func.call(this,params);
        },
        render:function (options) {
            var tableTree = new TableTree();
            tableTree.render(options,true);
            return {
                getTreeOptions:function () {
                    return tableTree.config;
                },
                getCheckedTreeNodeData:function () {
                    return tableTree.getCheckedTreeNodeData();
                },
                reload:function (options) {
                    tableTree.reload(options);
                },
                openTreeNode:function (params) {
                    tableTree.openTreeNode(params);
                }
                ,closeTreeNode:function (params) {
                    tableTree.closeTreeNode(params);
                }
                ,closeAllTreeNodes:function () {
                    tableTree.closeAllTreeNodes();
                }
                ,openAllTreeNodes:function () {
                    tableTree.openAllTreeNodes();
                }
                ,sort:function (options) {
                    var tableTreeid = $(tableTree.config.elem).attr('id');
                    var treeData = configs.tableTreeCache[tableTreeid];
                    tableTree.sort(options,treeData);
                    if(treeData.length<-0) return;
                    _layui.each(treeData,function (index,item) {
                        item['LAY_TABLE_INDEX'] = index;
                    });
                    var tr = $(tableTree.config.elem).next().find('div.layui-table-body tr').eq(0);
                    tableTree.refreshTableBody(treeData,tr,0,true);
                    tableTree.openAllTreeNodes();
                    form.render('checkbox');
                }
                ,getTableTreeData:function () {
                    return tableTree.getTableTreeData();
                }
                ,addTopTreeNode:function (data) {
                    tableTree.addTopTreeNode(data);
                }
                ,delTreeNode:function (params) {
                    tableTree.delTreeNode(params);
                }
                ,keywordSearch:function (value) {
                    tableTree.keywordSearch(value);
                }
                ,clearSearch:function () {
                    tableTree.clearSearch();
                }
                ,refresh:function (data) {
                    tableTree.refresh(data);
                }
                ,sortByTreeNode:function (tr,field,isAsc) {
                    tableTree.sortByTreeNode(tr,field,isAsc);
                }
            };
        }
    };
    exports(moduleName, active);
});