import Q from '../../lib/qunee-es.js';
import {getI18NString} from "../i18n.js";
import {showDialog} from "../modal/Dialog.js";
import {createElement} from "../utils.js";
import {isBlobSupported, saveAs} from "../FileSupport.js";

let template = '\
  <h3 style="text-align: center;">' + getI18NString('Image export preview') + '</h3>\
  <div>\
  <label>' + getI18NString('Canvas Size') + '</label>\
  <span class ="graph-export-panel__canvas_size"></span>\
  </div>\
  <div style="text-align: center;" title="' + getI18NString('Double click  to select the whole canvas range') + '">\
  <div class ="graph-export-panel__export_canvas" style="position: relative; display: inline-block;">\
  </div>\
  </div>\
  <div>\
  <label>' + getI18NString('Export Range') + '</label>\
  <span class ="graph-export-panel__export_bounds"></span>\
  </div>\
  <div>\
  <label>' + getI18NString('Scale') + ': <input class ="graph-export-panel__export_scale" type="range" value="1" step="0.2" min="0.2" max="3"><span class ="graph-export-panel__export_scale_label">1</span></label>\
  </div>\
  <div>\
  <label>' + getI18NString('Output Size') + ': </label><span class ="graph-export-panel__export_size"></span>\
  </div>\
  <div style="text-align: right">\
  <button type="submit" class="btn btn-primary graph-export-panel__export_submit">' + getI18NString('Export') + '</button>\
  <button type="submit" class="btn btn-primary graph-export-panel__print_submit">' + getI18NString('Print') + '</button>\
  </div>';

class ResizeBox {
    constructor(parent, onBoundsChange) {
        this.onBoundsChange = onBoundsChange;
        this.parent = parent;
        this.handleSize = Q.isTouchSupport ? 20 : 8;

        this.boundsDiv = this._createDiv(this.parent);
        this.boundsDiv.type = "border";
        this.boundsDiv.style.position = "absolute";
        this.boundsDiv.style.border = "dashed 1px #888";
        let handles = "lt,t,rt,l,r,lb,b,rb";
        handles = handles.split(",");
        for (let i = 0, l = handles.length; i < l; i++) {
            let name = handles[i];
            let handle = this._createDiv(this.parent);
            handle.type = "handle";
            handle.name = name;
            handle.style.position = "absolute";
            handle.style.backgroundColor = "#FFF";
            handle.style.border = "solid 1px #555";
            handle.style.width = handle.style.height = this.handleSize + "px";
            let cursor;
            if (name == 'lt' || name == 'rb') {
                cursor = "nwse-resize";
            } else if (name == 'rt' || name == 'lb') {
                cursor = "nesw-resize";
            } else if (name == 't' || name == 'b') {
                cursor = "ns-resize";
            } else {
                cursor = "ew-resize";
            }
            handle.style.cursor = cursor;
            this[handles[i]] = handle;
        }
        this.interaction = new Q.DragSupport(this.parent, this);
    }

    destroy() {
        this.interaction.destroy();
    }

    update(width, height) {
        this.wholeBounds = new Q.Rect(0, 0, width, height);
        this._setBounds(this.wholeBounds.clone());
    }

    ondblclick(evt) {
        if (this._bounds.equals(this.wholeBounds)) {
            if (!this.oldBounds) {
                this.oldBounds = this.wholeBounds.clone().grow(-this.wholeBounds.height / 5, -this.wholeBounds.width / 5);
            }
            this._setBounds(this.oldBounds, true);
            return;
        }
        this._setBounds(this.wholeBounds.clone(), true);
    }

    startdrag(evt) {
        if (evt.target.type) {
            this.dragItem = evt.target;
        }
    }

