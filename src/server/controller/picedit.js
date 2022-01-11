const Base = require('./base.js');
const fs = require('fs');
const path = require('path');
/**
 * @class
 * @apiDefine picedit 图片编辑器管理
 */
module.exports = class extends Base {

    async listAction() {
        let { page, limit, param } = this.get();
        let wsql = {};
        if (param) wsql = this.parseSearch(param, wsql);
        let list = await this.model('picedit').where(wsql).page(page, limit).order('id desc').select();
        let count = await this.model('picedit').where(wsql).count();
        return this.success({ list, count })
    }

    async addAction() {
        let post = this.post();
        //post.user_id = this.adminId;
        //post.add_time = this.now();
        //console.log(post)
        let name = Date.now() + post.title;
        if (name.indexOf('.') === -1) {
            name = name + '.png'
        }
        
        let filepath = path.join(think.ROOT_PATH, 'www/upload/picedit/' + name);
        let base64Data = post.content.split('base64,')[1].replace(/\s/g, "+");
        var dataBuffer = Buffer.from(base64Data, 'base64');
        fs.writeFileSync(filepath, dataBuffer)
        let save = {
            user_id: this.adminId,
            add_time: this.now(),
            title: post.title,
            content : name
        }
        let id = await this.model('picedit').add(save);
        return this.success(id);
    }

    async editAction() {
        let post = this.post();
        let has = await this.model('picedit').where({ id: post.id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        let filepath = path.join(think.ROOT_PATH, 'www/upload/picedit/' + has.content);
        let base64Data = post.content.split('base64,')[1].replace(/\s/g, "+");
        var dataBuffer = Buffer.from(base64Data, 'base64');
        fs.writeFileSync(filepath, dataBuffer)

        let save = {
            update_time: this.now()
        }
        await this.model('picedit').where({id : post.id}).update(save);
        return this.success()
    }

    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('picedit').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        // let name = data.content,
        //     filepath = path.join(think.ROOT_PATH, 'www/upload/picedit/' + name);
        // let file = fs.readFileSync(filepath, 'utf-8')
        data.url = '/upload/picedit/' + data.content;
        return this.success(data);
    }

    async delAction() {
        let id = this.post('id'),
            has = await this.model('picedit').where({id}).find()
        if (think.isEmpty(has))
            return this.fail('数据不存在')
        await this.model('picedit').where({ id }).delete()
        let filepath = path.join(think.ROOT_PATH, 'www/upload/picedit/' + has.content)
        fs.unlink(filepath, res => { })
        return this.success()
    }
    async editNameAction() {
        let id = this.post('id');
        if (!await this.hasData('picedit', { id }))
            return this.fail('数据不存在')
        await this.model('picedit').where({ id }).update({ title: this.post('value')})
        return this.success()
    }
}