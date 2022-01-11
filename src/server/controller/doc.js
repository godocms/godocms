const Base = require('./base.js');
/**
 * @class
 * @apiDefine doc 文档管理
 */
module.exports = class extends Base {

    async listAction() {
        let { page, limit, param } = this.get();
        let wsql = {};
        if (param) wsql = this.parseSearch(param, wsql);
        let list = await this.model('doc').where(wsql).page(page, limit).order('id desc').select();
        let count = await this.model('doc').where(wsql).count();
        return this.success({ list, count })
    }

    async addAction() {
        let post = this.post();
        let has = await this.model('doc').where({ key: post.key }).find()
        if (!think.isEmpty(has)) return this.fail('系统中存在相同的键')
        if (this.service('doc').checkPath(post.key)) return this.fail('系统中存在该目录')
        let now = this.now();
        let add = {
            name: post.name,
            title: post.title,
            key: post.key,
            version: post.version,
            logo: 'img/logo.png',
            remark: post.remark,
            //summary: JSON.stringify(summary),
            user_id: this.adminId,
            add_time: now,
            update_time : now
        }
        post.did = await this.model('doc').add(add);
        
        let topData = {
            title: '安装必读',
            name: '',
            content: '',
            type: 0,
            did: post.did,
            user_id: this.adminId,
            add_time: now,
            update_time: now
        }
        post.pid = await this.model('doc_cate').add(topData);
        post.now = now;
        post.uid = this.adminId;
        let fileData = this.service('doc').copyFile(post);
        await this.model('doc_cate').addMany(fileData);

        return this.success(post.did);
    }
    async addmdAction() {
        let post = this.post()
        let now = this.now()
        let data = await this.model('doc').where({ id: post.did }).find();
        if (think.isEmpty(data)) return this.fail('文集不存在');
        //let summary = JSON.parse(data.summary);
        let has = await this.model('doc_cate').where({ did: post.did, name: post.name }).find();
        if (!think.isEmpty(has)) return this.fail('系统中存在相同的文件名');
        let pid = await this.getPid(post)
        let addData = {
            title: post.title,
            name: post.name,
            pid : pid,
            content: post.content,
            type: 1,
            did: post.did,
            user_id: this.adminId,
            add_time: now,
            update_time: now,
            order_num : post.order_num*1 || 0
        }
        let id = await this.model('doc_cate').add(addData);
        await this.updateFile(post);
        return this.success()
    }
    async editmdAction() {
        let post = this.post()
        let data = await this.model('doc_cate').where({ id: post.id }).find();
        if (think.isEmpty(data)) return this.fail('数据不存在');
        //let summary = JSON.parse(data.summary);
        //如果更改了文件名
        if (post.name != data.name) {
            let has = await this.model('doc_cate').where({ did: data.did, name: post.name }).find();
            if (!think.isEmpty(has)) return this.fail('系统中存在相同的文件名');
        }

        let pid = await this.getPid(post);
        let upData = {
            title: post.title,
            name: post.name,
            pid: pid,
            content: post.content,
            type: 1,
            update_time: this.now(),
            order_num: post.order_num*1
        }
        await this.model('doc_cate').where({ id: data.id }).update(upData);

        await this.updateFile(post);
        return this.success()

    }
    async getPid(post) {
        let pid = await this.model('doc_cate').where({ did: post.did, title: post.catename, type: 0 }).getField('id', true);
        if (!pid) {
            let cateData = {
                title: post.catename,
                name: '',
                content: '',
                type: 0,
                did: post.did,
                user_id: this.adminId,
                add_time: this.now(),
                update_time: this.now(),
                order_num : 0
            }
            pid = await this.model('doc_cate').add(cateData);
        }
        return pid;
    }
    async updateFile(post) {
        let cateList = await this.model('doc_cate').where({ did: post.did }).field('id,title,type,pid,name').order('order_num desc').select();
        let topCate = [];
        cateList.forEach(d => {
            if (d.type == 0) {
                topCate.push(d)
            }
        });
        topCate.forEach(d => {
            cateList.forEach(p => {
                if (p.pid == d.id) {
                    if (!d.child) d.child = [];
                    d.child.push(p)
                }
            });
        });
        post.cateList = topCate;
        post.key = await this.model('doc').where({id : post.did}).getField('key', true);
        await this.service('doc').addmd(post);
        await this.model('doc').where({ id: post.did }).update({
            update_time: this.now()
        })
    }
    async listmdAction() {
        let did = this.get('did');
        let cateList = await this.model('doc_cate').where({ did: did }).field('id,title,type,pid,name,add_time, update_time,order_num').order('order_num desc').select();
        return this.success(cateList)
    }
    async editAction() {
        let post = this.post();
        let has = await this.model('doc').where({ id: post.id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        if (has.key != post.key) return this.fail('系统标志不允许更改')
        if (post.logo != has.logo) {
            await this.service('doc').changeLogo(post);
            post.logo = 'img/logo.png'
        }
        await this.model('doc').update(post);

        return this.success()
    }
    async backAction() {
        let did = this.post('did');
        let data = await this.model('doc').where({ id: did }).find()
        if (think.isEmpty(data)) return this.fail('数据不存在');
        let list = this.service('doc').getList(data.key);
        //console.log(JSON.stringify(list))
        //return;
        if (list && list.data) {
            //先清空
            await this.model('doc_cate').where({ did }).delete()
            let uid = this.adminId, now = this.now();
            //await this.model('doc_cate').addMany()
            list.data.forEach(async d => {
                let addData = {
                    title: d.name,
                    name: '',
                    pid: 0,
                    content: '',
                    type: 0,
                    did: did,
                    user_id: uid,
                    add_time: now,
                    update_time: now,
                    order_num: 0
                }
                let pid = await this.model('doc_cate').add(addData);
                if (pid && d.child && d.child.length > 0) {
                    let adds = [];
                    d.child.forEach(p => {
                        if (p && p.name) {
                            adds.push({
                                title: p.title,
                                name: p.name,
                                content: p.content,
                                type: 1,
                                did: did,
                                pid: pid,
                                user_id: uid,
                                add_time: now,
                                update_time: now,
                                order_num: 0
                            });
                        }
                        
                    })
                    if (adds.length > 0) {
                        await this.model('doc_cate').addMany(adds)
                    }
                    
                }
            })
            return this.success()
        } else {
            return this.fail(list);
        }
        
    }
    async addBeforeAction() {
        let id = this.get('did');
        if(!id) return this.fail('id为空')
        let data = await this.model('doc').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        let list = await this.model('doc_cate').field('id,title').where({ type: 0, did: id }).select();
        return this.success(list);
    }
    async editmdBeforeAction() {
        let id = this.get('id');
        if (!id) return this.fail('id为空')
        let data = await this.model('doc_cate').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        data.cate = await this.model('doc_cate').field('id,title').where({ type: 0, did: data.did }).select();
        data.cate.forEach(d => {
            if (d.id == data.pid) {
                data.catename = d.title
            }
        })
        return this.success(data)
    }
    
    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('doc').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        return this.success(data);
    }
    async delmdAction() {
        let { id, did } = this.post()
        let data = await this.model('doc_cate').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据不存在')
        if (data.type == 0) {
            let has = await this.model('doc_cate').where({ pid: id }).find()
            if(!think.isEmpty(has)) return this.fail('该目录下存在文档')
        }
        await this.model('doc_cate').where({ id }).delete()
        await this.updateFile({did});
        return this.success()
    }
    async editDataAction() {
        let { id, field, value } = this.post();
        if (!await this.hasData('doc_cate', { id }))
            return this.fail("编辑的数据不存在");
        if (field == 'order_num' && think.isNumber(value)) {
            return this.fail('排序应该为数字')
        }
        let up = {};
        up[field] = value;
        await this.model('doc_cate').where({ id }).update(up);
        return this.success()
    }
    async delAction() {
        let id = this.post('id');
        if(id < 3) return this.fail('系统文档不允许删除')
        let data = await this.model('doc').where({id}).find()
        if (think.isEmpty(data))
            return this.fail('数据不存在')
        await this.model('doc').where({ id }).delete()
        await this.model('doc_cate').where({ did: id }).delete()
        await this.service('doc').delDoc(data.key);
        return this.success()
    }
    
    async uploadAction() {
        let id = this.post('did');
        if (!id) return this.fail('id为空')
        let data = await this.model('doc').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        let fpath = data.key;
        const file = this.file('file[]');
        //console.log(this.file());
        if (!file) return this.fail(100, '请上传文件');
        let rt = await this.service('doc').uploadFile(file, fpath);
        if (!rt) return this.fail('上传格式错误')
        return this.success(rt)
    }
}