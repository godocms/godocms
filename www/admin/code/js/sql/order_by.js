Blockly.Blocks['select_orderby'] = {
    init: function() {
        this.appendValueInput('orderInput')
            .setCheck(["CONDITIONCHOOSER", 'aggregate_min', 'aggregate_avg', 'aggregate_max', 'aggregate_sum', 'aggregate_count', 'freeinput'])
            .setAlign(Blockly.ALIGN_LEFT)
            .appendField("ORDER BY        ");
        this.setPreviousStatement(true, ['GROUP BY', 'FROM']);
        this.setNextStatement(true, ['ORDER BY']);
        this.setColour('#8007f2');
        this.setTooltip("");
        this.setHelpUrl("");
    }
};
Blockly.JavaScript['select_orderby'] = function(block) {
    var code = Blockly.JavaScript.statementToCode(block, 'orderInput');
    var i = 1;
    var countAdditionalOBs = 1;
    while(this.getInput('OB'+countAdditionalOBs)){
        countAdditionalOBs++;
    }
    while(i <= countAdditionalOBs){
        code = code.concat(Blockly.JavaScript.statementToCode(block, 'OB'+i));
        i++;
    }
    code = code.replace(/blank/g, ',');
    code = code.replace(/SC/g, 'SC,');
    code = 'order by ' + code + ';'
    code = code.replace(',;', ';');
    return code;
}
