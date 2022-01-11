const Base = require('./base.js');
/**
 * @class
 * @apiDefine api 接口参数管理
 */
module.exports = class extends Base {
    async listAction() {
        let aid = this.get('aid');
        let list = await this.model('api_params').where({ aid }).select()
        let tabs = await this.model('api').getTables(aid);
        let fields = await this.model('api').getFields(tabs);
        //console.log(tabs)
        fields.forEach(d => {
            d.child.forEach(f => {
                f.hasck = list.some(l => {
                    return l.tablename == d.name && l.tablefield == f.name
                })
            })
        })
        return this.success({ list, fields})
    }
    async addFromDbAction() {
        let { aid, fields } = this.post()
        //console.log(fields)
        let data = await this.model('api').parseFields(fields, aid);
        //console.log(data)
        if (data.length > 0) {
            let keys = [];
            data.forEach(d => {
                keys.push(d.key)
            });
            let haslist = await this.model('api_params').where({ aid, key: ['in', keys] }).select(),
                addlist = [];
            if (haslist && haslist.length > 0) {
                data.forEach(d => {
                    let has = haslist.some(l => {
                        return l.key == d.key || (l.tablename == d.tablename && l.tablefield == d.tablefield)
                    })
                    if(!has) addlist.push(d)
                })
                if(addlist.length > 0)
                    await this.model('api_params').addMany(addlist);
            } else {
                await this.model('api_params').addMany(data);
            }
            //if(!think.isEmpty(has)) return this.fail('系统中存在相同的标志')
            await this.updateFile(aid);
            
        }
            
        return this.success()
    }
    async editDataAction() {
        let { id, field, value, aid } = this.post();
        if (!await this.hasData('api_params', { id }))
            return this.fail("编辑的数据不存在");
        if (field == 'key') {
            let has = await this.model('api_params').where({ aid, key: value }).find()
            if (!think.isEmpty(has)) return this.fail('系统中存在相同的标志')
        }
        let up = {};
        up[field] = value;
        await this.model('api_params').where({ id }).update(up);
        await this.updateFile(aid);
        return this.success()
    }
    async delAction() {
        let id = this.post('id');
        let data = await this.model('api_params').where({ id }).find();
        if (think.isEmpty(data))
            return this.fail('数据不存在');
        let aid = data.aid;
        await this.model('api_params').where({ id }).delete()
        await this.updateFile(aid);
        return this.success()
    }
    async addAction() {
        let post = this.post();
        let has = await this.model('api_params').where({ key: post.key, aid : post.aid }).find();
        if (!think.isEmpty(has)) return this.fail('存在相同的唯一标志');
        await this.model('api_params').add(post);
        await this.updateFile(post.aid);
        return this.success()
    }
    async addPageAction() {
        let aid = this.post('aid');
        let keys = ['page', 'limit', 'param'];
        let list = await this.model('api_params').where({ aid }).getField('key');
        let add = [];
        keys.forEach(d => {
            if (!list.includes(d)) add.push(d)
        });
        if (add.length > 0) {
            let adds = [];
            let keysname = {
                'page': {
                    name: '分页页数',
                    type: 'number',
                    def : 1
                },
                'limit': {
                    name: '每页数据量',
                    type: 'number',
                    def : 20
                },
                'param': {
                    name: '分页参数',
                    type: 'string',
                    def : ''
                }
            }
            add.forEach(d => {
                adds.push({
                    aid,
                    key: d,
                    name: keysname[d].name,
                    type: keysname[d].type,
                    def: keysname[d].def,
                    required: 0,
                    isdb: 0,
                    tablename: '',
                    tablefield: ''
                })
            })
            await this.model('api_params').addMany(adds);
            await this.updateFile(aid);
        }
        return this.success()
    }
    async editAction() {
        let post = this.post();
        let has = await this.model('api_params').where({ id: post.id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        if (has.key != post.key) {
            let exists = await this.model('api_params').where({ key: post.key, aid: post.aid }).find();
            if (!think.isEmpty(exists)) return this.fail('存在相同的唯一标志');
        }
        await this.model('api_params').where({ id: post.id }).update(post);
        await this.updateFile(post.aid);
        return this.success()
    }

    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('api_params').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        return this.success(data);
    }
    async updateFile(aid) {
        let api = await this.model('api').where({ id: aid }).find();
        let mod = await this.model('mod').where({ id: api.mod_id }).find();
        let params = await this.model('api_params').where({ aid }).select();
        this.service('api').updateParams(mod, api, params);
    }
}