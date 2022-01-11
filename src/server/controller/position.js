const Base = require('./base.js');
/**
 * @class
 * @apiDefine position 岗位管理
 */
module.exports = class extends Base {

    async listAction() {
        let { page, limit, param } = this.get();
        let wsql = {};
        if (param) wsql = this.parseSearch(param, wsql);
        let list = await this.model('position').where(wsql).page(page, limit).order('id desc').select();
        let count = await this.model('position').where(wsql).count();
        return this.success({ list, count })
    }

    async addAction() {
        let post = this.post();
        console.log(post)
        let id = await this.model('position').add(post);
        return this.success(id);
    }
    async addBeforeAction() {
        let menus = await this.model('menu').tree();
        return this.success({menus})
    }
    async editAction() {
        let post = this.post();
        let has = await this.model('position').where({ id: post.id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        await this.model('position').update(post);
        return this.success()
    }

    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('position').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        data.menus = await this.model('menu').tree();
        return this.success(data);
    }

    async delAction() {
        let id = this.post('id');
        if (!await this.hasData('position', { id }))
            return this.fail('数据不存在')
        await this.model('position').where({ id }).delete()
        return this.success()
    }
}