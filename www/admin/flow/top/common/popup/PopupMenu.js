import Q from '../../lib/qunee-es.js';
import {getI18NString} from "../i18n.js";
import {hidePopup, showPopup} from "./Popup.js";

function setZIndexWithChildren(data, zIndex) {
    data.zIndex = zIndex;
    data.forEachChild(function (c) {
        setZIndexWithChildren(c, zIndex)
    })
}

let menuClassName = 'dropdown-menu';

const Separator = 'divider';

export class PopupMenu {
    constructor(items) {
        this._invalidateFlag = true;


        this.items = items || [];
    }

    add(item) {
        this.items.push(item);
        this._invalidateFlag = true;
    }

    addSeparator() {
        this.add(Separator);
    }

    showAt(x, y) {
        if (!this.items || !this.items.length) {
            return false;
        }
        if (this._invalidateFlag) {
            this.render();
        }
        showPopup(this.dom, x, y);
        // this.dom.style.display = "block";
        // document.body.appendChild(this.dom);
        // showDivAt(this.dom, x, y);
    }

    hide() {
        this.dom && hidePopup(this.dom);
        // if (this.dom && this.dom.parentNode) {
        //     this.dom.parentNode.removeChild(this.dom);
        // }
    }

    isShowing() {
        return this.dom.parentNode !== null;
    }

    render() {
        this._invalidateFlag = false;
        if (!this.dom) {
            this.dom = document.createElement('ul');
            this.dom.setAttribute("role", "menu");
            this.dom.className = menuClassName;
            this.dom.addEventListener(Q.isTouchSupport ? "touchstart" : "mousedown", function (evt) {
                Q.stopEvent(evt);
            }, false);
        } else {
            this.dom.innerHTML = "";
        }
        for (let i = 0, l = this.items.length; i < l; i++) {
            let item = this.renderItem(this.items[i]);
            this.dom.appendChild(item);
        }
    }

    html2Escape(sHtml) {
        return sHtml.replace(/[<>&"]/g, function (c) {
            return {'<': '&lt;', '>': '&gt;', '&': '&amp;', '"': '&quot;'}[c];
        });
    }

    renderItem(menuItem, zIndex) {
        let dom = document.createElement('li');
        dom.setAttribute("role", "presentation");
        if (menuItem == Separator) {
            dom.className = Separator;
            dom.innerHTML = " ";
            return dom;
        }
        if (Q.isString(menuItem)) {
            dom.innerHTML = '<a role="menuitem" tabindex="-1" href="#">' + this.html2Escape(menuItem) + '</a>';
            return dom;
        }
        if (menuItem.selected) {
            dom.style.backgroundPosition = '3px 5px';
            dom.style.backgroundRepeat = 'no-repeat';
            dom.style.backgroundImage = "url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAPklEQVQ4y2P4//8/AyWYYdQA7AYAAZuamlo7ED+H4naQGNEGQDX/R8PtpBjwHIsBz+lqAGVeoDgQR1MiaRgAnxW7Q0QEK0cAAAAASUVORK5CYII=')";
        }
        let a = document.createElement("a");
        a.setAttribute("role", "menuitem");
        a.setAttribute("tabindex", "-1");
        a.setAttribute("href", "javascript:void(0)");
        dom.appendChild(a);

        if (menuItem.html) {
            a.innerHTML = menuItem.html;
        } else {
            let text = menuItem.text || menuItem.name;
            if (text) {
                a.innerHTML = this.html2Escape(text);
            }
        }
        let className = menuItem.className;
        if (className) {
            dom.className = className;
        }
        let call = menuItem.action;
        let self = this;

        let onclick = function (evt) {
            if (call) {
                call.call(menuItem.scope, evt, menuItem);
            }
            if (!Q.isIOS) {
                evt.target.focus();
            }
            setTimeout(function () {
                self.hide();
            }, 100);
        }
        if (Q.isTouchSupport) {
//            dom.ontouchstart = onclick;
            a.ontouchstart = onclick;
        } else {
            dom.onclick = onclick;
        }
        return dom;
    }

