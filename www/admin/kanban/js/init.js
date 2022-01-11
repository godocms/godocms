layui.use(['layer', 'dropdown'], function () {
    let $ = layui.$,
        layer = layui.layer,
        dropdown = layui.dropdown,
        id = _req('id'),
        kanbanId = 0,
        kanbanClsId = 0,
        kanban,
        dropEl,
        taskDataInfo = {
            maxid: 0,
            title : '我的看板'
        },
        taskDataList = [];
    let dropDownOptions = {
        elem: '.kb-header-i',
        trigger: 'hover',
        data: [{
            title: '添加',
            id: 1
        },
        {
            title: '编辑',
            id: 2
        },
        {
            title: '删除',
            id: 3
        },],
        ready: function (elemPanel, elem) {
            //console.log(elem)
            dropEl = elem;
        },
        click: (data, othis) => {
            //console.log(data);
            let boardId = $(dropEl).attr('data-id');
            if (data.id == 1) {
                addEl(boardId)
            }
            else if(data.id == 2) {
                editEl(boardId)
            }
            else if(data.id == 3) {
                delEl(boardId)
            }
        }
    };
    function editEl(boardId) {
        layer.prompt({
            formType: 0,
            value: '',
            title: '编辑看板',
            area: ['300px', '35px']
        }, function (value, index, elem) {
            if (value && value != '') {
                let data = getItemData(value, boardId);
                kanban.addElement(boardId, data);

                layer.close(index);
            }

        });
    }
    function delEl(boardId) {
        kanban.removeBoard(boardId);
    }
    function initKanban(){
        kanban = new jKanban({
            element: "#myKanban",
            gutter: "10px",
            widthBoard: "300px",
            itemHandleOptions: {
                enabled: true,
                customCssIconHandler: 'layui-icon layui-icon-slider'
            },
            boards: [],
            dropBoard: function (el, target, source, sibling) {
                console.log(taskDataList)
                console.log(el, target, source, sibling)
            }
        });
        dropdown.render(dropDownOptions)
    }
    function initParams() {
        if (taskDataList.length > 0) {
            kanbanId = taskDataInfo.maxid;
            kanbanClsId = kanbanId;
            if (kanbanClsId > 8) {
                kanbanClsId = 1;
            }
        }
    }
    if (!id) {
        initKanban()
    } else {
        $.get('/admin/kanban/js/data.json', res => {
            if (res.code == 0) {
                kanban = new jKanban({
                    element: "#myKanban",
                    gutter: "10px",
                    widthBoard: "300px",
                    itemHandleOptions: {
                        enabled: true,
                        customCssIconHandler: 'layui-icon layui-icon-templeate-1'
                    },
                    boards: res.data.list
                });
                taskDataInfo = $.extend(taskDataInfo, res.data.info);
                taskDataList = res.data.list;
                initParams();
                dropdown.render(dropDownOptions)
            } else {
                layer.msg('加载数据失败！', { icon: 2 })
                initKanban()
            }
        })
    }
    
    function getItemData(title, boardId){
        let tbId;
        taskDataList.forEach(d => {
            if (d.id = boardId) {
                d.maxid++;
                tbId = d.maxid;
            }
        })
        let rt = {
            id: 'tbitem_' + boardId + '_' + tbId,
            title
        }
        taskDataList.forEach(d => {
            if (d.id = boardId) {
                d.item.push(rt);
            }
        })
        return rt;
    }
    //添加看板任务
    function addEl(boardId){
        layer.prompt({
            formType: 0,
            value: '',
            title: '请输入任务名字',
            area: ['300px', '35px']
        }, function (value, index, elem) {
            if (value && value != '') {
                let data = getItemData(value, boardId);
                kanban.addElement(boardId, data);

                layer.close(index);
            }

        });
    }

    //添加看板
    $('#addKanban').on('click', e => {
        layer.prompt({
            formType: 0,
            value: '',
            title: '请输入看板名字',
            area: ['300px', '35px']
        }, function (value, index, elem) {
            if (value && value != '') {
                kanbanId++;
                kanbanClsId++;
                if (kanbanClsId > 8) {
                    kanbanClsId = 1;
                }
                let kanbanData = {
                    id: 'taskboard_' + kanbanId,
                    title: value,
                    class: 'kb' + kanbanClsId,
                    item: [],
                    maxid : 1
                };
                taskDataList.push(kanbanData);
                taskDataInfo.maxid = kanbanId;

                kanban.addBoards([kanbanData]);
                dropdown.render(dropDownOptions)
                layer.close(index);
            }

        });

    })


})