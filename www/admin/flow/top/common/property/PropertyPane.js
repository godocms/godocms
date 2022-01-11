import {getI18NString} from "../i18n.js";
import Q from "../../lib/qunee-es.js";
import {createElement} from "../utils.js";
import {createCellEditor, stringToValue} from "./input.js";

let elementProperties = [{name: 'name', displayName: 'Name'}, {
    style: Q.Styles.LABEL_FONT_SIZE,
    type: 'number',
    displayName: 'Font Size'
}, {style: Q.Styles.LABEL_COLOR, type: 'color', displayName: 'Label Color'}, {
    style: Q.Styles.RENDER_COLOR,
    type: 'color',
    displayName: 'Render Color'
}, {style: Q.Styles.LABEL_POSITION, displayName: 'Label Position'}, {
    style: Q.Styles.LABEL_ANCHOR_POSITION,
    displayName: 'Label Anchor Position'
}];
let nodeProperties = [{name: 'size', type: 'size', displayName: 'Size'}, {
    name: 'location',
    type: 'point',
    displayName: 'Location'
}, {name: 'rotate', type: 'number', displayName: 'Rotate'}, {
    style: Q.Styles.BORDER,
    type: 'number',
    displayName: 'Border'
}, {
    style: Q.Styles.BORDER_COLOR,
    type: 'color',
    displayName: 'Border Color'
}];
let shapeProperties = [{
    style: Q.Styles.SHAPE_FILL_COLOR,
    type: 'color',
    displayName: 'Fill Color'
}, {
    style: Q.Styles.SHAPE_STROKE_STYLE,
    type: 'color',
    displayName: 'Stroke Color'
}, {
    style: Q.Styles.SHAPE_STROKE,
    type: 'number',
    displayName: 'Stroke'
}];
let edgeProperties = [{name: 'angle', type: 'degree', displayName: 'angle 0-360°'}, {
    style: Q.Styles.BORDER,
    display: 'none'
}, {
    style: Q.Styles.EDGE_WIDTH,
    type: 'number',
    displayName: 'Edge Width'
}, {style: Q.Styles.EDGE_COLOR, type: 'color', displayName: 'Edge Color'}, {
    style: Q.Styles.ARROW_TO,
    type: 'boolean',
    displayName: 'Arrow To'
}];
let textProperties = [{name: 'size', display: 'none'}, {
    style: Q.Styles.LABEL_SIZE,
    type: 'size',
    displayName: 'Size'
}, {
    style: Q.Styles.RENDER_COLOR,
    display: 'none'
}, {style: Q.Styles.LABEL_BACKGROUND_COLOR, type: 'color', displayName: 'Background Color'}];

//let propertiesMap = {
//    'Q.Element': {
//        class: Q.Element,
//        properties: {
//            name: {name: 'name'},
//            'S:edge.width': {name: 'edge.width', type: 'number', propertyType: 'style'},
//            'S:edge.color': {name: 'edge.color', type: 'color', propertyType: 'style'}
//        }
//    }
//};
let DEFAULT_PROPERTY_MAP = {};

let classIndex = 0;

function getClassName(clazz) {
    let name = clazz._classPath || clazz._tempName;
    if (!name) {
        name = clazz._tempName = 'class-' + classIndex++;
    }
    return name;
}

function getPropertiesByTypeFrom(clazz, create, propertyMap) {
    let name = getClassName(clazz);
    if (!create) {
        return propertyMap[name];
    }
    return propertyMap[name] = {class: clazz, properties: {}};
}

function getPropertyKey(name, propertyType) {
    if (propertyType == Q.Consts.PROPERTY_TYPE_STYLE) {
        return 'S:' + name;
    }
    if (propertyType == Q.Consts.PROPERTY_TYPE_CLIENT) {
        return 'C:' + name;
    }
    return name;
}


export function registerDefaultProperties(options) {
    registerProperties(DEFAULT_PROPERTY_MAP, options)
}

function registerProperties(propertyMap, options) {
    let clazz = options.class;
    if (!clazz) {
        throw new Error('class property can not be null');
    }
    let properties = options.properties;

    let name = getClassName(clazz);
    if (!properties) {
        delete propertyMap[name];
        return;
    }
    let property = getPropertiesByTypeFrom(clazz, true, propertyMap);

    if (name in propertyMap) {
        property = propertyMap[name];
    } else {
        property = propertyMap[name] = {className: clazz, properties: {}};
    }

    formatProperties(options, property.properties);
}

