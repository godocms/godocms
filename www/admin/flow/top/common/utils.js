export function createElement({tagName = 'div', className, parent, html}) {
    let element = document.createElement(tagName);
    className && (element.className = className);
    parent && parent.appendChild(element);
    html && (element.innerHTML = html);
    return element;
}

export function getQStyleSheet() {
    const q_style_id = 'qunee-styles';
    let q_style = document.getElementById(q_style_id);
    if(q_style && q_style.sheet){
        return q_style.sheet;
    }
    let head = document.head;
    let style = document.createElement('style');
    style.id = q_style_id;
    head.insertBefore(style, head.childNodes[0]);
    return style.sheet;
}
