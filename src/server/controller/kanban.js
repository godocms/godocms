const Base = require('./base.js');
/**
 * @class
 * @apiDefine kanban 任务看板管理
 */
module.exports = class extends Base {

    async listAction() {
        let { page, limit, param } = this.get();
        let wsql = {};
        if (param) wsql = this.parseSearch(param, wsql);
        let list = await this.model('kanban').where(wsql).page(page, limit).order('id desc').select();
        let count = await this.model('kanban').where(wsql).count();
        return this.success({ list, count })
    }

    async addAction() {
        let post = this.post();
        let id = await this.model('kanban').add(post);
        return this.success(id);
    }

    async editAction() {
        let post = this.post();
        let has = await this.model('kanban').where({ id: post.id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        await this.model('kanban').update(post);
        return this.success()
    }

    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('kanban').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        return this.success(data);
    }

    async delAction() {
        let id = this.post('id');
        if (!await this.hasData('kanban', { id }))
            return this.fail('数据不存在')
        await this.model('kanban').where({ id }).delete()
        return this.success()
    }
}