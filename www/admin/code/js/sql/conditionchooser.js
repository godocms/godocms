Blockly.Blocks['conditionchooser'] = {
    init: function() {
        this.appendDummyInput('listInput')
            .appendField("     ")
            .appendField(new Blockly.FieldDropdown(fillTables(document.getElementById('database').innerHTML)), "chooseTableC")
            .appendField('.', "dot")
            .appendField(new Blockly.FieldDropdown(fillColumns(tables(document.getElementById('database').innerHTML)[0], document.getElementById('database').innerHTML)), "chooseColumnC")
        this.setInputsInline(true);
        this.setOutput(true, 'CONDITIONCHOOSER');
        this.setColour('#f1bf06');
        this.setTooltip("Dieser Block dient der Auswahl einer Tabelle");
        this.setHelpUrl("");
        this.setOnChange(function(changeEvent){
            var parent = this.getSurroundParent();
            var selectedTable = this.getFieldValue('chooseTableC');
            var correctColumn = this.getFieldValue('chooseColumnC');
            var doesThoseBothFit = doesMatch(selectedTable, correctColumn);
            if(parent != null && parent.toString().includes('ORDER BY') && (this.getField('orderC') == null)){
                this.appendDummyInput('listOrder').appendField(" ").appendField(new Blockly.FieldDropdown([["\u2009","BLANK"], ["ASC","ASC"], ["DESC","DESC"]]), "orderC")
            }
            else if((parent == null || (!(parent.toString().includes('ORDER BY')))) && this.getField('orderC') != null){
                this.removeInput('listOrder');
            }
            else if(parent != null){
                if(!doesThoseBothFit){
                    if(this.getInput('listInput') == null){
                        this.getInput('dummyInput').removeField('chooseColumnC');
                        this.getInput('dummyInput').appendField(new Blockly.FieldDropdown(fillColumns(selectedTable, document.getElementById('database').innerHTML)), "chooseColumnC");
                    }
                    else{
                        this.getInput('listInput').removeField('chooseColumnC');
                        this.getInput('listInput').appendField(new Blockly.FieldDropdown(fillColumns(selectedTable, document.getElementById('database').innerHTML)), "chooseColumnC");
                    }
                }
            }
        })
    }
};
Blockly.JavaScript['conditionchooser'] = function(block) {
    var chosenTableC = Blockly.JavaScript.variableDB_.getName(block.getFieldValue('chooseTableC'));
    var chosenColumnC = Blockly.JavaScript.variableDB_.getName(block.getFieldValue('chooseColumnC'));
    var chosenOrderC = '';
    if(this.getInput('listOrder')){
        chosenOrderC = Blockly.JavaScript.variableDB_.getName(block.getFieldValue('orderC'));
        if(chosenOrderC == 'BLANK'){
            chosenOrderC = '';
        }
    }
    var nextInList = Blockly.JavaScript.statementToCode(block, 'listInput');
    if(chosenColumnC == 'all'){
        chosenColumnC = '*';
    }
    var code = chosenTableC + '.' + chosenColumnC + ' ' + chosenOrderC;
    return code;
};
