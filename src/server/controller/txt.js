const Base = require('./base.js');
/**
 * @class
 * @apiDefine txt 文本编辑器管理
 */
module.exports = class extends Base {

    async listAction() {
        let { page, limit, param } = this.get();
        let wsql = {};
        if (param) wsql = this.parseSearch(param, wsql);
        let list = await this.model('txt').where(wsql).page(page, limit).order('id desc').select();
        let count = await this.model('txt').where(wsql).count();
        return this.success({ list, count })
    }

    async addAction() {
        let post = this.post();
        let data = {
            title: post.title,
            user_id: this.adminId,
            content: Buffer.from(post.content).toString('ascii'),
            add_time: this.now(),
            update_time : this.now()
        }
        let id = await this.model('txt').add(data);
        return this.success(id);
    }

    async editAction() {
        let post = this.post(),
            id = post.id;
        let has = await this.model('txt').where({ id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        let data = {
            title: post.title,
            content: Buffer.from(post.content).toString('ascii'),
            update_time: this.now()
        }
        await this.model('txt').where({id}).update(data);
        return this.success()
    }

    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('txt').where({ id }).find();
        if (think.isEmpty(data)) return this.fail('数据为空');
        data.content = Buffer.from(data.content, 'ascii').toString();
        return this.success(data);
    }

    async delAction() {
        let id = this.post('id');
        if (!await this.hasData('txt', { id }))
            return this.fail('数据不存在')
        await this.model('txt').where({ id }).delete()
        return this.success()
    }
}