const Base = require('./base.js');
const fs = require('fs');
const path = require('path');
const rename = think.promisify(fs.rename, fs);
const axios = require('axios');
module.exports = class extends Base {
    async listAction() {
        let aid = this.get('aid');
        let api = await this.model('api').where({id : aid}).find()
        let list = await this.model('api_test').where({ aid }).select()
        return this.success({ list,api })
    }
    async addBeforeAction() {
        let aid = this.get('aid')
        let api = await this.model('api').where({ id: aid }).find()
        let mod = await this.model('mod').where({ id: api.mod_id }).find()
        api.test_path = '/' + mod.server_path + '/' + mod.key + '/' + api.key;
        let params = await this.model('api_params').where({ aid }).select()
        let headers = [
            {
                key : 'Accept',
                val : '*/*'
            },
            // {
            //     key : 'Cookie',
            //     val : 'godoSystem'
            // },
            {
                key : 'rttoken',
                val : 'godoSystem'
            },
        ];
        let restop = [
            {
                key: 'code',
                val: 0,
                stype: 'number',
                isdata: 0
            },
            {
                key: 'message',
                val: '',
                stype: 'exist',
                isdata: 0
            },
            {
                key: 'data',
                val: '',
                stype: 'object',
                isdata: 1
            }
        ];
        let tabs = await this.model('api').getTables(aid);
        let fields = await this.model('api').getFields(tabs);

        return this.success({ api, mod, params, headers, restop, fields})
    }
    async testRunAction() {
        //let res = await axios('https://www.baidu.com');
        let post = this.post('data'),
            data = JSON.parse(post);
        console.log(data)
    }
    async addAction() {
        let post = this.post('data'),
            data = JSON.parse(post);
        let add = {
            aid: data.aid,
            name: data.name,
            method: data.formData.method,
            add_time: this.now(),
            update_time : 0,
            data: post
        };
        //console.log(add)
        await this.model('api_test').add(add);
        return this.success()
    }
    async uploadAction() {
        const file = this.file('file[]');
        //console.log(this.file());
        if (!file) return this.fail(100, '请上传文件');
        let canupload = ["png", "jpg", "jpeg", "gif", "sql","wav"],
            end = file.path.split(".").pop();
        if (!canupload.includes(end)) return this.fail('上传格式错误');
        let name = Date.now() + "." + end,
            filepath = path.join(think.ROOT_PATH, 'www/upload/test/' + name);
        think.mkdir(path.dirname(filepath));
        await rename(file.path, filepath);
        let filename = '/upload/test/' + name;
        return this.success({
            name: file.name,
            filename
        })
    }
}