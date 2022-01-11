Blockly.Blocks['select_groupby'] = {
    init: function() {
        this.appendValueInput('groupInput')
            .setCheck(['freeinput', "CONDITIONCHOOSER"])
            .setAlign(Blockly.ALIGN_LEFT)
            .appendField("GROUP BY ");
        this.setPreviousStatement(true, ['WHERE', 'FROM']);
        this.setNextStatement(true, ['GROUP BY', 'HAVING']);
        this.setColour('#8007f2');
        this.setTooltip("");
        this.setHelpUrl("");
    }
};
Blockly.JavaScript['select_groupby'] = function(block) {
    var code = Blockly.JavaScript.statementToCode(block, 'groupInput');
    return 'group by ' + code + ';';
}
