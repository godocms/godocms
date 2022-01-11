'use strict';

goog.provide('Blockly.FieldTextbutton');

goog.require('Blockly.Field');


Blockly.FieldTextbutton = function (buttontext, changeHandler) {
    Blockly.FieldTextbutton.superClass_.constructor.call(this, '');

    this.buttontext_ = buttontext;
    this.changeHandler_ = changeHandler;
    //this.setText(buttontext);
    this.text_ = buttontext;
};
Blockly.utils.object.inherits(Blockly.FieldTextbutton, Blockly.Field);


Blockly.FieldTextbutton.prototype.clone = function () {
    return new Blockly.FieldTextbutton(this.buttontext_, this.changeHandler_);
};


Blockly.FieldTextbutton.prototype.CURSOR = 'default';


Blockly.FieldTextbutton.prototype.showEditor_ = function () {
    if (this.changeHandler_) {
        this.changeHandler_();
    }
};


/*

//    An example of how to use FieldTextbutton: implementation of a simple register with limiters linked to "-" and "+" buttons

Blockly.Block.appendMinusPlusCounter = function(block, name, startValue, lowerLimit, upperLimit) {
    block.appendDummyInput(name+'_input')
        .appendField(name+':', name+'_label')
        .appendField(String(startValue || '0'), name)
        .appendField(new Blockly.FieldTextbutton('–', function() { var counter_=parseInt(this.sourceBlock_.getFieldValue(name))-1; if((lowerLimit===undefined) || counter_>=lowerLimit) { this.sourceBlock_.setFieldValue(String(counter_), name); } }), name+'_minus')
        .appendField(new Blockly.FieldTextbutton('+', function() { var counter_=parseInt(this.sourceBlock_.getFieldValue(name))+1; if((upperLimit===undefined) || counter_<=upperLimit) { this.sourceBlock_.setFieldValue(String(counter_), name); } }), name+'_plus');
}

//  A usage example of the above. You can add two independent MinusPlusCounters to a block by saying:

    Blockly.Block.appendMinusPlusCounter(this, 'age', 0, 0 );
    Blockly.Block.appendMinusPlusCounter(this, 'temperature', 37, 34, 42 );

*/

var original_onMouseUp_ = Blockly.Block.prototype.onMouseUp_;

Blockly.Block.prototype.onMouseUp_ = function (e) {
    original_onMouseUp_.call(this, e);

    if (Blockly.selected) {
        var rootBlock = Blockly.selected.getRootBlock();

        var isDisabled = (rootBlock.type != 'start');

        var descendants = Blockly.selected.getDescendants();
        for (var i in descendants) {
            descendants[i].setDisabled(isDisabled);
        }
    }
};


Blockly.FieldDropdown.prototype.setValue = function (newValue) {      // Allow the label on the closed menu to differ from values of the open menu
    this.value_ = newValue;
    // Look up and display the human-readable text.
    var options = this.getOptions();
    for (var x = 0; x < options.length; x++) {
        // Options are tuples of human-readable text and language-neutral values.
        if (options[x][1] == newValue) {
            var shortValue = options[x][2] || options[x][0];
            //this.setText(shortValue);
            this.text_ = shortValue;
            return;
        }
    }
};


Blockly.Input.prototype.appendSelector = function (allowedBlocks, presenceLabel, absenceLabel) {

    var presenceLabel = presenceLabel || this.name;
    var absenceLabel = absenceLabel || 'no ' + this.name;
    var ddl_name = 'ddl_' + this.name;

    var dd_list = [
        [absenceLabel, ':REMOVE', absenceLabel]
    ];
    if (allowedBlocks.length == 1) {
        dd_list.push([presenceLabel + ': ', allowedBlocks[0], presenceLabel]);
    } else {
        for (var i = 0; i < allowedBlocks.length; i++) {
            dd_list.push([allowedBlocks[i], allowedBlocks[i], presenceLabel]);
        }
    }

    var this_input = this;

    this//.setCheck(allowedBlocks)  // FIXME: we'll need to re-establish the connection rules somehow!
        .setAlign(this.type == Blockly.INPUT_VALUE ? Blockly.ALIGN_RIGHT : Blockly.ALIGN_LEFT)
        .appendField(new Blockly.FieldDropdown(dd_list, function (targetType) {

            return this.sourceBlock_.toggleTargetBlock(this_input, targetType);
        }
        ), ddl_name);

    return this;
};


