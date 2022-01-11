Blockly.defineBlocksWithJsonArray([
    {
        "type": "between",//AND-BLOCK
        "message0": "    %1",//Text on Block (First Input) --> messages need to be numbereds
        "args0": [
            {
                "type": "input_value",//FirstInput
                "name": "Con0",//name of FirstInput
                "check": ['CONDITIONCHOOSER', 'freeinput']//Acceptance Condition for following Blocks to be combined
            }
        ],
        "message1": "BETWEEN %1",//Text on second Input
        "args1": [
            {
                "type": "input_value",//SecondInput
                "name": "Con1",//name of SecondInput
                "check": ['AND']//Acceptance Condition for following Blocks to be combined
            }
        ],
        "output": "BETWEEN",//Condition of this Block defining, how this Block could be combined to previous Blocks
        "colour": '#5270DE',
        "helpUrl": "",
    },
]);
Blockly.JavaScript['between'] = function(block) {
    var argument0 = Blockly.JavaScript.statementToCode(block, 'Con0');
    var argument1 = Blockly.JavaScript.statementToCode(block, 'Con1');
    var code = argument0 + ' between ' + argument1;
    code = code.replace('(', '');
    code = code.replace(')', '');
    return code;
};
