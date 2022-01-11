Blockly.Blocks["select_from"] = {
    init: function() {
        this.appendValueInput('FROM')
            .appendField('FROM                ')
            .setCheck(["TABLE", 'tablename_as'])
        this.setInputsInline(false);
        this.setPreviousStatement(true, ['SELECT']);
        this.setNextStatement(true, ['WHERE', 'GROUP BY', 'FROM']);
        this.setColour('#8007f2');
    }
};
Blockly.JavaScript['select_from'] = function(block){
    var tables = Blockly.JavaScript.statementToCode(block, 'FROM');
    tables = tables.substring(0, tables.length);
    return 'FROM ' + tables + ';';
}
