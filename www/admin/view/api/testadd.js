layui.use([
    'form', 'layer', 'dropdown', 'element', 'laytpl', 'table'
], function () {
    let form = layui.form,
        layer = layui.layer,
        $ = layui.$,
        element = layui.element,
        table = layui.table,
        laytpl = layui.laytpl,
        dropdown = layui.dropdown,
        req = _req(),
        dk,
        dataTableIndex;
    let hasCache = [];//预想数据的缓存
    form.verify({
        len: (val, item) => {
            let min = item.getAttribute("min")
            if (val.length < min) {
                return '长度不能小于' + min;
            }
        }
    })
    _get(layui, 'apitest/addBefore?aid=' + req.aid, res => {
        //console.log(res)
        //顶部表单渲染
        form.val('testform', res.api)
        //参数开始
        laytpl($('#data-tpl').html()).render(res.params, function (html) {
            $('#data-area').html(html);
        })
        table.init('data-table', {
            limit: 1000,
            page: false,
            skin: 'line',
            toolbar: '#data-toolbar',
            defaultToolbar: []
        });
        table.on('tool(data-table)', function (obj) {
            if (obj.event === 'del') {
                obj.del();
            }
        })
        table.on('toolbar(data-table)', function (obj) {
            if (obj.event === 'add') {
                window.addData();
            } else if (obj.event === 'init') {
                window.initData();
            }
        });
        window.addData = () => {
            let d = $.extend([], table.cache['data-table']);
            //console.log(d)
            let add = $.extend({}, d[0])
            add.key = '';
            add.def = '';
            d.unshift(add);
            //console.log(d)
            table.reload('data-table', { data: d })
        }
        window.initData = () => {
            table.reload('data-table', { data: res.params })
        }
        //参数结束
        //headers开始
        laytpl($('#head-tpl').html()).render(res.headers, function (html) {
            $('#head-area').html(html);
        });
        table.init('head-table', {
            limit: 1000,
            page: false,
            skin: 'line',
            toolbar: '#head-toolbar',
            defaultToolbar: []
        });
        table.on('tool(head-table)', function (obj) {
            if (obj.event === 'delhead') {
                obj.del();
            }
        });
        table.on('toolbar(head-table)', function (obj) {
            if (obj.event === 'addhead') {
                window.addheadData();
            } else if (obj.event === 'inithead') {
                window.initheadData();
            }
        });
        window.addheadData = () => {
            let d = $.extend([], table.cache['head-table']);
            //console.log(d)
            let add = $.extend({}, d[0])
            add.key = '';
            add.val = '';
            d.unshift(add);
            //console.log(d)
            table.reload('head-table', { data: d })
        }
        window.initheadData = () => {
            table.reload('head-table', { data: res.headers })
        }
        //headers结束
        //预想开始
        //预想结构开始
        laytpl($('#restop-tpl').html()).render(res.restop, function (html) {
            $('#restop-area').html(html);
        })
        table.init('restop-table', {
            limit: 1000,
            page: false,
            skin: 'line',
            data: res.restop,
            toolbar: '#restop-toolbar',
            defaultToolbar: []
        });
        //预想结构编辑事件
        table.on('tool(restop-table)', function (obj) {
            if (obj.event === 'delrestop') {
                obj.del();
            }
        })
        //预想结构顶部事件
        table.on('toolbar(restop-table)', function (obj) {
            if (obj.event === 'addrestop') {
                window.addrestopData();
            } else if (obj.event === 'initrestop') {
                window.initresTop();
            }
        });
        //预想结构新增
        window.addrestopData = () => {
            let d = $.extend([], table.cache['restop-table']);
            //console.log(d)
            let add = $.extend({}, d[0])
            add.key = '';
            add.val = '';
            add.stype = 'exist';
            d.unshift(add);
            //console.log(d)
            table.reload('restop-table', { data: d })
        }
        //预想结构初始化
        window.initresTop = () => {
            table.reload('restop-table', { data: res.restop })
        }

        //预想结构结束
        //预想数据开始

        window.deepresData = (obj) => {
            //console.log(obj)
            if (obj.data.key == '') {
                layer.msg('请先设置该字段标志', { icon: 2 })
                return false;
            }
            let deepKey;
            if (obj.data.dataId && obj.data.dataId != '') {
                deepKey = obj.data.dataId + '_' + obj.data.key;
            } else {
                deepKey = obj.data.key;
            }
            let renderData = {
                key: deepKey
            }
            laytpl($('#deeptpl').html()).render(renderData, function (html) {
                //$('#deeparea').html(html);
                if (!hasCache.includes(deepKey)) {
                    $('#dp-area').append(html);
                    hasCache.push(deepKey)
                } else {
                    return false;
                }

                table.init('deeptable_' + deepKey, {
                    limit: 1000,
                    page: false,
                    skin: 'line',
                    toolbar: '#resdata-toolbar',
                    defaultToolbar: []
                });
                //预想数据编辑行
                table.on("tool(deeptable_" + deepKey + ")", function (obj) {
                    if (obj.event === 'delresdata') {
                        obj.del();
                        //删除深度数据
                        let id = obj.data.dataId + '_' + obj.data.key;
                        //console.log(id)
                        //console.log(hasCache)

                        if (hasCache.includes(id)) {
                            let nh = [];
                            hasCache.forEach(d => {
                                if (d.indexOf(id) !== -1) {
                                    //if(d.search(new RegExp(id, 'i')) !== -1) {
                                    $('#deep-' + d).remove()
                                } else {
                                    nh.push(d);
                                }
                            })
                            hasCache = nh;
                        }
                    }
                    else if (obj.event === 'deepresdata') {
                        window.deepresData(obj);
                    }
                })
                //预想数据工具栏
                table.on("toolbar(deeptable_" + deepKey + ")", function (obj) {

                    if (obj.event === 'addresDataOne') {
                        window.addresDataOne(deepKey);    
                    } else if (obj.event === 'addresDataDb') {
                        window.addresDataDb(deepKey);
                    } else if (obj.event === 'clearResData') {
                        window.clearResData(deepKey);
                    }
                });
                 
                //添加单项
                window.addresDataOne = (deepKey) => {
                    let d = $.extend([], table.cache['deeptable_' + deepKey]);
                    let add = {
                        key: '',
                        val: '',
                        dtype: 'exist',
                        dataId: deepKey
                    };
                    d.unshift(add);
                    //console.log(d)
                    table.reload('deeptable_' + deepKey, { data: d });
                        
                }
                
                //从数据库
                window.addresDataDb = (deepKey) => {
                    dk = deepKey;
                    dataTableIndex = layer.open({
                        type: 1,
                        title: '新增字段',
                        shade: 0.1,
                        offset: 'rt',
                        area: ['80%', '100%'],
                        anim: 1,
                        content: $('#tabs-area')
                    });
                    $("#tabs-content").find(":checkbox").each((id, el) => {
                        if ($(el).prop('checked')) {
                            $(el).prop('checked', false)
                        }
                        form.render('checkbox');
                    });
                }
                //清空
                window.clearResData = (deepKey) => {
                    table.reload('deeptable_' + deepKey, { data: [] })
                }

            })

        }
        let objdata = {};
        objdata.data = {
            key: 'data',
            dtype: 'exist',
            val: '',
            dataId: ''
        }
        
        window.deepresData(objdata);
        //预想数据结束
        //预想结束
        //数据库处理
        laytpl($('#tabs-tpl').html()).render(res.fields, function (html) {
            $('#tabs-area').html(html);
            form.render();
            $('#tabs-content').on('click', e => {
                if (e.target.tagName == 'TD') {
                    let chk = $(e.target).parent().children().last().children();
                    //console.log(chk)
                    if (!chk.prop('checked')) {
                        chk.prop('checked', true);
                    } else {
                        chk.prop('checked', false);
                    }
                    form.render('checkbox');
                }
                if (e.target.tagName == 'I' && e.target.parentNode.parentNode.tagName == 'TH') {
                    let cks = $(e.target).parentsUntil("#tabs-content").find('.isck');
                    //console.log(cks)

                    if (!form.val('dataformlist').chkall) {
                        cks.each((i, el) => {
                            $(el).prop("checked", true);
                        })
                    } else {
                        //console.log(cks)
                        cks.each((i, el) => {
                            $(el).removeAttr("checked")
                        })
                    }
                    form.render('checkbox');
                }
            });
            $('#saveDbFieldsBtn').on('click', e => {
                let rt = [];
                $("#tabs-content").find(":checkbox").each((id, el) => {
                    if ($(el).prop('checked')) rt.push($(el).val())
                });
                //console.log(rt)
                if (rt.length > 0) {
                    let d = $.extend([], table.cache['deeptable_' + dk]);

                    let ks = []
                    d.forEach(dd => {
                        ks.push(dd.key)
                    })
                    rt.forEach(ck => {
                        let kk = ck.indexOf('.') !== -1 ? ck.split('.')[1] : ck;
                        if (!ks.includes(kk)) {
                            d.push({
                                key: kk,
                                val: '',
                                dtype: 'exist',
                                dataId: dk
                            });
                        }

                    })
                    //console.log(d)
                    table.reload('deeptable_' + dk, { data: d })
                    layer.close(dataTableIndex)

                } else {
                    layer.msg('请选择字段', { icon: 2 })
                }

            })
        });
        //数据库处理结束



    });
    //备注
    const vditor = new Vditor('veditor', {
        height: 560,
        placeholder: '请输入内容',
        value: '',
        cache: {
            enable: false
        },
        upload: {
            url: apiUrl + 'apitest/upload',
            headers: getHeader(),
            withCredentials: true,
            format: (file, res) => {
                //console.log(res)
                let rt = JSON.parse(res);
                let r = {
                    "msg": rt.message,
                    "code": rt.code,
                    "data": {
                        "errFiles": [],
                        "succMap": {}
                    }
                }
                if (rt.code != 0) {
                    layer.msg(rt.message);
                } else {
                    r.data.succMap[rt.data.name] = rt.data.filename;
                }
                return JSON.stringify(r)
            }

        }
    })
    //监听发送
    function getData() {
        let formData = form.val('testform'),
            paramsData = table.cache['data-table'],
            headData = table.cache['head-table'],
            headerData = {},
            hasCookie = $("input[name='withCredentials']").is(':checked'),
            statusCode = $('#status').val(),
            dataType = $('dataType').val(),
            topData = table.cache['restop-table'],
            dataTopField = $("input[name='dataTopField']:checked").val(), deepData = {};
        if (headData.length > 0) {
            headData.forEach(d => {
                if (d.val == 'godoSystem') d.val = getToken();
                headerData[d.key] = d.val; 
            })
        }
        if (topData.length > 0) {
            topData.forEach(el => {
                el.stype = $(el.stype).val();
                if (el.key == dataTopField) {
                    el.isdata = true;
                } else {
                    el.isdata = false;
                }
            })
            //console.log(topData)
        }
        if (hasCache.length > 0) {
            hasCache.forEach(d => {
                let data = table.cache['deeptable_' + d];
                console.log(data)
                let ck = $('#deep-' + d + ' .layui-this');
                console.log(ck)
                ck.each((i, ek) => {
                    //console.log(c)
                    //console.log(ek)
                    data[i].dtype = $(ek).attr('lay-value')
                })
                if (!deepData[d]) deepData[d] = data;
                //console.log(data) 
            })
        }
        let descData = vditor.getValue(),
            name = $('#name').val();

        return { formData, paramsData, hasCookie, headerData, statusCode, dataType, deepData, descData, name };
        //console.log($('#deep-data .layui-this'))
        //console.log(hasCache)
    }
    //json格式美化
    function prettyFormat(json) {
        try {
            // 设置缩进为2个空格
            str = JSON.stringify(json, null, 2);
            str = str
                .replace(/&/g, '&')
                .replace(/</g, '<')
                .replace(/>/g, '>');
            return str.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, function (match) {
                var cls = 'number';
                if (/^"/.test(match)) {
                    if (/:$/.test(match)) {
                        cls = 'key';
                    } else {
                        cls = 'string';
                    }
                } else if (/true|false/.test(match)) {
                    cls = 'boolean';
                } else if (/null/.test(match)) {
                    cls = 'null';
                }
                //return '<span class="' + cls + '">' + match + '</span>';
                return match;
            });
        } catch (e) {
            alert("异常信息:" + e);
        }

    }
    //发送测试
    form.on('submit(api-save)', function () {
        element.tabChange('test_tab', '4');
        let data = getData();
        if (data.hasCookie) {
            $.ajaxSetup({
                xhrFields: {
                    withCredentials: true
                }
            })
        }
        $.ajax({
            method: data.formData.method,
            url: data.formData.test_path,
            headers : data.headerData,
            data: data.paramsData,
            dataType: data.dataType,
            complete: (res, textStatus) => {
                console.log(res)
                //console.log(textStatus)
                $('#resCode').text(res.status)
                if (res.responseJSON) {
                    $('#resResult').val(prettyFormat(res.responseJSON))
                } else {
                    $('#resResult').val(res.responseText);
                }
            }
        })

    });
        
    //保存数据
    $('#saveData').on('click', e => {
        let data = getData();
        
        if (!data.name) {
            layer.msg('请输入用例名称', { icon: 2 });
            $('#name').focus()
            return false;
        }
        data.resCode = $('#resCode').text();
        data.resResult = $('#resResult').val();
        data.aid = req.aid;
        _post(layui, 'apitest/add', {data : JSON.stringify(data)}, res => {
            //console.log(res)
            parent
                .layui
                .table
                .reload("test-table");
            parent
                .layer
                .close(parent.layer.getFrameIndex(window.name)); //关闭当前页

        })
    })

});