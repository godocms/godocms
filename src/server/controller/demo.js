const Base = require('./base.js');
/**
 * @class
 * @apiDefine demo 事例管理
 */
module.exports = class extends Base {
    /**
     * @api {get} demo/list 事例列表
     * @apiGroup demo
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {number} page 页码
     * @apiParam  {number} limit 每页显示数据
     * @apiParam  {string} param 每页显示数据
     *
     * @apiSuccess (200) {type} name description
     *
     */
    async listAction() {
        let { page, limit, param } = this.get();
        let wsql = {};
        if (param) wsql = this.parseSearch(param, wsql);
        let list = await this.model('demo').where(wsql).page(page, limit).select();
        let count = await this.model('demo').where(wsql).count();
        return this.success(list, count);
    }
    /**
     * @api {post} demo/delete 删除事例
     * @apiGroup demo
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {number} id id
     *
     * @apiSuccess (200) {type} name description
     *
     */
    async deleteAction() {
        let id = this.post('id');
        if (!this.hasData('demo', { id })) {
            return this.fail('数据不存在')
        }
        let rt = await this.model('demo').where({ id }).delete()
        return this.success(rt)
    }
    /**
     * @api {post} form/add 添加事例
     * @apiGroup form
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {number} id id
     *
     * @apiSuccess (200) {type} name description
     *
     */
    async addAction() {
        let id = await this.model('demo').add(this.post())
        return this.success(id)
    }
    /**
     * @api {get} demo/edit 编辑事例前
     * @apiGroup demo
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {number} id id
     *
     * @apiSuccess (200) {type} name description
     *
     */
    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('demo').where({ id }).find();
        if (!think.isEmpty(data)) {
            return this.fail('数据不存在')
        }
        return this.success(data)
    }
    /**
     * @api {post} demo/edit 编辑事例
     * @apiGroup demo
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {number} id id
     *
     * @apiSuccess (200) {type} name description
     *
     */
    async editAction() {
        let data = this.post(),
            id = data.id;
        if (!this.hasData('demo', { id })) {
            return this.fail('数据不存在')
        }
        let rt = await this.model('demo').where({ id }).update(data)
        return this.success(rt)
    }
};
