layui.use(['jquery','layer'], function () {
    let $ = layui.jquery,
        layer = layui.layer,
        req = _req(),
        id = req.id;
    $('body').on('mouseover','.blocklyTreeRow', e => {
        e.target.click()
    })
    let loadXML = (xmlString) => {
        let xmlDoc = null;
        //判断浏览器的类型
        //支持IE浏览器 
        if (!window.DOMParser && window.ActiveXObject) {   //window.DOMParser 判断是否是非ie浏览器
            var xmlDomVersions = ['MSXML.2.DOMDocument.6.0', 'MSXML.2.DOMDocument.3.0', 'Microsoft.XMLDOM'];
            for (let i = 0; i < xmlDomVersions.length; i++) {
                try {
                    xmlDoc = new ActiveXObject(xmlDomVersions[i]);
                    xmlDoc.async = false;
                    xmlDoc.loadXML(xmlString); //loadXML方法载入xml字符串
                    break;
                } catch (e) {
                }
            }
        }
        //支持Mozilla浏览器
        else if (window.DOMParser && document.implementation && document.implementation.createDocument) {
            try {
                domParser = new DOMParser();
                xmlDoc = domParser.parseFromString(xmlString, 'text/xml');
            } catch (e) {
            }
        }
        else {
            return null;
        }

        return xmlDoc;
    }
    _get(layui, 'api/getLogic?id=' + id, res => {
        //console.log(res)
        if (res && res.code) {
            let xml = Blockly.Xml.textToDom(res.code);
            console.log(xml)
            Blockly.Xml.domToWorkspace(xml, Blockly.mainWorkspace);
        }
    })
    window.saveData = () => {
        let xmlDom = Blockly.Xml.workspaceToDom(Blockly.mainWorkspace);
        //let code = Blockly.Xml.domToPrettyText(xmlDom);
        let code = Blockly.Xml.domToText(xmlDom);
        let str = Blockly.JavaScript.workspaceToCode(Blockly.mainWorkspace);
        //console.log(str)
        if (!id) {
            layer.msg('id不能为空', { icon: 2, time : 2000})
            return false;
        }
        _post(layui, 'api/addLogic', { id, code, str }, res => {
            layer.msg('保存成功', { icon: 1, time : 1000 })
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