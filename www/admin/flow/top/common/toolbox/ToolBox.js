import Q from '../../lib/qunee-es.js';
import {appendDNDInfo} from "../toolbox/DragSupport.js";
import {getI18NString} from "../i18n.js";

let createElement = function (className, parent, tag, html) {
    let element = document.createElement(tag || 'div');
    element.className = className;
    html && (element.innerHTML = html);
    if (parent) {
        parent.appendChild(element);
    }
    return element;
}

let forEach = function (object, call, scope) {
    if (Array.isArray(object)) {
        return object.forEach(function (v) {
            call.call(this, v);
        }, scope);
    }
    for (let name in object) {
        call.call(scope, object[name], name);
    }
}
let defaultImageStyles = {
    fillColor: '#EEE',
    lineWidth: 1,
    strokeStyle: '#2898E0',
    padding: {left: 1, top: 1, right: 5, bottom: 5},
    shadowColor: '#888',
    shadowOffsetX: 2,
    shadowOffsetY: 2,
    shadowBlur: 3
}
let nodeImageStyles = {};
nodeImageStyles[Q.Styles.RENDER_COLOR] = 'renderColor';
nodeImageStyles[Q.Styles.RENDER_COLOR_BLEND_MODE] = 'renderColorBlendMode';
nodeImageStyles[Q.Styles.SHAPE_FILL_COLOR] = 'fillColor';
nodeImageStyles[Q.Styles.SHAPE_STROKE_STYLE] = 'strokeStyle';
nodeImageStyles[Q.Styles.SHAPE_LINE_DASH] = 'borderLineDash';
nodeImageStyles[Q.Styles.SHAPE_LINE_DASH_OFFSET] = 'borderLineDashOffset';
//nodeImageStyles[Q.Styles.SHAPE_FILL_GRADIENT] = 'fillGradient';
nodeImageStyles[Q.Styles.SHAPE_OUTLINE] = 'outline';
nodeImageStyles[Q.Styles.SHAPE_OUTLINE_STYLE] = 'outlineStyle';
nodeImageStyles[Q.Styles.LINE_CAP] = 'lineGap';
nodeImageStyles[Q.Styles.LINE_JOIN] = 'lineJoin';
nodeImageStyles[Q.Styles.BACKGROUND_COLOR] = 'backgroundColor';
nodeImageStyles[Q.Styles.BACKGROUND_GRADIENT] = 'backgroundGradient';
nodeImageStyles[Q.Styles.BORDER] = 'border';
nodeImageStyles[Q.Styles.BORDER_COLOR] = 'borderColor';
nodeImageStyles[Q.Styles.BORDER_LINE_DASH] = 'borderLineDash';
nodeImageStyles[Q.Styles.BORDER_LINE_DASH_OFFSET] = 'borderLineDashOffset';
//Styles.IMAGE_BACKGROUND_COLOR = "image.background.color";
//Styles.IMAGE_BACKGROUND_GRADIENT = "image.background.gradient";
//Styles.IMAGE_BORDER = "image.border.width";
//Styles.IMAGE_BORDER_STYLE = Styles.IMAGE_BORDER_COLOR = "image.border.style";
//Styles.IMAGE_BORDER_LINE_DASH = "image.border.line.dash";
//Styles.IMAGE_BORDER_LINE_DASH_OFFSET = "image.border.line.dash.offset";
//Styles.IMAGE_RADIUS = Styles.IMAGE_BORDER_RADIUS = "image.radius";
//Styles.IMAGE_PADDING = "image.padding";


function mixStyles(styles) {
    if (!styles) {
        return defaultImageStyles;
    }
    let result = {};
    for (let name in defaultImageStyles) {
        result[name] = defaultImageStyles[name];
    }
    for (let name in styles) {
        let propertyName = nodeImageStyles[name];
        if (propertyName) {
            result[propertyName] = styles[name];
        }
    }
    return result;
}

let onGroupTitleClick = function (evt) {
    let parent = evt.target.parentNode;
    while (parent && !parent.classList.contains('q-group')) {
        parent = parent.parentNode;
    }
    closeGroup(parent);
}

