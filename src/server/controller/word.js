const Base = require('./base.js');
const fs = require('fs');
const path = require('path')
const rename = think.promisify(fs.rename, fs);
const PDFParser = require("pdf2json");
const textract = require('textract');
const getWorker = require('tesseract.js-node');//图片ocr
//const okrabyte = require('okrabyte');
//const pdf2html = require('pdf2html');
/**
 * @class
 * @apiDefine word 文档编辑器管理
 */
//module.exports = class extends think.Controller {
module.exports = class extends Base {
    async listAction() {
        let { page, limit, param } = this.get();
        let wsql = {};
        if (param) wsql = this.parseSearch(param, wsql);
        let list = await this.model('word').where(wsql).page(page, limit).order('id desc').select();
        let count = await this.model('word').where(wsql).count();
        return this.success({ list, count })
    }

    async addAction() {
        let post = this.post();
        let data = {
            title: post.title,
            content: post.content,
            add_time: this.now(),
            update_time: this.now(),
            user_id : this.adminId
        }
        console.log(data)
        let id = await this.model('word').add(data);
        return this.success(id);
    }

    async editAction() {
        let post = this.post();
        let id = post.id;
        let has = await this.model('word').where({ id: post.id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        let data = {
            title: post.title,
            content: post.content,
            update_time: this.now()
        }
        await this.model('word').where({id}).update(data);
        return this.success()
    }

    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('word').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        return this.success(data);
    }

    async delAction() {
        let id = this.post('id');
        if (!await this.hasData('word', { id }))
            return this.fail('数据不存在')
        await this.model('word').where({ id }).delete()
        return this.success()
    }
    async uploadAction() {
        const file = this.file('edit');
        console.log(file)
        //console.log(this.file());
        if (!file) return this.fail(100, '请上传文件');
        let canupload = ["xls", "xlsx", "doc", "docx", "pdf", "ppt", "pptx", "zip", "png", "jpg", "jpeg", "gif", "pem"],
            end = file.path.split(".").pop();
        if (file.type == 'image/png' && file.name == 'blob') {
            end = 'png';
        }
        if (!canupload.includes(end)) return this.fail(100, '上传文件格式错误')
        let name = Date.now() + "." + end,
            day = think.datetime(Date.now(), 'YYYY-MM-DD'),
            rpath = '/upload/word/' + end + '/' + day + '/',
            filepath = path.join(think.ROOT_PATH, 'www' + rpath + name);
        think.mkdir(path.dirname(filepath));
        await rename(file.path, filepath);

        let host = this.ctx.host || this.ctx.hostname;
        let filename = host + rpath + name;
        return this.success({
            name: file.name,
            filename,
            filepath,
            path: rpath + name
        })


    }
    async openFileAction() {
        const file = this.file('file');
        //console.log(file);
        if (!file) return this.fail('请上传文件');
        let end = file.path.split(".").pop();
        let filename = Date.now() + '.' + end,
            filepath = path.join(think.ROOT_PATH, 'www/upload/word/cache/' + filename)
        think.mkdir(path.dirname(filepath));
        await rename(file.path, filepath);
        try {
            let res;
            let imgs = ['jpg', 'png', 'bmp','pbm'];
            if (imgs.includes(end)) {
                res = await this.openPic(filepath);
            }
            else if (end == 'pdf') {
                res = await this.openPdf(filepath);
            }
            else {
                res = await this.openText(filepath);
            }
            fs.unlink(filepath, e => { })
            return this.success(res);
        } catch (e) {
            fs.unlink(filepath, e => { })
            return this.fail(e.message)
        }
    }
    async openText(filepath) {
        return new Promise((reslove, reject) => {
            textract.fromFileWithPath(filepath, function (error, text) {
                reslove(text)
                console.log(error)
            })
        })
    }
    async openPic(filepath) {
        const worker = await getWorker({
            tessdata: path.join(think.ROOT_PATH, 'data/ocr/lang'),
            languages: ['chi_sim']  
        });
        return await worker.recognize(filepath, 'chi_sim');
    }
    async openPdf(filepath) {
        return new Promise((reslove, reject) => { 
            const pdfParser = new PDFParser(this,1);
            pdfParser.loadPDF(filepath);
            pdfParser.on("pdfParser_dataReady", pdfData => {
                //console.log(pdfData)
                let data = pdfParser.getRawTextContent()
                reslove(data)
            });
        })
        
    }
    
}