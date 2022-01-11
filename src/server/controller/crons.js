const Base = require('./base.js');
const parser = require('cron-parser');
const path = require('path');
const fs = require('fs');
const ThinkSession = require('think-session');
/**
 * @class
 * @apiDefine crons 计划任务管理
 */
module.exports = class extends Base {

    async listAction() {
        let { page, limit, param } = this.get();
        let wsql = {};
        if (param) wsql = this.parseSearch(param, wsql);
        let list = await this.model('crons').where(wsql).page(page, limit).select();
        let count = await this.model('crons').where(wsql).count();
        const datetime = (date = new Date()) => {
            let format = 'MM-DD HH:mm:ss:zz';
            const fn = d => {
                return ('0' + d).slice(-2);
            };

            const d = new Date(date);
            const formats = {
                YYYY: d.getFullYear(),
                MM: fn(d.getMonth() + 1),
                DD: fn(d.getDate()),
                HH: fn(d.getHours()),
                mm: fn(d.getMinutes()),
                ss: fn(d.getSeconds()),
                zz: d.getMilliseconds()
            };
            return format.replace(/([a-z])\1+/ig, a => {
                return formats[a] || a;
            });
        }
        list.forEach(item => {
            if (item.uptime) item.uptime = datetime(item.uptime);
            if (item.nexttime) item.nexttime = datetime(item.nexttime);
        })
        await this.adminViewLog('查看计划任务列表');
        return this.success({ list, count })
    }
    parseUpData(data) {
        let updata = {
            name: data.name,
            handle: data.handle,
            cron: data.cron,
            interval: data.interval,
            intertype: data.intertype,
            enable: data.enable,
            immediate: data.immediate,
            type: data.type,
            runtype: data.runtype,
            cron: data.cron,
            remark: data.remark
        };
        if (data.runtype < 1 && data.interval) {
            updata.nexttime = (new Date().getTime()) + think.ms(data.interval + data.intertype);
        } else {
            updata.nexttime = parser.parseExpression(data.cron).next().getTime();
        }
        return updata;
    }
    //判断执行路径
    parseHandler(handler) {
        let arr = handler.split('/'),
            cronPath = '',
            basePath = path.join(think.ROOT_PATH, 'src/');
        //console.log(arr)
        if (arr.length == 1) {
            cronPath = 'server/' + arr[0] + '/index';
            //console.log(basePath + 'server/controller/' + arr[0] + '.js');
            if (think.isFile(basePath + 'server/controller/' + arr[0] + '.js')) {
                return cronPath;
            }
        }
        else if (arr.length == 2) {
            cronPath = 'server/' + arr[0] + '/' + arr[1];
            if (think.isFile(basePath + 'server/controller/' + arr[0] + '.js')) {
                return cronPath;
            } else {
                cronPath = arr[0] + '/' + arr[1] + '/index';
                if (think.isFile(basePath + arr[0] + '/controller/' + arr[1] + '.js')) { 
                    return cronPath;
                } else {
                    return false;
                }
            }
        }
        else if (arr.length == 3) {
            cronPath = arr[0] + '/' + arr[1] + '/' + arr[2];
            if (think.isFile(basePath + arr[0] + '/controller/' + arr[1] + '.js')) {
                return cronPath;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
    async addAction() {
        let data = this.parseUpData(this.post());
        data.addtime = this.now();
        data.handle = this.parseHandler(data.handle);
        if (!data.handle) return this.fail('执行路径不存在');
        let hasHandle = await this.model('crons').where({ handle: data.handle }).find()
        if (!think.isEmpty(hasHandle)) return this.fail('系统中存在相同的计划任务')
        //console.log(data)
        let id = await this.model('crons').add(data);
        await this.cronsWrite();
        await this.adminOpLog('添加计划任务');
        return this.success(id);
    }

    async editAction() {
        let post = this.post(),
            id = post.id;
        let has = await this.model('crons').where({ id }).find();
        if (think.isEmpty(has)) return this.fail('编辑的数据不存在');
        let data = this.parseUpData(post);
        data.uptime = new Date().getTime();
        data.handle = this.parseHandler(data.handle);
        if (!data.handle) return this.fail('执行路径不存在');
        //执行路径变更了
        if (has.handle != data.handle) {
            let hasHandle = await this.model('crons').where({ handle: data.handle }).find()
            if (!think.isEmpty(hasHandle)) return this.fail('系统中存在相同的计划任务')
        }
        await this.model('crons').where({ id }).update(data);
        await this.cronsWrite();
        await this.adminOpLog('编辑计划任务');
        return this.success()
    }
    async enableAction() {
        //console.log(this.post())
        let data = this.post(),
            id = data.id * 1;
        let updata = {
            enable: data.val == 'true' ? 1 : 0
        };
        await think.model('crons').where({ id }).update(updata);
        await this.cronsWrite();
        await this.adminOpLog('开启关闭计划任务');
        return this.success();

    }
    async editBeforeAction() {
        let id = this.get('id');
        let data = await this.model('crons').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('数据为空')
        return this.success(data);
    }

    async delAction() {
        let id = this.post('id');
        if (!await this.hasData('crons', { id }))
            return this.fail('数据不存在')
        await this.model('crons').where({ id }).delete();
        await this.cronsWrite();
        return this.success()
    }
    async cronsWrite() {
        //return true;
        let path = think.ROOT_PATH + '/src/common/config/crontab.js';
        //console.log(path);
        let data = await think.model('crons').where({ enable: 1 }).select();
        //console.log(data);
        let rt = [];
        data.forEach(item => {
            if (item.runtype < 1) {
                rt.push({
                    interval: item.interval.toString() + item.intertype,
                    handle: item.handle,
                    type: item.type,
                    immediate: item.immediate > 0 ? true : false
                });
            } else {
                rt.push({
                    cron: item.cron,
                    handle: item.handle,
                    type: item.type,
                    immediate: item.immediate > 0 ? true : false
                });
            }
        })
        //console.log(rt)
        fs.writeFileSync(path, 'module.exports = ' + JSON.stringify(rt));

    }
}