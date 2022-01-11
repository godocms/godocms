function getPageXY(evt) {
    if (evt.touches && evt.touches.length) {
        evt = evt.touches[0];
    }
    return {x: evt.pageX, y: evt.pageY};
}

function showDivAt(div, x, y) {
    if (!div.parentElement) {
        document.body.appendChild(div);
    }
    if (x instanceof MouseEvent) {
        var xy = getPageXY(x);
        x = xy.x;
        y = xy.y;
    }

    var body = document.documentElement;
    var bounds = {x: window.pageXOffset, y: window.pageYOffset, width: body.clientWidth - 2, height: body.clientHeight - 2}
    var width = div.offsetWidth;
    var height = div.offsetHeight;

    if (x + width > bounds.x + bounds.width) {
        x = bounds.x + bounds.width - width;
    }
    if (x < bounds.x) {
        x = bounds.x;
    }
    if (y + height > bounds.y + bounds.height) {
        y = bounds.y + bounds.height - height;
    }
    if (y < bounds.y) {
        y = bounds.y;
    }
    div.style.left = x + 'px';
    div.style.top = y + 'px';
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

export function showPopup(div, x, y, host) {
    if (typeof div == 'string') {
        div = document.getElementById(div);
        if (!div) {
            throw new Error('div cannot be found');
        }
    }
    if (div.style.display === 'none') {
        div.style.display = '';
    }
    showDivAt(div, x, y);
    autoHide(div, host);
}

export function hidePopup(div) {
    div.parentNode && div.parentNode.removeChild(div);
    if (div._onWindowMousedown) {
        window.removeEventListener("mousedown", div._onWindowMousedown);
        div._onWindowMousedown = null;
    }
}

function isInDom(e) {
    if (document.contains) {
        return document.contains(e);
    }
    while (e.parentNode) e = e.parentNode;
    return e === document;
}

/**
 * 自动隐藏，点击组件外面，或者esc时，自动隐藏组件
 */
function autoHide(div, host) {
    div.__host = host;
    if (!div._onWindowMousedown) {
        div._onWindowMousedown = function (evt) {
            if (!isInDom(this)) {
                hidePopup(this);
            }
            if (isDescendant(this, evt.target) || (this.__host && isDescendant(this.__host, evt.target))) {
                return;
            }
            // var xy = getPageXY(evt);
            // if (inBounds(this, xy.x, xy.y)) {
            //     return;
            // }
            hidePopup(this);
        }.bind(div)
    }
    window.addEventListener("mousedown", div._onWindowMousedown, true);
}
