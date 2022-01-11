Blockly.Blocks['select'] = {
    init: function() {
        this.appendValueInput('SELECT')
            .appendField('SELECT   ')
            .setCheck(['freeinput', "tablename_as", "ALL", "CONDITIONCHOOSER", "aggregate_min", "aggregate_max", "aggregate_avg", "aggregate_sum", "aggregate_count"])
            .appendField(new Blockly.FieldDropdown([["\u2009", 'blank'], ["ALL", 'all'], ["DISTINCT", 'distinct']]), 'option')
        this.setInputsInline(false);
        this.setPreviousStatement(true, ['SELECT', 'WHERE', 'GROUP BY', 'HAVING', 'ORDER BY', 'FROM']);
        this.setNextStatement(true, ['SELECT']);
        this.setColour('#8007f2');

    }
};

Blockly.JavaScript['select'] = function(block) {
    var select = Blockly.JavaScript.statementToCode(block, 'SELECT');

    if(!select.includes(' *')){
        select = select.substring(0,select.length-1);
    }
    else if(select.includes(' * ')){
        select = select.substring(0,select.length-1);
    }
    if(select.includes("AS")){
        select = select + '"';
        select = select.replace(/'/g, '"');
    }
    else if(select.includes("'" || '"') && select.includes("'," || '",')){
        select = select + '"';
        select = select.replace(/'/g, '"');
    }

    var option = Blockly.JavaScript.variableDB_.getName(block.getFieldValue('option'));
    if(option == 'blank' || option == 'all'){
        option = 'SELECT  ';
    }
    else{
        option = 'SELECT DISTINCT ';
    }

    var code = option + select;

    code = code.concat(';');
    return code;
};
