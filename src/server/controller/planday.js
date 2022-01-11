const Base = require('./base.js');
/**
 * @class
 * @apiDefine planday 日程计划管理
 */
module.exports = class extends Base {

    async listAction() {
        let { viewtype, start_time, end_time } = this.get();
        let wsql = {
            start: ['>', start_time/1000],
            end: ['<', end_time/1000]
        };
        let list = await this.model('planday').where(wsql).order('id desc').select();
        list.forEach(d => {
            d.content = JSON.parse(d.content)
            //console.log(JSON.stringify(d.content))
            d.content.start = think.datetime(d.start*1000, 'YYYY-MM-DD HH:mm:ss')
            d.content.end = think.datetime(d.end * 1000, 'YYYY-MM-DD HH:mm:ss')
            d.content.isAllDay = d.content.isAllDay === "true" ? true : false;
            d.content.isPrivate = d.content.isPrivate === "true" ? true : false;
        })
        return this.success(list)
    }

    async addAction() {
        let post = this.post();
        let data = {
            id: post.id,
            title: post.title,
            content: JSON.stringify(post),
            start: post.start / 1000,
            end : post.end/1000,
            user_id: this.adminId,
            add_time: this.now(),
            update_time: this.now()
        }
        let id = await this.model('planday').add(data);
        return this.success(id);
    }

    async editAction() {
        let post = this.post();
        let has = await this.model('planday').where({ id: post.id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        //delete post.changed;
        
        let content = JSON.parse(has.content);
        //content = think.extend({}, post);
        for (let p in post) {
            content[p] = post[p];
        }
        let data = {
            content: JSON.stringify(content),
            update_time: this.now()
        }
        if (post.title) data.title = post.title;
        if (post.start) data.start = post.start / 1000;
        if (post.end) data.end = post.end / 1000;
        console.log(data)
        await this.model('planday').where({ id: post.id }).update(data);
        return this.success()
    }

    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('planday').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        return this.success(data);
    }

    async delAction() {
        let id = this.post('id');
        if (!await this.hasData('planday', { id }))
            return this.fail('数据不存在')
        await this.model('planday').where({ id }).delete()
        return this.success()
    }
}