function closeGroup(parent, open) {
    if (!parent) {
        return;
    }
    if (open === undefined) {
        open = parent.classList.contains('q-group--closed');
    }
    if (open) {
        parent.classList.remove('q-group--closed');
    } else {
        parent.classList.add('q-group--closed');
    }
}

function isImage(image) {
    return typeof image === 'string' || image.draw instanceof Function;
}

export class ToolBox {
    constructor(html, groups) {
        this.imageWidth = 40;
        this.imageHeight = 40;
        this._groups = {};
        this._index = 0;

        this.dom = html;
        this.init(groups);
    }


    loadImageBox(json, insert) {
        if (typeof json === 'string') {
            json = JSON.parse(json);
        }
        if (Array.isArray(json)) {
            return json.forEach(function(item){
                this.loadImageBox(item, insert);
            }.bind(this));
        }
        if (insert) {
            let firstGroup = this.dom.getElementsByClassName('q-group').item(0);
            if (firstGroup) {
                this.dom.insertBefore(this._createGroup(json, json.prefix), firstGroup);
                return;
            }
        }
        return this.dom.appendChild(this._createGroup(json, json.prefix));
    }

//初始化拖拽节点列表
    init(groups) {
        let toolbox = this.dom;
        toolbox.classList.add('q-toolbox');
        // if (isRequestFileSupported()) {
        //     let buttonBar = createElement('q-toolbox__button-bar', toolbox);
        //     buttonBar.appendChild(createButton({
        //         type: 'file',
        //         name: getI18NString('Load Images...'),
        //         iconClass: 'q-icon toolbar-add',
        //         action(files) {
        //             //加载图元库文件
        //             if (!files[0]) {
        //                 return;
        //             }
        //             readTextFile(files[0], 'json', function (json) {
        //                 if (json) {
        //                     this.loadImageBox(json, true);
        //                 }
        //             }.bind(this));
        //         }
        //     }, this));
        // }
        let basicNodes = [{
            label: 'Node',
            image: 'Q-node'
        }, {
            type: 'Text',
            label: 'Text',
            html: '<span style="background-color: #2898E0; color:#FFF; padding: 3px 5px;">' + getI18NString('Text') + '</span>',
            styles: {
                'label.background.color': '#2898E0',
                'label.color': '#FFF',
                'label.padding': new Q.Insets(3, 5)
            }
        }, {
            type: 'Group',
            label: 'Group',
            image: 'Q-group',
            properties: {
                // groupType: Q.Consts.GROUP_TYPE_ELLIPSE,
                minSize: {width: 100, height: 100, x: 0, y: 0}
            }
        }, {
            label: 'SubNetwork',
            image: 'Q-subnetwork',
            properties: {enableSubNetwork: true}
        }];

        let innerGroups = [{prefix: 'Q-', name: 'basic.nodes', displayName: getI18NString('Basic Nodes'), images: basicNodes}, {
            prefix: 'Q-',
            name: 'register.images',
            displayName: getI18NString('Register Images'),
            images: Q.getAllImages(),
            close: true
        }, {
            name: 'default.shapes',
            displayName: getI18NString('Default Shapes'),
            prefix: 'Q-',
            images: Q.Shapes.getAllShapes(this.imageWidth, this.imageHeight),
            close: true
        }];
        this.loadImageBox(innerGroups);
        if (groups) {
            this.loadImageBox(groups);
        }
        Q.Shapes.getShape(Q.Consts.SHAPE_CIRCLE, 100, 100)
    }

    _getGroup(name) {
        return this._groups[name];
    }

    hideDefaultGroups() {
        this.hideGroup('basic.nodes');
        this.hideGroup('register.images');
        this.hideGroup('default.shapes');
    }

    hideGroup(name) {
        let group = this._getGroup(name);
        if (group) {
            group.style.display = 'none';
        }
    }

    showGroup(name) {
        let group = this._getGroup(name);
        if (group) {
            group.style.display = '';
        }
    }

