const Base = require('./base.js');
const flowType = {
    1: '图形编辑器',
    2: '图表编辑器',
    3: '权限编辑器',
    4: '工作流编辑器',
    5: '拓扑图编辑器'

}
/**
 * @class
 * @apiDefine flow 流程图管理
 */
module.exports = class extends Base {

    async listAction() {
        let { page, limit, param } = this.get();
        let wsql = {};
        if (param) wsql = this.parseSearch(param, wsql);
        let list = await this.model('flow').where(wsql).page(page, limit).order('id desc').select();
        list.forEach(d => {
            d.typeName = flowType[d.type]
        })
        let count = await this.model('flow').where(wsql).count();
        return this.success({ list, count })
    }
    
    async addAction() {
        let post = this.post();
        post.add_time = this.now();
        post.user_id = this.adminId;
        post.update_time = this.now();
        let id = await this.model('flow').add(post);
        return this.success(id);
    }

    async editAction() {
        let post = this.post();
        let has = await this.model('flow').where({ id: post.id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        post.update_time = this.now();
        await this.model('flow').update(post);
        return this.success()
    }

    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('flow').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        return this.success(data);
    }

    async delAction() {
        let id = this.post('id');
        if (!await this.hasData('flow', { id }))
            return this.fail('数据不存在')
        await this.model('flow').where({ id }).delete()
        return this.success()
    }
}