Blockly.Block.prototype.toggleTargetBlock = function (input, targetType) {     // universal version: can create any type of targetBlocks

    var targetBlock = input ? this.getInputTargetBlock(input.name) : this.getNextBlock();              // named input or next
    if (targetType == ':REMOVE') {
        if (targetBlock) {
            targetBlock.dispose(true, true);    // or targetBlock.unplug(...)
        }
    } else {
        if (targetBlock) {   // Don't remove it, but return the "override" value to make sure the DDL is up to date:
            return targetBlock.type;
        } else {            // add a new kind of block:
            targetBlock = Blockly.Block.obtain(Blockly.getMainWorkspace(), targetType);
            targetBlock.initSvg();
            targetBlock.render();

            var parentConnection = input ? this.getInput(input.name).connection : this.nextConnection;     // named input or next
            var childConnection = targetBlock.outputConnection || targetBlock.previousConnection;          // vertical or horizontal
            parentConnection.connect(childConnection);
        }
    }
};


// A very useful mapping from connection back to input
Blockly.Connection.prototype.getInput = function () {
    var inputList = this.sourceBlock_.inputList;

    for (var i in inputList) {
        var connection = inputList[i].connection;
        if (connection == this) {
            return inputList[i];
        }
    }
};


// If there is a ddl linked with the input, update its label to the type of the block plugged in:
Blockly.Input.prototype.updateLinkedDDL = function () {

    var ddl_name = 'ddl_' + this.name;
    var ddl_field = this.sourceBlock_.getField_(ddl_name);
    if (ddl_field) {
        var targetBlock = this.connection.targetBlock();
        var type = targetBlock ? targetBlock.type : ':REMOVE';
        ddl_field.setValue(type);
    }
}


// Update the DDL on connect() :
var original_connect = Blockly.Connection.prototype.connect;

Blockly.Connection.prototype.connect = function (otherConnection) {

    original_connect.call(this, otherConnection);

    var parentConnection = this.isSuperior() ? this : otherConnection;  // since connect() is symmetrical we never know which way it is called

    parentConnection.getInput().updateLinkedDDL();
};


// Update the DDL on disconnect() :
var original_disconnect = Blockly.Connection.prototype.disconnect;

Blockly.Connection.prototype.disconnect = function () {

    var parentConnection = this.isSuperior() ? this : this.targetConnection;  // since disconnect() is symmetrical we never know which way it is called

    original_disconnect.call(this);

    parentConnection.getInput().updateLinkedDDL();
};




Blockly.selectionArrow = function () { return Blockly.RTL ? "←" : "→"; };
Blockly.keyValueArrow = function () { return Blockly.RTL ? "⇐" : "⇒"; };


Blockly.Blocks['start'] = {
    init: function () {
        this.setColour(250);
        this.appendDummyInput()
            .setAlign(Blockly.ALIGN_CENTRE)
            .appendField("JSON structure");

        this.appendValueInput('json')
            .appendSelector(['dictionary', 'array', 'string', 'number', 'true', 'false'], Blockly.selectionArrow(), 'null');

        this.setDeletable(false);
    }
};


Blockly.Blocks['true'] = {
    init: function () {
        this.setColour(20);
        this.setOutput(true, ["element"]);

        this.appendDummyInput()
            .setAlign(Blockly.ALIGN_CENTRE)
            .appendField('true');
    }
};


Blockly.Blocks['false'] = {
    init: function () {
        this.setColour(20);
        this.setOutput(true, ["element"]);

        this.appendDummyInput()
            .setAlign(Blockly.ALIGN_CENTRE)
            .appendField('false');
    }
};


