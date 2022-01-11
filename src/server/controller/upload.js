const Base = require('./base.js');
const fs = require('fs');
const path = require('path')
const rename = think.promisify(fs.rename, fs); // 通过 promisify 方法把 rename 方法包装成 Promise 接口

module.exports = class extends Base {
    async indexAction() {
        try {
            await this.upload();
        } catch (e) {
            console.log(e.message)
            return this.fail(e.message)
        }
    }
    async upload() {
        const file = this.file('file');
        //console.log(file);
        if (!file) return this.fail(100, '请上传文件');
        let isSys = this.post('sys');
        //console.log(file);
        let canupload = ["xls", "xlsx", "doc", "docx", "pdf", "ppt", "pptx", "zip", "png", "jpg", "jpeg", "gif", "pem"],
            end = file.path.split(".").pop();
        if (!canupload.includes(end)) return this.fail(100, '上传文件格式错误')
        let name = Date.now() + "." + end,
            day = think.datetime(Date.now(), 'YYYY-MM-DD'),
            rpath = '/upload/' + end + '/' + day + '/',
            filepath = path.join(think.ROOT_PATH, 'www' + rpath + name);
        if (isSys) {
            filepath = path.join(think.ROOT_PATH, 'data' + rpath + name);
        }
        think.mkdir(path.dirname(filepath));
        await rename(file.path, filepath);
        
        if (isSys) {
            return this.success({
                name: file.name,
                filepath
            })
        } else {
            let host = this.ctx.host || this.ctx.hostname;
            let filename = host + rpath + name;
            return this.success({
                name: file.name,
                filename,
                filepath,
                path : rpath + name
            })
        }
        

    }
}
