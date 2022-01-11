import {getI18NString} from "../i18n.js";
import {showExportPanel} from "./Exportpane.js";
import {isBlobSupported, readTextFile, saveAs} from "../FileSupport.js";
import {exportJSON, parseJSON} from "../io/JSONSerializer.js";

function createDivByClassName(className) {
    let div = document.createElement('div');
    div.className = className;
    return div;
}

export function createButton(info, toolbar) {
    if (info.type == "search") {
        let div = createDivByClassName("Q-Search");
        div.innerHTML = '<div class="input-group input-group-sm" >\
            <input type="text" class="form-control" placeholder="' + (info.placeholder || '') + '">\
                <span class="input-group-btn">\
                    <div class="btn" type="button"></div>\
                </span>\
            </div>';
        let input = div.getElementsByTagName("input")[0];
        if (info.id) {
            input.id = info.id;
        }
        let button = div.querySelectorAll('.btn')[0];

        if (info.iconClass) {
            button.appendChild(createDivByClassName(info.iconClass));
        } else if (info.name) {
            button.appendChild(document.createTextNode(" " + info.name));
        }
        info.input = input;
        if (info.search) {
            let clear = function () {
                info.searchInfo = null;
            }
            let doSearch = function (prov) {
                let value = input.value;
                if (!value) {
                    clear();
                    return;
                }
                if (!info.searchInfo || info.searchInfo.value != value) {
                    let result = info.search.call(this, value, info);
                    if (!result || !result.length) {
                        clear();
                        return;
                    }
                    info.searchInfo = {value: value, result: result};
                }
                doNext(prov);
            }.bind(toolbar)
            let doNext = function (prov) {
                if (!(info.select instanceof Function) || !info.searchInfo || !info.searchInfo.result || !info.searchInfo.result.length) {
                    return;
                }
                let searchInfo = info.searchInfo;
                let result = info.searchInfo.result;
                if (result.length == 1) {
                    info.select(result[0], 0);
                    return;
                }
                if (searchInfo.index === undefined) {
                    searchInfo.index = 0;
                } else {
                    searchInfo.index += prov ? -1 : 1;
                    if (searchInfo.index < 0) {
                        searchInfo.index += result.length;
                    }
                    searchInfo.index %= result.length;
                }
                if (info.select.call(this, result[searchInfo.index], searchInfo.index) === false) {
                    info.searchInfo = null;
                    doSearch();
                }
            }.bind(toolbar)

            if (info.oninput) {
                input.oninput = function (evt) {
                    info.oninput.call(toolbar, evt, info);
                }
            }
            input.onkeydown = function (evt) {
                if (evt.key === 'Escape' && input.value) {
                    clear();
                    input.value = "";
                    evt.preventDefault();
                    return;
                }
                if (evt.key === 'Enter') {
                    doSearch(evt.shiftKey);
                }
            }.bind(toolbar)
            button.onclick = doSearch;
        }
        return div;
    }
    if (info.type == 'file') {
        let label = document.createElement('span');
        let input = document.createElement('input');
        label.className = 'file-input btn btn-file';
        input.setAttribute('type', 'file');
        input.className = 'btn-file';
        if (info.action) {
            input.onchange = function (evt) {
                let input = evt.currentTarget;
                let files = input.files;
                label = input.value.replace(/\\/g, '/').replace(/.*\//, '');
                if (files.length) {
                    info.action.call(toolbar, files, label, evt);
                }
                input.value = null;
            };
        }
        label.appendChild(input);

        if (info.icon) {
            let icon = document.createElement('img');
            icon.src = info.icon;
            label.appendChild(icon);
        } else if (info.iconClass) {
            label.appendChild(createDivByClassName(info.iconClass));
        } else if (info.name) {
            label.appendChild(document.createTextNode(" " + info.name));
        }
        if (info.name) {
            label.setAttribute("title", info.name);
        }
        return label;
    }
    if (info.type == "input") {
        let div = document.createElement("div");
        div.style.display = "inline-block";
        div.style.verticalAlign = "middle";
        div.innerHTML = '<div class="input-group input-group-sm" style="width: 150px;">\
            <input type="text" class="form-control">\
                <span class="input-group-btn">\
                    <button class="btn" type="button"></button>\
                </span>\
            </div>';
        let input = div.getElementsByTagName("input")[0];
        let button = div.getElementsByTagName("button")[0];
        button.innerHTML = info.name;
        info.input = input;
        if (info.action) {
            button.onclick = function (evt) {
                info.action.call(toolbar, evt, info);
            }
        }
        return div;
    } else if (info.type == "select") {
        let div = document.createElement("select");
        div.className = "form-control";
        let options = info.options;
        options.forEach(function (v) {
            let option = document.createElement("option");
            option.innerHTML = v;
            option.value = v;
            div.appendChild(option);
        });
        div.value = info.value;
        if (info.action) {
            div.onValueChange = function (evt) {
                info.action.call(toolbar, evt, info);
            }
        }
        return div;
    }
    let label, button;
    if (!info.type) {
        label = document.createElement("div");
    } else {
        label = document.createElement("label");
        button = document.createElement("input");
        info.input = button;
        info.checked && (button.checked = info.checked);
        button.setAttribute('type', info.type);
        label.appendChild(button);
        if (info.selected) {
            button.setAttribute('checked', 'checked');
            if (info.type == 'radio') {
                label.className += "active";
            }
        }
    }
    label.className += "btn";
    if (info.icon) {
        let icon = document.createElement('img');
        icon.src = info.icon;
        label.appendChild(icon);
    } else if (info.iconClass) {
        label.appendChild(createDivByClassName(info.iconClass));
    } else if (info.name) {
        label.appendChild(document.createTextNode(" " + info.name));
    }
    if (info.name) {
        label.setAttribute("title", info.name);
    }
    (button || label).onclick = info.action ? function (evt) {
        info.action.call(toolbar, evt, info);
    } : function (evt) {
        toolbar && toolbar.onclick && toolbar.onclick(evt, info);
    };
    if (info.selected) {
        label.classList.add('active');
    }
    return label;
}

function createBtnGroup(dom) {
    if (!dom) {
        dom = document.createElement("div");
    }
    dom.classList.add('btn-group');
    return dom;
}

export function createButtonGroup(buttons, scope, dom) {
    dom = createBtnGroup(dom);
    buttons.forEach(function (info) {
        let button = createButton(info, scope);
        if (button) {
            button.info = info;
            dom.appendChild(button);
        }
    })
    return dom;
}

function createButtons(buttonGroup, parent, scope, map = {}) {
    function getGroup(name) {
        let buttonGroup = map[name];
        if (!buttonGroup) {
            buttonGroup = createBtnGroup();
            buttonGroup.name = name;
            parent.appendChild(buttonGroup);
            map[name] = buttonGroup;
        }
        return buttonGroup;
    }

    forEachButton(buttonGroup, function (item, groupName) {
        let dom = createButton(item, scope);
        dom.info = item;
        if (!groupName) {
            parent.appendChild(dom);
        } else {
            let group = getGroup(groupName);
            group.appendChild(dom);
        }
    })
    return map;
}

function forEachButton(buttonGroup, call) {
    for (let name in buttonGroup) {
        let info = buttonGroup[name];
        if (!Array.isArray(info)) {
            call(info);
            continue;
        }
        info.forEach(function (item) {
            call(item, name);
        })
    }
}

const default_buttons = {
    interactionModes: [
        {
            name: getI18NString('Default Mode'),
            interactionMode: 'default',
            iconClass: 'q-icon toolbar-default'
        },
        {
            name: getI18NString('Rectangle Selection'),
            interactionMode: 'selection',
            iconClass: 'q-icon toolbar-rectangle_selection'
        },
        {
            name: getI18NString('View Mode'),
            interactionMode: 'view',
            iconClass: 'q-icon toolbar-pan'
        }
    ],
    zoom: [
        {
            name: getI18NString('Zoom In'), iconClass: 'q-icon toolbar-zoomin', action: function () {
                this.graph.zoomIn()
            }
        },
        {
            name: getI18NString('Zoom Out'), iconClass: 'q-icon toolbar-zoomout', action: function () {
                this.graph.zoomOut()
            }
        },
        {
            name: '1:1', iconClass: 'q-icon toolbar-zoomreset', action: function () {
                this.graph.moveToCenter(1);// = 1;
            }
        },
        {
            name: getI18NString('Zoom to Overview'),
            iconClass: 'q-icon toolbar-zoom_overview',
            action: function () {
                this.graph.zoomToOverview()
            }
        }
    ],
    editor: [
        {
            name: getI18NString('Create Edge'),
            interactionMode: 'create.edge',
            iconClass: 'q-icon toolbar-edge'
        },
        {
            name: getI18NString('Create L Edge'),
            interactionMode: 'create.simple.edge',
            iconClass: 'q-icon toolbar-edge_VH',
            edgeType: 'orthogonal.V.H'
        },
        {
            name: getI18NString('Create Shape'),
            interactionMode: 'create.shape',
            iconClass: 'q-icon toolbar-polygon'
        },
        {
            name: getI18NString('Create Line'),
            interactionMode: 'create.line',
            iconClass: 'q-icon toolbar-line'
        }
    ],
    search: {
        name: 'Find',
        placeholder: 'Name',
        iconClass: 'q-icon toolbar-search',
        type: 'search',
        id: 'search_input',
        search: function (name, info) {
            let result = [];
            let reg = new RegExp(name, 'i');
            let graph = this.graph;
            graph.forEach(function (e) {
                if (graph.isVisible(e) && e.name && reg.test(e.name)) {
                    result.push(e.id);
                }
            });
            return result;
        },
        select: function (item) {
            let graph = this.graph || this.view;
            item = graph.graphModel.getById(item);
            if (!item) {
                return false;
            }
            graph.setSelection(item);
            graph.sendToTop(item);
            let bounds = graph.getUIBounds(item);
            if (bounds) {
                graph.centerTo(bounds.cx, bounds.cy, Math.max(2, graph.scale), true);
            }
        }
    },
    export_image: {
        name: getI18NString('Export Image'), iconClass: 'q-icon toolbar-print', action: function () {
            showExportPanel(this.graph);
        }
    },
    json: [{
        iconClass: 'q-icon toolbar-upload',
        name: getI18NString('Load File ...'),
        type: 'file',
        action(files) {
            console.log('upload files', files)
            if (!files[0]) {
                return;
            }
            let graph = this.graph || this.view;
            readTextFile(files[0], 'json', function (json) {
                if (!json) {
                    alert(getI18NString('json file is empty'));
                    return;
                }
                parseJSON(json, graph);
            });
        }
    }]
}


if (isBlobSupported()) {
    default_buttons.json.push({
        iconClass: 'q-icon toolbar-download',
        name: getI18NString('Download File'),
        action() {
            let graph = this.graph || this.view;
            let name = graph.name || 'graph';
            let json = exportJSON(graph, true);
            saveAs(new Blob([json], {type: "text/plain;charset=utf-8"}), name + ".json");
        }
    })
}
default_buttons.json.push({
    iconClass: 'q-icon toolbar-save',
    name: getI18NString('Save'),
    action() {
        let graph = this.graph || this.view;
        let name = graph.name || 'graph';
        let json = exportJSON(graph, true);
        //console.log(json)
        if (!_ProId) {
            prompt('请输入添加的文件名', '保存', (title) => {
                //console.log(input)
                if (!title) {
                    _msg('请输入文件名');
                    return false;
                }
                __post('flow/add', { title, content: json, type: 5 }, res => {
                    _ProId = res.data;
                    window._ProTitle = title;
                    _msg('添加成功');
                })
            });
            
        } else {
            prompt('请确认编辑的文件名', '保存', (title) => {
                //console.log(input)
                __post('flow/edit', { id: _ProId, title, content: json, type: 5 }, res => {
                    _msg('编辑成功');
                })
            }, window._ProTitle);
        }
        
        //saveAs(new Blob([json], { type: "text/plain;charset=utf-8" }), name + ".json");
    }
})

export class Toolbar {
    constructor(dom) {
        if (!dom) {
            dom = document.createElement('div');
        }
        dom.classList.add('Q-Toolbar');
        this.dom = dom;

        setTimeout(function () {
            this._init();
        }.bind(this))
    }

    setGraph(graph) {
        let old = this.graph;
        if (old) {
            old.propertyChangeDispatcher.removeListener(this._onInteractionModeChange, this);
        }
        this.graph = graph;
        this._updateButtonStatus();
        if (graph) {
            graph.propertyChangeDispatcher.addListener(this._onInteractionModeChange, this);
        }
    }

    _onInteractionModeChange(evt) {
        if (evt.kind == 'interactionMode') {
            this._updateButtonStatus();
        }
    }

    _updateButtonStatus() {
        let g = this.graph;
        let mode = g ? g.interactionMode : null;
        let interactionProperties = g ? g.interactionProperties : null;
        let buttons = this.dom.querySelectorAll('.btn');
        let i = 0, l = buttons.length;
        while (i < l) {
            let btn = buttons[i++];
            if (!btn.info || !btn.info.interactionMode) {
                continue
            }
            if (mode && btn.info.interactionMode === mode) {
                if (!interactionProperties || interactionProperties === btn.info) {
                    btn.classList.add('active');
                    continue;
                }
            }
            btn.classList.remove('active');
        }
    }

    _init() {
        let buttons = get(this.mode);
        buttons && createButtons(buttons, this.dom, this);
    }

    setMode(mode){
        this.mode = mode;
        this.dom.innerHTML = '';
        this._init();
    }

    onclick(evt, info) {
        if (!this.graph) {
            return
        }
        if (info && info.interactionMode) {
            this.graph.interactionProperties = info;
            this.graph.interactionMode = info.interactionMode;
        }
    }
}

let BUTTON_MAP = {};

function register(type, buttons) {
    BUTTON_MAP[type] = buttons;
}

function get(type) {
    let buttons = BUTTON_MAP[type || 'default'];
    if (!buttons) {
        throw 'No toolbar buttons are defined'
    }
    return Object.assign({}, buttons);
}

register('default', default_buttons);
register('view', {
    zoom: default_buttons.zoom,
    search: default_buttons.search,
    export_image: default_buttons.export_image
});

