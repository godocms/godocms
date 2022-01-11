const path = require('path');
const fs = require('fs');
const cachePath = path.join(think.ROOT_PATH, 'data/mod/');
const srcPath = path.join(think.ROOT_PATH, 'src/');
const viewPath = path.join(think.ROOT_PATH, 'www/admin/view/');
const tplFile = require(cachePath + 'tpl/curd.js');
const types = {
    1: 'controller',
    2: 'model',
    3: 'service',
    4: 'logic'
};
module.exports = class extends think.Service {
    async createMod(data) {
        if (data.type > 4) {
            
            await this.createModCurd(data);
            data.extra = JSON.stringify({
                iscate: data.iscate,
                topAuthId: data.pid,
                topAuthIcon: data.icon
            });
        }
        else {
            let obj = this.getParseData(data);
            this.setParseData(obj);
            if (data.type == 1) {
                data.type = 4;
                delete data.paramsList;
                let logic = this.getParseData(data);
                this.setParseData(logic);
            }
        }
    }
    async del(data) {
        await this.delFile(data);
        if (data.type == 1) {
            data.type = 4;
            await this.delFile(data);
        }
    }
    async delFile(data) {
        //return false;
        let jsonfile = cachePath + data.server_path + '/' + types[data.type] + '/' + data.key + '.json';
        //console.log(jsonfile)
        let jsfile = srcPath + data.server_path + '/' + types[data.type] + '/' + data.key + '.js';
        //console.log(jsfile)
        if (think.isFile(jsfile)) {
            await fs.unlink(jsfile, res => {});
        }
        if (think.isFile(jsonfile)) {
            await fs.unlink(jsonfile, res => { });
        }
        if (data.type == 5) {
            think.rmdir(viewPath + data.key, false).then(() => {
                console.log('模版删除完成')
            })
        }
    }
    setParseData(data) {
        let str = ``;
        if (data.comments) str += data.comments;
        if (data.params) str += data.params;
        str += data.start;
        if (data.content) str += data.content;
        str += data.end;
        fs.writeFileSync(data.path, str);
    }
    getParseData(data) {
        let typesName = types[data.type];
        let comments = `/**\n* @${typesName}\n* @apiDefine ${data.key} ${data.name}\n*/\n`;
        let paramStr = ``;
        if (data.paramsList) {
            //解析顶部常量
            data.paramsList.forEach(d => {
                if (d.type == 1) {
                    paramStr += `const ${d.key} = require('${d.content}');\n`;
                }
                else if (d.type == 2 || d.type == 4 || d.type == 5) {
                    paramStr += `const ${d.key} = ${d.content};\n`;
                }
                else if (d.type == 3) {
                    paramStr += `const ${d.key} = \`${d.content}\`;\n`;
                }
            });
        }
        let start = {
            1: `const Base = require('./base.js');\nmodule.exports = class extends Base {\n`,
            2: `module.exports = class extends think.Model {\n`,
            3: `module.exports = class extends think.Service {\n`,
            4:`module.exports = class extends think.Logic {\n`
        }
        let end = `};`;
        let file = cachePath + data.server_path + '/' + typesName + '/' + data.key + '.json';
        let path = srcPath + data.server_path + '/' + typesName + '/' + data.key + '.js';
        //console.log(file);
        let jsonData;
        if (think.isFile(file)) {
            jsonData = require(file);
            jsonData.info = data;
            jsonData.path = path;
            jsonData.typesName = typesName;
            jsonData.params = paramStr;
            jsonData.comments = comments;
            jsonData.start = start[data.type];
            jsonData.end = end;
            fs.writeFileSync(file, JSON.stringify(jsonData));
        } else {
            jsonData = {
                info: data,
                path: path,
                linkPath : '',
                typesName: typesName,
                params: paramStr,
                comments: comments,
                start: start[data.type],
                content: {},
                funcs: {},
                end : end
            };
            //console.log(jsonData)
            fs.writeFileSync(file, JSON.stringify(jsonData));
        }
        return jsonData;
    }
    /**
     * 不带分类的控制层模版
     * @param {object} data 
     * @returns 
     */
    getControllerTpl(data) {
        let controllerTpl = tplFile.ctpl.start;
        controllerTpl += tplFile.ctpl.list;
        controllerTpl += tplFile.ctpl.add;
        controllerTpl += tplFile.ctpl.edit;
        controllerTpl += tplFile.ctpl.editBefore;
        controllerTpl += tplFile.ctpl.del;
        controllerTpl += tplFile.endTpl;
        let prefix = think.config('mysql.prefix');
        controllerTpl = this.replaceTpl(controllerTpl, data.name, data.tables_main.replace(prefix, ''));
        return controllerTpl;
    }
    /**
     * 不带分类的逻辑层模版
     * @param {object} data
     * @returns
     */
    getLogicTpl(data) {
        let logicTpl = tplFile.ltpl.start;
        logicTpl += tplFile.ltpl.list;
        logicTpl += tplFile.ltpl.add;
        logicTpl += tplFile.ltpl.edit;
        logicTpl += tplFile.ltpl.editBefore;
        logicTpl += tplFile.ltpl.del;
        logicTpl += tplFile.endTpl;
        return logicTpl;
    }
    /**
     * 不带分类的试图层模版
     * @param {object} data
     * @returns
     */
    getHtmlTpl(data) {
        //console.log(tplFile);
        let list = this.replaceTpl(tplFile.htmlTpl.list, data.name, data.key),
        edit = this.replaceTpl(tplFile.htmlTpl.edit, data.name, data.key);
        return { list, edit}
    }
    //@todo 模型的多模版可以在这里扩展，第二期
    async createModCurd(data) {
        let path = srcPath + data.server_path,//服务器端路径
            name = data.name,//模块名字
            tags = data.key,//模块标识
            controllerFile = path + '/controller/' + tags + '.js',
            logicFile = path + '/logic/' + tags + '.js',
            vPath = viewPath + tags,
            listFile = vPath + '/list.html',
            editFile = vPath + '/edit.html',
            controllerTpl = '',
            logicTpl = '',
            htmlTpl = {};
        if (!think.isDirectory(vPath)) think.mkdir(vPath);
        //不带分类的
        if (!data.iscate) {
            //控制器
            controllerTpl = this.getControllerTpl(data);
            fs.writeFileSync(controllerFile, controllerTpl);
            //逻辑层
            logicTpl = this.getLogicTpl(data);
            fs.writeFileSync(logicFile, logicTpl);
            //视图层
            htmlTpl = this.getHtmlTpl(data);
            fs.writeFileSync(listFile, htmlTpl.list);
            fs.writeFileSync(editFile, htmlTpl.edit);
        }
        else {
            
        }
        
    }
    replaceTpl(tpl, name, tags) {
        return tpl.replace(/{{tags}}/g, tags).replace(/{{name}}/g, name);
    }
    
}