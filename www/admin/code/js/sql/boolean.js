Blockly.defineBlocksWithJsonArray([
    {
        "type": "boolean",
        "message0": "%1",
        "args0": [
            {
                "type": "field_dropdown",
                "name": "BOOL",
                "options": [
                    ["true", "TRUE"],
                    ["false", "FALSE"]
                ]
            }
        ],
        "output": "Boolean",
        "colour": '#FC4758',
        "tooltip": "",
        "helpUrl": ""
    },
])

Blockly.JavaScript['boolean'] = function(block) {
    var code = (block.getFieldValue('BOOL') == 'TRUE') ? 'true' : 'false';
    code = '' + code;
    return code;
};
