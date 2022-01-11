const path = require('path');
const fs = require('fs');
const cachePath = path.join(think.ROOT_PATH, 'data/mod/');
const srcPath = path.join(think.ROOT_PATH, 'src/');
module.exports = class extends think.Service {
    addApi(mod, post) {
        let cPath = cachePath + mod.server_path + '/controller/' + mod.key + '.json';
        let cData = require(cPath);
        cData.funcs[post.key] = { info: post };
        let comments = `\t/**\n\t* @name ${post.name}\n\t*/\n\t`;
        //cData.content += `${comments}async ${post.key}Action(){}\n`;
        if (!cData.content) lData.content = {};
        if (!cData.content[post.key]) cData.content[post.key] = {};
        cData.content[post.key].start = `${comments}async ${post.key}Action(){\n`;
        if (!cData.content[post.key].list)
            cData.content[post.key].list = [];
        cData.content[post.key].end = `\t}\n`;
        fs.writeFileSync(cPath, JSON.stringify(cData));
        this.setParseData(cData);
        let lPath = cachePath + mod.server_path + '/logic/' + mod.key + '.json';
        let lData = require(lPath);
        lData.funcs[post.key] = { info: post };
        if (!lData.content) lData.content = {};
        if (!lData.content[post.key]) lData.content[post.key] = {};
        lData.content[post.key].start = `${comments}${post.key}Action(){\n\t`;
        if (!lData.content[post.key].list)
            lData.content[post.key].list = [`\tthis.allowMethods = '${post.method}';\n`];
        lData.content[post.key].end = `\t}\n`;
        //lData.content += `${comments}${post.key}Action(){\n\t\tthis.allowMethods = '${post.method}';\n\t}\n`;
        fs.writeFileSync(lPath, JSON.stringify(lData));
        this.setParseData(lData);
    }
    delApi(mod, key) {
        let cPath = cachePath + mod.server_path + '/controller/' + mod.key + '.json';
        let cData = require(cPath);
        delete cData.funcs[key];
        delete cData.content[key];
        fs.writeFileSync(cPath, JSON.stringify(cData));
        this.setParseData(cData);
        let lPath = cachePath + mod.server_path + '/logic/' + mod.key + '.json';
        let lData = require(lPath);
        delete lData.funcs[key];
        delete lData.content[key];
        fs.writeFileSync(lPath, JSON.stringify(lData));
        this.setParseData(lData);
    }
    setParseData(data) {
        let str = ``;
        if (data.comments) str += data.comments;
        if (data.params) str += data.params;
        str += data.start;
        if (data.content) {
            let clist = data.content;
            for (let p in clist) {
                let item = clist[p];
                if (item.start) str += item.start;
                if (item.list && item.list.length > 0) {
                    
                    item.list.forEach(d => {
                        if (data.typesName == 'controller') {
                            d = "\t\t" + d.replace(/\n/g, "\n\t\t")
                            //d = d.replace(/(.*)}/, "\n}")
                            //d = d.replace("(.*)}", "$1\n}")
                        }
                        str += d;
                    })
                }
                if (item.end) str += item.end;

            }
            
        }
        str += data.end;
        fs.writeFileSync(data.path, str);
    }
    //更新逻辑层某个接口
    updateParams(mod, api, params) {
        let lPath = cachePath + mod.server_path + '/logic/' + mod.key + '.json';
        let lData = require(lPath);
        lData.funcs[api.key]['params'] = params;
        let list = [`\tthis.allowMethods = '${api.method}';\n`];
        list.push(`\t\tthis.rules = {\n`);
        let fourt = `\t\t\t\t`;
        params.forEach(d => {
            list.push(`\t\t\t ${d.key} : {\n`);
            if (d.required == 1) list.push(`${fourt}required : true,\n`);
            if (d.type == 'string') {
                list.push(`${fourt}string : true,\n`);
            }
            if (d.len_max || d.len_min) {
                let str = `${fourt}length: {`;
                if (d.len_max) str += `max : ${d.len_max}`;
                if (d.len_min) {
                    if (d.len_max) str += `,`;
                    str += `min : ${d.len_min}`
                }
                str += `},\n`;
                if (d.len_min > 0 && d.len_min == d.len_max) {
                    str = `${fourt}length: ${d.len_max},\n`;
                }
                list.push(str)
            }
            if (d.type == 'number') {
                if (d.num_max || d.num_min) {
                    let str = `${fourt}int: {`;
                    if (d.num_max) str += `max : ${d.num_max}`;
                    if (d.num_min) {
                        if (d.num_min) str += `,`;
                        str += `min : ${d.num_min}`
                    }
                    str += `},\n`;
                    if (d.num_min > 0 && d.num_min == d.num_max) {
                        str = `${fourt}int: ${d.num_max},\n`;
                    }
                    list.push(str)
                } else {
                    list.push(`${fourt}int : true,\n`)
                }
            }
            if (!think.isEmpty(d.format)) {
                if (d.format == 'image') {
                    list.push(`${fourt}image: true,\n${fourt}method: 'file',\n`)
                } else {
                    list.push(`${fourt}${d.format}: true,\n`)
                }
            }
            if (!think.isEmpty(d.def)) {
                if (d.type == 'number') {
                    list.push(`${fourt}defalut: ${d.def},\n`)
                } else {
                    list.push(`${fourt}defalut: '${d.def}',\n`)
                }
                
            }
            list.push(`${fourt}aliasName : '${d.name}'\n`);
            list.push(`\t\t\t},\n`);
        })
        list.push(`\t\t}\n`);
        lData.content[api.key].list = list;
        //lData.content += `${comments}${post.key}Action(){\n\t\tthis.allowMethods = '${post.method}';\n\t}\n`;
        fs.writeFileSync(lPath, JSON.stringify(lData));
        this.setParseData(lData);
    }
    //更新接口层代码
    updateCode(mod, api, str) {
        let cPath = cachePath + mod.server_path + '/controller/' + mod.key + '.json';
        let cData = require(cPath);
        cData.content[api.key]['list'] = [str];
        fs.writeFileSync(cPath, JSON.stringify(cData));
        this.setParseData(cData);
    }
}