Blockly.Blocks['string'] = {
    init: function () {
        this.setColour(190);
        this.setOutput(true, ["element"]);

        this.appendDummyInput()
            .setAlign(Blockly.ALIGN_CENTRE)
            .appendField('"')
            .appendField(new Blockly.FieldTextInput(''), 'string_value')
            .appendField('"');
    }
};


Blockly.Blocks['number'] = {
    init: function () {
        this.setColour(210);
        this.setOutput(true, ["element"]);

        this.appendDummyInput()
            .setAlign(Blockly.ALIGN_CENTRE)
            .appendField('№')
            .appendField(new Blockly.FieldTextInput('0', Blockly.FieldTextInput.numberValidator), "number_value");
    }
};


Blockly.Blocks['dictionary'] = {
    length: 0,
    init: function () {
        this.setColour(120);
        this.setOutput(true, ["element"]);

        this.appendDummyInput('open_bracket')
            .appendField(" { ")
            .appendField(new Blockly.FieldTextbutton('+', function () { this.sourceBlock_.appendKeyValuePairInput(); }));

        this.appendDummyInput('close_bracket')
            .appendField(" } ");

        this.setInputsInline(false);
    },

    appendKeyValuePairInput: function () {

        var lastIndex = this.length++;

        var appended_input = this.appendValueInput('element_' + lastIndex);
        appended_input.appendField(new Blockly.FieldTextbutton('–', function () { this.sourceBlock_.deleteKeyValuePairInput(appended_input); }))
            .appendField(new Blockly.FieldTextInput('key_' + lastIndex), 'key_field_' + lastIndex)
            .appendField(Blockly.keyValueArrow())
            .appendSelector(['string', 'number', 'true', 'false', 'dictionary', 'array'], Blockly.selectionArrow(), 'null');

        this.moveInputBefore('element_' + lastIndex, 'close_bracket');

        return appended_input;
    },

    deleteKeyValuePairInput: function (inputToDelete) {

        var inputNameToDelete = inputToDelete.name;

        var substructure = this.getInputTargetBlock(inputNameToDelete);
        if (substructure) {
            substructure.dispose(true, true);
        }
        this.removeInput(inputNameToDelete);

        var inputIndexToDelete = parseInt(inputToDelete.name.match(/\d+/)[0]);

        var lastIndex = --this.length;

        for (var i = inputIndexToDelete + 1; i <= lastIndex; i++) { // rename all the subsequent element-inputs
            var input = this.getInput('element_' + i);
            input.name = 'element_' + (i - 1);

            var key_field = this.getField_('key_field_' + i);
            key_field.name = 'key_field_' + (i - 1);
        }
    }
};


Blockly.Blocks['array'] = {
    length: 0,
    init: function () {
        this.setColour(350);
        this.setOutput(true, ["element"]);

        this.appendDummyInput('open_bracket')
            .appendField(" [ ")
            .appendField(new Blockly.FieldTextbutton('+', function () { this.sourceBlock_.appendArrayElementInput(); }));

        this.appendDummyInput('close_bracket')
            .appendField(" ] ");

        this.setInputsInline(false);
    },

    appendArrayElementInput: function () {

        var lastIndex = this.length++;

        var appended_input = this.appendValueInput('element_' + lastIndex);
        appended_input.appendField(new Blockly.FieldTextbutton('–', function () { this.sourceBlock_.deleteArrayElementInput(appended_input); }))
            .appendSelector(['string', 'number', 'true', 'false', 'dictionary', 'array'], Blockly.selectionArrow(), 'null');

        this.moveInputBefore('element_' + lastIndex, 'close_bracket');

        return appended_input;
    },

    deleteArrayElementInput: function (inputToDelete) {

        var inputNameToDelete = inputToDelete.name;

        var substructure = this.getInputTargetBlock(inputNameToDelete);
        if (substructure) {
            substructure.dispose(true, true);
        }
        this.removeInput(inputNameToDelete);

        var inputIndexToDelete = parseInt(inputToDelete.name.match(/\d+/)[0]);

        var lastIndex = --this.length;

        for (var i = inputIndexToDelete + 1; i <= lastIndex; i++) { // rename all the subsequent element-inputs
            var input = this.getInput('element_' + i);

            input.name = 'element_' + (i - 1);
        }
    }
};


