import {createElement} from "../utils.js";
import {createColorInput} from "../color-picker/ColorPicker.js";
import Q from "../../lib/qunee-es.js";

class StringEditor {
    constructor(property, parent, getter, setter, scope) {
        this.getter = getter;
        this.setter = setter;
        this.scope = scope;
        this.property = property;

        this.createHtml(parent);
    }

    _getValue() {
        return this.getter.call(this.scope);
    }

    update() {
        this.value = this._getValue();
    }

    setValue(v) {
        this.input.value = valueToString(v, this.property.type);
    }

    getValue() {
        return stringToValue(this.input.value, this.property.type);
    }

    createHtml(parent) {
        let input;
        let property = this.property;
        if (Array.isArray(property.options)) {
            input = createElement({
                tagName: 'select',
                className: "form-control",
                parent: parent
            });

            property.options.forEach(function (item, i) {
                let option = document.createElement('option');
                option.value = item;
                option.innerText = item;
                input.appendChild(option);
            })
        } else {
            input = createElement({
                tagName: 'input',
                className: "form-control",
                parent: parent
            });
        }

        this.input = input;

        if (property.readonly) {
            input.setAttribute('readonly', 'readonly');
        }
        this.update();

        input.oninput = function (evt) {
            if (this.ajdusting) {
                return;
            }
            this.setter.call(this.scope, this);
        }.bind(this);
    }
}

Object.defineProperties(StringEditor.prototype, {
    value: {
        get() {
            return this.getValue();
        },
        set(v) {
            this.ajdusting = true;
            this.setValue(v);
            this.ajdusting = false;
        }
    }
})

class BooleanEditor extends StringEditor {
    setValue(v) {
        if (v) {
            this.input.setAttribute('checked', 'checked')
        } else {
            this.input.removeAttribute('checked')
        }
        // this.input.setAttribute('checked', v ? 'checked' : false);
    }

    getValue() {
        return stringToValue(this.input.checked, this.property.type);
    }

    createHtml(parent) {
        let property = this.property;
        let input = createElement({
            tagName: 'input',
            parent: parent
        });
        input.setAttribute('type', 'checkbox');
        this.input = input;

        if (property.readonly) {
            input.setAttribute('readonly', 'readonly');
        }
        this.update();
        input.onclick = function (evt) {
            if (this.ajdusting) {
                return;
            }
            this.setter.call(this.scope, this);
        }.bind(this)
    }
}

class ColorEditor extends StringEditor {
    createHtml (parent) {
        let colorInput = this.colorInput = createColorInput({
            onchange: function(color) {
                this.value = color;
            }.bind(this)
        })
        parent.appendChild(colorInput.dom);
        this.input = colorInput.input;

        this.update();
    }

    setValue(v) {
        this.input.value = valueToString(v, this.property.type);
        this.setter.call(this.scope, this);
    }

    getValue() {
        return stringToValue(this.input.value, this.property.type);
    }
}


function numberToString(number) {
    return number | 0;
    //return number.toFixed(2);
}

function valueToString(value, type) {
    if (!value) {
        return value;
    }
    if (type == 'point') {
        return numberToString(value.x) + ',' + numberToString(value.y);
    }
    if (type == 'size') {
        return numberToString(value.width) + ',' + numberToString(value.height);
    }
    if (type == 'degree') {
        return '' + (value * 180 / Math.PI) | 0;
    }
    return value.toString();
}

let positions = {};
for (let name in Q.Position) {
    let p = Q.Position[name];
    if (name == "random" || !(p instanceof Q.Position)) {
        continue;
    }
    positions[p.toString()] = p;
}

export function stringToValue(string, type) {
    // if (type == 'color' && $.colorpicker && $.colorpicker.Color) {
    //     return new $.colorpicker.Color(string, null, null, "hex", true).toString()
    // }
    if (type == 'position') {
        return positions[string];
    }
    if (type == 'number') {
        return parseFloat(string) || 0;
    }
    if (type == 'boolean') {
        return string ? true : false;
    }
    if (type == 'point') {
        let xy = string.split(',');
        if (xy.length == 2) {
            return {x: parseFloat(xy[0] || 0), y: parseFloat(xy[1]) || 0};
        }
        return;
    }
    if (type == 'size') {
        let xy = string.split(',');
        if (xy.length == 2) {
            let w = parseFloat(xy[0]) || 0;
            let h = parseFloat(xy[1]) || 0;
            if (w && h) {
                return {width: w, height: h};
            }
        }
        return;
    }
    if (type == 'degree') {
        return parseInt(string) * Math.PI / 180
    }
    return string;
}

export function createCellEditor(item, parent, getter, setter, scope) {
    let type = item.type;
    if (type == 'color') {
        return new ColorEditor(item, parent, getter, setter, scope);
    }
    if (type == 'boolean') {
        return new BooleanEditor(item, parent, getter, setter, scope);
    }
    return new StringEditor(item, parent, getter, setter, scope);
}