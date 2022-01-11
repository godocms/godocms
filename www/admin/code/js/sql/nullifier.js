Blockly.defineBlocksWithJsonArray([{
    "type": "nullifier",
    "message0": " %1 IS %2 NULL %3",
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
                ["\u2009", "IN"],
                ["NOT", "INN"],
            ]
        },
        {
            "type": "input_dummy",
            "name": "secConditionC",
        }
    ],
    "inputsInline": true,
    "output": "NULLIFIER",
    "colour": '#3ED9D9',
    "helpUrl": "%{BKY_LOGIC_COMPARE_HELPURL}",
    "extensions": ["logic_compare", "logic_op_tooltip"],
    "mutator": "compMutator",
}])
Blockly.JavaScript['nullifier'] = function(block) {
    var OPERATORS = {
        'EQ': '=',
        'NEQ': '!=',
        'LT': '<',
        'LTE': '<=',
        'GT': '>',
        'GTE': '>=',
        'IN' : 'IS NULL',
        'INN': 'IS NOT NULL',
        'I': 'IN',
        'NI': 'NOT IN'
    };
    var operator = OPERATORS[block.getFieldValue('OP')];
    var argument0 = Blockly.JavaScript.statementToCode(block, '1ConditionC');
    var argument1 = '';
    if(operator != 'IS NULL' && operator != 'IS NOT NULL'){
        argument1 = Blockly.JavaScript.statementToCode(block, '2ConditionC');
        if(operator == 'IN' || operator == 'NOT IN'){
            if(argument1.includes(';')){
                if(argument1.includes(';SELECT')){
                    argument1 = argument1.replace(/;SELECT/g, '<BR> UNION <BR>SELECT');
                }
                argument1 = argument1.replace(';', ' ');
            }
            argument1 = '(' + argument1 + ')';
        }
    }
    var code = argument0 + ' ' + operator + ' ' + argument1;
    return code;
};