    ondrag(evt) {
        if (!this.dragItem) {
            return;
        }
        Q.stopEvent(evt);
        let dx = evt.dx;
        let dy = evt.dy;
        if (this.dragItem.type == "border") {
            this._bounds.offset(dx, dy);
            this._setBounds(this._bounds, true);
        } else if (this.dragItem.type == "handle") {
            let name = this.dragItem.name;
            if (name[0] == 'l') {
                this._bounds.x += dx;
                this._bounds.width -= dx;
            } else if (name[0] == 'r') {
                this._bounds.width += dx;
            }
            if (name[name.length - 1] == 't') {
                this._bounds.y += dy;
                this._bounds.height -= dy;
            } else if (name[name.length - 1] == 'b') {
                this._bounds.height += dy;
            }
            this._setBounds(this._bounds, true);
        }

    }

    enddrag(evt) {
        if (!this.dragItem) {
            return;
        }
        this.dragItem = false;
        if (this._bounds.width < 0) {
            this._bounds.x += this._bounds.width;
            this._bounds.width = -this._bounds.width;
        } else if (this._bounds.width == 0) {
            this._bounds.width = 1;
        }
        if (this._bounds.height < 0) {
            this._bounds.y += this._bounds.height;
            this._bounds.height = -this._bounds.height;
        } else if (this._bounds.height == 0) {
            this._bounds.height = 1;
        }
        if (this._bounds.width > this.wholeBounds.width) {
            this._bounds.width = this.wholeBounds.width;
        }
        if (this._bounds.height > this.wholeBounds.height) {
            this._bounds.height = this.wholeBounds.height;
        }
        if (this._bounds.x < 0) {
            this._bounds.x = 0;
        }
        if (this._bounds.y < 0) {
            this._bounds.y = 0;
        }
        if (this._bounds.right > this.wholeBounds.width) {
            this._bounds.x -= this._bounds.right - this.wholeBounds.width;
        }
        if (this._bounds.bottom > this.wholeBounds.height) {
            this._bounds.y -= this._bounds.bottom - this.wholeBounds.height;
        }

        this._setBounds(this._bounds, true);
    }

    _createDiv(parent) {
        let div = document.createElement("div");
        parent.appendChild(div);
        return div;
    }

    _setHandleLocation(handle, x, y) {
        handle.style.left = (x - this.handleSize / 2) + "px";
        handle.style.top = (y - this.handleSize / 2) + "px";
    }

    _setBounds(bounds) {
        if (!bounds.equals(this.wholeBounds)) {
            this.oldBounds = bounds;
        }
        this._bounds = bounds;
        bounds = bounds.clone();
        bounds.width += 1;
        bounds.height += 1;
        this.boundsDiv.style.left = bounds.x + "px";
        this.boundsDiv.style.top = bounds.y + "px";
        this.boundsDiv.style.width = bounds.width + "px";
        this.boundsDiv.style.height = bounds.height + "px";

        this._setHandleLocation(this.lt, bounds.x, bounds.y);
        this._setHandleLocation(this.t, bounds.cx, bounds.y);
        this._setHandleLocation(this.rt, bounds.right, bounds.y);
        this._setHandleLocation(this.l, bounds.x, bounds.cy);
        this._setHandleLocation(this.r, bounds.right, bounds.cy);
        this._setHandleLocation(this.lb, bounds.x, bounds.bottom);
        this._setHandleLocation(this.b, bounds.cx, bounds.bottom);
        this._setHandleLocation(this.rb, bounds.right, bounds.bottom);
        if (this.onBoundsChange) {
            this.onBoundsChange(this._bounds);
        }
    }

    get bounds() {
        return this._bounds;
    }

    set bounds(v) {
        this._setBounds(v);
    }
}

class ExportPanel {
    _getChild(selector) {
        return this.html.querySelector(selector);
    }

