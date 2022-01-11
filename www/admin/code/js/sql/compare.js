Blockly.defineBlocksWithJsonArray([
    {
        "type": "compare",
        "message0": "%1 %2 %3",
        "args0": [
            {
                "type": "input_value",
                "name": "1ConditionC",
                "check": ["DatePicker", "MATH", "CONDITIONCHOOSER", 'HAVING', 'Boolean', 'Number', 'freeinput', 'aggregate_min', 'aggregate_avg', 'aggregate_max', 'aggregate_sum', 'aggregate_count', 'datepicker'],
            },
            {
                "type": "field_dropdown",
                "name": "OP",
                "options": [
                    ["=", "EQ"],
                    ["\u2260", "NEQ"],
                    ["<", "LT"],
                    ["\u2264", "LTE"],
                    [">", "GT"],
                    ["\u2265", "GTE"],
                    ["LIKE", 'L']
                ]
            },
            {
                "type": "input_value",
                "name": "2ConditionC",
                "check": ["DatePicker", "MATH", "CONDITIONCHOOSER", 'Boolean', 'Number', 'freeinput', 'aggregate_min', 'aggregate_avg', 'aggregate_max', 'aggregate_sum', 'aggregate_count', 'datepicker'],
            }
        ],
        "inputsInline": true,
        "output": "COMPARE",
        "colour": '#3ED9D9',
        "helpUrl": "",
        //"mutator": "compMutator",
    },
    {
        "type": "compareDerived",
        "message0": "%1    %2 %3",
        "args0": [
            {
                "type": "input_value",
                "name": "1ConditionCD",
                "check": ['aggregate_AVG','aggregate_COUNT', 'aggregate_MAX', 'aggregate_MIN', 'aggregate_SUM', 'CONDITIONCHOOSER'],
            },
            {
                "type": "field_dropdown",
                "name": "OP",
                "options": [
                    ["=", "EQ"],
                    ["\u2260", "NEQ"],
                    ["<", "LT"],
                    ["\u2264", "LTE"],
                    [">", "GT"],
                    ["\u2265", "GTE"],
                ]
            },
            {
                "type": "input_value",
                "name": "2ConditionCD",
                "check": ["MATH", "CONDITIONCHOOSER", 'Boolean', 'Number', 'freeinput'],
            },
        ],
        "output": 'DERIVED',
        "colour": 180,
        "helpUrl": "%{BKY_LOGIC_COMPARE_HELPURL}",
        "extensions": ["logic_compare", "logic_op_tooltip"],
    }]);// COMPAREDERIVED-Block for HAVING in Workspace
Blockly.NULLEXTEND = function() {
    this.getField('OP').setValidator(function(option) {
        var compareInput = (option != 'IN' && option != 'INN');
        var isThisIn = '';
        if(option == 'I' || option == 'NI'){
            var isThisIn = 'thisIsIn';
        }
        this.sourceBlock_.updateShape_(compareInput, isThisIn);
    });
};//updating COMPARE-Inputs
Blockly.COMPMUTATOR_MIXIN = {
    //Create XML to represent the number of new value-inputs.
    mutationToDom: function() {
        var container = document.createElement('mutation');
        var compareInput = (this.getFieldValue('OP') != 'IN' && this.getFieldValue('OP') != 'INN');
        container.setAttribute('compare_input', compareInput);
        return container;
    },
    //Parse XML to restore the various value-inputs.
    domToMutation: function(xmlElement) {
        var compareInput = (xmlElement.getAttribute('compare_input') == 'true');
        this.updateShape_(compareInput);
    },
    //Modify this block to have the correct number of inputs.
    updateShape_: function(compareInput, isThisIn) {
        //check wether Input this is
        if(isThisIn == 'thisIsIn'){
            var inputExists = this.getInput('2ConditionC');
            if (!inputExists) {
                this.appendStatementInput('2ConditionC')
                    .setCheck(["SELECT"]);
            }
            else if (inputExists) {
                this.removeInput('2ConditionC');
                this.appendStatementInput('2ConditionC')
                    .setCheck(["SELECT"]);
            }
        }
        else{
            // Add or remove a Value Input.
            this.removeInput('2ConditionC');
            var inputExists = this.getInput('2ConditionC');
            if (compareInput) {
                if (!inputExists) {
                    this.appendValueInput('2ConditionC')
                        .setCheck(["MATH", "CONDITIONCHOOSER", 'Boolean', 'Number', 'freeinput']);
                }
            }
            else if (inputExists) {
                this.removeInput('2ConditionC');
            }
        }
    }
};//Methods for COMPARE-Mutation (now only for NULLIFIER and INNIFIER)
Blockly.Extensions.registerMutator('compMutator', Blockly.COMPMUTATOR_MIXIN, Blockly.NULLEXTEND);//registering Mutator
Blockly.JavaScript['compare'] = function(block) {
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
        'NI': 'NOT IN',
        'L': 'LIKE'
    };
    var operator = OPERATORS[block.getFieldValue('OP')];
    var argument0 = Blockly.JavaScript.statementToCode(block, '1ConditionC');
    var argument1 = '';
    if(operator != 'IS NULL' && operator != 'IS NOT NULL'){
        argument1 = Blockly.JavaScript.statementToCode(block, '2ConditionC');
        if(operator == 'IN' || operator == 'NOT IN'){
            if(argument1.includes(';')){
                if(argument1.includes(';SELECT')){
                    argument1 = argument1.replace(/;SELECT/g, '<BR> union <BR>select');
                }
                argument1 = argument1.replace(';', ' ');
            }
            argument1 = '(' + argument1 + ')';
        }
    }
    var code = argument0 + ' ' + operator + ' ' + argument1;
    return code;
};//CodeGenerator COMPARE