Blockly.JSON = new Blockly.Generator('JSON');


Blockly.JavaScript.fromWorkspace = function (workspace) {

    var json_text = '';

    var top_blocks = workspace.getTopBlocks(false);
    for (var i in top_blocks) {
        var top_block = top_blocks[i];

        if (top_block.type == 'start') {
            var json_structure = this.generalBlockToObj(top_block);

            json_text += JSON.stringify(json_structure, null, 4) + '\n\n';
        }
    }

    return json_text;
};


Blockly.JavaScript.generalBlockToObj = function (block) {

    if (block) {

        // dispatcher:
        var func = this[block.type];
        if (func) {
            return func.call(this, block);
        } else {
            console.log("Don't know how to generate JSON code for a '" + block.type + "'");
        }
    } else {
        return null;
    }
};


Blockly.JavaScript['start'] = function (block) {

    var json = this.generalBlockToObj(block.getInputTargetBlock('json'));

    return json;
};

Blockly.JavaScript['true'] = function (block) {
    return true;
};


Blockly.JavaScript['false'] = function (block) {
    return false;
};


Blockly.JavaScript['string'] = function (block) {
    var string_value = block.getFieldValue('string_value');

    return string_value;
};


Blockly.JavaScript['number'] = function (block) {
    var number_value = Number(block.getFieldValue('number_value'));

    return number_value;
};


Blockly.JavaScript['dictionary'] = function (block) {

    var dictionary = {};

    for (var i = 0; i < block.length; i++) {
        var pair_key = block.getFieldValue('key_field_' + i);
        var pair_value = this.generalBlockToObj(block.getInputTargetBlock('element_' + i));

        dictionary[pair_key] = pair_value;
    }

    return dictionary;
};


Blockly.JavaScript['array'] = function (block) {

    var array = [];

    for (var i = 0; i < block.length; i++) {
        var element_value = this.generalBlockToObj(block.getInputTargetBlock('element_' + i));

        array[i] = element_value;
    }

    return array;
};


Blockly.JavaScript.toWorkspace = function (json_text, workspace) {

    var json_structure = JSON.parse(json_text);

    workspace.clear();

    var startBlock = Blockly.Block.obtain(workspace, 'start');
    startBlock.initSvg();
    startBlock.render();
    Blockly.JSON.buildAndConnect(json_structure, startBlock.getInput('json').connection);
};


Blockly.JavaScript.buildAndConnect = function (json_structure, parentConnection) {
    if (json_structure === null) {
        return;
    } else {
        var type = typeof (json_structure);
        if (type == 'boolean') {
            type = String(Boolean(json_structure));
        } else if (type == 'object') {
            type = (json_structure instanceof Array) ? 'array' : 'dictionary';
        }

        var targetBlock = Blockly.Block.obtain(parentConnection.sourceBlock_.workspace, type);
        targetBlock.initSvg();
        targetBlock.render();

        var childConnection = targetBlock.outputConnection;
        parentConnection.connect(childConnection);

        switch (type) {
            case 'string':
                targetBlock.setFieldValue(String(json_structure), 'string_value');
                break;
            case 'number':
                targetBlock.setFieldValue(String(json_structure), 'number_value');
                break;
            case 'dictionary':
                var i = 0;
                for (var key in json_structure) {
                    targetBlock.appendKeyValuePairInput();
                    targetBlock.setFieldValue(key, 'key_field_' + i);

                    var elementConnection = targetBlock.getInput('element_' + i).connection;
                    Blockly.JSON.buildAndConnect(json_structure[key], elementConnection);

                    i++;
                }
                break;
            case 'array':
                for (var i in json_structure) {
                    targetBlock.appendArrayElementInput();

                    var elementConnection = targetBlock.getInput('element_' + i).connection;
                    Blockly.JSON.buildAndConnect(json_structure[i], elementConnection);
                }
                break;
        }
    }
};

