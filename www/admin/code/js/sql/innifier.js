Blockly.defineBlocksWithJsonArray([{
    "type": "innifier",
    "message0": "%1 %2 %3",
    "args0": [
        {
            "type": "input_value",
            "name": "1ConditionC",
            "check": ["MATH", "CONDITIONCHOOSER", 'freeinput'],
        },
        {
            "type": "field_dropdown",
            "name": "OP",
            "options": [
                ["IN", "I"],
                ["NOT IN", "NI"],
            ]
        },
        {
            "type": "input_statement",
            "name": "2ConditionC",
            "check": ["SELECT"],
        },
    ],
    "inputsInline": true,
    "output": "INNIFIER",
    "colour": '#5270DE',
    "helpUrl": "",
}])
Blockly.JavaScript['innifier'] = function(block) {
    var OPERATORS = {
        'I': 'IN',
        'NI': 'NOT IN'
    };
    var operator = OPERATORS[block.getFieldValue('OP')];
    var argument0 = Blockly.JavaScript.statementToCode(block, '1ConditionC');
    var argument1 = Blockly.JavaScript.statementToCode(block, '2ConditionC');
    if(operator == 'IN' || operator == 'NOT IN'){
        if(argument1.includes(';')){
            if(argument1.includes(';SELECT')){
                argument1 = argument1.replace(/;SELECT/g, '<BR> union <BR>select');
            }
            argument1 = argument1.replace(/;/g, ' ');
        }
        argument1 = '(' + argument1 + ')';
    }
    var code = argument0 + ' ' + operator + ' ' + argument1;
    return code;
};
