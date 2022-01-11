Blockly.defineBlocksWithJsonArray([
    {
        "type": "and",
        "message0": "AND %1",
        "args0": [
            {
                "type": "input_value",
                "name": "Con0",
                "check": ["Number", "COMPARE", "NULLIFIER", "INNIFIER", "OR", 'NOT', 'AND', 'BETWEEN']
            }
        ],
        "message1": "    %1",
        "args1": [
            {
                "type": "input_value",
                "name": "sCon0",
                "check": ["Number", "COMPARE", "NULLIFIER", "INNIFIER", "OR", 'NOT', 'AND', 'BETWEEN']
            }
        ],
        "output": "AND",
        "colour": '#5270DE',
        "helpUrl": "",
    },
]);

Blockly.JavaScript['and'] = function(block) {
    var argument0 = Blockly.JavaScript.statementToCode(block, 'Con0');
    var argument1 = Blockly.JavaScript.statementToCode(block, 'sCon0');
    var n = 1;
    var code = argument0 + ' and ' + argument1 + ' ';
    while (block.getInput('Con' + n)) {
        var additionalCode = Blockly.JavaScript.statementToCode(block, 'Con' + n);
        code = code.concat('and ' + additionalCode);
        ++n;
    } ;
    code = '\u0028' + code + '\u0029';
    return code;
};
