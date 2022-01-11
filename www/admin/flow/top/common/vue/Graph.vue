<template>
    <div/>
</template>
<script>
import Q from '../../lib/qunee-es.js';

export default {
    mounted() {
        this.graph = new Q.Graph(this.$el);
    },
    methods: {}
}
</script>