    initCanvas() {
        let export_canvas = this._getChild('.graph-export-panel__export_canvas');
        export_canvas.innerHTML = "";

        let canvas = Q.createCanvas(true);
        export_canvas.appendChild(canvas);
        this.canvas = canvas;

        let export_bounds = this._getChild(".graph-export-panel__export_bounds");
        let export_size = this._getChild(".graph-export-panel__export_size");
        let clipBounds;
        let drawPreview = function () {
            let canvas = this.canvas;
            let g = canvas.g;
            let ratio = canvas.ratio || 1;
            g.save();
            //g.scale(1/g.ratio, 1/g.ratio);
            g.clearRect(0, 0, canvas.width, canvas.height);
            g.drawImage(this.imageInfo.canvas, 0, 0);
            g.beginPath();
            g.moveTo(0, 0);
            g.lineTo(canvas.width, 0);
            g.lineTo(canvas.width, canvas.height);
            g.lineTo(0, canvas.height);
            g.lineTo(0, 0);

            let x = clipBounds.x * ratio, y = clipBounds.y * ratio, width = clipBounds.width * ratio,
                height = clipBounds.height * ratio;
            g.moveTo(x, y);
            g.lineTo(x, y + height);
            g.lineTo(x + width, y + height);
            g.lineTo(x + width, y);
            g.closePath();
            g.fillStyle = "rgba(0, 0, 0, 0.3)";
            g.fill();
            g.restore();
        }
        let onBoundsChange = function (bounds) {
            clipBounds = bounds;
            this.clipBounds = clipBounds;
            drawPreview.call(this);
            let w = clipBounds.width / this.imageInfo.scale | 0;
            let h = clipBounds.height / this.imageInfo.scale | 0;
            export_bounds.textContent = (clipBounds.x / this.imageInfo.scale | 0) + ", "
                + (clipBounds.y / this.imageInfo.scale | 0) + ", " + w + ", " + h;
            this.updateOutputSize();
        }
        this.updateOutputSize = function () {
            let export_scale = this._getChild(".graph-export-panel__export_scale");
            let scale = export_scale.value;
            let w = clipBounds.width / this.imageInfo.scale * scale | 0;
            let h = clipBounds.height / this.imageInfo.scale * scale | 0;
            let info = w + " X " + h;
            if (w * h > 3000 * 4000) {
                info += "<span style='color: #F66;'>" + getI18NString('Image size is too large, the export may appear memory error') + "</span>";
            }
            export_size.innerHTML = info;
        }
        let resizeHandler = new ResizeBox(canvas.parentNode, onBoundsChange.bind(this));
        this.update = function () {
            let ratio = this.canvas.ratio || 1;
            let width = this.imageInfo.width / ratio;
            let height = this.imageInfo.height / ratio;
            this.canvas.setSize(width, height);
            resizeHandler.update(width, height);
        }
    }

    destroy() {
        this.graph = null;
        this.imageInfo = null
        this.clipBounds = null;
        this.bounds = null;
    }

    _initDom() {
        let export_panel = this.html = createElement({
            html: template
        })
        export_panel.addEventListener("mousedown", function (evt) {
            if (evt.target == export_panel) {
                this.destroy();
            }
        }.bind(this), false);
        let export_scale = this._getChild(".graph-export-panel__export_scale");
        let export_scale_label = this._getChild(".graph-export-panel__export_scale_label");
        export_scale.onchange = function (evt) {
            export_scale_label.textContent = this.scale = export_scale.value;
            this.updateOutputSize();
        }.bind(this);
        this.export_scale = export_scale;

        let export_submit = this._getChild(".graph-export-panel__export_submit");
        export_submit.onclick = this._doExport.bind(this, 'file');
        let print_submit = this._getChild(".graph-export-panel__print_submit");
        print_submit.onclick = this._doExport.bind(this, 'print');
    }

    _doExport(type){
        let scale = this.export_scale.value;
        let s = this.imageInfo.scale;
        let clipBounds = new Q.Rect(this.clipBounds.x / s, this.clipBounds.y / s, this.clipBounds.width / s, this.clipBounds.height / s);
        clipBounds.offset(this.bounds.x, this.bounds.y);
        if(type === 'print'){
            return printGraph(this.graph, clipBounds, scale);
        }
        exportImageFile(this.graph, clipBounds, scale);
    }

