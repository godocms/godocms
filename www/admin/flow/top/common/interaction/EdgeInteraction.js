export class EdgeInteraction extends Q.DrawableInteraction{
    doDraw (g, scale) {

    }
    onmousemove(evt, graph){
        if (!this.element) {
            return;
        }
        // var data = this.element;
        // var edgeType = data.edgeType;
        // var edgeUI = graph.getUI(data);
        // var fromUI = graph.getUI(data.fromAgent);
        // var toUI = graph.getUI(data.toAgent);
        // var sourceBounds = edgeUI.getEndPointBounds(fromUI);
        // var targetBounds = edgeUI.getEndPointBounds(toUI);
        //
        // var xGap = calculateXGap(sourceBounds, targetBounds);
        // var yGap = calculateYGap(sourceBounds, targetBounds);
        // Q.log('xGap', xGap, 'yGap', yGap);
    }
    onstart(evt, graph) {
        if (this.element) {
            return;
        }
        var data = graph.getElement(evt);
        if (!(data instanceof Q.Edge) || this.element == data || !isOrthogonalEdge(data)) {
            return;
        }
        this.element = data;

        var edgeType = data.edgeType;
        var edgeUI = graph.getUI(data);
        var fromUI = graph.getUI(data.fromAgent);
        var toUI = graph.getUI(data.toAgent);
        var sourceBounds = edgeUI.getEndPointBounds(fromUI);
        var targetBounds = edgeUI.getEndPointBounds(toUI);

        var isH = isHorizontal(edgeType, sourceBounds, targetBounds);

        var split_value;
        if(graph.getStyle(data, Q.Styles.EDGE_SPLIT_BY_PERCENT)){
            var split_percent = graph.getStyle(data, Q.Styles.EDGE_SPLIT_PERCENT);
            Q.log('split_percent', split_percent)
            split_value = split_percent * (isH ? calculateXGap(sourceBounds, targetBounds) : calculateYGap(sourceBounds, targetBounds));
        }else{
            split_value = graph.getStyle(data, Q.Styles.EDGE_SPLIT_VALUE);
        }
    }
    startdrag(evt) {
        if (!this.element) {
            return;
        }

    }
    ondrag(evt) {
        if (!this.element) {
            return;
        }

    }
    enddrag(evt) {
        if (!this.element) {
            return;
        }

    }
}

function OrthogonalEdgeInteraction(graph) {
    Q.doSuperConstructor(this, OrthogonalEdgeInteraction, arguments);
}

function isOrthogonalEdge(edge) {
    if (edge.hasPathSegments()) {
        return false;
    }
    var type = edge.edgeType;
    return type == Q.Consts.EDGE_TYPE_ORTHOGONAL
        || type == Q.Consts.EDGE_TYPE_ORTHOGONAL_HORIZONTAL
        || type == Q.Consts.EDGE_TYPE_HORIZONTAL_VERTICAL
        || type == Q.Consts.EDGE_TYPE_ORTHOGONAL_VERTICAL
        || type == Q.Consts.EDGE_TYPE_VERTICAL_HORIZONTAL
        || type == Q.Consts.EDGE_TYPE_EXTEND_TOP
        || type == Q.Consts.EDGE_TYPE_EXTEND_LEFT
        || type == Q.Consts.EDGE_TYPE_EXTEND_BOTTOM
        || type == Q.Consts.EDGE_TYPE_EXTEND_RIGHT;
}

function calculateXGap(sourceBounds, targetBounds) {
    var sumWidth = Math.max(sourceBounds.x + sourceBounds.width, targetBounds.x
        + targetBounds.width)
        - Math.min(sourceBounds.x, targetBounds.x);
    return sumWidth - sourceBounds.width - targetBounds.width;
}

function calculateYGap(sourceBounds, targetBounds) {
    var sumHeight = Math.max(sourceBounds.y + sourceBounds.height,
        targetBounds.y + targetBounds.height)
        - Math.min(sourceBounds.y, targetBounds.y);
    return sumHeight - sourceBounds.height - targetBounds.height;
}

function isHorizontal(edgeType, sourceBounds, targetBounds) {
    if (edgeType != null) {
        if (edgeType == Consts.EDGE_TYPE_ELBOW_HORIZONTAL
            || edgeType == Consts.EDGE_TYPE_ORTHOGONAL_HORIZONTAL
            || edgeType == Consts.EDGE_TYPE_HORIZONTAL_VERTICAL
            || edgeType == Consts.EDGE_TYPE_EXTEND_LEFT
            || edgeType == Consts.EDGE_TYPE_EXTEND_RIGHT) {
            return true;
        } else if (edgeType == Consts.EDGE_TYPE_ELBOW_VERTICAL
            || edgeType == Consts.EDGE_TYPE_ORTHOGONAL_VERTICAL
            || edgeType == Consts.EDGE_TYPE_VERTICAL_HORIZONTAL
            || edgeType == Consts.EDGE_TYPE_EXTEND_TOP
            || edgeType == Consts.EDGE_TYPE_EXTEND_BOTTOM) {
            return false;
        }
    }
    var xGap = calculateXGap(sourceBounds, targetBounds);
    var yGap = calculateYGap(sourceBounds, targetBounds);
    return xGap >= yGap;
}