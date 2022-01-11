const path = require('path');
const fs = require('fs');
const docBasePath = path.join(think.ROOT_PATH, 'www/docs/');
const tplPath = path.join(think.ROOT_PATH, 'data/doc/');

const rename = think.promisify(fs.rename, fs);
module.exports = class extends think.Service {
    checkPath(name) {
        return think.isDirectory(docBasePath + name)
    }
    copyFile(post) {
        think.mkdir(docBasePath + post.key, '0775');
        think.mkdir(docBasePath + post.key + '/img', '0777');
        fs.writeFileSync(docBasePath + post.key + '/summary.md',
            fs.readFileSync(tplPath + 'summary.md'));
        let readmeTpl = fs.readFileSync(tplPath + 'README.md');
        fs.writeFileSync(docBasePath + post.key + '/README.md', readmeTpl);
        let changelogTpl = fs.readFileSync(tplPath + 'CHANGELOG.md');
        fs.writeFileSync(docBasePath + post.key + '/CHANGELOG.md', changelogTpl);
        let coverPageTpl = fs.readFileSync(tplPath + '_coverpage.md', 'utf-8');
        //console.log(coverPageTpl)
        fs.writeFileSync(docBasePath + post.key + '/_coverpage.md',
            this.replaceCoverpage(coverPageTpl, post));
        let indexTpl = fs.readFileSync(tplPath + 'index.html', 'utf-8');
        fs.writeFileSync(docBasePath + post.key + '/index.html',
            this.replaceIndex(indexTpl, post));
        let logoPath = path.join(think.ROOT_PATH, 'www') + post.logo;
        fs.writeFileSync(docBasePath + post.key + '/img/logo.png',
            fs.readFileSync(logoPath));
        fs.unlink(logoPath, res => { });
        return [
            {
                title: '安装说明',
                name: 'README',
                content: readmeTpl,
                type: 1,
                did: post.did,
                pid: post.pid,
                user_id: post.uid,
                add_time: post.now,
                update_time: post.now,
                order_num : 2
            },
            {
                title: '变更日志',
                name: 'CHANGELOG',
                content: changelogTpl,
                type: 1,
                did: post.did,
                pid: post.pid,
                user_id: post.uid,
                add_time: post.now,
                update_time: post.now,
                order_num : 1
            }
        ]
    }
    getList(key) {
        let syspath = docBasePath + key + '/';
        let spath = syspath + 'summary.md';
        if (!think.isFile(spath)) return 'summary.md文件不存在';
        let tpl = fs.readFileSync(spath, 'utf-8');
        let arr = tpl.split('\n');
        console.log(arr);
        if(arr.length < 1) return '数据为空'
        let cate = [], list = [];
        //先取目录
        arr.forEach((v, i) => {
            if (v.indexOf('.md') === -1) {
                v = v.trim();
                if (v && v != '') {
                    cate.push({
                        id: i,
                        name: v.replace('* ', '')
                    })
                }
                
            }
        })
        console.log(cate)
        const parseTitle = t => {
            t = t.trim()
            t = t.replace('/\t', '')
                .replace('* ', '')
                .replace('[', '')
                .replace('.md)', '')
            let arr = t.split('](');
            return {
                title: arr[0].trim(),
                name : arr[1]
            }
        }
        for (let i = 0; i < cate.length; i++) {
            let item = cate[i], next = cate[i + 1];
            if (!cate[i]['child']) cate[i]['child'] = [];
            arr.forEach((p,k) => {
                if (p.indexOf('.md') !== -1) {
                    if (next && next.id) {
                        if (k > item.id && k < next.id) {
                            cate[i]['child'].push(parseTitle(p))
                        }
                    } else {
                        if (k > item.id) {
                            cate[i]['child'].push(parseTitle(p))
                        }
                    }
                }
            })
        }
        cate.forEach(d => {
            if (d.child && d.child.length > 0) {
                d.child.forEach((p, i) => {
                    let pfile = syspath + p.name + '.md';
                    if (think.isFile(pfile)) {
                        p.content = fs.readFileSync(pfile, 'utf-8')
                    } else {
                        delete d.child[i]
                    }
                })
            }
        })
        return {data : cate}
    }
    changeLogo(post) {
        let logoPath = path.join(think.ROOT_PATH, 'www') + post.logo;
        fs.writeFileSync(docBasePath + post.key + '/img/logo.png',
            fs.readFileSync(logoPath));
        fs.unlink(logoPath, res => { });
    }
    replaceCoverpage(tpl, data) {
        return tpl.replace(/{{title}}/g, data.title)
            .replace(/{{name}}/g, data.name)
            .replace(/{{version}}/g, data.version)
            .replace(/{{remark}}/g, data.remark);
    }
    replaceIndex(tpl, data) {
        return tpl.replace(/{{title}}/g, data.title);
    }
    async uploadFile(file, fpath) {
        let canupload = ["png", "jpg", "jpeg", "gif", "sql","wav"],
            end = file.path.split(".").pop();
        if (!canupload.includes(end)) return false;
        try {
            let name = Date.now() + "." + end,
                filepath = path.join(think.ROOT_PATH, 'www/docs/' + fpath + '/img/' + name);
            think.mkdir(path.dirname(filepath));
            await rename(file.path, filepath);

            let filename = '/docs/' + fpath + '/img/' + name;
            return {
                name: file.name,
                filename
            }
        } catch (e) {
            console.log(e.message)
            return false;
        }
        
    }
    async delDoc(key) {
        let filePath = docBasePath + key;
        await think.rmdir(filePath, false)
    }
    async addmd(post) {
        if (post.content) {
            let filepath = path.join(think.ROOT_PATH, 'www/docs/' + post.key + '/' + post.name + '.md');
            fs.writeFileSync(filepath, post.content);
        }
        if (post.cateList) {
            let cateStr = this.parseSummary(post.cateList);
            let catepath = path.join(think.ROOT_PATH, 'www/docs/' + post.key + '/summary.md');
            fs.writeFileSync(catepath, cateStr);
        }
        
    }
    parseSummary(cate) {
        let str = '';
        cate.forEach(d => {
            str += '* ' + d.title + '\n';
            if (d.child && d.child.length > 0) {
                d.child.forEach(k => {
                    str += '	* [' + k.title + '](' + k.name + '.md)\n';
                })
            }
            
        });
        return str;
    }
}