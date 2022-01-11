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

    addAction() {
        this.allowMethods = 'post';
        this.rules = {}
    }

    editAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                int: { min: 1 },
                required: true
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

    delAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                int: { min: 1 },
                required: true
            }
        }
    }
}