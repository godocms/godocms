module.exports = class extends think.Logic {
    listAction() {
        this.allowMethods = 'get';
        this.rules = {
            page: {
                default: 1,
                int: { min: 1 },
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
                length: { min: 2, max: 255 },
                aliasName: '名称'
            },
            key: {
                required: true,
                aliasName: '模块标志'
            },
            type: {
                required: true,
                aliasName : '模块类型'
            },
            server_path: {
                required: true,
                length: { min: 2, max: 255 },
                aliasName: '后台路径'
            },
            params : {
                aliasName: '参数'
            },
            tables_main: {
                aliasName : '主表'
            },
            tables_more: {
                aliasName : '附加表'
            },
            remark: {
                aliasName: '标注'
            },
            
        }
    }
    addBeforeAction() {
        this.allowMethods = 'get';
    }
    editBeforeAction() {
        this.allowMethods = 'get';
        this.rules = {
            id: {
                required: true,
                int: { min: 0 },
                aliasName: 'id'
            }
        }
    }
    editAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                required: true,
                int: { min: 0 },
                aliasName: 'id'
            },
            name: {
                required: true,
                length: { min: 2, max: 255 },
                aliasName: '名称'
            },
            key: {
                required: true,
                aliasName: '模块标志'
            },
            type: {
                required: true,
                aliasName: '模块类型'
            },
            server_path: {
                required: true,
                length: { min: 2, max: 255 },
                aliasName: '后台路径'
            },
            params: {
                aliasName: '参数'
            },
            tables_main: {
                aliasName: '主表'
            },
            tables_more: {
                aliasName: '附加表'
            },
            remark: {
                aliasName: '标注'
            }
        }
    }
    deleteAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                required: true,
                int: { min: 1 },
                aliasName: '模块id'
            }
        }
    }
    paramsAction() {
        this.allowMethods = 'get';
        this.rules = {
            page: {
                default: 1,
                int: { min: 1 },
                aliasName: '页码'
            },
            limit: {
                default: 20,
                int: true,
                aliasName: '页数'
            }
        }
    }
    paramsBeforeAction() {
        this.allowMethods = 'get';
        this.rules = {
            id: {
                required: true,
                int: { min: 0 },
                aliasName: 'id'
            }
        }
    }
    paramsAddAction() {
        this.allowMethods = 'post';
        this.rules = {
            name: {
                required: true,
                length: { min: 2, max: 255 },
                aliasName: '常量名称'
            },
            key: {
                required: true,
                length: { min: 2, max: 255 },
                aliasName: '常量标志'
            },
            type: {
                required: true,
                int : {min:1,max:5},
                aliasName: '常量类型'
            },
            content: {
                required: true,
                length: { min: 1, max: 255 },
                aliasName: '常量内容'
            }

        }
    }
    paramsEditAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                required: true,
                int: { min: 1 },
                aliasName: 'id'
            },
            name: {
                required: true,
                length: { min: 2, max: 255 },
                aliasName: '常量名称'
            },
            key: {
                required: true,
                length: { min: 2, max: 255 },
                aliasName: '常量标志'
            },
            type: {
                required: true,
                int: { min: 1, max: 5 },
                aliasName: '常量类型'
            },
            content: {
                required: true,
                length: { min: 1, max: 255 },
                aliasName: '常量内容'
            }

        }
    }
};