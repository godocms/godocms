const Base = require('./base.js');
const fs = require('fs');
const path = require('path');
const srcPath = path.join(think.ROOT_PATH, 'src/');
/**
 * @class
 * @apiDefine code 程序设计器管理
 */
module.exports = class extends Base {

    async listAction() {
        let { page, limit, param } = this.get();
        let wsql = {};
        if (param) wsql = this.parseSearch(param, wsql);
        let list = await this.model('code').where(wsql).page(page, limit).order('id desc').select();
        let count = await this.model('code').where(wsql).count();
        return this.success({ list, count })
    }

    async addAction() {
        let post = this.post();
        let filepath = srcPath + post.path + '/' + post.type;
        if (!think.isDirectory(filepath)) return this.fail('目录不存在')
        let file = filepath + '/' + post.name + '.js';
        if (think.isFile(file)) return this.fail('程序已经存在');
        let data = {
            title: post.title,
            name: post.name,
            content: '',
            path : post.path,
            type: post.type,
            remark: post.remark,
            add_time: this.now(),
            update_time: this.now()
        }
        let id = await this.model('code').add(data);
        return this.success(id);
    }

    async editAction() {
        let post = this.post();
        let has = await this.model('code').where({ id: post.id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        let up = {
            title: post.title,
            remark: post.remark,
            update_time: this.now()
        }
        await this.model('code').update(up);
        return this.success()
    }
    async editCodeAction() {
        let post = this.post();
        //console.log(post)
        let has = await this.model('code').where({ id: post.id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        let up = {
            content: post.content,
            update_time: this.now()
        }
        console.log(up)
        await this.model('code').where({ id: post.id }).update(up);
        let filepath = srcPath + has.path + '/' + has.type + '/' + has.name + '.js';
        console.log(filepath)
        fs.writeFileSync(filepath, post.str);
        return this.success();
    }
    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('code').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        return this.success(data);
    }

    async delAction() {
        let id = this.post('id');
        let has = await this.model('code').where({ id }).find();
        if (!think.isEmpty(has))
            return this.fail('数据不存在')
        let filepath = srcPath + has.path + '/' + has.type + '/' + has.name + '.js';
        if (think.isFile(filepath)) {
            fs.unlink(filepath, res => { })
        }
        await this.model('code').where({ id }).delete()
        return this.success()
    }
}