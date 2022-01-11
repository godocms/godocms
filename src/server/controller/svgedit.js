const Base = require('./base.js');
const fs = require('fs');
const path = require('path');
/**
 * @class
 * @apiDefine svg svg编辑器管理
 */
module.exports = class extends Base {

    async listAction() {
        let { page, limit, param } = this.get();
        let wsql = {};
        if (param) wsql = this.parseSearch(param, wsql);
        let list = await this.model('svg').where(wsql).page(page, limit).order('id desc').select();
        let count = await this.model('svg').where(wsql).count();
        return this.success({ list, count })
    }

    async addAction() {
        let post = this.post();
        let name = Date.now() + '.svg';
        let filepath = path.join(think.ROOT_PATH, 'www/upload/svg/' + name);
        fs.writeFileSync(filepath, post.content)
        let save = {
            user_id: this.adminId,
            add_time: this.now(),
            title: post.title,
            url: name
        }
        let id = await this.model('svg').add(save);
        return this.success(id);
    }

    async editAction() {
        let post = this.post();
        let has = await this.model('svg').where({ id: post.id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        let filepath = path.join(think.ROOT_PATH, 'www/upload/svg/' + has.url);
        fs.writeFileSync(filepath, post.content)
        let save = {
            update_time: this.now(),
            title: post.title
        }
        await this.model('svg').where({id : post.id}).update(save);
        return this.success()
    }

    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('svg').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        return this.success(data);
    }

    async delAction() {
        let id = this.post('id');
        let data = await this.model('svg').where({ id }).find()
        if (think.isEmpty(data))
            return this.fail('数据不存在')
        await this.model('svg').where({ id }).delete()
        let filepath = path.join(think.ROOT_PATH, 'www/upload/svg/' + data.url)
        fs.unlink(filepath, res => { })
        return this.success()
    }
}