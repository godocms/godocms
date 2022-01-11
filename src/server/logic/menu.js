module.exports = class extends think.Logic {
    /**
     * 获取单个菜单数据
     */
    oneAction() {
        this.allowMethods = 'get';
        this.rules = {
            id: {
                required: true,
                int: { min: 0 },
                aliasName: '菜单id'
            }
        }
    }
    /**
     * 添加校验
     */
    addAction() {
        this.allowMethods = 'post';
        this.rules = {
            title: {
                required: true,
                aliasName: '菜单名称'
            },
            href: {
                aliasName: '前端模版'
            },
            route: {
                required: true,
                aliasName: '后端路由'
            },
            icon: {
                aliasName: '菜单icon'
            },
            type: {
                required: true,
                int: true,
                aliasName : '菜单类型'
            },
            desktop: {
                required: true,
                int: true,
                aliasName: '桌面推荐'
            },
            order_num: {
                int: true,
                aliasName: '菜单排序'
            },
            pid: {
                required: true,
                int: true,
                aliasName : '上级id'
            }

        }
    }
    /**
     * 编辑校验
     */
    editAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                required: true,
                int : {min : 1},
                aliasName: '菜单id'
            },
            title: {
                required: true,
                aliasName: '菜单名称'
            },
            href: {
                aliasName: '前端模版'
            },
            route: {
                required: true,
                aliasName: '后端路由'
            },
            icon: {
                aliasName: '菜单icon'
            },
            type: {
                required: true,
                int: true,
                aliasName: '菜单类型'
            },
            desktop: {
                required: true,
                int: true,
                aliasName: '桌面推荐'
            },
            order_num: {
                int: true,
                aliasName: '菜单排序'
            },
            pid: {
                required: true,
                int: true,
                aliasName: '上级id'
            }

        }
    }
    /**
     * 显示校验
     */
    ifshowAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                int: {min : 1},
                required: true,
                aliasName: '菜单id'
            },
            ifshow: {
                int: true,
                required: true,
                aliasName : '菜单状态'
            }
        }
    }
    //删除
    delAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                int: { min: 1 },
                required: true,
                aliasName: '菜单id'
            }
        }
    }
    editDataAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                int: { min: 1 },
                required: true,
                aliasName: '菜单id'
            },
            field: {
                required: true,
                aliasName : '字段名称'
            },
            value: {
                required: true,
                aliasName : '字段值'
            }
        }
    }
    
};
