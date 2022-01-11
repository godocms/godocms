module.exports = class extends think.Model {
    async getTables(aid) {
        let api = await this.model('api').where({ id: aid }).find()
        let mod = await this.model('mod').where({ id: api.mod_id }).find()
        //console.log(mod)
        let tabs = [mod.tables_main];
        if (mod.tables_more) {
            tabs = tabs.concat(mod.tables_more.split(','))
        }
        return tabs;
    }
    async getFields(tabs) {
        let tabsstr = tabs.join("','");
        let insql = `in (\'${tabsstr}\')`;
        //console.log(sql)
        let rt = await this.query(`select TABLE_NAME,COLUMN_NAME,COLUMN_COMMENT,COLUMN_TYPE,IS_NULLABLE,COLUMN_DEFAULT FROM information_schema.COLUMNS where TABLE_NAME ${insql}`);
        let keys = {};
        //console.log(rt)
        rt.forEach(d => {
            if (!keys[d.TABLE_NAME]) keys[d.TABLE_NAME] = {};
            if (!keys[d.TABLE_NAME][d.COLUMN_NAME])
                keys[d.TABLE_NAME][d.COLUMN_NAME] = {
                    name: d.COLUMN_NAME,
                    title: d.COLUMN_COMMENT,
                    type: d.COLUMN_TYPE.toLowerCase().indexOf('int') === -1 ? 'string' : 'number',
                    isnull: d.IS_NULLABLE,
                    def: d.COLUMN_DEFAULT === null ? '' : d.COLUMN_DEFAULT
                }
        })
        //取表名
        let list = await this.query(`SELECT TABLE_NAME,TABLE_COMMENT FROM information_schema.TABLES WHERE \`TABLE_SCHEMA\` = '${this.config.database}' and TABLE_NAME ${insql}`);
        let res = [];
        for (let p in keys) {
            let item = keys[p];
            let val = {
                name: p,
                comment: list.find(d => {
                    return d.TABLE_NAME === p
                }).TABLE_COMMENT
            };
            let child = [];
            for (let k in item) {
                child.push(item[k])
            }
            val.child = child;
            res.push(val)
        }
        //console.log(res)
        return res;
    }
    /**
     * 解析参数
     * @param {string} fields 
     * @param {number} aid 
     * @returns 
     */
    async parseFields(fields, aid) {
        let tabs = [], tobj = {};
        let fdArr = fields.split(',');
        let prefix = this.config.prefix;
        //先建索引
        fdArr.forEach(d => {
            let arr = d.split('.')
            if (!tabs.includes(arr[0])) {
                tabs.push(arr[0]);
            }
            //存字段
            if (!tobj[arr[0]]) tobj[arr[0]] = [];
            tobj[arr[0]].push(arr[1]);
        })
        //console.log(tabs)
        let flist = await this.getFields(tabs);
        //console.log(flist)
        let rt = [];
        flist.forEach(d => {
            d.child.forEach(f => {
                if (tobj[d.name].includes(f.name)) {
                    let add = {
                        aid,
                        key: f.name,
                        name: f.title,
                        type: f.type,
                        def : f.def,
                        required: f.isnull === 'YES' ? 1 : 0,
                        isdb: 1,
                        tablename: d.name,
                        tablefield: f.name
                    }
                    //去掉重名
                    let has = rt.some(r => {
                        return r.key == f.name
                    })
                    if (has) {
                        add.key = d.name.replace(prefix, '') + '_' + f.name
                    }
                    
                    rt.push(add);
                }
            })
        })
        return rt;
    }
    async del(id) {
        let data = await this.model('api').where({ id }).find();
        if (think.isEmpty(data)) return;
        let rt = think.extend({}, data);
        //console.log(rt)
        await this.model('api').where({ id }).delete();
        await this.model('api_params').where({ aid: id }).delete();
        //await this.model('api_')
        return rt;
    }
}