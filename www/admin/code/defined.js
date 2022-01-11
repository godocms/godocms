

Blockly.Blocks['gd_post'] = {
    init: function () {
        this.appendDummyInput()
            .appendField("this.post(")
            .appendField(new Blockly.FieldTextInput(''), 'var')
            .appendField(")");
        this.setOutput(true, 'String');
        this.setColour(90);
        this.setTooltip('获取post');
    }
};
Blockly.JavaScript['gd_post'] = function (block) {
    var text_var = block.getFieldValue('var');
    if (text_var !== '') {
        return ["this.post('" + text_var+"')", 0];
    } else {
        return ["this.post()", 0];
    } 
};
Blockly.Blocks['gd_get'] = {
    init: function () {
        this.appendDummyInput()
            .appendField("this.get(")
            .appendField(new Blockly.FieldTextInput(''), 'var')
            .appendField(")");
        this.setOutput(true, 'String');
        this.setColour(90);
        this.setTooltip('获取get');
    }
};
Blockly.JavaScript['gd_get'] = function (block) {
    var text_var = block.getFieldValue('var');
    if (text_var !== '') {
        return ["this.get('" + text_var + "')", 0];
    } else {
        return ["this.get()", 0];
    }
};
Blockly.Blocks['gd_success'] = {
    init: function () {
        this.appendDummyInput()
            .appendField("return this.success(")
            .appendField(new Blockly.FieldTextInput(''), 'var')
            .appendField(")");
        //this.setOutput(true, 'String');
        this.setPreviousStatement(true, null);
        this.setColour(90);
        this.setTooltip('返回正确');
    }
};
Blockly.JavaScript['gd_success'] = function (block) {
    var text_var = block.getFieldValue('var');
    if (text_var !== '') {
        return "return this.success(" + text_var + ");\n";
    } else {
        return "return this.success();\n";
    }
};
Blockly.Blocks['gd_fail'] = {
    init: function () {
        this.appendDummyInput()
            .appendField("return this.fail(")
            .appendField(new Blockly.FieldTextInput(''), 'var')
            .appendField(")");
        //this.setOutput(true, 'String');
        this.setPreviousStatement(true, null);
        this.setColour(90);
        this.setTooltip('返回错误');
    }
};
Blockly.JavaScript['gd_fail'] = function (block) {
    var text_var = block.getFieldValue('var');
    if (text_var !== '') {
        return "return this.fail('" + text_var + "');\n";
    } else {
        return "return this.fail();\n";
    }
};
Blockly.Blocks['gd_file'] = {
    init: function () {
        this.appendDummyInput()
            .appendField("this.file(")
            .appendField(new Blockly.FieldTextInput(''), 'var')
            .appendField(")");
        this.setOutput(true, 'String');
        this.setColour(90);
        this.setTooltip('获取上传数据');
    }
};
Blockly.JavaScript['gd_file'] = function (block) {
    var text_var = block.getFieldValue('var');
    if (text_var !== '') {
        return ["this.file('" + text_var + "')", 0];
    } else {
        return ["this.file()", 0];
    }
};
Blockly.Blocks['gd_isempty'] = {
    init: function () {
        let options = [
            ['isEmpty','isEmpty'],
            ['isNumber','isNumber'],
            ['isArray','isArray'],
            ['isBoolean','isBoolean'],
            ['isMethod','isMethod'],
            ['isAjax','isAjax'],
            ['isJsonp','isJsonp'],
            ['isExist','isExist'],
            ['isFile','isFile'],
            ['isDirectory','isDirectory'],
            ['isInt','isInt'],
            ['isNull','isNull'],
            ['isNullOrUndefined','isNullOrUndefined'],
            ['isString','isString'],
            ['isSymbol','isSymbol'],
            ['isUndefined','isUndefined'],
            ['isRegExp','isRegExp'],
            ['isDate','isDate'],
            ['isError','isError'],
            ['isFunction','isFunction'],
            ['isPrimitive','isPrimitive'],
            ['isIP','isIP'],
            ['isBuffer','isBuffer'],
            ['isIPv4','isIPv4'],
            ['isIPv6','isIPv6'],
            ['isObject','isObject'],
            ['isNumberString','isNumberString'],
            ['isTrueEmpty','isTrueEmpty']
        ]
        this.appendDummyInput()
            .appendField(new Blockly.FieldDropdown(options), 'var_type')
            .appendField("(")
            .appendField(new Blockly.FieldTextInput('data'), 'var')
            .appendField(")");
        this.setOutput(true, 'Boolean');
        //this.setPreviousStatement(true, null);
        this.setColour(90);
        this.setTooltip('判断是否为空');
    }
};
Blockly.JavaScript['gd_isempty'] = function (block) {
    var var_type = block.getFieldValue('var_type');
    var text_var = block.getFieldValue('var');
    return ["think."+var_type+"(" + text_var + ")",0];
};


