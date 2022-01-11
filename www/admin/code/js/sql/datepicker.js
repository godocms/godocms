Blockly.Blocks['datepicker'] = {
    init: function() {
        this.appendDummyInput()
            .appendField("Year:")
            .appendField(new Blockly.FieldNumber(2018), "date_year");
        this.appendDummyInput()
            .appendField("Month:")
            .appendField(new Blockly.FieldNumber(0, 1, 12), "date_month");
        this.appendDummyInput()
            .appendField("Day:")
            .appendField(new Blockly.FieldNumber(0, 1, 31), "date_day");
        this.appendDummyInput()
            .appendField("Hour:")
            .appendField(new Blockly.FieldNumber(0, 0, 23), "date_time");
        this.setInputsInline(true);
        this.setOutput(true, "DatePicker");
        this.setColour('#FC4758');
        this.setTooltip("");
        this.setHelpUrl("");
    }
};//DATE-Block in Workspace
Blockly.JavaScript['datepicker'] = function(block) {
    // Numeric value and adapted for MySQL
    var year = parseFloat(block.getFieldValue('date_year'));
    var month = parseFloat(block.getFieldValue('date_month'));
    var day = parseFloat(block.getFieldValue('date_day'));
    var time = parseFloat(block.getFieldValue('date_time'));
    if(month < 10){
        month = '0' + month;
    }
    if(day < 10){
        day = '0' + day;
    }
    if(time < 10){
        time = '0' + time;
    }
    time = time + '00';
    var code = '\u0022' + year + month + day + time + '\u0022';
    return code;
};
