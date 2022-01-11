Blockly.Blocks['all_join'] = {
    init: function() {
        this.appendValueInput("STATEMENT")
            .appendField(new Blockly.FieldDropdown([['\u2009', 'BLANKJ'], ['INNER', 'INNER'], ['LEFT', 'LEFT'], ['RIGHT', 'RIGHT']]), "chooseTableType")
            .appendField('JOIN')
            .appendField(new Blockly.FieldDropdown(fillTables(document.getElementById('database').innerHTML)), "chooseTableJoin2")
            .setCheck("COMPARE")
            .appendField(new Blockly.FieldDropdown([['ON', 'onModifier'], ['\u2009', 'Blank']]), "modifierActive");
        this.setOutput(true, ["INNER_JOIN"]);
        this.setColour('#8007f2');
        this.setTooltip("");
        this.setHelpUrl("");
        this.setOnChange(function(changeEvent){
            if(this.getInput("STATEMENT") == null){
                if(this.getFieldValue('modifierActive') != 'Blank'){
                    this.removeInput("noSTATEMENT");
                    this.appendValueInput("STATEMENT")
                    //.appendField(new Blockly.FieldDropdown(fillTables(document.getElementById('database').innerHTML)), "chooseTableJoin1")
                        .appendField(new Blockly.FieldDropdown([['\u2009', 'BLANKJ'], ['INNER', 'INNER'], ['LEFT', 'LEFT'], ['RIGHT', 'RIGHT']]), "chooseTableType")
                        .appendField('JOIN')
                        .appendField(new Blockly.FieldDropdown(fillTables(document.getElementById('database').innerHTML)), "chooseTableJoin2")
                        .setCheck("COMPARE")
                        .appendField(new Blockly.FieldDropdown([['ON', 'onModifier'], ['\u2009', 'Blank']]), "modifierActive");
                }
            }
            else{
                if(this.getFieldValue('modifierActive') == 'Blank'){
                    this.removeInput("STATEMENT");
                    this.appendValueInput("noSTATEMENT")
                        .appendField(new Blockly.FieldDropdown([['\u2009', 'BLANKJ'], ['INNER', 'INNER'], ['LEFT', 'LEFT'], ['RIGHT', 'RIGHT']]), "chooseTableType")
                        .appendField('JOIN')
                        .setCheck("tablename_as")
                        .appendField(new Blockly.FieldDropdown([['\u2009', 'Blank'], ['ON', 'onModifier']]), "modifierActive");
                }
            }
        });
    }
};
Blockly.JavaScript['all_join'] = function(block) {
    var type = Blockly.JavaScript.variableDB_.getName(block.getFieldValue('chooseTableType'));
    if(type == 'BLANKJ'){
        type = '';
    }
    var join = '';
    var isModifierActive = '';
    var statement = '';
    var nostatement = '';
    if(this.getInput('STATEMENT') != null){
        join = Blockly.JavaScript.variableDB_.getName(block.getFieldValue('chooseTableJoin2'));
        statement = Blockly.JavaScript.statementToCode(block, 'STATEMENT');
    }
    else{
        nostatement = Blockly.JavaScript.statementToCode(block, 'noSTATEMENT');
    }
    var code = /*table + ' ' + */type + ' join' + ' ';
    if(this.getFieldValue('modifierActive') == 'onModifier'){
        if(statement == ''){
            code = code.concat('' + join + ' ' + 'on' + ' ');
        }
        else{
            code = code.concat('' + join + ' ' + 'on' + statement + ' ');
        }
    }
    else{
        if(nostatement == ''){
            code = code.concat('' + join + ' ');
        }
        else{
            code = code.concat('' + join + ' ' + nostatement + ' ');
        }
    }
    return code;
};
