let FLOWING_FORWARD = 'forward';
let FLOWING_BACKWARD = 'backward';
import Q from '../lib/qunee-es.js';


export function addFlowSupport(graph){
    new FlowingSupport(graph);
}
class FlowingSupport {
    constructor(graph) {
        this.length = 0;
        this._interval = 300;
        this.perStep = 10;
        this.map = {};
        this.graph = graph;
        this._onStep = function(){
            if (!this.length) {
                this._timer = null;
                return;
            }
            let perStep = this.perStep;//Math.max(this.perStep / this.graph.scale, 1);
            for (let id in this.map) {
                let element = this.map[id];
                let ui = this.graph.getUI(id);
                if (!ui) {
                    // this._doRemove(id);
                    continue;
                }
                let lineLength = ui.length;
                if (!lineLength) {
                    continue;
                }
                let x = element._flowingIcon._offset || 0;
                x += element.flow == FLOWING_BACKWARD ? -perStep : perStep;
                x %= lineLength;
                element._flowingIcon._offset = x;
                element._flowingIcon.position = {x: x, y: 0};
                this.graph.invalidateUI(ui);
            }
            this._timer = setTimeout(this._onStep, this._interval);
        }.bind(this)

        graph.dataPropertyChangeDispatcher.addListener(function (evt) {
            if (evt.propertyName !== 'flow') {
                return;
            }
            this.onChanged(evt.source);
        }.bind(this));
        graph.listChangeDispatcher.addListener(function (evt) {
            if (evt.kind == Q.ListEvent.KIND_CLEAR) {
                this.clear();
            } else if (evt.kind == Q.ListEvent.KIND_REMOVE) {
                this.onRemove(evt.data);
            } else if (evt.kind == Q.ListEvent.KIND_ADD) {
                this.onAdd(evt.data);
            }
        }.bind(this));
    }

    clear() {
        this.map = {};
        this.length = 0;
    }

    _add(item) {
        if (this.map[item.id]) {
            return;
        }
        this.length++;
        this.map[item.id] = item;

        if (!item._flowingIcon) {
            let ui = new Q.ImageUI(Q.Shapes.getShape(Q.Consts.SHAPE_CIRCLE));
            ui.fillColor = '#Fdd';
            ui.layoutByPath = true;
            ui.position = {x: 0, y: 0};
            ui.size = {width: 16};
            ui.renderColor = "#F00";
            item.addUI(ui);
            item._flowingIcon = ui;
        }

        this.start();
    }

    _remove(item) {
        if (!this.map[item.id]) {
            return;
        }
        if (item._flowingIcon) {
            item.removeUI(item._flowingIcon);
            item._flowingIcon = null;
        }
        delete this.map[item.id];
        this.length--;
    }

    start() {
        if (this._timer) {
            return;
        }
        this._timer = setTimeout(this._onStep, this._interval);
    }

    onChanged(element) {
        element.flow ? this._add(element) : this._remove(element);
    }

    _dataToArray(data) {
        if (Q.isArray(data)) {
            return data;
        }
        return [data];
    }

    onRemove(data) {
        data = this._dataToArray(data);
        data.forEach(function (item) {
            if (this.map[item.id]) {
                this._remove(item);
            }
        }, this);
    }

    onAdd(data) {
        data = this._dataToArray(data);
        data.forEach(function (item) {
            if (item instanceof Q.Edge && item.flow && !this.map[item.id]) {
                this._add(item);
            }
        }, this);
    }
}

Object.defineProperties(Q.Edge.prototype, {
    flow: {
        get() {
            return this._flow;
        },
        set(v) {
            if (this._flow == v) {
                return;
            }
            let old = this._flow;
            this._flow = v;
            this.firePropertyChangeEvent('flow', v, old);
        }
    }
});
Object.defineProperties(Q.ShapeNode.prototype, {
    flow: {
        get() {
            return this._flow;
        },
        set(v) {
            if (this._flow == v) {
                return;
            }
            let old = this._flow;
            this._flow = v;
            this.firePropertyChangeEvent('flow', v, old);
        }
    }
});
