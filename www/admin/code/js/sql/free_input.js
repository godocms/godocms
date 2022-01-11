Blockly.Blocks['freeinput'] = {
    init: function() {
        this.appendDummyInput()
            .appendField("\u201C")
            .appendField(new Blockly.FieldTextInput("\u2009"), "textInput")
            .appendField("\u201D")
        this.setOutput(true, "freeinput");
        this.setColour('#FC4758');
        this.setInputsInline(true);
        this.setTooltip("");
        this.setHelpUrl("");
        this.setOnChange(function(changeEvent){
            var parent = this.getSurroundParent();
            //die folgende Funktion ersetzt den ehem. ASCDESC-Block:
            if(parent != null && parent.toString().includes('ORDER BY') && (this.getField('orderfI') == null)){
                this.appendDummyInput('listOrder').appendField(" ").appendField(new Blockly.FieldDropdown([["\u2009","BLANK"], ["ASC","ASC"], ["DESC","DESC"]]), "orderfI")
            }
            else if((parent == null || (!(parent.toString().includes('ORDER BY')))) && this.getField('orderfI') != null){
                this.removeInput('listOrder');
            }
        })
    }
};
Blockly.JavaScript['freeinput'] = function(block) {
    // Numeric value.
    var code = "\"" + (block.getFieldValue('textInput')) + "\"";
    if(code.match(/create/i) || code.match(/alter/i) || code.match(/index/i) || code.match(/drop/i) || code.match(/show/i) || code.match(/execute/i) || code.match(/insert/i) || code.match(/update/i) || code.match(/delete/i) || code.match(/file/i) || code.match(/grant/i) /*|| code.match(/super/i)*/ || code.match(/process/i) || code.match(/shutdown/i) || code.match(/reload/i) || code.match(/lock/i) || code.match(/replication/i)){
        code = '';
    }
    if(code.match(/Ä/g)){
        code = code.replace(/Ä/g, 'Ae');
    }
    if(code.match(/ä/g)){
        code = code.replace(/ä/g, 'ae');
    }
    if(code.match(/Ö/g)){
        code = code.replace(/Ö/g, 'Oe');
    }
    if(code.match(/ö/g)){
        code = code.replace(/ö/g, 'oe');
    }
    if(code.match(/Ü/g)){
        code = code.replace(/Ü/g, 'Ue');
    }
    if(code.match(/ü/g)){
        code = code.replace(/ü/g, 'ue');
    }
    var countEscape1 = (code.match(/"/g) || []).length;
    var countEscape2 = (code.match(/'/g) || []).length;
    if(countEscape1%2 != 0 || countEscape2%2 != 0 || code.includes('\u005C') || code.includes('\u002F')){
        code = '';
    }

    var chosenOrderfI = '';
    if(this.getInput('listOrder')){
        chosenOrderfI = Blockly.JavaScript.variableDB_.getName(block.getFieldValue('orderfI'));
        if(chosenOrderfI == 'BLANK'){
            chosenOrderfI = '';
        }
        else{
            code = code + ' ' + chosenOrderfI;
        }
    }

    return code;
};
