<template>
    <div class="q-graph-editor">
        <div ref="toolbar_pane" class="toolbar">
            <Toolbar ref="toolbar" style="display: inline-block;"/>
        </div>
        <div style="display: flex; width: 100%; flex: 1 1 auto; overflow: hidden;">
            <ToolBox ref="toolbox" class="toolbox" style="flex: 1 0 200px;"></ToolBox>
            <div style="position: relative; flex: 10 1 500px;">
                <div ref="canvas" style="width: 100%; height: 100%;"></div>
                <div ref="overview"
                     style="background-color: rgba(255, 255, 255, 0.8); position: absolute; right: 0px; top: 0px; width: 200px; height: 150px; margin: 10px;"></div>
                <PropertyPane ref="property" class="property"></PropertyPane>
                <div ref="json_pane" class="json-pane" style="display: none;">
                    <textarea ref="json_textarea" spellcheck="false"></textarea>
                    <div ref="json_btn_group" class="btn-group" style="position: absolute; top: 5px; right: 20px;">
                        <div class="btn" @click="exportJSON">Update</div>
                        <div class="btn" @click="submitJSON">Submit</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import {getI18NString} from '../i18n.js';
import Q from '../../lib/qunee-es.js';

Q.Defaults.ADD_SEGMENT_TYPE = 'line';

Q.Defaults.DELAY_CLICK = false;

export default {
    components: {
        ToolBox,
        Toolbar,
        PropertyPane
    },
    mounted() {
        let graph = this.graph = new Q.Graph(this.$refs.canvas);
        let overview = new Overview(this.$refs.overview, graph);
        this.toolbar = this.$refs.toolbar.toolbar;
        this.toolbox = this.$refs.toolbox.toolbox;
        this.initPopupMenu(graph);
        graph.editable = true;
        graph.originAtCenter = false;

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
                let el = this.$el;
                let isMax = !el.classList.contains('q-max');
                isMax ? evt.currentTarget.classList.add('active') : evt.currentTarget.classList.remove('active');
                isMax ? el.classList.add('q-max') : el.classList.remove('q-max');
                graph.updateViewport();
            }
        }], this);
        demoBtnGroup.style.float = 'right';
        this.$refs.toolbar_pane.appendChild(demoBtnGroup);
    },
    methods: {
        setEditable(editable) {
            this.graph.editable = editable;
            this.graph.interactionMode = editable ? Q.Consts.INTERACTION_MODE_DEFAULT : Q.Consts.INTERACTION_MODE_VIEW;
            this.graph.updateViewport();

            this.$refs.toolbar.toolbar.setMode(editable ? 'default' : 'view');
            function setVisible(div, visible) {
                (div.$el || div).style.display = visible ? '' : 'none';
            }
            setVisible(this.$refs.toolbox, editable);
            setVisible(this.$refs.property, editable);
            setVisible(this.$refs.json_btn_group, editable);
        },
        exportJSON() {
            this.$refs.json_textarea.value = exportJSON(this.graph, true, {space: '  '});
        },
        submitJSON() {
            let json = this.$refs.json_textarea.value;
            this.graph.clear();
            parseJSON(json, this.graph);
        },
        initPopupMenu(graph){
            addFlowSupport(graph);
            let popupmenu = graph.popupmenu = new PopupMenu(graph);
            let superGetMenuItems = popupmenu.getMenuItems;
            popupmenu.getMenuItems = function(graph, element, evt){
                let items = superGetMenuItems.apply(this, arguments);
                if(!element){
                    return items;
                }
                if(element instanceof Q.Group){
                    items.unshift({
                        text: 'Ellipse Group',
                        action(){
                            element.groupType = Q.Consts.GROUP_TYPE_ELLIPSE;
                        }
                    })
                    items.unshift({
                        text: 'Rect Group',
                        action(){
                            element.groupType = Q.Consts.GROUP_TYPE_RECT;
                        }
                    })
                }
                if(element instanceof Q.Edge || element instanceof Q.ShapeNode){
                    let flow = element.flow !== true;
                    items.unshift({
                        text: flow ? 'Flow' : 'Stop Flow',
                        action(){
                            element.flow = flow;
                        }
                    })
                }
                return items;
            }

        },
    }
}
import ToolBox from "@/common/toolbox/ToolBox.vue";
import Toolbar from "@/common/toolbar/Toolbar.vue";
import PropertyPane from "@/common/property/PropertyPane.vue";
import {PopupMenu} from "@/common/popup/PopupMenu";
import '../css/global.css';
import '../popup/popup.css';
import './graph.editor.css';
import {Overview} from "@/common/overview/Overview";
import {createButtonGroup} from "@/common/toolbar/Toolbar";
import {exportJSON, parseJSON} from "../io/JSONSerializer.js";
import {addFlowSupport} from "@/js/FlowSupport";

</script>