    show(graph) {
        if (!this.html) {
            this._initDom();
        }

        showDialog({
            content: this.html
        })

        this.graph = graph;
        let bounds = graph.bounds;
        this.bounds = bounds;

        let canvas_size = this._getChild(".graph-export-panel__canvas_size");
        canvas_size.textContent = (bounds.width | 0) + " X " + (bounds.height | 0);

        let size = Math.min(500, screen.width / 1.3);
        let imageScale;
        if (bounds.width > bounds.height) {
            imageScale = Math.min(1, size / bounds.width);
        } else {
            imageScale = Math.min(1, size / bounds.height);
        }
        if (!this.canvas) {
            this.initCanvas();
        }
        this.imageInfo = graph.exportImage(imageScale * this.canvas.ratio);
        this.imageInfo.scale = imageScale;

        this.update();
    }
}

let exportPanel;

export function showExportPanel(graph) {
    if (!exportPanel) {
        exportPanel = new ExportPanel();
    }
    exportPanel.show(graph);
}

function doPrint(image, doc = document, win = window) {
    function __print() {
        function closePrint() {
            win.removeEventListener('afterprint', closePrint);
            doc.body.removeChild(image);
            image.classList.remove('q-print__body');
            doc.documentElement.classList.remove('q-print');
        }

        function showPrint() {
            doc.documentElement.classList.add('q-print');
            image.classList.add('q-print__body');
            doc.body.appendChild(image);
            win.removeEventListener('beforeprint', showPrint);
            win.addEventListener('afterprint', closePrint);
        }

        win.addEventListener('beforeprint', showPrint);
        win.print();
        ///ie, edge浏览器不会阻塞，异步调用print
        ///safari第一次会阻塞进程，但第二次则不会阻塞，会显示是否打印的确认框，如果点击取消，不会进入打印状态
    }

    if (!image.width) {
        image.onload = __print
    } else {
        __print();
    }
}

function getStyleByID(id, doc = document) {
    let style = doc.getElementById(id);
    if (style && style.sheet) {
        return style;
    }
    style = doc.createElement('style');
    style.id = id;
    doc.head.insertBefore(style, doc.head.childNodes[0]);
    return style;
}

function initPrintStyle(doc = document) {
    const print_css = `
@media print {
    html.q-print, html.q-print > body {
        margin: 0 !important;
        box-sizing: border-box !important;
        height: 100% !important;
        width: 100% !important;
        display: flex !important;
        align-items: center !important;
    }
    html.q-print > body > *:not(.q-print__body){
        display: none !important;
    }
}
.q-print__body {
    position: absolute;
    margin: auto;
    top: 0px;
    left: 0px;
    right: 0px;
    bottom: 0px;
    max-width: 100%;
    max-height: 100%;
    flex: 0 0 auto;
}`
    getStyleByID('qunee-styles__print', doc).appendChild(doc.createTextNode(print_css));
}

initPrintStyle();

function showImageInNewWindow(imageInfo, name, print) {
    let win = window.open();
    let doc = win.document;
    doc.title = name || "export image";
    doc.body.style.textAlign = "center";
    doc.body.style.margin = "0px";

    if (print === true) {
        let style = doc.createElement("style");
        style.setAttribute("type", "text/css");
        style.setAttribute("media", "print");
        let printCSS = "img {max-width: 100%; max-height: 100%;}";
        if (imageInfo.width / imageInfo.height > 1.2) {
            printCSS += "\n @page { size: landscape; }";
        } else {
            printCSS += "\n @page { size: portrait; }";
        }
        style.appendChild(doc.createTextNode(printCSS));
        doc.head.appendChild(style);
    }

    let img = doc.createElement("img");
    let imageStyles = {
        'max-width': '100%',
        'max-height': '100%',
        'position': 'absolute',
        'margin': 'auto',
        'top': 0,
        'left': 0,
        'right': 0,
        'bottom': 0
    }
    for (let name in imageStyles) {
        img.style[name] = imageStyles[name];
    }

    if (print === true) {
        img.onload = function () {
            win.print();
            win.close();
        }
    }
    img.src = imageInfo.data;
    doc.body.appendChild(img);
}

