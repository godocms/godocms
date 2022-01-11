module.exports = class extends think.Logic {
    cateAction() {
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
    cateAddAction() {
        this.allowMethods = 'post';
        this.rules = {
            key: {
                required: true,
                length: { min: 3, max: 255 },
                aliasName: '类目键值'
            },
            name: {
                required: true,
                length: { min: 2, max: 255 },
                aliasName: '类目名'
            },
            remark: {
                aliasName: '标注'
            }
        }
    }
    cateEditBeforeAction() {
        this.allowMethods = 'get';
        this.rules = {
            id: {
                required: true,
                int: { min: 2 },
                aliasName: '类目id'
            }
        }
    }
    cateEditAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                required: true,
                int: { min: 2 },
                aliasName: '类目id'
            },
            name: {
                required: true,
                length: { min: 2, max: 255 },
                aliasName: '类目名'
            },
            remark: {
                aliasName: '标注'
            }
        }
    }
    cateDeleteAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                required: true,
                int: { min: 2 },
                aliasName: '类目id'
            }
        }
    }
    addAction() {
        this.allowMethods = 'post';
        this.rules = {
            cate_id: {
                required: true,
                int: { min: 1 },
                aliasName: '类目id'
            },
            key: {
                required: true,
                length: { min: 2, max: 255 },
                aliasName: '配置键值'
            },
            name: {
                required: true,
                length: { min: 2, max: 255 },
                aliasName: '配置名'
            },
            remark: {
                aliasName: '标注'
            }

        }
    }
    listAction() {
        this.allowMethods = 'get';
        this.rules = {
            cate_id: {
                required: true,
                int: { min: 1 },
                aliasName: '类目id'
            },
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
    deleteAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                required: true,
                int: { min: 1 },
                aliasName: '配置id'
            }
        }
    }
};