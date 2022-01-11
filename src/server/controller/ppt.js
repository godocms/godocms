const Base = require('./base.js');
/**
 * @class
 * @apiDefine ppt 演示文稿管理
 */
module.exports = class extends Base {

    async listAction() {
        let { page, limit, param } = this.get();
        let wsql = {};
        if (param) wsql = this.parseSearch(param, wsql);
        let list = await this.model('ppt').where(wsql).order('id desc').page(page, limit).select();
        let count = await this.model('ppt').where(wsql).count();
        return this.success({ list, count })
    }

    async addAction() {
        let post = this.post();
        post.add_time = this.now();
        post.user_id = this.adminId;
        post.update_time = this.now();
        let id = await this.model('ppt').add(post);
        return this.success(id);
    }

    async editAction() {
        let post = this.post();
        let has = await this.model('ppt').where({ id: post.id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        post.update_time = this.now();
        await this.model('ppt').update(post);
        return this.success()
    }

    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('ppt').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        return this.success(data);
    }

    async delAction() {
        let id = this.post('id');
        if (!await this.hasData('ppt', { id }))
            return this.fail('数据不存在')
        await this.model('ppt').where({ id }).delete()
        return this.success()
    }
}