    getMenuItems(graph, data, evt) {
        let items = [];
        //items.push({
        //  text: '添加主机',
        //  action(evt, item){
        //    alert('添加主机');//这里实现弹出页面
        //  }
        //})
        function getSelectedNodes(graph) {
            let nodes = [];
            graph.selectionModel.forEach(function (e) {
                e instanceof Q.Node && nodes.push(e);
            })
            return nodes;
        }


        /**
         *  左对齐
         */
        function alignLeft(graph, nodeUIs) {
            let left;
            nodeUIs.forEach(function (e) {
                if (left === undefined) {
                    left = e.x;
                } else {
                    left = Math.min(left, e.x);
                }
            });
            nodeUIs.forEach(function (node) {
                node.x = left;
            });
        }

        if (data) {
            let nodes = getSelectedNodes(graph);
            if (nodes.length >= 2) {
                items.push({
                    text: 'Align Left', action() {
                        alignLeft(graph, nodes)
                    }
                })
            }
            let isShapeNode = data instanceof Q.ShapeNode;
            let isGroup = data instanceof Q.Group;
            let isNode = !isShapeNode && data instanceof Q.Node;
            let isEdge = data instanceof Q.Edge;

            items.push({
                text: getI18NString('Rename'), action(evt, item) {
                    Q.prompt(getI18NString('Input Element Name'), data.name || '', function (name) {
                        if (name === null) {
                            return;
                        }
                        data.name = name;
                    })
                }
            });
            if (isEdge) {
                let isDashLine = data.getStyle(Q.Styles.EDGE_LINE_DASH) || Q.DefaultStyles[Q.Styles.EDGE_LINE_DASH];
                items.push({
                    text: isDashLine ? getI18NString('Solid Line') : getI18NString('Dashed Line'),
                    action(evt, item) {
                        data.setStyle(Q.Styles.EDGE_LINE_DASH, isDashLine ? null : [5, 3]);
                    }
                });
                items.push({
                    text: getI18NString('Line Width'), action(evt, item) {
                        Q.prompt(getI18NString('Input Line Width'), data.getStyle(Q.Styles.EDGE_WIDTH) || Q.DefaultStyles[Q.Styles.EDGE_WIDTH], function (lineWidth) {
                            if (lineWidth === null) {
                                return;
                            }
                            lineWidth = parseFloat(lineWidth);
                            data.setStyle(Q.Styles.EDGE_WIDTH, lineWidth);
                        })
                    }
                });
                items.push({
                    text: getI18NString('Line Color'), action(evt, item) {
                        Q.prompt(getI18NString('Input Line Color'), data.getStyle(Q.Styles.EDGE_COLOR) || Q.DefaultStyles[Q.Styles.EDGE_COLOR], function (color) {
                            if (color === null) {
                                return;
                            }
                            data.setStyle(Q.Styles.EDGE_COLOR, color);
                        })
                    }
                });
            } else if (data.parent instanceof Q.Group) {
                items.push({
                    text: getI18NString('Out of Group'), action() {
                        data.parent = null;
                    }
                })
            }
            items.push(Separator);

            items.push({
                text: getI18NString('Send to Top'), action(evt, item) {
                    // data.zIndex = 1;
                    setZIndexWithChildren(data, 1);
                    graph.sendToTop(data);
                    graph.invalidate();
                }
            });
            items.push({
                text: getI18NString('Send to Bottom'), action(evt, item) {
                    // data.zIndex = -1;
                    setZIndexWithChildren(data, -1);
                    graph.sendToBottom(data);
                    graph.invalidate();
                }
            });
            items.push({
                text: getI18NString('Reset Layer'), action(evt, item) {
                    // data.zIndex = 0;
                    setZIndexWithChildren(data, 0);
                    graph.invalidate();
                }
            });
            items.push(Separator);
        }
        items.push({
            text: getI18NString('Clear Graph'), action() {
                graph.clear();
            }
        })
        items.push(Separator);

        items.push({
            text: getI18NString('Zoom In'), action(evt, item) {
                let localXY = graph.globalToLocal(evt);
                graph.zoomIn(localXY.x, localXY.y, true);
            }
        });
        items.push({
            text: getI18NString('Zoom Out'), action(evt, item) {
                let localXY = graph.globalToLocal(evt);
                graph.zoomOut(localXY.x, localXY.y, true);
            }
        });
        items.push({
            text: getI18NString('1:1'), action(evt, item) {
                let localXY = graph.globalToLocal(evt);
                graph.scale = 1;
            }
        });
        items.push(Separator);
        let currentMode = graph.interactionMode;
        let interactons = [
            {text: getI18NString('Pan Mode'), value: Q.Consts.INTERACTION_MODE_DEFAULT},
            {text: getI18NString('Rectangle Select'), value: Q.Consts.INTERACTION_MODE_SELECTION}
        ];
        for (let i = 0, l = interactons.length; i < l; i++) {
            let mode = interactons[i];
            if (mode.value == currentMode) {
                mode.selected = true;
            }
            mode.action = function (evt, item) {
                graph.interactionMode = item.value;
            };
            items.push(mode)
        }
        items.push(Separator);
        items.push({html: '<a href="http://qunee.com" target="_blank">Qunee' + ' - ' + Q.version + '</a>'});
        return items;
    }

    get items() {
        return this._items;
    }

    set items(v) {
        this._items = v;
        this._invalidateFlag = true;
    }
}

let _contextmenuListener = {
    onstart(evt, graph) {
        graph._popupmenu.hide();
    }
}

function getPageXY(evt) {
    if (evt.touches && evt.touches.length) {
        evt = evt.touches[0];
    }
    return {x: evt.pageX, y: evt.pageY};
}

function showMenu(evt, graph) {
    let menu = graph.popupmenu;
    let xy = getPageXY(evt);
    let x = xy.x, y = xy.y;

    let items = menu.getMenuItems(graph, graph.getElement(evt), evt);

    if (!items) {
        return;
    }
    menu.items = items;
    menu.showAt(x, y);

    Q.stopEvent(evt);
}

if (Q.isTouchSupport) {
    _contextmenuListener.onlongpress = function (evt, graph) {
        showMenu(evt, graph);
    }
}

Object.defineProperties(Q.Graph.prototype, {
    popupmenu: {
        get() {
            return this._popupmenu;
        },
        set(v) {
            if (this._popupmenu == v) {
                return;
            }
            this._popupmenu = v;

            if (!this._contextmenuListener) {
                this._contextmenuListener = _contextmenuListener;
                this.addCustomInteraction(this._contextmenuListener);
                this.html.oncontextmenu = function (evt) {
                    if (!this.popupmenu) {
                        return;
                    }
                    showMenu(evt, this);
                }.bind(this);
            }
        }
    }
});