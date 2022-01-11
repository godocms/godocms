Blockly.Blocks['allchooser'] = {
    init: function() {
        this.appendDummyInput('allInput')
            .setAlign(Blockly.ALIGN_CENTRE)
            .appendField("*");
        this.setOutput(true, "ALL");
        this.setColour('#f1bf06');
        this.setTooltip("");
        this.setHelpUrl("");
    }
};
Blockly.JavaScript['allchooser'] = function(block){
    return '*';
}
