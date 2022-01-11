Blockly.Blocks['math'] = {
    init: function() {
        this.appendValueInput("1ConditionM")
            .setCheck(["freeinput", "CONDITIONCHOOSER", "Number", 'MATH'])
            .setAlign(Blockly.ALIGN_CENTRE);
        this.appendValueInput("2ConditionM")
            .setCheck(["freeinput", "CONDITIONCHOOSER", "Number", 'MATH'])
            .setAlign(Blockly.ALIGN_CENTRE)
            .appendField(new Blockly.FieldDropdown([["\u002B","plus"], ["\u002D","minus"], ["\u00D7","mul"], ["\u00F7","div"]]), "mathemator");
        this.setInputsInline(true);
        this.setOutput(true, ["MATH"]);
        this.setColour('#5BE5E5');
        this.setTooltip("");
        this.setHelpUrl("");
    }
};
Blockly.JavaScript['math'] = function(block) {
    var OPERATORS = {
        'plus': '\u002B',
        'minus': '\u002D',
        'mul': "*",
        'div': "/",
    };
    var operator = OPERATORS[block.getFieldValue('mathemator')];
    var argument0 = Blockly.JavaScript.statementToCode(block, '1ConditionM');
    argument0 = argument0.trim();
    var argument1 = Blockly.JavaScript.statementToCode(block, '2ConditionM');
    var code = '(' + argument0 + ' ' + operator + ' ' + argument1 + ')';
    return code;
};
