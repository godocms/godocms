const Base = require('./base.js');
/**
 * @class
 * @apiDefine set 系统配置
 */
module.exports = class extends Base {
   
    async addAction() {
        let post = this.post();
        if (await this.hasData('set', { key: post.key }))
            return this.fail('系统中存在相同的配置标志');
        //console.log(post)
        let id = await this.model('set').add(post);
        return this.success(id);

    }
    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('set').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        return this.success(data);
    }
    async editAction() {
        let post = this.post();
        if (post.key) return this.fail('key不允许编辑');
        let has = await this.model('set').where({ id: post.id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        let rt = await this.model('set').update(post);
        return this.success(rt)
    }
    async listAction() {
        let { page, limit } = this.get();

        let list = await this.model('set').page(page, limit).select();
        let count = await this.model('set').count();

        return this.success({ list, count })
    }
    async deleteAction() {
        let id = this.post('id');
        let data = await this.model('set').where({ id }).find();

        if (think.isEmpty(data))
            return this.fail('数据不存在')
        await this.model('set').where({ id }).delete()
        if (data.form_id) {
            await this.model('form')
                .where({
                    id: data.form_id,
                    link_id: data.id
                })
                .delete()
        }
        return this.success()
    }
    /**
     * @api {post} set/enable 设置是否可用
     * @apiGroup set
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {number} status 状态
     * @apiParam  {number} id
     * 
     * @apiSuccess (200) {type} name description
     *
     */
    async enableAction() {
        let post = this.post(),
            id = post.id;

        if (!await this.hasData('set', { id }))
            return this.fail("数据不存在");

        let rt = await this.model('set')
            .where({ id })
            .update({
                enable: post.status
            })
        await this.adminOpLog('设置配置可用');
        return this.success(rt)
    }
};