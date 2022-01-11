const RateLimit = require('koa2-ratelimit').RateLimit;
const Stores = require('koa2-ratelimit').Stores;
const defaultOptions = {
    enable: true,
    interval: 1 * 60 * 1000, // 15 minutes
    max: 120,
}
const conf = require('../config/config.js')
module.exports = (options = {}, app) => {
    // 合并传递进来的配置
    options = Object.assign({}, defaultOptions, conf.ratelimit);
    return (ctx, next) => {
        if (options.enable) {
            const limiter = RateLimit.middleware(options);
            //  apply to all requests
            app.use(limiter);
        }
        return next()
    }
}