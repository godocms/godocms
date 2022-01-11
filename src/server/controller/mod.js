const Base = require('./base.js');
/**
 * @class
 * @apiDefine mod 系统模块管理
 */
module.exports = class extends Base {
    /**
     * @api {get} mod/list 系统配置类目列表
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

        let list = await this.model('mod').page(page, limit).order('id desc').select();
        let types = {
            1: '控制层',
            2: '模型层',
            3: '服务层',
            5 : 'curd'
        };
        list.forEach(d => {
            d.typeName = types[d.type];
        })
        let count = await this.model('mod').count();

        return this.success({ list, count })
    }
    
    /**
     * @api {get} mod/addBefore 模块添加前
     * @apiGroup mod
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {number} id 模块id
     *
     * @apiSuccess (200) {type} name description
     *
     */
    async addBeforeAction() {
        let authTree = await this.model('mod').getTree('menu');
        let params = await this.model('params').select();
        let tableList = await this.model('mod').tableList();
        return this.success({ params, tableList, authTree});
    }
    /**
     * @api {get} mod/add 添加模块
     * @apiGroup mod
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {string} tags 模块标志
     * @apiParam  {string} name 模块名
     *
     * @apiSuccess (200) {type} name description
     *
     */
    async addAction() {
        let post = this.post();
        let key = post.key;
        let sys = ['mod', 'admin', 'db', 'database', 'form', 'auth', 'admin',  'doc','api', 'ppt', 'mind','excel', 'flow', 'index', 'logs', 'set','base','cate'];
        if (sys.includes(key)) return this.fail('系统模块不允许添加');
        if (await this.hasData('mod', { key: key, type: post.type })) {
            return this.fail('系统中存在相同的模块');
        }
        if (post.params) {
            post.paramsList  = await think.model('params')
                .where({ id: ['in', post.params.split(',')] })
                .select();
        }
        //console.log(post);
        await this.service('mod').createMod(post);
        if (post.type == 4) {
            post.type = 1;
        }
        let add = {
            name: post.name,
            key: post.key,
            server_path: post.server_path,
            params: post.params,
            type : post.type,
            tables_main: post.tables_main,
            tables_more : post.tables_more,
            remark: post.remark,
            extra : post.extra ? post.extra : ''
        }
        let id = await this.model('mod').add(add);

        if (post.type == 5) {
            await this.addRule(post);
        }
        return this.success(id);
    }
    async addRule(data) {
        if (data.pid < 0) return;
        let serverDir = 'server/';
        let topData = {
            pid: data.pid,
            title: data.name,
            href: 'view/' + data.key + '/list.html',
            route: serverDir + data.key + '/list',
            icon: data.icon,
            type: 1,
            order_num: 0
        }
        let topId = await this.model('menu').add(topData),
            adds = [],
            name = data.name,
            key = data.key,
            arr = ['add', 'edit', 'del', 'editBefore'],
            names = ['添加', '编辑', '删除', '编辑前'],
            tpls = ['edit','edit','',''];
        if (data.iscate && data.iscate == 'on') {
            arr = arr.concat(['addBefore', 'cate', 'cateAdd', 'cateEdit', 'cateDel']);
            names = names.concat(['添加前', '分类', '分类添加', '分类编辑', '分类删除']);
            tpls = tpls.concat(['', 'cate', 'cateEdit', 'cateEdit', '']);
        }
        arr.forEach((k, i) => {
            adds.push({
                pid: topId,
                title: name + names[i],
                href: tpls[i] != '' ? 'view/' + key + '/' + tpls[i] + '.html' : '',
                route: serverDir + key + '/' + k,
                icon: '',
                type: 3,
                order_num: 0
            })
        })
        await this.model('menu').addMany(adds);

    }
    /**
     * @api {get} mod/editBefore 模块编辑前
     * @apiGroup mod
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {number} id 模块id
     *
     * @apiSuccess (200) {type} name description
     *
     */
    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('mod').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        let params = await this.model('params').select();
        let tableList = await this.model('mod').tableList();
        return this.success({data, params, tableList});
    }
    /**
     * @api {get} mod/eidt 编辑模块
     * @apiGroup mod
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {string} remark 模块注释
     * @apiParam  {string} name 模块名
     *
     * @apiSuccess (200) {type} name description
     *
     */
    async editAction() {
        let post = this.post();
        //if (post.key) return this.fail('tags不允许编辑');
        let has = await this.model('mod').where({ id: post.id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        await this.model('mod').update(post);
        this.service('mod').createModNone(post);
        return this.success()
    }
    /**
     * @api {get} mod/delete 删除模块
     * @apiGroup mod
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {number} id 模块id
     *
     * @apiSuccess (200) {type} name description
     *
     */
    async deleteAction() {
        let id = this.post('id');
        if(id < 50) return this.fail('系统模块禁止删除')
        let data = await this.model('mod').where({id}).find()
        if (think.isEmpty(data))
            return this.fail('数据不存在')
        await this.service('mod').del(data);
        await this.model('mod').where({ id }).delete();
        let route = 'server/' + data.key + '/list';
        let topRuleId = await this.model('menu').where({ route}).getField('id', true);
        //删除权限
        if (topRuleId) {
            await this.model('menu').where({ pid: topRuleId }).delete();
            await this.model('menu').where({ id: topRuleId }).delete();
        }
        return this.success()
    }
    async paramsAction() {
        let { page, limit } = this.get();

        let list = await this.model('params').page(page, limit).select();
        let types = {
            1: '文件',
            2: '数字',
            3: '字符串',
            4: '数组',
            5: '对象'
        };
        list.forEach(d => {
            d.typeName = types[d.type];
        })
        let count = await this.model('mod').count();

        return this.success({ list, count })
    }
    async paramsBeforeAction() {
        let id = this.get('id');
        let data = await this.model('params').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据不存在')
        return this.success(data)
    }
    async paramsAddAction() {
        let data = this.post()
        let has = await this.model('params').where({ key: data.key }).find()
        if (!think.isEmpty(has)) return this.fail('系统中存在相同的key')
        let add = {
            name: data.name,
            key: data.key,
            type: data.type,
            content: data.content
        }
        let rt = await this.model('params').add(add)
        return this.success(data)
    }
    async paramsEditAction() {
        let data = this.post(),
            id = data.id;
        let has = await this.model('params').where({ id }).find()
        if (think.isEmpty(has)) return this.fail('数据不存在')
        if (has.key != data.key) {
            let haskey = await this.model('params').where({ key: data.key }).find();
            if (!think.isEmpty(haskey)) return this.fail('系统中存在相同的key');
        }
        let up = {
            name: data.name,
            key: data.key,
            type: data.type,
            content: data.content
        }
        await this.model('params').where({ id }).update(up)
        return this.success()
    }
    async paramDeleteAction() {
        let id = this.post('id');
        if (!this.hasData('params', { id })) return this.fail('数据不存在')
        await this.model('params').where({ id }).delete()
        return this.success()
    }
}