Blockly.defineBlocksWithJsonArray([
    {
        "type": "tablename_as",
        "message0": "%1 AS %2",
        "args0": [
            {
                "type": "input_value",
                "name": "as_oldName",
                "check": ["aggregate_min", "aggregate_max", "aggregate_avg", "aggregate_count", "aggregate_sum", "CONDITIONCHOOSER", "freeinput"]
            },
            {
                "type": "input_value",
                "name": "as_newName",
                "check": ["freeinput"]
            }
        ],
        "inputsInline": true,
        "output": 'tablename_as',
        "colour": '#0ddb69',
        "tooltip": "",
        "helpUrl": "",
        'extensions': 'assExtensions'
    },
]);//AS-Modifier
Blockly.Extensions.register('assExtensions', function(){
    this.setOnChange(function (changeEvent) {
        var parent = this.getSurroundParent();
        if(parent != null){
            if(parent.toDevString().includes('select_from') || parent.toDevString().includes('all_join')){
                this.getInput('as_oldName').setCheck("TABLE");
            }
            else{
                this.getInput('as_oldName').setCheck(["freeinput", "aggregate_min", "aggregate_max", "aggregate_avg", "aggregate_count", "aggregate_sum", "CONDITIONCHOOSER"]);
            }
        }
    })
});
Blockly.JavaScript['tablename_as'] = function(block) {
    var argumentOld = Blockly.JavaScript.statementToCode(block, 'as_oldName');
    var argumentNew = Blockly.JavaScript.statementToCode(block, 'as_newName');
    var code = argumentOld + ' as ' + argumentNew;
    return code;
};