function printGraph(graph, bounds, scale) {
    let imageInfo = exportImageInfo(graph, bounds, scale);
    let img = document.createElement("img");
    img.src = imageInfo.data;
    doPrint(img);
}

function exportImageFile(graph, bounds, scale){
    let name = graph.name || 'graph';
    let imageInfo = exportImageInfo(graph, bounds, scale);
    if (!isBlobSupported()) {
        return showImageInNewWindow(imageInfo, name);
    }
    saveImage(imageInfo, name);
}

const maxLength = 32767, maxSize = 16384 * 16384;

function isImageTooBig(width, height) {
    return (Q.isFirefox || Q.isChrome) && width >= maxLength || height >= maxLength || width * height >= maxSize;
}

function exportImageInfo(graph, bounds, scale) {
    scale = parseFloat(scale) || 1;
    let width = Math.ceil(bounds.width * scale);
    let height = Math.ceil(bounds.height * scale);

    if (!isImageTooBig(width, height)) {
        return graph.exportImage(scale, bounds);
    }

    //图片太大，超过<canvas>支持尺寸
    let hCount = Math.ceil((width + 1) / maxLength);
    let vCount = Math.ceil((height + 1) / maxLength);
    let minCells = Math.ceil((width * height + 1) / maxSize);
    if (minCells > hCount * vCount) {
        if (width > height) {
            hCount = Math.ceil(minCells / vCount);
        } else {
            vCount = Math.ceil(minCells / hCount);
        }
    }
    let cellWidth = Math.ceil(width / hCount), cellHeight = Math.ceil(height / vCount);

    function toImage(x, y) {
        let perWidth = cellWidth / scale, perHeight = cellHeight / scale;
        return graph.exportImage(scale, new Q.Rect(bounds.x + x * perWidth, bounds.y + y * perHeight, perWidth, perHeight))
    }

    let svg = '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"' +
        ' width="' + width + '" height="' + height + '">';
    let x = 0;
    while (x < hCount) {
        let y = 0;
        while (y < vCount) {
            let imageInfo = toImage(x, y);
            svg += '<image x="' + x * cellWidth + '" y = "' + y * cellHeight + '" width="' + imageInfo.width + '" height="' + imageInfo.height + '" '
                + 'xlink:href="' + imageInfo.data + '" />';
            y++;
        }
        x++;
    }
    svg += '</svg>';
    return {
        width: width,
        height: height,
        data: 'data:image/svg+xml, ' + svg,
        svg
    }
}

function saveImage(imageInfo, name) {
    if (imageInfo.svg) {
        return saveSVG(imageInfo.svg, name);
    }
    saveCanvas(imageInfo.canvas, name);
}

function saveSVG(svg, name) {
    svg = '<?xml version="1.0" encoding="UTF-8"?>\n' + svg;
    let blob = new Blob([svg], {type: "image/svg+xml"});
    saveAs(blob, name + ".svg");
}

function saveCanvas(canvas, name) {
    let type = "image/png";
    name += '.png';
    if (canvas.toBlob) {
        return canvas.toBlob(function (blob) {
            saveAs(blob, name);
        }, type);
    }

    let binStr = atob(canvas.toDataURL(type).split(',')[1]);
    let len = binStr.length, arr = new Uint8Array(len);

    for (let i = 0; i < len; i++) {
        arr[i] = binStr.charCodeAt(i);
    }
    saveAs(new Blob([arr], {type}), name);
}