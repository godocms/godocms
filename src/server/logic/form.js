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
            },
            param: {
                aliasName: '查询字段'
            }
        }
    }
    deleteAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                int: { min: 1 },
                required : true
            }
        }
    }
    addAction() {
        this.allowMethods = 'post';
        this.rules = {
            formName : {
                required: true,
                aliasName : '表单名称'
            },
            formId: {
                required: true,
                aliasName : '表单标志'
            },
            form_path: {
            //    required: true,
                aliasName : '生成地址'
            },
            params_len: {
                int : true,
                aliasName :'参数个数'
            },
            params_get: {
                aliasName: '接收参数'
            },
            params_post: {
                aliasName: '发送参数'
            },
            get_url: {
                aliasName : '数据地址'
            },
            post_url: {
                aliasName: '发送地址'
            }
        }
    }
    editBeforeAction() {
        this.allowMethods = 'get';
        this.rules = {
            id: {
                int: { min: 1 },
                required: true
            }
        }
    }
    editAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                int: { min: 1 },
                required: true
            },
            name: {
                required: true,
                aliasName: '表单名称'
            }
        }
    }


}