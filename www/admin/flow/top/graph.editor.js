import Q from "./lib/qunee-es.js";
import {getI18NString} from "./common/i18n.js";
import {Overview} from "./common/overview/Overview.js";
import {addFlowSupport} from "./js/FlowSupport.js";
import {exportJSON, parseJSON} from "./common/io/JSONSerializer.js";
import {createButtonGroup, Toolbar} from "./common/toolbar/Toolbar.js";
import {ToolBox} from "./common/toolbox/ToolBox.js";
import {PopupMenu} from "./common/popup/PopupMenu.js";
import {PropertyPane} from "./common/property/PropertyPane.js";

function forEachItem(dom, call) {
    let children = dom.children;
    let i = 0, l = children.length;
    while (i < l) {
        let item = children[i++];
        call(item);
        forEachItem(item, call);
    }
}

export class Editor {
    _checkVue(dom) {
        let refs = this.$refs = {};
        forEachItem(dom, function (item) {
            let ref = item.getAttribute('ref');
            if (ref) {
                refs[ref] = item;
            }
            let click = item.getAttribute('@click');
            if (click) {
                item.onclick = function (evt) {
                    this[click](evt);
                }.bind(this)
            }
        }.bind(this))
    }

    constructor(container, options) {
        let template = document.getElementById(options.template);
        let dom = template.content.cloneNode(true);
        this._checkVue(dom);
        if(typeof container === 'string'){
            container = document.getElementById(container);
        }
        this.container = container;
        container.appendChild(dom);
        let graph = this.graph = new Q.Graph(this.$refs.canvas);
        graph.editable = true;
        graph.originAtCenter = false;

        let overview = new Overview(this.$refs.overview, graph);

        this.toolbar = new Toolbar(this.$refs.toolbar);
        this.toolbar.setGraph(graph);
        this.toolbox = new ToolBox(this.$refs.toolbox);
        this.propertyPane = new PropertyPane(graph, this.$refs.property);
        this.initPopupMenu(graph);

        let demoBtnGroup = createButtonGroup([{
            name: 'edit mode', type: 'checkbox', checked: graph.editable, action(evt) {
                this.setEditable(evt.target.checked)
            }
        }, {
            name: getI18NString('show json panel'), iconClass: 'q-icon toolbar-json',
            action(evt) {
                let jsonPane = this.$refs.json_pane;
                let visible = jsonPane.style.display === 'none';
                visible ? evt.currentTarget.classList.add('active') : evt.currentTarget.classList.remove('active');
                jsonPane.style.display = visible ? '' : 'none';
                if (visible) {
                    this.exportJSON();
                }
            }
        }, {
            name: getI18NString('show overview'), iconClass: 'q-icon toolbar-overview',
            selected: true,
            action(evt) {
                let visible = !overview.visible;
                visible ? evt.currentTarget.classList.add('active') : evt.currentTarget.classList.remove('active');
                overview.setVisible(visible);
                overview.setGraph(visible ? graph : null);
            }
        }, {
            name: getI18NString('max'), iconClass: 'q-icon toolbar-max',
            action(evt) {
                let el = this.container;
                let isMax = !el.classList.contains('q-max');
                isMax ? evt.currentTarget.classList.add('active') : evt.currentTarget.classList.remove('active');
                isMax ? el.classList.add('q-max') : el.classList.remove('q-max');
                graph.updateViewport();
            }
        }], this);
        demoBtnGroup.style.float = 'right';
        this.$refs.toolbar_pane.appendChild(demoBtnGroup);
    }

    setEditable(editable) {
        this.graph.editable = editable;
        this.graph.interactionMode = editable ? Q.Consts.INTERACTION_MODE_DEFAULT : Q.Consts.INTERACTION_MODE_VIEW;
        this.graph.updateViewport();

        this.toolbar.setMode(editable ? 'default' : 'view');

        function setVisible(div, visible) {
            div.style.display = visible ? '' : 'none';
        }

        setVisible(this.$refs.toolbox, editable);
        setVisible(this.$refs.property, editable);
        setVisible(this.$refs.json_btn_group, editable);
    }

    exportJSON() {
        this.$refs.json_textarea.value = exportJSON(this.graph, true, {space: '  '});
    }

    submitJSON() {
        let json = this.$refs.json_textarea.value;
        this.graph.clear();
        parseJSON(json, this.graph);
    }

    initPopupMenu(graph) {
        addFlowSupport(graph);
        let popupmenu = graph.popupmenu = new PopupMenu(graph);
        let superGetMenuItems = popupmenu.getMenuItems;
        popupmenu.getMenuItems = function (graph, element, evt) {
            let items = superGetMenuItems.apply(this, arguments);
            if (!element) {
                return items;
            }
            if (element instanceof Q.Group) {
                items.unshift({
                    text: 'Ellipse Group',
                    action() {
                        element.groupType = Q.Consts.GROUP_TYPE_ELLIPSE;
                    }
                })
                items.unshift({
                    text: 'Rect Group',
                    action() {
                        element.groupType = Q.Consts.GROUP_TYPE_RECT;
                    }
                })
            }
            if (element instanceof Q.Edge || element instanceof Q.ShapeNode) {
                let flow = element.flow !== true;
                items.unshift({
                    text: flow ? 'Flow' : 'Stop Flow',
                    action() {
                        element.flow = flow;
                    }
                })
            }
            return items;
        }
    }
}