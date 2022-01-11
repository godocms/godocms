Blockly.defineBlocksWithJsonArray([
    {
        "type": "number",
        "message0": "%1",
        "args0": [{
            "type": "field_number",
            "name": "NUM",
            "value": 0
        }],
        "output": "Number",
        "colour": '#FC4758',
        "helpUrl": "%{BKY_MATH_NUMBER_HELPURL}",
        "tooltip": "%{BKY_MATH_NUMBER_TOOLTIP}",
        "extensions": ["parent_tooltip_when_inline"]
    },
])// NUMBER-Block in Workspace
Blockly.JavaScript['number'] = function(block) {
    // Numeric value.
    var code = parseFloat(block.getFieldValue('NUM'));
    code = '' + code;
    return code;
};
