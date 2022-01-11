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
                required: true
            }
        }
    }
    addAction() {
        this.allowMethods = 'post';
        this.rules = {
            name: {
                required: true,
                aliasName: '表单名称'
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