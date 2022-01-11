const Base = require('./base.js');
/**
 * @class
 * @apiDefine cate 系统分类表
 */
module.exports = class extends Base {
    /**
     * @api {get} set/cate 系统配置类目列表
     * @apiGroup set
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {number} page 页码
     * @apiParam  {number} limit 每页显示数据
     *
     * @apiSuccess (200) {type} name description
     *
     */
    async listAction() {
        let { page, limit } = this.get();

        let list = await this.model('set_cate').page(page, limit).select();
        let count = await this.model('set_cate').count();

        return this.success({ list, count })
    }
    /**
     * @api {get} set/cateAdd 添加系统配置类目
     * @apiGroup set
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {string} key 类目键值
     * @apiParam  {string} name 类目名
     *
     * @apiSuccess (200) {type} name description
     *
     */
    async addAction() {
        let post = this.post();
        if (await this.hasData('set_cate', { key: post.key }))
            return this.fail('系统中存在相同的键值')
        let id = await this.model('set_cate').add(post);
        return this.success(id);
    }
    async eidtBeforeAction() {
        let id = this.get('id');
        let data = await this.model('set_cate').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        return this.success(data);
    }
    async eidtAction() {
        let post = this.post();
        if (post.key) return this.fail('key不允许编辑');
        let has = await this.model('set_cate').where({ id: post.id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        let rt = await this.model('set_cate').update(post);
        return this.success(rt)
    }
    async deleteAction() {
        let id = this.post('id');
        if (!await this.hasData('set_cate', { id }))
            return this.fail('数据不存在')
        await this.model('set_cate').where({ id }).delete()

        return this.success()
    }
}