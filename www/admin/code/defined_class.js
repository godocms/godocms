Blockly.Blocks['gd_class'] = {
    init: function () {
        let options = [
            ['空', ''],
            ['Base', 'Base'],
            ['think.Controller', 'think.Controller'],
            ['think.Logic', 'think.Logic'],
            ['think.Model', 'think.Model'],
            ['think.Service', 'think.Service']
        ];
        this.appendDummyInput()
            .appendField('类名')
            .appendField(new Blockly.FieldTextInput('className'), 'className');
        this.appendDummyInput()
            .appendField('扩展')
            .appendField(new Blockly.FieldTextInput(''), 'extendsName')
            .appendField('or')
            .appendField(new Blockly.FieldDropdown(options), 'var_type');
        this.appendStatementInput('chain')
            .appendField('chain')
            .setCheck(null);
        this.setColour(250);
        this.setPreviousStatement(true, null);
        this.setNextStatement(true, null);
        //this.setOutput(true, null);
        this.setTooltip('');
    }
};
Blockly.JavaScript['gd_class'] = function (block) {
    var className = block.getFieldValue('className');
    var extendsName = block.getFieldValue('extendsName');
    var var_type = block.getFieldValue('var_type');
    var value_val = Blockly.JavaScript.statementToCode(block, 'chain');
    var code = ``;
    //console.log(var_type)
    if (extendsName == '' && var_type == '') {
        code = `/**\n* @class ${className}\n*/\nmodule.exports = class{\n${value_val}\n}`;   
    } else {
        var exName = var_type;
        if (extendsName != '') {
            exName = extendsName;
        }
        //console.log(exName)
        if (exName == 'Base') {
            code = `const Base = require('./base.js');\n/**\n* @class ${className}\n*/\nmodule.exports = class extends ${exName}{\n${value_val}\n}`;
        } else {
            code = `/**\n* @class ${className}\n*/\nmodule.exports = class extends ${exName}{\n${value_val}\n}`;
        }
        
    }
    return code;
};
Blockly.Blocks['gd_classmethod'] = {
    init: function () {
        this.appendDummyInput()
            .appendField('方法')
            .appendField(new Blockly.FieldTextInput('methodName'), 'methodName');
        this.appendDummyInput()
            .appendField('参数')
            .appendField(new Blockly.FieldTextInput(''), 'params');
        this.appendStatementInput('chains')
            .appendField('chains')
            .setCheck(null);
        this.setColour(250);
        this.setPreviousStatement(true, null);
        this.setNextStatement(true, null);
        //this.setOutput(true, null);
        this.setTooltip('');
    }
};
Blockly.JavaScript['gd_classmethod'] = function (block) {
    var methodName = block.getFieldValue('methodName');
    var params = block.getFieldValue('params');
    var value_val = Blockly.JavaScript.statementToCode(block, 'chains');
    //console.log(value_val)
    let code = '';
    if (value_val !== '') {
        code = `${methodName}(${params}){\n${value_val}\n}\n`;
    } else {
        code = `${methodName}(${params}){\n}\n`;
    }
    return code;
    //return [code, Blockly.JavaScript.ORDER_NONE];

    
}
Blockly.Blocks['gd_constructor'] = {
    init: function () {
        this.appendDummyInput()
            .appendField('constructor');
        this.appendDummyInput()
            .appendField('params')
            .appendField(new Blockly.FieldTextInput('params'), 'params');
        this.appendStatementInput('chain')
            .setCheck(null);
        this.setColour(250);
        this.setPreviousStatement(true, null);
        this.setNextStatement(true, null);
        //this.setOutput(true, null);
        this.setTooltip('');
    }
};
Blockly.JavaScript['gd_constructor'] = function (block) {
    var params = block.getFieldValue('params');
    var value_val = Blockly.JavaScript.statementToCode(block, 'chains');
    //console.log(value_val)
    let code = '';
    if (value_val !== '') {
        code = `constructor(${params}){\n${value_val}\n}\n`;
    } else {
        code = `constructor(${params}){\n}\n`;
    }
    return code;
}
