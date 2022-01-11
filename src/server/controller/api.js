const Base = require('./base.js');
/**
 * @class
 * @apiDefine api 接口设计管理
 */
module.exports = class extends Base {

    async listAction() {
        let { page, limit, param } = this.get();
        let wsql = {};
        if (param) wsql = this.parseSearch(param, wsql);
        let list = await this.model('api').where(wsql).page(page, limit).order('id desc').select();
        list.forEach(async d => {
            d.modname = await this.model('mod').where({id : d.mod_id}).getField('name', true)
        })
        let count = await this.model('api').where(wsql).count();
        return this.success({ list, count })
    }
    async addBeforeAction() {
        let authTree = await this.model('mod').getTree('menu');
        let modList = await this.model('mod').where({type : 1}).select();
        return this.success({ modList, authTree });
    }
    async addAction() {
        let post = this.post();
        let mod = await this.model('mod').where({ id: post.mod_id, type: 1 }).find()
        if (think.isEmpty(mod)) return this.fail('模块不存在')
        let has = await this.model('api').where({ mod_id: mod.id, key: post.key }).find()
        if(!think.isEmpty(has)) return this.fail('系统中存在相同的接口名字')
        let menu_id = 0;
        if (post.pid > -1) {
            let menuData = {
                pid: post.pid,
                title: post.name,
                href: '',
                route: mod.key + '/' + post.key,
                icon: post.icon,
                type: 3,
                order_num: 0
            }
            menu_id = await this.model('menu').add(menuData)
        }
        let saveData = {
            name: post.name,
            key: post.key,
            mod_id: mod.id,
            menu_id,
            mod_key: mod.key,
            method: post.method,
            remark: post.remark,
            add_time: this.now(),
            update_time: this.now(),
            user_id : this.adminId
        }

        let id = await this.model('api').add(saveData);
        this.service('api').addApi(mod, post);
        return this.success(id);
    }
    //@todo 如果接口权限发生了变更，菜单权限要同步
    async editAction() {
        let post = this.post();
        let has = await this.model('api').where({ id: post.id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        let upData = {
            name: post.name,
            remark: post.remark,
            update_time : this.now()
        }
        await this.model('api').where({id : post.id}).update(upData);
        return this.success()
    }
    
    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('api').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        return this.success(data);
    }

    async delAction() {
        let id = this.post('id');
        let data = await this.model('api').del(id);
        //console.log(data)
        let mod = await this.model('mod').where({ id: data.mod_id }).find();
        this.service('api').delApi(mod, data.key);
        return this.success()
    }
    async addLogicAction() {
        let { id, code, str } = this.post();
        try {
            let data = await this.model('api_logic').where({ id }).find()
            if (!think.isEmpty(data)) {
                let up = {
                    id,
                    code,
                    update_time: this.now()
                }
                await this.model('api_logic').where({ id }).update(up)
            } else {
                let add = {
                    id,
                    code,
                    add_time: this.now(),
                    update_time: 0
                }
                await this.model('api_logic').add(add)
            }
            let api = await this.model('api').where({ id }).find()
            let mod = await this.model('mod').where({ id: api.mod_id }).find()
            this.service('api').updateCode(mod, api, str);
            return this.success()
        } catch (e) {
            return this.fail(e.message)
        }
        
    }
    async getLogicAction() {
        let id = this.get('id');
        let data = await this.model('api_logic').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据不存在')
        return this.success(data)
    }
}