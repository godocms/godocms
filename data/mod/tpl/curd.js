const fs = require('fs');
let ctpl = {}, ltpl = {};

ctpl.start = `const Base = require('./base.js');
/**
 * @class
 * @apiDefine {{tags}} {{name}}管理
 */
module.exports = class extends Base {
`;
ctpl.list = `
    async listAction() {
        let { page, limit, param } = this.get();
        let wsql = {};
        if (param) wsql = this.parseSearch(param, wsql);
        let list = await this.model('{{tags}}').where(wsql).page(page, limit).order('id desc').select();
        let count = await this.model('{{tags}}').where(wsql).count();
        return this.success({ list, count })
    }
`;
ctpl.add = `
    async addAction() {
        let post = this.post();
        let id = await this.model('{{tags}}').add(post);
        return this.success(id);
    }
`;
ctpl.edit = `
    async editAction() {
        let post = this.post();
        let has = await this.model('{{tags}}').where({ id: post.id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        await this.model('{{tags}}').update(post);
        return this.success()
    }
`;
ctpl.editBefore = `
    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('{{tags}}').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        return this.success(data);
    }
`;

ctpl.del = `
    async delAction() {
        let id = this.post('id');
        if (!await this.hasData('{{tags}}', { id }))
            return this.fail('数据不存在')
        await this.model('{{tags}}').where({ id }).delete()
        return this.success()
    }
`;

ctpl.addBefore = `
    async addBeforeAction() {
        let data = await this.model('mod').getTree('{{cate}}');
        if (think.isEmpty(data)) return this.fail('数据为空')
        return this.success(data);
    }
`;
ctpl.editBeforeCate = `
    async editBeforeAction() {
        let id = this.get('id');
        let cate = await this.model('mod').getTree('{{cate}}');
        let data = await this.model('{{tags}}').where({ id }).find();
        data.cateName = await this.model('{{cate}}').where({cid : data.cid}).getField('title', true);
        if (think.isEmpty(data)) return this.fail('数据为空')
        return this.success({data,cate});
    }
`;

ltpl.start = `module.exports = class extends think.Logic {`;
ltpl.list = `
    listAction() {
        this.allowMethods = 'get';
        this.rules = {
            page: {
                default: 1,
                int: { min: 1 },
                aliasName: '页码'
            },
            limit: {
                default: 20,
                int: true,
                aliasName: '页数'
            },
            param: {
                aliasName: '查询字段'
            }
        }
    }
`;
ltpl.add = `
    addAction() {
        this.allowMethods = 'post';
        this.rules = {}
    }
`;
ltpl.addBefore = `
    addAction() {
        this.allowMethods = 'get';
        this.rules = {}
    }
`;
ltpl.del = `
    delAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                int: { min: 1 },
                required: true
            }
        }
    }
`;
ltpl.editBefore = `
    editBeforeAction() {
        this.allowMethods = 'get';
        this.rules = {
            id: {
                int: { min: 1 },
                required: true
            }
        }
    }
`;
ltpl.editBeforeCate = `
    editBeforeCateAction() {
        this.allowMethods = 'get';
        this.rules = {
            id: {
                int: { min: 1 },
                required: true
            }
        }
    }
`;

ltpl.edit = `
    editAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                int: { min: 1 },
                required: true
            }
        }
    }
`;

let endTpl = `}`;
let htmlTpl = {};
//不带分类的模块
htmlTpl.list = require('./list.html.js');
htmlTpl.edit = require('./edit.html.js');
//带分类的模版
htmlTpl.listCate = require('./list-cate.html.js');;
htmlTpl.editCate = require('./edit-cate.html.js');
module.exports = {
    ctpl,
    ltpl,
    endTpl,
    htmlTpl
}