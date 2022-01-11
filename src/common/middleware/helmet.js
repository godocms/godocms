const helmet = require('koa-helmet');
const defaultOptions = {
    enable: true
}
module.exports = (options = {}, app) => {
    // 合并传递进来的配置
    options = Object.assign({}, defaultOptions, options);
    return (ctx, next) => {
        if (options.enable) {
            //  apply to all requests
            //app.use(helmet());
            // if (ctx.request.url.indexOf('/p/') === -1) {
            //     app.use(helmet.contentSecurityPolicy());
            // }
            app.use(helmet.dnsPrefetchControl());
            app.use(helmet.expectCt());
            app.use(helmet.frameguard());
            app.use(helmet.hidePoweredBy());
            app.use(helmet.hsts());
            app.use(helmet.ieNoOpen());
            app.use(helmet.noSniff());
            app.use(helmet.permittedCrossDomainPolicies());
            app.use(helmet.referrerPolicy());
            app.use(helmet.xssFilter());
        }
        return next()
    }
}