Blockly.Blocks['gd_datetime'] = {
    init: function () {
        this.appendDummyInput()
            .appendField("datetime(")
            .appendField(new Blockly.FieldTextInput('date'), 'var1')
            .appendField(",")
            .appendField(new Blockly.FieldTextInput('YYYY-MM-DD HH:mm:ss'), 'var2')
            .appendField(")");
        this.setOutput(true, 'String');
        this.setColour(90);
        this.setTooltip('格式化时间');
    }
};
Blockly.JavaScript['gd_datetime'] = function (block) {
    var text_var1 = block.getFieldValue('var1');
    var text_var2 = block.getFieldValue('var2');
    return ["think.datetime(" + text_var1 + ",'"+text_var2+"')", 0];
};

Blockly.Blocks['gd_md5'] = {
    init: function () {
        let options = [
            ['md5', 'md5'],
            ['timeout', 'timeout'],
            ['escapeHtml', 'escapeHtml'],
            ['omit', 'omit'],
            ['defer', 'defer'],
            ['uuid', 'uuid'],
            ['ms', 'ms'],
            ['getdirFiles', 'getdirFiles'],
            ['config', 'config']
        ]
        this.appendDummyInput()
            .appendField("think.")
            .appendField(new Blockly.FieldDropdown(options), 'var_type')
            .appendField("(")
            .appendField(new Blockly.FieldTextInput('params'), 'var')
            .appendField(")");
        this.setOutput(true, 'String');
        this.setColour(90);
        this.setTooltip('获取服务');
    }
};
Blockly.JavaScript['gd_md5'] = function (block) {
    var var_type = block.getFieldValue('var_type');
    var text_var = block.getFieldValue('var');
    return ["think." + var_type + "(" + text_var + ")", 0];
};


Blockly.Blocks['gd_service'] = {
    init: function () {
        let options = [
            ['service', 'service'],
            ['session', 'session'],
            ['cache', 'cache'],
            ['assign', 'assign'],
            ['display', 'display'],
            ['render','render'],
            ['model', 'model'],
            ['cookie', 'cookie'],
            ['header', 'header'],
            ['redirect', 'redirect'],
            ['download', 'download'],
            ['controller', 'controller'],
            ['action', 'action'],
            ['json', 'json'],
            ['jsonp','jsonp'],
        ]
        this.appendDummyInput()
            .appendField("this.")
            .appendField(new Blockly.FieldDropdown(options), 'var_type')
            .appendField("(")
            .appendField(new Blockly.FieldTextInput('params'), 'var')
            .appendField(")");
        this.setOutput(true, 'String');
        this.setColour(90);
        this.setTooltip('获取服务');
    }
};
Blockly.JavaScript['gd_service'] = function (block) {
    var var_type = block.getFieldValue('var_type');
    var text_var = block.getFieldValue('var');
    return ["this."+var_type+"(" + text_var + ")", 0];
};


Blockly.Blocks['gd_chmod'] = {
    init: function () {
        let options = [
            ['chmod', 'chmod'],
            ['mkdir', 'mkdir'],
            ['rmdir', 'rmdir']
        ]
        this.appendDummyInput()
            .appendField("think.")
            .appendField(new Blockly.FieldDropdown(options), 'var_type')
            .appendField("(")
            .appendField(new Blockly.FieldTextInput('params1,params2'), 'var')
            .appendField(")");
        this.setPreviousStatement(true, null);
        this.setNextStatement(true, null);
        this.setColour(90);
        this.setTooltip('获取服务');
    }
};
Blockly.JavaScript['gd_chmod'] = function (block) {
    var var_type = block.getFieldValue('var_type');
    var text_var = block.getFieldValue('var');
    return "think." + var_type + "(" + text_var + ")\n";
};

Blockly.Blocks['gd_ip'] = {
    init: function () {
        let options = [
            ['ip', 'ip'],
            ['ips', 'ips'],
            ['ctx','ctx'],
            ['body', 'body'],
            ['method', 'method'],
            ['isGet', 'isGet'],
            ['isPost', 'isPost'],
            ['isCli', 'isCli'],
            ['userAgent','userAgent']
        ]
        this.appendDummyInput()
            .appendField("this.")
            .appendField(new Blockly.FieldDropdown(options), 'var_type');
        this.setOutput(true, null);
        this.setColour(90);
        this.setTooltip('获取上传数据');
    }
};
Blockly.JavaScript['gd_ip'] = function (block) {
    var var_type = block.getFieldValue('var_type');
    return ["this." + var_type, 0];
};



