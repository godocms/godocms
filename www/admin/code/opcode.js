layui.use(['jquery', 'layer','dropdown'], function () {
    let $ = layui.jquery,
        layer = layui.layer,
        dropdown = layui.dropdown,
        req = _req(),
        id = req.id;
    //$('body').on('mouseover', '.blocklyTreeRow', e => {
    //    e.target.click()
    //})
    dropdown.render({
        elem: '.demobtn'
        ,data: [{
          title: '控制层'
          ,id: 1
        },{
          title: '模型层'
          ,id: 2
        },{
          title: '逻辑层'
          ,id: 3
        },{
            title: '服务层'
            ,id: 4
          }]
        ,click: function(obj){
          //layer.tips('点击了：'+ obj.title + obj.id, this.elem, {tips: [1, '#5FB878']})
          $.get('/admin/code/demo/' + obj.id + '.xml', res =>{
              //console.log(res)
              let xml = Blockly.Xml.textToDom(res);
              Blockly.mainWorkspace.clear();
               Blockly.Xml.domToWorkspace(xml, Blockly.mainWorkspace);
          },'text')
        }
      });
    
    _get(layui, 'code/editBefore?id=' + id, res => {
        //console.log(res)
        if (res && res.content && res.content != '') {
            let xml = Blockly.Xml.textToDom(res.content);
            //console.log(xml)
            Blockly.Xml.domToWorkspace(xml, Blockly.mainWorkspace);
        }
    })
    window.saveData = () => {
        let xmlDom = Blockly.Xml.workspaceToDom(Blockly.mainWorkspace);
        //let code = Blockly.Xml.domToPrettyText(xmlDom);
        let content = Blockly.Xml.domToText(xmlDom);
        let str = Blockly.JavaScript.workspaceToCode(Blockly.mainWorkspace);
        //console.log(str)
        if (!id) {
            layer.msg('id不能为空', { icon: 2, time: 2000 })
            return false;
        }
        _post(layui, 'code/editCode', { id, content, str }, res => {
            layer.msg('保存成功', { icon: 1, time: 1000 })
        })
    }
    $('#linkButton').click(e => {
        //console.log(e)
        saveData()


    })
    //js监听键盘ctrl+s快捷键保存
    document.addEventListener('keydown', (e) => {
        if (e.keyCode == 83 && (navigator.platform.match("Mac") ? e.metaKey : e.ctrlKey)) {
            e.preventDefault();
            //let data = form.val('editform');
            saveData();
            //alert('saved');
        }
    });
})