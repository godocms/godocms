<template>

</template>

<script>
import "./toolbox.css";
import {ToolBox} from "./ToolBox.js";

export default {
    name: "ToolBox",
    mounted() {
        this.toolbox = new ToolBox(this.$el);
    }
}
</script>