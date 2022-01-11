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
        this.rules = {
            username: {
                required: true,
                aliasName: '登录名',
                length: { min: 3,max:50 }
            },
            password: {
                required: true,
                aliasName: '密码',
                length: { min: 6, max: 50 }
            },
            name: {
                required: true,
                aliasName: '真实姓名',
                length: { min: 2, max: 50 }
            },
            mobile: {
                aliasName: '手机号',
                mobile: true
            },
            status: {
                int: true,
                aliasName: '状态'
            }
        }
    }
    editBeforeAction() {
        this.allowMethods = 'get';
        this.rules = {
            id: {
                int: { min: 2 },
                required: true,
                aliasName: '管理员id'
            }
        }
    }
    editAction() {
        this.allowMethods = 'post';
        this.rules = {
            admin_id: {
                int: { min: 1 },
                required: true,
                aliasName: '管理员id'
            },
            username: {
                required: true,
                aliasName: '登录名',
                length: { min: 3, max: 50 }
            },
            password: {
                aliasName: '密码',
                length: { min: 6, max: 50 }
            },
            name: {
                required: true,
                aliasName: '真实姓名',
                length: { min: 2, max: 50 }
            },
            mobile: {
                aliasName: '手机号',
                mobile: true
            },
            status: {
                int: true,
                aliasName: '状态'
            }
        }
    }
    delAction() {
        this.allowMethods = 'post';
        this.rules = {
            admin_id: {
                int: { min: 2 },
                required: true,
                aliasName: '管理员id'
            }
        }
    }
    enableAction() {
        this.rules = {
            id: {
                int: { min: 2 },
                required: true,
                aliasName: '管理员id'
            },
            status: {
                int: true,
                required: true,
                aliasName: '状态'
            }
        }
    }
};