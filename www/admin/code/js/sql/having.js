Blockly.Blocks['select_having'] = {
    init: function() {
        this.appendValueInput('haveInput')
            .setCheck(["COMPARE"])
            .setAlign(Blockly.ALIGN_LEFT)
            .appendField("HAVING           ");
        this.setPreviousStatement(true, ['HAVING']);
        this.setNextStatement(true, ['HAVING', 'GROUP BY']);
        this.setColour('#8007f2');
        this.setTooltip("");
        this.setHelpUrl("");
        this.setInputsInline(true);
    }
};
Blockly.JavaScript['select_having'] = function(block) {
    var code = Blockly.JavaScript.statementToCode(block, 'haveInput');
    return 'having ' + code + ';';
}
