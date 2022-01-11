module.exports = class extends think.Logic {
    listAction() {
        this.allowMethods = 'get';
        this.rules = {
            page: {
                default: 1,
                int: true,
                aliasName: '页码'
            },
            limit: {
                default: 20,
                int: true,
                aliasName: '页数'
            }
        }
    }
    addAction() {
        this.allowMethods = 'post';
        this.rules = {
            name: {
                required: true,
                aliasName : '角色名称'
            },
            status: {
                required: true,
                int: true,
                aliasName:'状态'
            },
            rules: {
                required: true,
                aliasName : '权限id集合'
            },
            remark: {
                aliasName : '标注'
            }
        }
    }
    beforEditAction() {
        this.allowMethods = 'get';
        this.rules = {
            id: {
                required: true,
                int: {min : 1}
            }
        }
    }
    editAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                required: true,
                int: { min: 1 }
            },
            name: {
                required: true,
                aliasName: '角色名称'
            },
            status: {
                required: true,
                int: true,
                aliasName: '状态'
            },
            rules: {
                required: true,
                aliasName: '权限id集合'
            },
            remark: {
                aliasName: '标注'
            }
        }
    }
    enableAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                int: { min: 1 },
                required: true,
                aliasName: '角色id'
            },
            status: {
                int: true,
                required: true,
                aliasName: '角色状态'
            }
        }
    }
    //删除
    delAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                int: { min: 2 },
                required: true,
                aliasName: '角色id'
            }
        }
    }

};