function formatProperties(options, result) {
    result = result || {};
    let properties = options.properties;
    let groupName = options.group || 'Element'
    properties.forEach(function (item) {
        let key;
        if (item.style) {
            item.propertyType = Q.Consts.PROPERTY_TYPE_STYLE;
            item.name = item.style;
        } else if (item.client) {
            item.propertyType = Q.Consts.PROPERTY_TYPE_CLIENT;
            item.name = item.client;
        } else if (item.name) {
            item.propertyType = Q.Consts.PROPERTY_TYPE_ACCESSOR;
        } else {
            return;
        }
        key = item.key = getPropertyKey(item.name, item.propertyType);
        if (!item.groupName) {
            item.groupName = groupName;
        }
        result[key] = item;
    })
    return result;
}

registerDefaultProperties({
    class: Q.Element,
    properties: elementProperties,
    group: 'Element'
})

registerDefaultProperties({
    class: Q.Node,
    properties: nodeProperties,
    group: 'Node'
})

registerDefaultProperties({
    class: Q.Edge,
    properties: edgeProperties,
    group: 'Edge'
})

registerDefaultProperties({
    class: Q.Text,
    properties: textProperties,
    group: 'Text'
})

registerDefaultProperties({
    class: Q.ShapeNode,
    properties: shapeProperties,
    group: 'Shape'
})

let groupProperties = [{name: 'minSize', type: 'size'}];
registerDefaultProperties({
    class: Q.Group,
    properties: groupProperties,
    group: 'Group'
})

function getProperties(data, properties, propertyMap) {
    if (!propertyMap) {
        propertyMap = DEFAULT_PROPERTY_MAP;
    }
    properties = properties || {};
    for (let name in propertyMap) {
        if (!(data instanceof propertyMap[name].class)) {
            continue;
        }
        let map = propertyMap[name].properties;
        for (let key in map) {
            let p = map[key];
            if (p.display == 'none') {
                delete properties[key];
            } else {
                properties[key] = p;
            }
        }
    }
    return properties;
}

class PropertyGroup {
    constructor(properties) {
        this.properties = properties;
        let groups = {};
        let length = 0;
        for (let key in properties) {
            length++;
            let groupName = properties[key].groupName;
            let group = groups[groupName];
            if (!group) {
                group = groups[groupName] = {};
            }
            group[key] = properties[key];
        }
        this.group = groups;
        this.length = length;
    }

    contains(name, propertyType) {
        let key = getPropertyKey(name, propertyType);
        return this.properties[key];
    }

    isEmpty() {
        return this.length == 0;
    }

}

function getElementProperty(graph, element, name, type) {
    if (!type || type == Q.Consts.PROPERTY_TYPE_ACCESSOR) {
        return element[name];
    }
    if (type == Q.Consts.PROPERTY_TYPE_STYLE) {
        return graph.getStyle(element, name);
    }
    if (type == Q.Consts.PROPERTY_TYPE_CLIENT) {
        return element.get(name);
    }
}

function setElementProperty(value, element, name, type) {
    if (!type || type == Q.Consts.PROPERTY_TYPE_ACCESSOR) {
        return element[name] = value;
    }
    if (type == Q.Consts.PROPERTY_TYPE_STYLE) {
        return element.setStyle(name, value);
    }
    if (type == Q.Consts.PROPERTY_TYPE_CLIENT) {
        return element.set(name, value);
    }
}

export class PropertyPane {
    constructor(graph, html) {
        this._formItems = null;
        this.adjusting = false;
        this._cellEditors = null;
        this.showDefaultProperties = true;

        this._propertyMap = {};
        this._formItems = [];
        this.html = this.container = html;
        this.dom = createElement({className: 'q-from', parent: html, tagName: 'form'});
        this.graph = graph;

        graph.dataPropertyChangeDispatcher.addListener(function (evt) {
            this.onDataPropertyChange(evt);
        }.bind(this));

        graph.selectionChangeDispatcher.addListener(function (evt) {
            if(!this.graph.editable){
                return;
            }
            this.datas = this.graph.selectionModel.toDatas();
        }.bind(this));
    }

    onValueChange(value, item) {
        this.setValue(value, item);
    }

    _containsElement(data) {
        for (let d in this.datas) {
            if (d == data) {
                return true;
            }
        }
    }

    _containsProperty(name, type) {
        return this.propertyGroup && this.propertyGroup.contains(name, type);
    }