    _createGroup(groupInfo) {
        let name = groupInfo.name;
        let root = groupInfo.root || '';
        let images = groupInfo.images;
        let close = groupInfo.close;
        let displayName = groupInfo.displayName || name;

        let group = createElement('q-group');
        group.id = name;
        this._groups[name] = group;

        let title = createElement('q-group__title', group);
        title.onclick = onGroupTitleClick;
        createElement(null, title, 'span', displayName);
        createElement('q-icon group-expand toolbar-expand', title, 'span');
        let items = createElement('q-group__items', group);
        let clearDiv = document.createElement('div');
        clearDiv.style.clear = 'both';
        group.appendChild(clearDiv);
        if (close) {
            closeGroup(group);
        }

        if (!images) {
            return group;
        }

        //let images = [{
        //    type: '图元类型',
        //    label: '图元文本',
        //    image: '图元图片',
        //    imageName: '图片名称',
        //    styles: '图元样式',
        //    properties: '图元属性',
        //    clientProperties: '图元client属性',
        //    html: '拖拽html内容'
        //}, 'a.png', {draw(g){}}];
        //let group = {
        //    name: '分组名称',
        //    root: '根目录',
        //    imageWidth: '',
        //    imageHeight: '',
        //    size: 'q-icon size',
        //    images: images//'拖拽图片信息'
        //}

        let imageWidth = groupInfo.imageWidth || this.imageWidth;
        let imageHeight = groupInfo.imageHeight || this.imageHeight;
        let showLabel = groupInfo.showLabel;

        function fixImagePath(image, name, isIcon) {
            if (!image) {
                return image;
            }
            if (typeof image === 'string') {
                return root + image;
            }
            if (image.draw instanceof Function) {
                if (isIcon) {
                    return image;
                }
                let imageName = image.imageName || image.name || name || 'drawable-' + this._index++;
                if (!Q.hasImage(imageName)) {
                    Q.registerImage(imageName, image);
                }
                return imageName;
            }
            throw new Error('image format error');
        }

        forEach(images, function (imageInfo, name) {
            if (name == '_classPath' || name == '_className') {
                return;
            }

            let image, icon;
            if (isImage(imageInfo)) {
                icon = image = fixImagePath(imageInfo, name);
                imageInfo = {
                    image: image
                }
            } else {
                image = imageInfo.image = fixImagePath(imageInfo.image, name);
                icon = imageInfo.icon ? fixImagePath(imageInfo.icon, name, true) : image;
            }

            let imageDiv, tooltip;
            if (imageInfo.html) {
                imageDiv = document.createElement('div');
                imageDiv.style.width = imageWidth + 'px';
                imageDiv.style.height = imageHeight + 'px';
                imageDiv.style.lineHeight = imageHeight + 'px';
                imageDiv.style.overflow = 'hidden';
                imageDiv.innerHTML = imageInfo.html;
            } else if (icon) {
                imageDiv = Q.createCanvas(imageWidth, imageHeight, true);
                Q.drawImage(icon, imageDiv, mixStyles(imageInfo.styles));
                if (groupInfo.size) {
                    if (!imageInfo.properties) {
                        imageInfo.properties = {}
                    }
                    if (!imageInfo.properties.size) {
                        imageInfo.properties.size = groupInfo.size;
                    }
                }
                tooltip = image;
            } else {
                return;
            }
            tooltip = imageInfo.tooltip || imageInfo.label || tooltip || name;
            imageDiv.setAttribute('title', tooltip);
            let item = createElement('q-group__item', items);
            appendDNDInfo(imageDiv, imageInfo);
            item.appendChild(imageDiv);
            if (tooltip && (showLabel || imageInfo.showLabel)) {
                let sortName = tooltip;
                let sortLength = 10;
                if (sortName.length > sortLength) {
                    sortName = '...' + sortName.substring(sortName.length - sortLength + 2)
                }
                let label = document.createElement('div');
                label.style.lineHeight = '1em';
                label.style.overFlow = 'hide'
                label.style.marginTop = '0px'
                label.textContent = sortName;
                item.appendChild(label);
            }
            if (imageInfo.br) {
                items.appendChild(document.createElement('br'));
            }

        }, this)
        return group;
    }
}