<template>
<div class="q-property-pane"/>
</template>

<script>
import './form.css';
import './property.css';
import '../color-picker/color-picker.css';
import {PropertyPane} from "./PropertyPane.js";

export default {
name: "PropertyPane",
    props: ['graph'],
    mounted() {
        setTimeout(function () {
            let graph = this.$parent;
            if (this.graph) {
                graph = graph.$refs[this.graph] || graph;
            }
            graph = graph.graph;
            this.propertyPane = new PropertyPane(graph, this.$el);
        }.bind(this))
    }
}
</script>