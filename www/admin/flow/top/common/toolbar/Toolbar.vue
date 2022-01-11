<template>
    <div/>
</template>

<script>
import "@/common/toolbar/toolbar.css";
import '@/common/modal/dialog.css';

import {Toolbar} from "@/common/toolbar/Toolbar.js";

export default {
    name: "Toolbar",
    props: ['graph'],
    mounted() {
        this.toolbar = new Toolbar(this.$el);
        setTimeout(function () {
            let graph = this.$parent;
            if (this.graph) {
                graph = graph.$refs[this.graph] || graph;
            }
            this.toolbar.setGraph(graph.graph);
        }.bind(this))
    }
}
</script>
