Blockly.Blocks['gd_inline'] = {
    init: function () {
        this.appendDummyInput()
            .appendField(new Blockly.FieldTextInput(''), 'var');
        this.setOutput(true, null);
        this.setColour(90);
        this.setTooltip('结果赋值');
    }
};
Blockly.JavaScript['gd_inline'] = function (block) {
    var val = block.getFieldValue('var');
    return [val, 0];
};
Blockly.Blocks['gd_text'] = {
    init: function () {
        this.appendValueInput('val')
            .appendField(new Blockly.FieldTextInput(''), 'var');
        this.setOutput(true, null);
        this.setColour(90);
        this.setTooltip('承左启右');
    }
};
Blockly.JavaScript['gd_text'] = function (block) {
    var val = block.getFieldValue('var');
    var value_val = Blockly.JavaScript.valueToCode(block, 'val', Blockly.JavaScript.ORDER_ATOMIC);
    //var code = var_type + ' ' + text_var;
    if (value_val === '') {
        //code += '\n';
        return [val, 0];
    } else {
        //code += ' = ' + value_val + '\n';
        return [val + ' ' + value_val, 0];
    }
    //return [val, 0];
};
Blockly.Blocks['gd_plain'] = {
    init: function () {
        this.appendDummyInput().appendField(new Blockly.FieldTextInput(''), 'var');
        //this.setOutput(true, 'String');
        this.setPreviousStatement(true, null);
        this.setNextStatement(true, null);
        this.setColour(90);
        this.setTooltip('承上启下');
    }
};
Blockly.JavaScript['gd_plain'] = function (block) {
    var val = block.getFieldValue('var');
    return val + '\n';
};
Blockly.Blocks['gd_console'] = {
    init: function () {
        this.appendDummyInput()
            .appendField('console.log(')
            .appendField(new Blockly.FieldTextInput(''), 'var')
            .appendField(')');
        //this.setOutput(true, 'String');
        this.setPreviousStatement(true, null);
        this.setNextStatement(true, null);
        this.setColour(90);
        this.setTooltip('打印');
    }
};
Blockly.JavaScript['gd_console'] = function (block) {
    var val = block.getFieldValue('var');
    return 'console.log(' + val + ');\n';
};
Blockly.Blocks['gd_new'] = {
    init: function () {
        this.appendValueInput('chain')
            .appendField('new')
            .setCheck(null);
        //this.setPreviousStatement(true, null);
        this.setOutput(true, null);
        this.setColour(90);
        this.setTooltip('新');
    }
};
Blockly.JavaScript['gd_new'] = function (block) {
    var value_val = Blockly.JavaScript.valueToCode(block, 'chain', Blockly.JavaScript.ORDER_ATOMIC);
    if (value_val === '') {
        return ['new ', 0];
    } else {
        return ['new ' + value_val, 0];
    }
};
Blockly.Blocks['gd_require'] = {
    init: function () {
        this.appendDummyInput()
            .appendField('require("')
            .appendField(new Blockly.FieldTextInput(''), 'var')
            .appendField('")');
        this.setOutput(true, 'String');
        this.setColour(90);
        this.setTooltip('包含');
    }
};
Blockly.JavaScript['gd_require'] = function (block) {
    var val = block.getFieldValue('var');
    return ['require("'+ val + '");\n',0];
};
Blockly.JavaScript['gd_await'] = function (block) {
    var value_val = Blockly.JavaScript.valueToCode(block, 'val', Blockly.JavaScript.ORDER_ATOMIC);
    if (value_val === '') {
        return ['await ', 0];
    } else {
        return ['await ' + value_val, 0];
    }
};
Blockly.Blocks['gd_await'] = {
    init: function () {
        this.appendValueInput('val')
            .setCheck(null)
            .appendField('await');
        this.setOutput(true, 'String');
        //this.setPreviousStatement(true, null);
        //this.setNextStatement(true, null);
        //this.setOutput(true, null);
        this.setColour(90);
        this.setTooltip('异步指令');
        //this.setOutput(true);
    }
};
Blockly.JavaScript['gd_awaits'] = function (block) {
    var value_val = Blockly.JavaScript.valueToCode(block, 'val', Blockly.JavaScript.ORDER_ATOMIC);
    if (value_val === '') {
        return 'await ';
    } else {
        return 'await ' + value_val;
    }
};
Blockly.Blocks['gd_awaits'] = {
    init: function () {
        this.appendValueInput('val')
            .setCheck(null)
            .appendField('await');
        this.setPreviousStatement(true, null);
        this.setNextStatement(true, null);
        this.setColour(120);
        this.setTooltip('异步指令');
        //this.setOutput(true);
    }
};
// Blockly.JavaScript['gd_await'] = function (block) {
//     var value_val = Blockly.JavaScript.valueToCode(block, 'val', Blockly.JavaScript.ORDER_ATOMIC);
//     console.log(value_val)
//     return ['await ',0];
// };
Blockly.Blocks['gd_var'] = {
    init: function () {
        this.appendValueInput('val')
            .setCheck(null)
            .appendField(new Blockly.FieldDropdown([['let', 'let'], ['var', 'var'], ['const', 'const']]), 'var_type')
            .appendField(new Blockly.FieldTextInput('data'), 'var')
            .appendField('=');
        this.setPreviousStatement(true, null);
        this.setNextStatement(true, null);
        this.setColour(90);
        this.setTooltip('');
        //Blockly.Variables.createVariable('data')
        this.setHelpUrl('http://www.godo.im/');
    }
};
Blockly.JavaScript['gd_var'] = function (block) {
    var var_type = block.getFieldValue('var_type');
    var text_var = block.getFieldValue('var');
    var value_val = Blockly.JavaScript.valueToCode(block, 'val', Blockly.JavaScript.ORDER_ATOMIC);
    var code = var_type + ' ' + text_var;
    if (value_val === '') {
        code += '\n';
    } else {
        code += ' = ' + value_val + '\n';
    }
    //return [code, Blockly.JavaScript.ORDER_NONE];
    return code;
};


