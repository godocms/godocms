const fs = require('fs');
module.exports = class extends think.Model {
    constructor(modelName, config) {
        super(modelName, config);
        //this.config = think.config('model.sqlite');
        this.config = think.config('model.mysql');
        this.service = think.service('db', 'server');
    }
    get pk() {
        return 'id';
    }
    get schema() {
        return {
            id: {
                type: 'int(10)',
                primary : true
            },
            host : { // 主机名
                type: 'varchar(200)',
                default: '127.0.0.1'
            },
            user: { // 用户名
                type: 'varchar(100)',
                default: 'root'
            },
            password: {
                type: 'varchar(120)',
                default: ''
            },
            port : {
                type: 'int(10)',
                default: 3306
            },
            isdef: {
                type: 'tinyint(2)',
                default : 0
            },
            encoding: {
                type: 'varchar(120)',
                default: 'utf8'
            },
            prefix: {
                type: 'varchar(120)',
                default: 'rt_'
            },
            dateStrings: {
                type: 'tinyint(2)',
                default: 0
            },
            ssh: {
                type: 'tinyint(2)',
                default: 0
            },
            shost: {
                type: 'varchar(120)'
            },
            sport: {
                type: 'int(10)',
                default: 22
            },
            suser: {
                type: 'varchar(120)'
            },
            spass: {
                type: 'varchar(120)'
            },
            stype: {
                type: 'tinyint(2)',
                default:1
            },
            // skey: {
            //     type: 'text'
            // },
            spath: {
                type: 'varchar(255)'
            },

        }
    }
    async list(page, limit) {
        let list = await this.page(page, limit).select();
        let count = await this.count();
        //console.log(list)
        if (think.isEmpty(list)) {
            let setConf = this.service.getConfig();
            let data = think.extend({},setConf);
            await this.add(data);
            let safeAdd = [];
            setConf.safeList.forEach(d => {
                safeAdd.push({
                    data_id: 1,
                    name : d
                })
            });
            await this.model('datasafe').addMany(safeAdd);
            list[0] = data;
            count = 1;
        }
        return { list, count };
    }
    async createData(name) {
        
        let data = await this.where({ isdef: 1 }).find(),
            id = data.id;
        data.database = name;
        delete data.id;
        let nid = await this.add(data);
        data.id = nid;
        this.service.setConfig(data);
        await this.where({ id }).update({ isdef: 0 });
    }
    async hasData(data) {
        let has = await this.where({ host: data.host, database: data.database, port: data.port }).find();
        if (think.isEmpty(has)) {
            return false;
        }
        return true;
    }
    async addData(data) {
        //console.log('add')
        //console.log(data)
        await this.where({isdef : 1}).update({ isdef: 0 });
        data.isdef = 1;
        delete data.id;
        let dataId = await this.add(data);
        data.id = dataId;
        data.safeList = [];
        this.service.setConfig(data);
    }
    async upData(data) {
        let has = await this.model('database').where({ id : data.id }).find();
        if (think.isEmpty(has)) return false;
        if (!data.ssh || data.ssh == 0) {
            data.sport = 0;
        }
        await this.where({ id: data.id }).update(data);
        if (has.isdef == 1) {
            data.isdef = 1;
            this.service.setConfig(data);
        }
    }
    async changeData(id) {
        let data = await this.where({ id }).find();
        if (think.isEmpty(data)) return false;
        await this.where({ isdef: 1 }).update({ isdef: 0 });
        await this.where({ id }).update({ isdef: 1 });
        data.safeList = await this.model('datasafe').where({ data_id: id }).getField('name');
        this.service.setConfig(data);
    }
    async del(id) {
        if (id == 1) return false;
        let data = await this.where({ id }).find();
        if (think.isEmpty(data)) return false;

        await this.where({ id }).delete();
        await this.model('datasafe').where({ data_id: id }).delete();
        if (data.isdef == 1) {
            let data = await this.where({ id: 1 }).find();
            data.safeList = await this.model('datasafe').where({ data_id: 1 }).getField('name');
            this.service.setConfig(data);
        }
        return true;
    }
    async getSafe() {
        let setConf = this.service.getConfig();
        //console.log(setConf)
        let list = await this.model('datasafe').where({ data_id: setConf.id }).select();

        return list;
    }
    async addSafe(names) {
        let arr = names.split(','),
            setConf = this.service.getConfig(),
            dataId = setConf.id,
            prefix = setConf.prefix,
            has = await this.model('datasafe').where({ data_id: dataId }).getField('name'),
            add = [];
        arr.forEach(d => {
            let n = d.replace(prefix, '');
            if (!has.includes(n)) {
                add.push({
                    data_id: dataId,
                    name : n
                })
            }
        })
        if (add.length > 0)
            await this.model('datasafe').addMany(add);
        //更新主缓存
        setConf.safeList = has.concat(add);
        this.service.setConfig(setConf);

    }
    async safeDel(id) {
        await this.model('datasafe').where({ id }).delete();
        //更新主缓存
        let setConf = this.service.getConfig();
        setConf.safeList = await this.model('datasafe').where({ data_id: setConf.id }).getField('name');
        this.service.setConfig(setConf);
    }

}