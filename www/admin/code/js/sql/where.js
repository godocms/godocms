Blockly.Blocks['select_where'] = {
    init: function() {
        this.appendValueInput('whereInput')
            .setCheck(['BETWEEN', 'AND', 'OR', 'COMPARE', 'NULLIFIER', 'INNIFIER', 'NOT', 'freeinput'])
            .setAlign(Blockly.ALIGN_LEFT)
            .appendField("WHERE                 ");
        this.setPreviousStatement(true, ['FROM']);
        this.setNextStatement(true, ['WHERE', 'GROUP BY']);
        this.setColour('#8007f2');
        this.setTooltip("");
        this.setHelpUrl("");
    }
};
Blockly.JavaScript['select_where'] = function(block) {
    var code = Blockly.JavaScript.statementToCode(block, 'whereInput');
    return 'where ' + code + ';';
}
