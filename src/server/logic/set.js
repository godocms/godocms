module.exports = class extends think.Logic {
    addAction() {
        this.allowMethods = 'post';
        this.rules = {
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
    async setBeforeAction() {
        let conftype = this.get('conftype');
        let data = await this.model('set').where({ key: conftype }).find()
        if (think.isEmpty(data)) return this.fail('数据不存在')
        if (data.val) {
            return this.success(JSON.parse(data.val))
        } else {
            return this.success()
        }
    }
    async setConfAction() {
        let conftype = this.post('conftype');
        let data = await this.model('set').where({ key: conftype }).find()
        if (think.isEmpty(data)) return this.fail('数据不存在')
        let save = { val: JSON.stringify(this.post()) };
        await this.model('set').where({ id: data.id }).update(save);
        return this.success()
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
    enableAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                int: { min: 1 },
                required: true,
                aliasName: 'id'
            },
            status: {
                int: true,
                required: true,
                aliasName: '状态'
            }
        }
    }
};