import Q from '../../lib/qunee-es.js';

function globalToLocal(evt, div) {
    if (evt.touches) {
        if (evt.changedTouches && evt.changedTouches.length) {
            evt = evt.changedTouches[0];
        } else {
            evt = evt.touches[0];
        }
    }
    let clientRect = div.getBoundingClientRect();
    let x = evt.clientX || 0;
    let y = evt.clientY || 0;
    if (Q.isTouchSupport && Q.isSafari) {
        if (window.pageXOffset && x == evt.pageX) {
            x -= window.pageXOffset;
        }
        if (window.pageYOffset && y == evt.pageY) {
            y -= window.pageYOffset;
        }
    }
    return [x - clientRect.left, y - clientRect.top];
}

export class Overview {
    constructor(html, graph) {
        this._invalidateGraphFlag = false;
        this.visible = true;
        this.html = html;
        this.canvas = Q.createCanvas(true);
        this.html.appendChild(this.canvas);
        new Q.DragSupport(this.canvas, this);
        this.setGraph(graph);
    }

    setGraph(graph) {
        if (this.graph == graph) {
            return;
        }
        this._uninstall();
        this.graph = graph;
        this._install();
    }

    _install() {
        if (!this.graph) {
            return;
        }
        if (!this._onPropertyChanged) {
            this._onPropertyChanged = function (evt) {
                let kind = evt.kind;
                if (kind == 'element.bounds') {
                    this._invalidateGraph();
                    return;
                }
                if (kind == 'transform' || kind == 'viewport') {
                    this.invalidate();
                }
            }.bind(this)
            this._onDataChanged = function (evt) {
                this._invalidateGraph();
            }.bind(this)
        }
        this.graph.propertyChangeDispatcher.addListener(this._onPropertyChanged);
        this.graph.dataPropertyChangeDispatcher.addListener(this._onDataChanged);
        this.graph.listChangeDispatcher.addListener(this._onDataChanged);
        this._invalidateGraph(true);
    }

    _uninstall() {
        if (!this.graph || !this._onPropertyChanged) {
            return;
        }
        this.graph.propertyChangeDispatcher.removeListener(this._onPropertyChanged);
        this.graph.dataPropertyChangeDispatcher.removeListener(this._onDataChanged);
        this.graph.listChangeDispatcher.removeListener(this._onDataChanged);
        this.imageInfo = null;
        this.bounds = null;
        this.scale = null;
    }

    _toCanvas(x, y) {
        x = this.scale * (x - this.bounds.x);
        y = this.scale * (y - this.bounds.y);
        return [x, y]
    }

    _toGraph(evt) {
        let xy = globalToLocal(evt, this.html);
        let x = xy[0] / this.scale + this.bounds.x;
        let y = xy[1] / this.scale + this.bounds.y;
        return [x, y]
    }

    _validateGraph() {
        this._invalidateGraphFlag = false;
        if (!this.visible) {
            return;
        }
        let width = this.html.clientWidth, height = this.html.clientHeight;
        if (!width || !height) {
            return;
        }
        let bounds = new Q.Rect();
        bounds.add(this.graph.bounds);
        let imageScale = Math.min(width / bounds.width, height / bounds.height) * this.canvas.ratio;

        this.imageInfo = this.exportGraphImage(imageScale, bounds);

        this.imageInfo.scale = imageScale;
        this.imageInfo.bounds = bounds;

        this.invalidate();
    }

    exportGraphImage(scale, bounds) {
        return this.graph.exportImage(scale, bounds);
    }

    _invalidateGraph(force) {
        if (!this.graph || (!force && this._invalidateGraphFlag)) {
            return;
        }
        this._invalidateGraphFlag = true;
        this.graph.callLater(this._validateGraph, this, force ? 100 : 1000);
    }

    invalidate(force) {
        if (!force && this._invalidateFlag) {
            return;
        }
        this._invalidateFlag = true;
        setTimeout(this.validate.bind(this));
    }

