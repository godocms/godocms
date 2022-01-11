Blockly.Blocks['table'] = {
    init: function() {
        this.appendDummyInput('previousTables')
            .appendField('     ')
            .appendField(new Blockly.FieldDropdown(fillTables(document.getElementById('database').innerHTML)), "chooseTableT")
        this.setOutput(true, 'TABLE');
        this.setColour('#f1bf06');
        this.setTooltip("Dieser Block dient der Auswahl einer Tabelle");
        this.setHelpUrl("");
    }
};
Blockly.JavaScript['table'] = function(block) {
    var chosenTableT = Blockly.JavaScript.variableDB_.getName(block.getFieldValue('chooseTableT'));
    var code = chosenTableT;
    return code;
};
