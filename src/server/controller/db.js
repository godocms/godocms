const { fail } = require('./base.js');
const Base = require('./base.js');

/**
 * @class
 * @apiDefine db 数据库管理
 */
module.exports = class extends Base {
    /**
     * @api {get} db/list 数据列表
     * @apiHeader {string} rttoken 必填
     * @apiGroup db
     */
    async listAction() {
        let list = await this.model('db').list();
        return this.success({ list });
    }
    /**
     * @api {get} db/update 更新缓存
     * @apiHeader {string} rttoken 必填
     * @apiGroup db
     */
    async updateAction() {
        await this.model('db').createList();
        return this.success();
    }
    /**
     * @api {get} db/backup 备份数据
     * @apiHeader {string} rttoken 必填
     * @apiGroup db
     */
    async backupAction() {
        await this.model('db').backup();
        return this.success();
    }
    /**
     * @api {get} db/backupFile 列出备份数据文件
     * @apiHeader {string} rttoken 必填
     * @apiGroup db
     */
    async backupFileAction() {
        let list = await this.model('db').backupFile();
        return this.success(list)
    }
    /**
     * @api {get} db/reback 还原数据
     * @apiGroup db
     * @apiHeader {string} rttoken 必填
     */
    async rebackAction() {
        let file = this.post('file');
        await this.model('db').reback(file);
        return this.success()
    }
    /**
     * @api {get} db/delback 删除还原数据
     * @apiGroup db
     * @apiHeader {string} rttoken 必填
     */
    async delbackAction() {
        let file = this.post('file');
        await this.model('db').delBackupFile(file);
        return this.success()
    }
    /**
     * @api {get} db/doc 查看文档
     * @apiGroup db
     * @apiHeader {string} rttoken 必填
     */
    async docAction() {
        let data = await this.model('db').allList();
        //console.log(data)
        let rt = await this.service('md').db(data);
        return this.success(rt)
    }
    /**
     * @api {post} db/editTable 编辑表名/注释/autoId
     * @apiGroup db
     * @apiHeader {string} rttoken 必填
     */
    async editTableAction() {
        let data = this.post();
        //console.log(data)
        try {
            if (data.field == 'Auto_increment') {
                if (isNaN(data.value) || data.value < 1)
                    return this.fail('自增长id必须大于0')
                await this.model('db').editTableAutoId(data.table, data.value);
            }
            else if (data.field == 'Name') {
                await this.model('db').renameTable(data.old, data.value);
            }
            else if (data.field == 'Comment') {
                await this.model('db').editTableComment(data.table, data.value);
            }

            return this.success()
        } catch (error) {
            return this.fail(error.message)
        }

    }
    /**
     * @api {post} db/delTable 删除表
     * @apiGroup db
     * @apiHeader {string} rttoken 必填
     */
    async delTableAction() {
        let table = this.post('table');
        try {
            await this.model('db').drop(table);
            return this.success()
        } catch (e) {
            return this.fail(e.message)
        }
    }
    /**
     * @api {post} db/repair 修复表
     * @apiGroup db
     * @apiHeader {string} rttoken 必填
     */
    async repairAction() {
        let table = this.post('table');
        try {
            await this.model('db').repair(table);
            return this.success()
        } catch (e) {
            return this.fail(e.message)
        }
    }
    /**
     * @api {post} db/optimize 优化表
     * @apiGroup db
     * @apiHeader {string} rttoken 必填
     */
    async optimizeAction() {
        let table = this.post('table');
        try {
            await this.model('db').optimize(table);
            return this.success()
        } catch (e) {
            return this.fail(e.message)
        }
    }
    /**
     * 复制表
     * @returns 
     */
    async opcopyAction() {
        let table = this.post('table');
        try {
            await this.model('db').opcopy(table);
            return this.success()
        } catch (e) {
            return this.fail(e.message)
        }
    }
    /**
     * 获取sql结果
     * @returns 
     */
    async getSqlAction() {
        //console.log(this.get())
        let table = this.get('table');
        //console.log(table)
        try {
            let rt = await this.model('db').getSql(table);
            return this.success(rt)
        } catch (e) {
            return this.fail(e.message)
        }
    }
    /**
     * 执行sql
     * @returns 
     */
    async runSqlAction() {
        let code = this.post('code');
        try {
            let rt = await this.model('db').sql(code);
            return this.success(rt)
        } catch (e) {
            return this.fail(e.message)
        }
    }
    /**
     * @api {post} db/clear 清空表
     * @apiGroup db
     * @apiHeader {string} rttoken 必填
     */
    async clearAction() {
        let table = this.post('table');
        try {
            await this.model('db').clear(table);
            return this.success()
        } catch (e) {
            return this.fail(e.message)
        }
    }
    /**
     * 数据字段头部
     * @returns 
     */
    async fieldListAction() {
        let table = this.get('table');
        try {
            let list = await this.model('db').fieldList(table);
            let rt = [];
            list.forEach(d => {
                rt.push({
                    title: d.COLUMN_COMMENT ? d.COLUMN_COMMENT : d.COLUMN_NAME,
                    //title: d.COLUMN_NAME,
                    field: d.COLUMN_NAME,
                    align: 'center',
                    edit: 'text',
                    filter: true,
                    align: 'left',
                    sort: true
                })
            });
            return this.success([rt])
        } catch (e) {
            console.log(e)
            return this.fail(e.message)
        }
    }
    /**
     * 字段列表
     * @returns 
     */
    async fieldsAction() {
        let table = this.get('table');
        try {
            let data = await this.model('db').fieldList(table);
            let list = [];
            data.forEach(el => {
                list.push({
                    name: el.COLUMN_NAME,
                    comment: el.COLUMN_COMMENT,
                    type: el.COLUMN_TYPE,
                    isnull: el.IS_NULLABLE,
                    key: el.COLUMN_KEY,
                    extra: el.EXTRA,
                    default: el.COLUMN_DEFAULT,
                    order: el.ORDINAL_POSITION
                })
            });
            return this.success({ list, count: list.length })
        } catch (e) {
            return this.fail(e.message)
        }
    }
    /**
     * 数据列表
     * @returns 
     * @todo 添加查询
     */
    async listDataAction() {
        let { page, limit, param, table } = this.get();
        let wsql = {};
        if (param) wsql = this.parseSearch(param, wsql);
        //let db = this.model('db');
        //let tname = table.replace(think.config('mysql.prefix'), '');
        
        let listSql = await this.model('db')
            .table(table, true)
            .where(wsql)
            .page(page, limit)
            .buildSelectSql();
        let list = await this.model('db').sql(listSql);
        //console.log(list)
        //return;
        let countData = await this.model('db').sql(`select count(*) as num from ` + table);
        //console.log(countData)
        //await this.adminViewLog('管理员列表');
        return this.success({ list, count: countData[0].num })
    }
    /**
     * 编辑数据
     * @returns 
     */
    async editDataAction() {
        let post = this.post(),
            table = post.table;
        if (this.model('db').sysTable(table))
            return this.fail('系统表数据不允许编辑');
        try {
            let wh = await this.model('db').parseWhere(post);
            if (!wh) return this.fail('该表无主键');
            let sql = "update `" + post.table + "` set `"+post.field+"` = '"+post.value+"' where " + wh;
            await this.model('db').sql(sql);
            return this.success()
        } catch (e) {
            console.log(e)
            return this.fail(e.message)
        }

    }
    /**
     * 添加数据
     * @returns 
     */
    async addDataAction() {
        let post = this.post(),
            table = post._table;
        if (this.model('db').sysTable(table))
            return this.fail('保护表数据不允许编辑');
        try {
            delete post._table;
            let fields = [], vals = [];
            for (let p in post) {
                fields.push('`' + p + '`');
                vals.push("'" + post[p] + "'");
            }
            let sql = "INSERT INTO `" + table + "` (" + fields.join(',') + ") VALUES (" + vals.join(',') + ")";
            console.log(sql)
            await this.model('db').sql(sql);
            return this.success()
        } catch (e) {
            console.log(e)
            return this.fail(e.message)
        }
    }
    /**
     * 删除数据
     * @returns 
     */
    async delDataAction() {
        let post = this.post();
        //console.log(post)
        try {
            if (this.model('db').sysTable(post.table))
                return this.fail('保护数据不允许删除');
            let wh = await this.model('db').parseWhere(post);
            if (!wh) return this.fail('该表无主键');
            let sql = "delete from `" + post.table + "` where " + wh;
            await this.model('db').sql(sql);
            return this.success()
        } catch (e) {
            return this.fail(e.message)
        }
    }
    /**
     * 删除字段
     * @returns 
     */
    async delFieldAction() {
        //console.log(this.post())
        let { table, field } = this.post();
        try {
            await this.model('db').delField(table, field);
            return this.success()
        } catch (e) {
            return this.fail(e.message)
        }
    }
    /**
     * 字段排序
     * @returns 
     */
    async sortFieldAction() {
        let { table, row, t, sortField } = this.post();
        try {
            await this.model('db').sortField(table, JSON.parse(row), t, sortField);
            return this.success()
        } catch (e) {
            return this.fail(e.message)
        }
    }
    /**
     * 更改字段名字
     * @returns 
     */
    async changeFieldNameAction() {
        let { table, name, field, value } = this.post();
        let row = await this.model('db').fieldRow(table, name);
        try {
            if (field == 'name') {
                // if(await this.model('db').hasField(table, value)) {
                //     return this.fail('表中存在相同的字段')
                // }
                //rowdata.name = old;
                await this.model('db').changeFieldName(table, row, value);
            }
            else if (field == 'comment') {
                await this.model('db').changeFieldComment(table, row, value);
            }
            else if (field == 'default') {
                await this.model('db').changeFieldDefault(table, row, value);
            }
            else if (field == 'type') {
                await this.model('db').changeFieldType(table, row, value);
            }
            return this.success()
        } catch (e) {
            console.log(e.message)
            return this.fail(e.message)
        }
    }
    /**
     * 更改字段状态
     * @returns 
     */
    async setStatusAction() {
        let { table, name, status, type } = this.post();
        try {
            let row = await this.model('db').fieldRow(table, name);
            //console.log(row);
            //return;
            if (type == 'isnull') {
                if (status === 0 && (row.COLUMN_KEY === 'PRI' || row.EXTRA === 'auto_increment')) {
                    return this.fail('改字段不允许设置空')
                }
                await this.model('db').changeFieldNull(table, row, status);
            }
            else if (type == 'auto') {
                if (status === 0 && row.COLUMN_KEY !== 'PRI') {
                    return this.fail('只有主键才能设置自增长')
                }
                await this.model('db').changeFieldAuto(table, row, status);
            }
            return this.success()
        } catch (e) {
            console.log(e.message)
            return this.fail(e.message)
        }

    }
    /**
     * 添加字段
     * @returns 
     */
    async addFieldAction() {
        let post = this.post();
        let table = post.table;
        // console.log(post)
        // return;
        try {
            if (await this.model('db').hasField(table, post.name)) {
                return this.fail('表中存在相同的字段')
            }
            await this.model('db').addField(table, post);
            return this.success()
        } catch (e) {
            console.log(e.message)
            return this.fail(e.message)
        }
    }
    /**
     * 主键列表
     * @returns 
     */
    async keysListAction() {
        let table = this.get('table');
        let list = await this.model('db').keysList(table);
        return this.success({ list })
    }
    /**
     * 删除主键
     * @returns 
     */
    async delKeyAction() {
        let { table, name } = this.post();
        try {
            await this.model('db').delKey(table, name);
            return this.success()
        } catch (e) {
            console.log(e)
            return this.fail(e.message)
        }
    }
    /**
     * 设置主键
     * @returns 
     */
    async setKeyAction() {
        let {table, names, type} = this.post()
        try {
            await this.model('db').setKey(table, names, type);
            return this.success()
        } catch (e) {
            console.log(e)
            return this.fail(e.message)
        }
    }
    /**
     * 创建表
     * @returns 
     */
    async createTableAction() {
        let data = this.post();
        try {
            await this.model('db').createTable(data);
            return this.success();
        } catch (e) {
            console.log(e)
            return this.fail(e.message)
        }
    }
    /**
     * 批量删除表
     * @returns 
     */
    async batchRemoveAction() {
        let ids = this.post('ids');
        //console.log(ids)
        try {
            let arr = ids.split(',');
            if (arr.length > 0) {
                arr.forEach(async (e) => {
                    await this.model('db').drop(e);
                })
            }
            return this.success()
        } catch (e) {
            return this.fail(e.message)
        }
        
    }
    /**
     * 数据库列表
     * @returns object
     */
    async confListAction() {
        let { page, limit } = this.get();
        let { list, count } = await this.model('database').list(page, limit);
        console.log(list)
        return this.success({ list, count });
    }
    /**
     * 添加数据库
     */
    async confAddAction() {
        let data = this.post();
        //console.log(data)
        if (await this.model('database').hasData(data))
            return this.fail('数据库中存在相同的配置')
        try {
            let can = await this.model('db').testConf(data);
            if (can) {
                await this.model('database').addData(data);
                process.send('think-cluster-reload-workers');
                return this.success()
            } else {
                return this.fail('连接不成功！')
            }
            
        } catch (e) {
            return this.fail(e.message)
        }
    }
    /**
     * 编辑数据库
     */
    async confEditAction() {
        let data = this.post();
        try {
            let can = await this.model('db').testConf(data);
            if (can) {
                let rt = await this.model('database').upData(data);
                if (!rt) this.fail('数据不存在');
                process.send('think-cluster-reload-workers');
                return this.success()
            } else {
                return this.fail('连接不成功！')
            }
        } catch (e) {
            return this.fail(e.message)
        }
        
    }
    async confEditBeforeAction() {
        let id = this.get('id');
        let data = await this.model('database').where({ id }).find();
        //console.log(data)
        return this.success(data);
    }
    /**
     * 测试数据库连接
     */
    async confTestAction() {
        let post = this.post();
        console.log(post)
        let rt = await this.model('db').testConf(post);
        if (rt) {
            //process.send('think-cluster-reload-workers');
            return this.success()
        } else {
            return this.fail()
        }
    }
    /**
     * 删除数据库配置
     */
    async confDelAction() {
        let id = this.post('id');
        if (id < 2) return this.fail('系统数据库不允许删除');
        try {
            let rt = await this.model('database').del(id);
            if (!rt) return this.fail('数据库不存在');
            process.send('think-cluster-reload-workers');
            return this.success();
        } catch (e) {
            return this.fail(e.message)
        }
    }
    /**
     * 更换数据库
     */
    async confChangeAction() {
        let id = this.post('id');
        try {
            await this.model('database').changeData(id);
            process.send('think-cluster-reload-workers');
            return this.success()
        } catch (e) {
            return this.fail(e.message)
        }
    }
    /**
     * 保护列表
     */
    async safeListAction() {
        let list = await this.model('database').getSafe();
        return this.success({ list });
    }
    /**
     * 添加保护
     */
    async safeAddAction() {
        let data = this.post();
        try {
            await this.model('database').addSafe(data.names);
            return this.success()
        } catch (e) {
            return this.fail(e.message)
        }
    }
    /**
     * 删除保护
     */
    async safeDelAction() {
        let data = this.post();
        try {
            await this.model('database').safeDel(data.id);
            return this.success()
        } catch (e) {
            return this.fail(e.message)
        }
    }
    async creatDatabaseAction() {
        let name = this.post('name');
        try {
            await this.model('db').createDatabase(name);
            process.send('think-cluster-reload-workers');
            return this.success();
        } catch (e) {
            console.log(e.message)
            return this.fail(e.message);
        }
    }
    
}