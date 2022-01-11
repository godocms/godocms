import Q from "../lib/qunee-es.js";
import {GridBackground} from "./GridBackground.js";
import {parseJSON} from "../common/io/JSONSerializer.js";

Q.registerImage('lamp', Q.Shapes.getShape(Q.Consts.SHAPE_CIRCLE, -8, -8, 16, 16));

let lampGradient = new Q.Gradient(Q.Consts.GRADIENT_TYPE_RADIAL, [Q.toColor(0xAAFFFFFF), Q.toColor(0x33EEEEEE), Q.toColor(0x44888888), Q.toColor(0x33666666)],
    [0.1, 0.3, 0.7, 0.9], 0, -0.2, -0.2);

Q.Group.prototype.linkable = false;

function createLampStyles(color) {
    let styles = {};
    styles[Q.Styles.SHAPE_FILL_COLOR] = color;
    styles[Q.Styles.SHAPE_STROKE] = 0.5;
    styles[Q.Styles.SHAPE_STROKE_STYLE] = '#CCC';
    styles[Q.Styles.LABEL_BACKGROUND_COLOR] = '#FF0';
    styles[Q.Styles.SHAPE_FILL_COLOR] = color;
    styles[Q.Styles.LABEL_SIZE] = {width: 100, height: 20};
    styles[Q.Styles.LABEL_PADDING] = 5;
    styles[Q.Styles.LABEL_OFFSET_Y] = -10;
    styles[Q.Styles.SHAPE_FILL_GRADIENT] = lampGradient;
    styles[Q.Styles.LABEL_POSITION] = 'ct';
    styles[Q.Styles.LABEL_ANCHOR_POSITION] = 'lb';
    return styles;
}

let customShape = new Q.Path();
customShape.moveTo(-200, -50);
customShape.lineTo(200, -50);
customShape.lineTo(200, 50);
customShape.lineTo(-100, 50);

let editor_config = {
    images: [
        {
            name: '自定义Shape',
            images: [{
                image: 'lamp', customDrop: true
            }
            ]
        },{
        //     name: 'Cisco图标',
        //     root: 'data/cisco/',
        //     images: ['ATMSwitch.png', 'multilayerSwitch.png', 'workgroupSwitch.png', 'workgroupSwitchSubdued.png', '100BaseT_hub.png', 'cisco_hub.png', 'switch1100.png']
        // }, {
            name: '自定义图标',
            imageWidth: 30,
            imageHeight: 30,
            images: [{
                image: 'lamp',
                properties: {
                    name: 'Message'
                },
                styles: createLampStyles('#F00')
            }, {
                image: 'lamp',
                properties: {
                    name: 'Message'
                },
                br: true,
                styles: createLampStyles('#FF0')
            }, {
                image: 'lamp',
                properties: {
                    name: 'Message'
                },
                styles: createLampStyles('#0F0')
            }, {
                image: 'lamp',
                properties: {
                    name: 'Message'
                },
                styles: createLampStyles('#0FF')
            }, {
                image: 'lamp',
                properties: {
                    name: 'Message'
                },
                styles: createLampStyles('#00F')
            }, {
                image: 'lamp',
                properties: {
                    name: 'Message'
                },
                styles: createLampStyles('#F0F')
            }]
        }],
    callback: function (editor) {
        let graph = editor.graph;
        let defaultStyles = graph.styles = {};
        defaultStyles[Q.Styles.ARROW_TO] = false;

        graph.dropAction = function (evt, xy, info) {
            if (!info.customDrop) {
                return
            }
            //自己处理拖拽事件，返回false时，qunee就不再处理
            let shape = this.createShapeNode('自定义shape', customShape, xy.x, xy.y);
            return false;
        }

        graph.moveToCenter();
        // graph.createNode('10000', 10000, 10000);

        new GridBackground(graph);

        let currentCell = 10;

        function snapToGrid(x, y) {
            let gap = currentCell;
            x = Math.round(x / gap) * gap;
            y = Math.round(y / gap) * gap;
            return [x, y];
        }

        /**
         * 根据拖拽信息，找到拖拽源头对象
         */
        function findDragTargetByDropEvent(dropEvent){
            let dragInfo = dropEvent.dataTransfer.getData('text');
            let parent = editor.toolbox.dom;
            let list = parent.querySelectorAll('[draggable=true]');
            let i = 0, l = list.length;
            while(i < l){
                let item = list[i++];
                if(item.getAttribute('draginfo') === dragInfo){
                    return item.parentElement;
                }
            }
        }

        graph.interactionDispatcher.addListener(function (evt) {
            if (evt.kind == Q.InteractionEvent.ELEMENT_CREATED) {
                // let target = findDragTargetByDropEvent(evt.event);
                // if(target){
                //     target.parentElement.removeChild(target);
                // }

                let node = evt.data;
                if (!(node instanceof Q.Node)) {
                    return
                }
                let ps = snapToGrid(node.x, node.y);
                node.setLocation(ps[0], ps[1]);
                if (node instanceof Q.ShapeNode) {
                    node.zIndex = 10;
                }
                return;
            }
            if (evt.kind == Q.InteractionEvent.ELEMENT_MOVE_END) {
                let datas = evt.datas;
                datas.forEach(function (node) {
                    if (!(node instanceof Q.Node) || node instanceof Q.Group) {
                        return
                    }
                    let ps = snapToGrid(node.x, node.y);
                    node.setLocation(ps[0], ps[1]);
                });
                return;
            }
            // if (evt.kind == Q.InteractionEvent.POINT_MOVE_END) {
            //     let line = evt.data;
            //     Q.log(evt.point);
            //     let segment = evt.point.segment;
            //     segment.points = snapToGrid(segment.points[0], segment.points[1]);
            //     line.invalidate();
            //     return;
            // }
        });
    }
}

export function initDemo(editor, dataUrl){
    let graph = editor.graph;
    editor.toolbox.loadImageBox(editor_config.images);
    dataUrl && Q.loadJSON(dataUrl, function (json) {
        parseJSON(json, graph);
        graph.moveToCenter();
    })
    editor_config.callback(editor);
}
export function fromJson(editor, json) {
    if (!json) {
        json = {
            "version": "1.0",
            "refs": {}
        };
    }
    let graph = editor.graph;
    editor.toolbox.loadImageBox(editor_config.images);
    parseJSON(json, graph);
    graph.moveToCenter();
    editor_config.callback(editor);
}
