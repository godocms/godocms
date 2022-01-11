
Blockly.Blocks['controls_switch'] = {
    init: function () {
        this.setColour(120);
        this.appendValueInput('SWITCH')
            .appendField(Blockly.Msg.CONTROLS_SWITCH);
        this.appendValueInput('CASE0')
            .setCheck(null)
            .appendField(Blockly.Msg.CONTROLS_SWITCH_CASE);
        this.appendStatementInput('DO0')
            .appendField(Blockly.Msg.CONTROLS_SWITCH_DO);
        this.setPreviousStatement(true);
        this.setNextStatement(true);
        this.setMutator(new Blockly.Mutator(['controls_switch_case', 'controls_switch_default']));
        // Assign 'this' to a variable for use in the tooltip closure below.
        var thisBlock = this;
        this.setTooltip(function () {
            if (!thisBlock.caseCount_ && !thisBlock.defaultCount_) {
                return Blockly.Msg.CONTROLS_SWITCH_TOOLTIP_1;
            } else if (!thisBlock.caseCount_ && thisBlock.defaultCount_) {
                return Blockly.Msg.CONTROLS_SWITCH_TOOLTIP_2;
            } else if (thisBlock.caseCount_ && !thisBlock.defaultCount_) {
                return Blockly.Msg.CONTROLS_SWITCH_TOOLTIP_3;
            } else if (thisBlock.caseCount_ && thisBlock.defaultCount_) {
                return Blockly.Msg.CONTROLS_SWITCH_TOOLTIP_4;
            }
            return '';
        });
        this.caseCount_ = 0;
        this.defaultCount_ = 0;
    },
    /**
     * Create XML to represent the number of else-if and else inputs.
     * @return {Element} XML storage element.
     * @this Blockly.Block
     */
    mutationToDom: function () {
        if (!this.caseCount_ && !this.defaultCount_) {
            return null;
        }
        var container = document.createElement('mutation');
        if (this.caseCount_) {
            container.setAttribute('case', this.caseCount_);
        }
        if (this.defaultCount_) {
            container.setAttribute('default', 1);
        }

        return container;
    },
    /**
     * Parse XML to restore the else-if and else inputs.
     * @param {!Element} xmlElement XML storage element.
     * @this Blockly.Block
     */
    domToMutation: function (xmlElement) {
        this.caseCount_ = parseInt(xmlElement.getAttribute('case'), 10) || 0;
        this.defaultCount_ = parseInt(xmlElement.getAttribute('default'), 10) || 0;
        this.updateShape_();
    },
    /**
     * Populate the mutator's dialog with this block's components.
     * @param {!Blockly.Workspace} workspace Mutator's workspace.
     * @return {!Blockly.Block} Root block in mutator.
     * @this Blockly.Block
     */
    decompose: function (workspace) {
        var containerBlock = workspace.newBlock('controls_switch_switch');
        containerBlock.initSvg();
        var connection = containerBlock.nextConnection;
        for (var x = 1; x <= this.caseCount_; x++) {
            var caseBlock = workspace.newBlock('controls_switch_case');
            caseBlock.initSvg();
            connection.connect(caseBlock.previousConnection);
            connection = caseBlock.nextConnection;
        }
        if (this.defaultCount_) {
            var defaultBlock = workspace.newBlock('controls_switch_default');
            defaultBlock.initSvg();
            connection.connect(defaultBlock.previousConnection);
        }
        return containerBlock;
    },
    /**
     * Reconfigure this block based on the mutator dialog's components.
     * @param {!Blockly.Block} containerBlock Root block in mutator.
     * @this Blockly.Block
     */
    compose: function (containerBlock) {
        var clauseBlock = containerBlock.nextConnection.targetBlock();
        // Count number of inputs.
        this.caseCount_ = 0;
        this.defaultCount_ = 0;
        var valueConnections = [null];
        var statementConnections = [null];
        var defaultStatementConnection = null;
        while (clauseBlock) {
            switch (clauseBlock.type) {
                case 'controls_switch_case':
                    this.caseCount_++;
                    valueConnections.push(clauseBlock.valueConnection_);
                    statementConnections.push(clauseBlock.statementConnection_);
                    break;
                case 'controls_switch_default':
                    this.defaultCount_++;
                    defaultStatementConnection = clauseBlock.statementConnection_;
                    break;
                default:
                    throw 'Unknown block type.';
            }
            clauseBlock = clauseBlock.nextConnection &&
                clauseBlock.nextConnection.targetBlock();
        }
        this.updateShape_();
        // Reconnect any child blocks.
        for (var i = 1; i <= this.caseCount_; i++) {
            Blockly.Mutator.reconnect(valueConnections[i], this, 'CASE' + i);
            Blockly.Mutator.reconnect(statementConnections[i], this, 'DO' + i);
        }
        Blockly.Mutator.reconnect(defaultStatementConnection, this, 'DEFAULT');
    },
    /**
     * Store pointers to any connected child blocks.
     * @param {!Blockly.Block} containerBlock Root block in mutator.
     * @this Blockly.Block
     */
    saveConnections: function (containerBlock) {
        var clauseBlock = containerBlock.getInputTargetBlock('STACK');
        var i = 1;
        while (clauseBlock) {
            switch (clauseBlock.type) {
                case 'controls_switch_case':
                    var inputCase = this.getInput('CASE' + i);
                    var inputDo = this.getInput('DO' + i);
                    clauseBlock.valueConnection_ =
                        inputCase && inputCase.connection.targetConnection;
                    clauseBlock.statementConnection_ =
                        inputDo && inputDo.connection.targetConnection;
                    x++;
                    break;
                case 'controls_switch_default':
                    var inputDo = this.getInput('DEFAULT');
                    clauseBlock.statementConnection_ =
                        inputDo && inputDo.connection.targetConnection;
                    break;
                default:
                    throw 'Unknown block type.';
            }
            clauseBlock = clauseBlock.nextConnection &&
                clauseBlock.nextConnection.targetBlock();
        }
    },
    //when the block is changed,
    /**
     * Modify this block to have the correct number of inputs.
     * @private
     * @this Blockly.Block
     */
    updateShape_: function () {
        // Delete everything.
        if (this.getInput('DEFAULT')) {
            this.removeInput('DEFAULT');
            this.removeInput('DEFAULTDO');
        }
        var i = 1;
        while (this.getInput('CASE' + i)) {
            this.removeInput('CASE' + i);
            this.removeInput('DO' + i);
            i++;
        }
        // Rebuild block.
        for (var i = 1; i <= this.caseCount_; i++) {
            this.appendValueInput('CASE' + i)
                .setCheck(null)
                .appendField(Blockly.Msg.CONTROLS_SWITCH_CASE);
            this.appendStatementInput('DO' + i)
                .appendField(Blockly.Msg.CONTROLS_SWITCH_DO);
        }
        if (this.defaultCount_) {
            this.appendStatementInput('DEFAULT')
                .appendField(Blockly.Msg.CONTROLS_SWITCH_DEFAULT);
            this.appendDummyInput('DEFAULTDO')
                .appendField(Blockly.Msg.CONTROLS_SWITCH_DO);
        }
    }
};

