const Base = require('./base.js');
const fs = require('fs');
/**
 * @class
 * @apiDefine form 表单管理
 */
module.exports = class extends Base {
    /**
     * @api {get} form/list 表单列表
     * @apiGroup form
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
        let list = await this.model('form').where(wsql).page(page, limit).select()
        let count = await this.model('form').where(wsql).count()
        return this.success({ list, count})
    }
    /**
     * @api {post} form/delete 删除表单
     * @apiGroup form
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
        if (!this.hasData('form', { id })) {
            return this.fail('数据不存在')
        }
        let rt = await this.model('form').where({ id }).delete()
        return this.success(rt)
    }
    /**
     * @api {post} form/add 添加表单
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
        let data = this.post();
        //console.log(data)
        let id = 0;
        let save = {
            name: data.formName,
            key: data.formId,
            data: data.data,
            get_url: data.get_url,
            post_url: data.post_url,
            form_path: data.form_path,
            link_id: data.link_id,
            link_name: data.link_name,
            link_field: data.link_field,
            params_get: data.params_get,
            params_post : data.params_post,
            update_time : this.now()
        }
        //if (data.params_len > 0)
        //存数据
        if (data.form_id > 0) {
            let has = await this.model('form').where({ id: data.form_id }).find()
            if (think.isEmpty(has)) {
                save.add_time = this.now();
                id = await this.model('form').add(save);
            } else {
                id = data.form_id;
                await this.model('form').where({ id: data.form_id }).update(save)
            }
        } else {
            save.add_time = this.now();
            id = await this.model('form').add(save);
        }
        //回写
        if (save.form_path && save.form_path.indexOf('.html') === -1) {
            save.form_path = save.form_path + '.html';
        }
        if (!think.isEmpty(save.link_name)) {
            if (!save.link_field) save.link_field = 'id';
            let sql = {};
            sql[save.link_field] = save.link_id;
            await this.model(save.link_name)
                .where(sql)
                .update({
                    form_id: id,
                    form_path : '/admin/view/' + save.form_path
                });
        }
        if (!think.isEmpty(save.form_path)) {
            fs.writeFileSync(think.ROOT_PATH + '/www/admin/view/' + save.form_path, data.htmlCode);
        }
        
        return this.success(id)
    }
    async addBeforeAction() {
        let id = this.get('id');
        let data = await this.model('form').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空');
        data.formId = data.key;
        data.formName = data.name;
        return this.success(data)
    }
    
};
