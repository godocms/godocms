Blockly.Blocks['select_limit'] = {
    init: function() {
        this.appendDummyInput('limitInput')
            .setAlign(Blockly.ALIGN_LEFT)
            .appendField("LIMIT           ")
            .appendField(new Blockly.FieldNumber(0, 0), "numberInput");
        this.setPreviousStatement(true, ['WHERE', 'FROM', 'ORDER BY', 'HAVING']);
        this.setNextStatement(false, ['ORDER BY', 'LIMIT']);
        this.setColour('#8007f2');
        this.setTooltip("");
        this.setHelpUrl("");
    }
};
Blockly.JavaScript['select_limit'] = function(block) {
    var code = Blockly.JavaScript.variableDB_.getName(block.getFieldValue('numberInput'));
    code = code.replace(/my_/g, '');
    return 'limit ' + code + ';';
}
