import {hidePopup, showPopup} from "../popup/Popup.js";

let color_input_template = `
    <input class="form-control">
    <div class="q-color">
        <div class="q-color__block"></div>
    </div>
`

let color_picker_template = `
<div class="q-color-picker">
    <div class="q-flex">
        <label>Current color:</label>
        <span class="q-flex__fill q-color__text"></span>
        <div class="q-color">
            <div class="q-color__block"></div>
        </div>
    </div>
    <div class="q-color-spectrum"></div>
    <label>Alpha</label>
    <div class="q-flex">
        <input class="q-alpha__slider q-flex__fill" style="padding: 0px; margin-right: 5px;" type="range" value="100" step="1" min="0" max="100">
        <span class="q-alpha__text">100%</span>
    </div>
</div>`


let is = {
    hex: a => /(^#[0-9A-F]{6}$)|(^#[0-9A-F]{3}$)/i.test(a),
    rgb: a => /^rgb/.test(a),
}


function hexToRgb(hexValue) {
    let rgx = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
    let hex = hexValue.replace(rgx, (m, r, g, b) => r + r + g + g + b + b);
    let rgb = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    let r = parseInt(rgb[1], 16) || 0;
    let g = parseInt(rgb[2], 16) || 0;
    let b = parseInt(rgb[3], 16) || 0;
    return [r, g, b, 1];
}

function colorToRGBA(color) {
    if (is.hex(color)) {
        return hexToRgb(color);
    }
    if (is.rgb(color)) {
        let start = color.indexOf("(");
        let end = color.indexOf(")");
        if (start < 0 || end < start) {
            return;
        }
        color = color.substring(start + 1, end);
        color = color.split(",");
        if (color.length < 3) {
            return;
        }
        let r = parseInt(color[0]) || 0;
        let g = parseInt(color[1]) || 0;
        let b = parseInt(color[2]) || 0;
        if (color.length == 3) {
            return [r, g, b, 1]
        }
        return [r, g, b, parseFloat(color[3])];
    }
}

function createElementByTemplate(html) {
    let template = document.createElement('template');
    if (!template || !template.content) {
        template = document.createElement('div');
        template.innerHTML = html.trim();
        let node = template.childNodes[0];
        template.removeChild(node);
        return node;
    }
    template.innerHTML = html.trim();
    return template.content.firstChild;
}


function isDescendant(parent, child) {
    while (child) {
        if (child === parent) {
            return true;
        }
        child = child.parentNode;
    }
    return false;
}

export function createColorInput({value = '#FFF', onchange, dom}) {
    dom = dom || document.createElement('div');
    dom.classList.add('q-color-input');
    dom.innerHTML = color_input_template.trim();
    let input = dom.getElementsByTagName('input')[0];
    let icon = dom.getElementsByClassName('q-color__block')[0];
    input.value = icon.style.backgroundColor = value;
    input.oninput = function () {
        colorPicker.setValue(input.value);
        icon.style.backgroundColor = colorPicker.value;
        onchange && onchange(input.value);
    }
    let colorPicker = new ColorPicker();
    colorPicker.input = input;
    colorPicker.setValue(value);
    colorPicker.onchange = function (color) {
        icon.style.backgroundColor = input.value = color;
        // input.focus();
        onchange && onchange(color);
    }

    input.onfocus = function () {
        let rect = dom.getBoundingClientRect();
        colorPicker.show(window.pageXOffset + rect.left, window.pageYOffset + rect.top + rect.height + 5);
    }
    input.onblur = function (){
        if(!colorPicker.dom){
            return
        }
        setTimeout(function(){
            if(document.activeElement !== document.body && !isDescendant(colorPicker.dom, document.activeElement)){
                colorPicker.hide();
            }
        })
    }
    return {
        dom,
        input
    };
}

function rgbToColor(rgb, alpha) {
    return alpha === 1 ? 'rgb(' + rgb[0] + ',' + rgb[1] + ',' + rgb[2] + ')'
        : 'rgba(' + rgb[0] + ',' + rgb[1] + ',' + rgb[2] + ',' + alpha.toFixed(2) + ')';
}

class ColorPicker {

    constructor() {
        this.value = '#FFFFFF';
    }
    _init() {
        let dom = this.dom = createElementByTemplate(color_picker_template);

        let color_spectrum = dom.getElementsByClassName('q-color-spectrum')[0];
        let color_text = dom.getElementsByClassName('q-color__text')[0];
        let color_icon = dom.getElementsByClassName('q-color__block')[0];
        let alpha_slider = dom.getElementsByClassName('q-alpha__slider')[0];
        let alpha_text = dom.getElementsByClassName('q-alpha__text')[0];

        let updateValue = function (silent) {
            let value = _rgb ? rgbToColor(_rgb, _alpha) : null;
            color_icon.style.backgroundColor = color_text.innerHTML = value;
            if(value != this.value){
                this.value = value;
                !silent && this.onchange && this.onchange(value);
            }
        }.bind(this)

        let _rgb, _alpha = 1;

        setValue(this.value);

        function setValue(value) {
            _rgb = colorToRGBA(value);
            if(_rgb){
                _alpha = _rgb[3];
                alpha_slider.value = _alpha * 100;
                alpha_text.innerHTML = alpha_slider.value + '%';
            }
            updateValue(true);
        }

        this._setValue = setValue;

        //slider在ie下不支持oninput
        alpha_slider.oninput = alpha_slider.onchange = function () {
            alpha_text.innerHTML = alpha_slider.value + '%';
            _alpha = parseFloat(alpha_slider.value) / 100;
            updateValue();
        };

        appendColorSpectrum(color_spectrum, function (rgb) {
            _rgb = rgb;
            updateValue();
            this.input && this.input.focus();
        }.bind(this))
    }

    show(x, y) {
        if (!this.dom) {
            this._init();
        }
        showPopup(this.dom, x, y, this.input);
        // document.body.appendChild(this.dom);
        // this.dom.style.left = x + 'px';
        // this.dom.style.top = y + 'px';
    }

    hide(){
        this.dom && hidePopup(this.dom);
        // this.dom && this.dom.parentNode && this.dom.parentNode.removeChild(this.dom);
    }

    setValue(value) {
        this.value = value;
        this._setValue && this._setValue(value);
    }
}

function fillLinearGradient(g, width, height, colors, isH, positions) {
    let gradient = isH ? g.createLinearGradient(0, 0, width, 0) : g.createLinearGradient(0, 0, 0, height);
    let step = 1 / (colors.length - 1);
    colors.forEach(function (color, index) {
        if (positions) {
            gradient.addColorStop(positions[index], color);
        } else {
            gradient.addColorStop(index * step, color);
        }
    })
    g.fillStyle = gradient;
    g.fillRect(0, 0, width, height);
}

function appendColorSpectrum(container, onColorChoose) {
    let canvas = document.createElement('canvas');
    container.appendChild(canvas);

    let imageData;

    function toLocal(evt, div) {
        let clientRect = div.getBoundingClientRect();
        return {x: evt.clientX - Math.round(clientRect.left), y: evt.clientY - Math.round(clientRect.top)}
    }

    function init() {
        if(!container.offsetWidth){
            return;
        }
        let ratio = devicePixelRatio || 1;
        let canvasWidth = container.offsetWidth, canvasHeight = container.offsetHeight;
        canvas.width = canvasWidth * ratio;
        canvas.height = canvasHeight * ratio;
        let g = canvas.getContext('2d');
        let hPadding = 5, vPadding = 2;//给两侧留出一定宽度，方便选取黑白颜色
        g.save();
        g.scale(ratio, ratio);
        g.fillStyle = '#F00';
        g.fillRect(0, 0, canvas.width, canvas.height);
        let gradientWidth = canvasWidth - hPadding * 2;
        g.translate(hPadding, vPadding);
        fillLinearGradient(g, gradientWidth, canvasHeight - vPadding * 2, ['#F00', '#FF0', '#0F0', '#0FF', '#00F', '#F0F', '#F00'], false);
        g.translate(0, -vPadding);
        fillLinearGradient(g, gradientWidth, canvasHeight, ['#FFF', 'rgba(255,255,255, 0)', 'rgba(0,0,0,0)', '#000'], true, [0, 0.5, 0.5, 1]);
        g.translate(-hPadding, 0);
        g.fillStyle = '#FFF';
        g.fillRect(0, 0, hPadding, canvasHeight);
        g.fillStyle = '#000';
        g.fillRect(canvasWidth - hPadding, 0, hPadding, canvasHeight);

        g.restore();

        imageData = g.getImageData(0, 0, canvas.width, canvas.height).data;

        canvas.onmousedown = canvas.onmousemove = function (evt) {
            if (!evt.buttons) {
                return
            }
            evt.preventDefault();
            evt.stopPropagation();
            let xy = toLocal(evt, canvas);
            let color = getRGB(xy.x * ratio, xy.y * ratio);
            onColorChoose && onColorChoose(color);
        }.bind(this)
    }

    container.offsetWidth ? init() : setTimeout(init.bind(this));

    function getRGB(x, y) {
        if (x < 0) {
            x = 0;
        } else if (x > canvas.width) {
            x = canvas.width;
        }
        if (y < 0) {
            y = 0;
        } else if (y > canvas.height - 1) {
            y = canvas.height - 1;
        }
        let index = (y * canvas.width + x) * 4;

        return [imageData[index++], imageData[index++], imageData[index++]];
    }
}
