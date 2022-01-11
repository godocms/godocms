const defaultOptions = {
    enable: false, // 是否打印执行时间的配置
    headerName: 'godocms'
}
const conf = require('../config/config.js')
module.exports = (options = {}) => {
    // 合并传递进来的配置
    options = Object.assign({}, defaultOptions, options);
    return (ctx, next) => {
        if (options.enable) {
            //return next(); // 如果不需要打印执行时间，直接调用后续执行逻辑
            //console.log(ctx.request)
            if (ctx.request.method &&
                ctx.request.method == 'POST' &&
                ctx.request.header) {
                //console.log(ctx.request)
                let ck = ctx.request.header.cookie;
                if (ck && ck == conf.cookie.name + '=' + ctx.cookie(conf.cookie.name)) {
                    return next()
                } else {
                    console.log('err')
                    return false;
                }
            }
        }
        return next()
    }
}