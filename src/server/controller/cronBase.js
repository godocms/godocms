const parser = require('cron-parser');
module.exports = class extends think.Controller {
    constructor(ctx) {
        super(ctx);
        this.starttime = new Date().getTime();
        this.crondata = {};
    }
    async __before() {
        //if(!this.isCli) return this.fail(1000, 'deny')

        let url = `${this.ctx.module}/${this.ctx.controller}/${this.ctx.action}`;
        //console.log(url);
        this.crondata = await think.model('crons').where({ handle: url }).find()
        if (!think.isEmpty(this.crondata)) {
            let nexttime = this.crondata.nexttime;
            if (nexttime && nexttime > 0) {
                let runtime = this.crondata.runtime;
                //保证只执行一次
                if (this.starttime + runtime < nexttime) {
                    return this.fail(10006, 'the next time is ' + think.datetime(nexttime));
                }
                //保证任务不锁定
                if (this.starttime < runtime + this.crondata.uptime) {
                    await this.err(this.crondata.name + '计划任务执行超时', '需重新设置');
                    //return false;
                }
            }
        }


    }
    async __after() {
        let data = this.crondata;
        if (think.isEmpty(data)) return;
        //indexAction 执行完成后执行，如果 indexAction 返回了 false 则不再执行
        let endtime = new Date().getTime();
        let runtime = endtime - this.starttime;
        //console.log(runtime);
        let up = {
            uptime: endtime,
            runtime
        };
        if (data.runtype < 1) {
            up.nexttime = endtime + think.ms(data.interval);
        } else {
            
            let interval = parser.parseExpression(data.cron);
            let next = interval.next();
            up.nexttime = next.getTime();
        }
        await think.model('crons').where({ id: data.id }).update(up);
    }
    fixNumber(num, decimal, fix = 2) {
        return Number(num / Math.pow(10, decimal)).toFixed(fix) * 1
    }

    /**
     * 如果相应的Action不存在则调用该方法
     */
    __call() {
        return this.fail(10006, 'err action')
    }
};