Blockly.Blocks['controls_switch_switch'] = {
    init: function () {
        this.setColour(120);
        this.appendDummyInput()
            .appendField(Blockly.Msg.CONTROLS_SWITCH);
        this.setPreviousStatement(true);
        this.setNextStatement(true);
        this.setTooltip(Blockly.Msg.CONTROLS_SWITCH_CASE_TOOLTIP);
        this.contextMenu = false;
    }
};

Blockly.Blocks['controls_switch_case'] = {
    init: function () {
        this.setColour(120);
        this.appendDummyInput()
            .appendField(Blockly.Msg.CONTROLS_SWITCH_CASE);
        this.setPreviousStatement(true);
        this.setNextStatement(true);
        this.setTooltip(Blockly.Msg.CONTROLS_SWITCH_CASE_TOOLTIP);
        this.contextMenu = false;
    }
};

Blockly.Blocks['controls_switch_default'] = {
    init: function () {
        this.setColour(120);
        this.appendDummyInput()
            .appendField(Blockly.Msg.CONTROLS_SWITCH_DEFAULT);
        this.setPreviousStatement(true);
        this.setTooltip(Blockly.Msg.CONTROLS_SWITCH_DEFAULT_TOOLTIP);
        this.contextMenu = false;
    }
};

Blockly.Blocks['controls_switch_break'] = {
    /**
     * Block for break in the switch block.
     * @this Blockly.Block
     */
    init: function () {
        this.setColour(120);
        this.appendDummyInput()
            .appendField(Blockly.Msg.CONTROLS_SWITCH_BREAK);
        this.setPreviousStatement(true);
        this.setTooltip(Blockly.Msg.CONTROLS_SWITCH_BREAK_TOOLTIP);
    },
    /**
     * Called whenever anything on the workspace changes.
     * Add warning if this flow block is not nested inside a loop.
     * @this Blockly.Block
     */
    onchange: function () {
        if (!this.workspace) {
            // Block has been deleted.
            return;
        }
        var legal = false;
        // Is the block nested in a control statement?
        var block = this;
        do {
            if (block.type == 'controls_switch') {
                legal = true;
                break;
            }
            block = block.getSurroundParent();
        } while (block);
        if (legal) {
            this.setWarningText(null);
        } else {
            this.setWarningText(Blockly.Msg.CONTROLS_SWITCH_BREAK_WARNING);
        }
    }
};

Blockly.JavaScript['controls_switch'] = function (block) {
    var n = 0;
    var condition = Blockly.JavaScript.valueToCode(block, 'SWITCH', Blockly.JavaScript.ORDER_NONE) || '0';
    var argument = Blockly.JavaScript.valueToCode(block, 'CASE' + n,
        Blockly.JavaScript.ORDER_NONE) || n;
    var branch = Blockly.JavaScript.statementToCode(block, 'DO' + n);
    var code = 'switch (' + condition + ') {\n  case ' + argument + ' : \n    ' + branch + '\n    break;';
    for (n = 1; n <= block.caseCount_; n++) {
        argument = Blockly.JavaScript.valueToCode(block, 'CASE' + n,
            Blockly.JavaScript.ORDER_NONE) || n;
        branch = Blockly.JavaScript.statementToCode(block, 'DO' + n);
        code += '\n  case ' + argument + ' : ' + '\n    ' + branch + '\n    break;';
    }
    if (block.defaultCount_) {
        branch = Blockly.JavaScript.statementToCode(block, 'DEFAULT');
        code += '\n  default :\n    ' + branch + '\n    break;';
    }
    code += '\n}';
    return code + '\n';
};

Blockly.JavaScript['controls_switch_break'] = function (block) {
    return 'break;\n';
};