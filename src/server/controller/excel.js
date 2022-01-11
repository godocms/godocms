const Base = require('./base.js');
const fs = require('fs');
const LuckyExcel = require('luckyexcel');
/**
 * @class
 * @apiDefine excel excel管理管理
 */
module.exports = class extends Base {

    async listAction() {
        let { page, limit, param } = this.get();
        let wsql = {};
        if (param) wsql = this.parseSearch(param, wsql);
        let list = await this.model('excel').where(wsql).page(page, limit).order('id desc').select();
        let count = await this.model('excel').where(wsql).count();
        return this.success({ list, count })
    }

    async addAction() {
        let post = this.post();
        post.add_time = this.now();
        post.user_id = this.adminId;
        post.update_time = this.now();
        let id = await this.model('excel').add(post);
        return this.success(id);
    }

    async editAction() {
        let post = this.post();
        let has = await this.model('excel').where({ id: post.id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        post.update_time = this.now();
        await this.model('excel').update(post);
        return this.success()
    }

    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('excel').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        return this.success(data);
    }

    async delAction() {
        let id = this.post('id');
        if (!await this.hasData('excel', { id }))
            return this.fail('数据不存在')
        await this.model('excel').where({ id }).delete()
        return this.success()
    }

    async uploadAction() {
        const file = this.file('file');
        //console.log(file);
        if (!file) return this.fail('请上传文件');
        let end = file.path.split(".").pop();
        if (end != 'xlsx') return this.fail('请选择xlsx格式');
        let fileData = fs.readFileSync(file.path);
        let filename = file.name.replace('.'+end, '');
        //console.log(file.path)
        //console.log(fileData)
        try {
            LuckyExcel.transformExcelToLucky(fileData, async (exportJson, luckysheetfile) => {
                let add = {
                    title: filename,
                    content: JSON.stringify(exportJson.sheets),
                    add_time: this.now(),
                    update_time: this.now()
                }
                await this.model('excel').add(add)
            });
            return this.success()
        } catch (e) {
            return this.fail(e.message)
        }
        
    }
    async importAction() {
        const file = this.file('file');
        //console.log(file);
        if (!file) return this.fail('请上传文件');
        let end = file.path.split(".").pop();
        if (end != 'xlsx') return this.fail('请选择xlsx格式');
        let fileData = fs.readFileSync(file.path);
        let filename = file.name.replace('.' + end, '');
        //console.log(file.path)
        //console.log(fileData)
        try {
            let getData = (fileData) => {
                return new Promise((reslove, reject) => {
                    LuckyExcel.transformExcelToLucky(fileData, (exportJson, luckysheetfile) => {
                        //console.log(exportJson.sheets)
                        return reslove(exportJson.sheets);
                    });
                })
            }
            let res = await getData(fileData)
            //console.log(res)
            return this.success({title : filename, content : res});
            
        } catch (e) {
            return this.fail(e.message)
        }
    }
}