    validate() {
        this._invalidateFlag = false;
        let imageInfo = this.imageInfo;
        if (!imageInfo) {
            return;
        }
        let viewportBounds = this.graph.viewportBounds;
        if (!viewportBounds.height || !viewportBounds.width) {
            return;
        }

        let canvas = this.canvas;
        let ratio = canvas.ratio;
        let g = canvas.getContext('2d');
        let width = this.html.clientWidth, height = this.html.clientHeight;
        canvas.style.width = width + 'px';
        canvas.style.height = height + 'px';
        canvas.width = width * ratio;
        canvas.height = height * ratio;
        g.scale(ratio, ratio);

        let bounds = new Q.Rect(imageInfo.bounds);
        bounds.add(viewportBounds);
        let scale = Math.min(width / bounds.width, height / bounds.height);
        this.scale = scale;

        let offsetX = (width / scale - bounds.width) / 2;
        let offsetY = (height / scale - bounds.height) / 2;
        bounds.x -= offsetX;
        bounds.y -= offsetY;
        bounds.width = width / scale;
        bounds.height = height / scale;
        this.bounds = bounds;

        g.save();
        let xy = this._toCanvas(imageInfo.bounds.x, imageInfo.bounds.y);
        g.translate(xy[0], xy[1]);
        g.scale(scale / imageInfo.scale, scale / imageInfo.scale);
        g.drawImage(this.imageInfo.canvas, 0, 0);
        g.restore();

        g.beginPath();
        g.moveTo(0, 0);
        g.lineTo(canvas.width, 0);
        g.lineTo(canvas.width, canvas.height);
        g.lineTo(0, canvas.height);
        g.lineTo(0, 0);

        xy = this._toCanvas(viewportBounds.x, viewportBounds.y);
        let x = xy[0];
        let y = xy[1];
        width = viewportBounds.width * scale;
        height = viewportBounds.height * scale;


        g.moveTo(x, y);
        g.lineTo(x, y + height);
        g.lineTo(x + width, y + height);
        g.lineTo(x + width, y);
        g.closePath();
        g.fillStyle = "rgba(30, 30, 30, 0.3)";
        g.fill();
        g.lineWidth = 0.5;
        g.strokeStyle = '#333';
        g.strokeRect(x, y, width, height)
    }

    accept() {
        return this.graph != null;
    }

    startdrag(evt) {
        this.enddrag();
        if (!this.scale) {
            return;
        }
        let xy = this._toGraph(evt);
        let viewport = this.graph.viewportBounds;
        if (viewport.contains(xy[0], xy[1])) {
            this._dragInfo = {
                scale: this.scale / this.graph.scale,
                point: xy
            };
            this.graph.stopAnimation()
        }
    }

    ondrag(evt) {
        if (!this._dragInfo) {
            return;
        }
        let scale = this._dragInfo.scale;
        let dx = evt.dx;
        let dy = evt.dy;
        dx /= scale;
        dy /= scale;
        this.graph.translate(-dx, -dy, false)
    }

    enddrag() {
        this._dragInfo = null;
    }

    onstart(evt) {
        Q.stopEvent(evt);
        let xy = this._toGraph(evt);
        this.graph.centerTo(xy[0], xy[1])
    }

    onmousewheel(evt) {
        Q.stopEvent(evt);
        let xy = this._toGraph(evt);
        xy = this.graph.toCanvas(xy[0], xy[1]);
        this.graph.zoomAt(Math.pow(this.graph.scaleStep, evt.delta), xy.x, xy.y);
    }

    ondblclick(evt) {
        let graph = this.graph;
        if (graph.enableDoubleClickToOverview) {
            let resetScale = graph.resetScale || 1;
            if (Math.abs(graph.scale - resetScale) < 0.001) {
                graph.zoomToOverview();
            } else {
                graph.moveToCenter(resetScale)
            }
        }
    }

    setVisible(visible) {
        this.visible = visible;
        if (visible) {
            this.html.style.display = 'block';
        } else {
            this.html.style.display = 'none';
        }
        this._invalidateGraph();
    }
}