const prefix = think.config('mysql.prefix');
module.exports = class extends think.Model {
    /**
     * 前台渲染递归 表结构必须有id pid title
     * @param {array} tid 
     * @returns 
     */
    async getTree(tabName) {
        let data = await this.model(tabName).select()
        //根据 id取出某一个分类的子集
        //console.log(tid)
        const findById = (id) => {
            let child = [];
            data.forEach((value) => {
                if (value.pid == id) {
                    let d = {
                        title: value.title,
                        id: value.id,
                    }
                    child.push(d);
                }
            });
            return child;
        };
        // 递归查询到数据并将数据存储到数组 
        const deeploop = function (id) {
            let dataArr = findById(id);
            if (dataArr.length <= 0) {
                return null;
            } else {
                dataArr.forEach((value) => {
                    if (deeploop(value.id) != null) {
                        value["child"] = deeploop(value.id);
                    }
                });
            }
            return dataArr;
        };
        return [
            {
                id: 0,
                title: '顶层目录',
                child: deeploop(0)
            }
        ];
    }
    async hasTable(table) {
        
        if (table.indexOf(prefix) === -1) {
            table = prefix + table;
        }
        let rows = await this.query(`select * FROM information_schema.COLUMNS where table_name = '${table}'`);
        if (rows.length > 0) {
            return true;
        }
        return false;
    }
    async tableList() {
        let list = await this.query("SELECT TABLE_NAME,TABLE_COMMENT FROM information_schema.TABLES WHERE `TABLE_SCHEMA` = '" + think.config('mysql.database') + "'");
        let rt = {}, res = [];
        list.forEach(d => {
            //let name = d.TABLE_NAME.replace(new RegExp(prefix, 'g'), '');
            let name = d.TABLE_NAME;
            if (!rt[name]) {
                rt[name] = d.TABLE_COMMENT;
            }
        });
        for (let p in rt) {
            res.push({ name: rt[p], id : p })
        }
        return res;
    }

};
