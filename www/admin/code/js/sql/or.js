Blockly.defineBlocksWithJsonArray([
    {
        "type": "or",//AND-BLOCK
        "message0": "OR %1",//Text on Block (First Input) --> messages need to be numbereds
        "args0": [
            {
                "type": "input_value",//FirstInput
                "name": "Con0",//name of FirstInput
                "check": ["COMPARE", "NULLIFIER", "INNIFIER", "AND", 'NOT', 'OR', 'BETWEEN']//Acceptance Condition for following Blocks to be combined
            }
        ],
        "message1": "    %1",//Text on second Input
        "args1": [
            {
                "type": "input_value",//SecondInput
                "name": "sCon0",//name of SecondInput
                "check": ["COMPARE", "NULLIFIER", "INNIFIER", "AND", 'NOT', 'OR', 'BETWEEN']//Acceptance Condition for following Blocks to be combined
            }
        ],
        "output": "OR",//Condition of this Block defining, how this Block could be combined to previous Blocks
        "colour": '#5270DE',
        "helpUrl": "",
        //discarded: 18.09.2017 "mutator": "orMutator",//name of the Mutator (necessary for merging Mutator_Mixin into this Block)
    },
]);// OR-Block in Workspace
Blockly.JavaScript['or'] = function(block) {
    var argument0 = Blockly.JavaScript.statementToCode(block, 'Con0');
    var argument1 = Blockly.JavaScript.statementToCode(block, 'sCon0');
    var n = 1;
    var code = argument0 + ' or ' + argument1 + ' ';
    while (block.getInput('Con' + n)) {
        var additionalCode = Blockly.JavaScript.statementToCode(block, 'Con' + n);
        code = code.concat('OR ' + additionalCode);
        ++n;
    } ;
    code = '\u0028' + code + '\u0029';
    return code;
};//CodeGenerator OR
