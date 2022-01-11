const json2md = require("json2md");
const path = require('path');
const fs = require('fs');
module.exports = class extends think.Service {
    db(data) {
        //const data = require(path.join(think.ROOT_PATH, 'data/db.json'));
        //const data = think.model('db').all();
        let rt = [];
        rt.push({ 'h3': '表清单' });
        //{ headers: ["a", "b"], rows: [{ a: "col1", b: "col2" }] } } or { table: { headers: ["a", "b"], rows: [["col1", "col2"]] }
        let listheader = ['序号','数据表', '名称'],
            headerRows = [],
            i=0;
        for (let p in data) {
            let e = data[p];
            i++;
            headerRows.push([i, e.tabname, e.tabcomment]);
        }
        rt.push({
            'table': {
                headers: listheader,
                rows : headerRows
            }
        });
        rt.push({ hr: "" });
        let tabheader = ['排序', '字段名', '名称', '类型', '是否为空','索引','默认值'];
        for (let p in data) {
            let e = data[p];
            rt.push({ 'h4': e.tabname + '-' + e.tabcomment });
            let bodyRows = [];
            for (let k in e.fields) {
                let d = e.fields[k];
                bodyRows.push([d.order, d.name, d.comment, d.type, d.isnull, d.key, d.default ? d.default : 'null'])
            }
            //console.log(bodyRows)
            rt.push({
                'table': {
                    headers: tabheader,
                    rows: bodyRows
                }
            });
            rt.push({"p" : '创建代码'})
            rt.push({
                "code": {
                    language: "js",
                    content: [e.sql]
                }
            })
            rt.push({ hr: "" })
        }
        
        let res = json2md(rt);
        //写入到开发文档 后期可注释掉
        //let sqlmdFile = path.join(think.ROOT_PATH, 'www/docs/server/doc/sql.md');
        //fs.writeFileSync(sqlmdFile, res);
        //
        return res;
    }
}