    _getCellEditors(name, propertyType) {
        if (!this._cellEditors) {
            return;
        }
        let key = getPropertyKey(name, propertyType);
        return this._cellEditors[key];
    }

    onDataPropertyChange(evt) {
        if (this.adjusting) {
            return;
        }
        if (!this.datas || !this.datas.length) {
            return null;
        }
        let data = evt.source;
        if (!this._containsElement(data)) {
            let editors = this._getCellEditors(evt.kind, evt.propertyType);
            if (!editors) {
                return;
            }
            if (!Q.isArray(editors)) {
                editors = [editors];
            }
            editors.forEach(function (editor) {
                editor.update();
            })
        }
    }

    clear() {
        // $('.colorpicker-element').colorpicker('hide');
        this.dom.innerHTML = '';
        this._formItems = [];
        this._cellEditors = null;
        this.setVisible(false);
    }

    setVisible(visible) {
        let display = visible ? 'block' : 'none';
        if (this.container) {
            this.container.style.display = display;
        } else {
            this.dom.style.display = display;
        }
    }

    createItem(parent, property) {
        let formItem = createElement({className: 'q-from-item', parent: parent});
        createElement({
            parent: formItem,
            tagName: 'label',
            html: getI18NString(property.displayName || property.name)
        });
        // let inputDIV = createElement({parent: formItem, tagName: 'input'});

        let cellEditor = createCellEditor(property, formItem, function () {
            return this.getValue(property);
        }.bind(this), function (editor) {
            this.onValueChange(editor.value, property);
        }.bind(this));

        let key = getPropertyKey(property.name, property.propertyType);
        if (!this._cellEditors) {
            this._cellEditors = {};
        }
        let editors = this._cellEditors[key];
        if (!editors) {
            this._cellEditors[key] = [cellEditor];
        } else {
            editors.push(cellEditor);
        }
        return formItem;
    }

    setValue(value, property) {
        if (!this.datas || !this.datas.length) {
            return null;
        }
        this.adjusting = true;

        if (property.type && property.type != 'string' && Q.isString(value)) {
            value = stringToValue(value, property.type);
        }

        this.datas.forEach(function (data) {
            let old = getElementProperty(this.graph, data, property.name, property.propertyType);
            if (old === value) {
                return;
            }
            setElementProperty(value, data, property.name, property.propertyType);
        }, this)

        this.adjusting = false;
    }

    getValue(property) {
        if (!this.datas || !this.datas.length) {
            return null;
        }
        if (this.datas.length == 1) {
            return getElementProperty(this.graph, this.datas[0], property.name, property.propertyType) || '';
        }
    }

    createItemGroup(name, properties) {
        let group = createElement({className: 'class-group', parent: this.dom});
        createElement({tagName: 'h4', parent: group, html: name});
        for (let name in properties) {
            this.createItem(group, properties[name]);
        }
    }

    register(options) {
        registerProperties(this._propertyMap, options);
    }

    getCustomPropertyDefinitions(data) {
        return data.propertyDefinitions;
    }

    getProperties(data) {
        let properties = {};
        if (this.showDefaultProperties) {
            getProperties(data, properties);
        }
        if (this._propertyMap) {
            getProperties(data, properties, this._propertyMap);
        }
        let propertyDefinitions = this.getCustomPropertyDefinitions(data);
        if (propertyDefinitions) {
            let map = formatProperties(propertyDefinitions);
            for (let name in map) {
                properties[name] = map[name];
            }
        }
        return properties;
    }

    _getProperties(data) {
        let properties = this.getProperties(data);
        return new PropertyGroup(properties);
    }

    _show() {
        let datas = this.datas;
        if (!datas || !datas.length) {
            return;
        }
        this.setVisible(true);
        this.propertyGroup = this._getProperties(datas[0]);

        let group = this.propertyGroup.group;
        for (let groupName in group) {
            this.createItemGroup(groupName, group[groupName]);
        }
    }

    get datas() {
        return this._datas;
    }

    set datas(datas) {
        if (this._datas == datas) {
            return;
        }
        if (datas && !Q.isArray(datas)) {
            datas = [datas];
        }
        this.clear();
        if (!datas.length) {
            this._datas = null;
            return;
        }
        this._datas = datas;
        if (datas.length == 1) {
            // getPropertyInfoFromServer(datas[0], this._show.bind(this))
            this._show();
        }
    }
}