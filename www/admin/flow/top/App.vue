<template>
    <div id="app">
        
        <GraphEditor id="editor" ref="editor"/>
        <footer id="footer" role="contentinfo">
        </footer>
    </div>
</template>

<script>
import GraphEditor from "@/common/vue/GraphEditor";
export default {
    components: {
        GraphEditor
    },
    mounted() {
        let editor = this.$refs.editor;
        initDemo(editor, 'data/topo2.json');
    }
}

import './app.css';
import './common/css/global.css';
import {initDemo} from "./js/main.js";

</script>