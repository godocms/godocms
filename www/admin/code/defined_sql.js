Blockly.Blocks['gd_select'] = {
    init: function () {
        this.appendDummyInput()
            .appendField(".select()");
        this.setOutput(true, 'String');
        this.setColour(90);
        this.setTooltip('查询');
    }
};
Blockly.JavaScript['gd_select'] = function () {
    return [".select()\n", 0];
};
Blockly.Blocks['gd_find'] = {
    init: function () {
        this.appendDummyInput()
            .appendField(".find()");
        this.setOutput(true, 'String');
        this.setColour(90);
        this.setTooltip('查询单个数据');
    }
};
Blockly.JavaScript['gd_find'] = function () {
    return [".find()\n", 0];
};
Blockly.Blocks['gd_add'] = {
    init: function () {
        let options = [
            ['add','add'],
            ['update','update'],
            ['getField','getField'],
            ['updateMany','updateMany'],
            ['increment','increment'],
            ['decrement','decrement'],
            ['beforeAdd','beforeAdd'],
            ['afterAdd','afterAdd'],
            ['afterDelete','afterDelete'],
            ['beforeUpdate','beforeUpdate'],
            ['afterUpdate','afterUpdate'],
            ['afterFind','afterFind'],
            ['afterSelect','afterSelect']

        ]
        this.appendDummyInput()
        .appendField(".")
        .appendField(new Blockly.FieldDropdown(options), 'var_type')
        .appendField("(")
            .appendField(new Blockly.FieldTextInput('data'), 'var')
            .appendField(")");
        this.setOutput(true, 'String');
        this.setColour(90);
        this.setTooltip('添加数据');
    }
};
Blockly.JavaScript['gd_add'] = function (block) {
    var var_type = block.getFieldValue('var_type');
    var text_var = block.getFieldValue('var');
    return ["."+var_type+"(" + text_var + ")\n", 0];
};
Blockly.Blocks['gd_update'] = {
    init: function () {
        this.appendDummyInput()
            .appendField(".update(")
            .appendField(new Blockly.FieldTextInput('data'), 'var')
            .appendField(")");
        this.setOutput(true, 'String');
        this.setColour(90);
        this.setTooltip('更新数据');
    }
};
Blockly.JavaScript['gd_update'] = function (block) {
    var text_var = block.getFieldValue('var');
    return [".update(" + text_var + ")\n", 0];
};
Blockly.Blocks['gd_addmany'] = {
    init: function () {
        this.appendDummyInput()
            .appendField(".addMany(")
            .appendField(new Blockly.FieldTextInput('data'), 'var')
            .appendField(new Blockly.FieldDropdown([['null', 'null'], ['ignore', 'ignore'], ['replace', 'replace']]), 'add_type')
            .appendField(")");
        this.setOutput(true, 'String');
        this.setColour(90);
        this.setTooltip('添加数据');
    }
};
Blockly.JavaScript['gd_addmany'] = function (block) {
    var text_var = block.getFieldValue('var');
    var add_type = block.getFieldValue('add_type');
    console.log(add_type)
    if (add_type == 'ignore' || add_type == 'replace') {
        return [".addMany(" + text_var + ", {" + add_type + ":true})\n", 0];
    } else {

        return [".addMany(" + text_var + ")\n", 0];
    }

};

Blockly.Blocks['gd_delete'] = {
    init: function () {
        this.appendDummyInput()
            .appendField(".delete()");
        this.setOutput(true, 'String');
        this.setColour(90);
        this.setTooltip('查询单个数据');
    }
};
Blockly.JavaScript['gd_delete'] = function () {
    return [".delete()\n", 0];
};
Blockly.Blocks['gd_where'] = {
    init: function () {
        let options = [
            ['where','where'],
            ['page','page'],
            ['limit','limit'],
            ['field','field'],
            ['db','db'],
            ['table','table'],
            ['join','join'],
            ['order','order'],
            ['alias','alias'],
            ['having','having'],
            ['group','group'],
            ['distinct','distinct']
        ]
        this.appendValueInput('val')
            .setCheck('String')
            .appendField(".")
            .appendField(new Blockly.FieldDropdown(options), 'var_type')
            .appendField("(")
            .appendField(new Blockly.FieldTextInput('sqlObject'), 'var')
            .appendField(")");
        this.setOutput(true, 'String');
        this.setColour(90);
        this.setTooltip('模型查询');
    }
};
Blockly.JavaScript['gd_where'] = function (block) {
    var var_type = block.getFieldValue('var_type');
    var text_var = block.getFieldValue('var');
    var value_val = Blockly.JavaScript.valueToCode(block, 'val', Blockly.JavaScript.ORDER_ATOMIC);
    if (value_val === '') {
        return ["."+var_type+"(" + text_var + ")", 0];
    } else {
        return ["."+var_type+"(" + text_var + ")" + value_val, 0];
    }
};
Blockly.Blocks['gd_model'] = {
    init: function () {
        this.appendValueInput('val')
            .setCheck('String')
            .appendField("this.model(")
            .appendField(new Blockly.FieldTextInput('modelName'), 'var')
            .appendField(")");
        this.setOutput(true, 'String');
        //this.setNextStatement(true, null);
        //this.setOutput(true, );
        this.setColour(90);
        this.setTooltip('模型');
        //this.setOutput(true);
    }
};
Blockly.JavaScript['gd_model'] = function (block) {
    var text_var = block.getFieldValue('var');
    var value_val = Blockly.JavaScript.valueToCode(block, 'val', Blockly.JavaScript.ORDER_ATOMIC);
    if (value_val === '') {
        return ["this.model('" + text_var + "')", 0];
    } else {
        return ["this.model('" + text_var + "')" + value_val, 0];
    }

};

Blockly.Blocks['gd_startTrans'] = {
    init: function () {
        let options = [
            ['startTrans','startTrans'],
            ['commit','commit'],
            ['rollback','rollback']
        ]
        this.appendDummyInput()
            .appendField(new Blockly.FieldDropdown(options), 'var_type')
            .appendField("()");
        this.setPreviousStatement(true, null);
        this.setNextStatement(true, null);
        this.setColour(90);
        this.setTooltip('事物');
    }
};
Blockly.JavaScript['gd_startTrans'] = function (block) {
    var var_type = block.getFieldValue('var_type');
    return "await this."+var_type+"();\n";
};


Blockly.Blocks['gd_query'] = {
    init: function () {
        let options = [
            ['query','query'],
            ['count','count'],
            ['sum','sum'],
            ['min','min'],
            ['max','max'],
            ['avg','avg'],
            ['execute','execute']
        ];
        this.appendDummyInput()
            .appendField(".")
            .appendField(new Blockly.FieldDropdown(options), 'var_type')
            .appendField("(")
            .appendField(new Blockly.FieldTextInput('sql'), 'var')
            .appendField(")");
        this.setOutput(true, 'String');
        this.setColour(90);
        this.setTooltip('执行语句');
    }
};
Blockly.JavaScript['gd_query'] = function (block) {
    var var_type = block.getFieldValue('var_type');
    var text_var = block.getFieldValue('var');
    return ["."+var_type+"(" + text_var + ")\n", 0];
};
