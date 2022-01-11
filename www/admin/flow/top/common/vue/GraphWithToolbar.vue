<template>
    <div style="position: relative;">
        <div ref="canvas" style="width: 100%; height: 100%;"/>
        <Toolbar style="position: absolute; top: 0px; margin: 5px; width: 100%;"/>
    </div>
</template>

<script>
import Q from '../../lib/qunee-es.js';
import Toolbar from "@/common/toolbar/Toolbar.vue";

export default {
    components: {
        Toolbar
    },
    mounted() {
        this.graph = new Q.Graph(this.$refs.canvas);
    }
}
</script>