Blockly.Blocks['gd_true'] = {
    init: function () {
        this.setColour(20);
        this.setOutput(true, ["element"]);

        this.appendDummyInput()
            .setAlign(Blockly.ALIGN_CENTRE)
            .appendField('true');
    }
};


Blockly.Blocks['gd_false'] = {
    init: function () {
        this.setColour(20);
        this.setOutput(true, ["element"]);

        this.appendDummyInput()
            .setAlign(Blockly.ALIGN_CENTRE)
            .appendField('false');
    }
};
Blockly.JavaScript['gd_true'] = function (block) {
    return ["true", 0];
};


Blockly.JavaScript['gd_false'] = function (block) {
    return ["false", 0];
};
Blockly.Blocks['gd_return'] = {
    init: function () {
        this.appendValueInput('ret')
            .setCheck(null)
            .appendField('return')
        this.setPreviousStatement(true, null);
        this.setNextStatement(true, null);
        this.setColour(290);
        this.setTooltip('');
    }
};
Blockly.JavaScript['gd_return'] = function (block) {
    var value_ret = Blockly.JavaScript.valueToCode(block, 'ret', Blockly.JavaScript.ORDER_ATOMIC);
    var code = 'return ' + value_ret + '\n';
    //return [code, Blockly.JavaScript.ORDER_ATOMIC];
    return code;
};
Blockly.Blocks['gd_abc'] = {
    init: function () {
        let options = [
            ["=", "="],
            ["==", "=="],
            ["===", "==="],
            ["!=", "!="],
            ["!==", "!=="],
            ["<", "<"],
            [">", ">"],
            ["<=", "<="],
            [">=", ">="],
            ["||", "||"],
            ["&&", "&&"],
            ["|", "|"],
            ["&", "&"]
          ];
        this.appendDummyInput()
        .appendField(new Blockly.FieldTextInput('var1'), 'var1')
        .appendField(new Blockly.FieldDropdown(options), 'var_type')
        .appendField(new Blockly.FieldTextInput('var2'), 'var2');
        this.setOutput(true, null);
        //this.setPreviousStatement(true, null);
        this.setNextStatement(true, null);
        this.setColour(90);
        this.setTooltip('多数判断');
    }
};

Blockly.JavaScript['gd_abc'] = function(block) {
    var var1 = block.getFieldValue('var1');
    var var2 = block.getFieldValue('var2');
    var var_type = block.getFieldValue('var_type');
    var code = var1 + ' ' + var_type + ' ' + var2;
    //return [code, Blockly.JavaScript.ORDER_NONE];
    return code;
  };

  Blockly.Blocks['gd_val'] = {
    init: function () {
        this.appendDummyInput()
        .appendField(new Blockly.FieldTextInput('var1'), 'var1')
        .appendField("=")
        .appendField(new Blockly.FieldTextInput('var2'), 'var2');
        //this.setOutput(true, null);
        this.setPreviousStatement(true, null);
        this.setNextStatement(true, null);
        this.setColour(90);
        this.setTooltip('查询');
    }
};

Blockly.JavaScript['gd_val'] = function(block) {
    var var1 = block.getFieldValue('var1');
    var var2 = block.getFieldValue('var2');
    var code = var1 + ' = ' + var2 + '\n';
    //return [code, Blockly.JavaScript.ORDER_NONE];
    return code;
};


Blockly.Blocks['gd_lets'] = {
    init: function () {
        let options = [
            ['let', 'let'],
            ['const', 'const'],
            ['var', 'var']
        ];
        this.appendDummyInput()
            .appendField('多定义')
            .appendField(new Blockly.FieldDropdown(options), 'var_type')
            .appendField(new Blockly.FieldTextInput(''), 'letsname');
        this.appendStatementInput('chain')
            .appendField('chain')
            .setCheck(null);
        this.setColour(90);
        this.setPreviousStatement(true, null);
        this.setNextStatement(true, null);
        this.setTooltip('');
    }
};
Blockly.JavaScript['gd_lets'] = function (block) {
    var var_type = block.getFieldValue('var_type');
    var letsname = block.getFieldValue('letsname');
    var value_val = Blockly.JavaScript.statementToCode(block, 'chain');
    let arr = value_val.split('\n');
    let rt = [];
    arr.forEach(d => {
        d = d.trim()
        if (d) {
            rt.push(d)
        }
    })
    let str = rt.join(',');
    //console.log(str)
    let code = `${var_type} {${str}} = ${letsname};\n`;
    return code;
}
