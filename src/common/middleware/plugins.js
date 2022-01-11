const serve = require('koa-static-router');
const path = require('path');

const getFilePath = (pathName) => {
    //console.log(pathName)
    //console.log(pluginConfig)
    //后期包多的时候要做整包处理
    const commonConfig = require(think.ROOT_PATH + '/data/plugin.json');
    let data;
    if (commonConfig[pathName]) {
        data = commonConfig[pathName];
    } else {
        //分包处理易维护开发 添加完后要重启服务才能生效
        let pluginsConfigFile = think.ROOT_PATH + '/data/plugins/' + pathName + '.json';
        //console.log(pluginsConfigFile)
        if (!think.isFile(pluginsConfigFile)) return false;
        data = require(pluginsConfigFile);
    }
    //if (!pluginConfig[pathName]) return false;
    //let data = pluginConfig[pathName];
    if (data.isTest) {
        data.filePath = think.ROOT_PATH + '/plugins/' + data.path + '/src/';
        data.route = {
            dir: 'plugins/' + data.path + '/public/',
            router: '/p/' + pathName + '/'
        };
    } else {
        try {
            let modData = require(data.key + "/info.js");
            //console.log(modData);
            data.filePath = modData.dir + '/src/';
            data.path = modData.dir.replace(think.ROOT_PATH + '/node_modules/', '');
            data.route = {
                dir: 'node_modules/' + data.path + '/public/',
                router: '/p/' + pathName + '/'
            };
        } catch (error) {
            console.log(error.message)
            return false;
        }
        
    }
    //console.log(data)
    return data;
}
const checkExt = (url) => {
    let arr = url.split('.');
    if (!arr || arr.length < 1) return false;
    let str = arr.pop()
    if (str.indexOf('?') !== -1) {
        str = str.split('?')[0];
    }
    let exts = ['css', 'js', 'html', 'png', 'jpg', 'gif', 'wav', 'eot','svg','ttf','woff','woff2','md','mp3','mp4','json','ico'];
    if (exts.includes(str)) {
        return true;
    }
    return false;
}
module.exports = (options = {}, app) => {
    return (ctx, next) => {
        //console.log(ctx.controller)
        //return;
        //console.log(ctx.request.url)
        if (!options.enable || ctx.request.url.indexOf('/p/') === -1) {
            return next();
        }
        let urls = ctx.request.url.split('/');
        //console.log(urls)
        if (urls.length < 3 && urls[1] !== 'p') { 
            return next();
        }
        let pathName = urls[2],
            fileData = getFilePath(pathName);
        //console.log(fileData)
        if (fileData === false) {
            return next();
        }
        let filePath = fileData.filePath;
        // console.log(filePath)
        // console.log('plugins/' + fileData.path + '/public/')
        // console.log('/p/' + pathName + '/')
        //处理静态路由
        app.use(serve(fileData.route));
        //如果是静态文件则跳出
        if (checkExt(ctx.request.url)) {
            return next();
        }

        ctx.pluginName = pathName;

        let controllerName = urls[3] || 'index',
            actionName = urls[4] || 'index';
        
        //多层级
        if (think.isDirectory(filePath + controllerName + '/')) {
            filePath = filePath + urls[3] + '/';
            controllerName = urls[4] || 'index';
            actionName = urls[5] || 'index';
            ctx.module = urls[3];
        }
        //后缀
        if (actionName.indexOf('?') !== -1) {
            actionName = actionName.split('?')[0]
        }
        
        //处理逻辑层
        let logicFile = filePath + 'logic/' + controllerName + '.js';
        if (think.isFile(logicFile)) {
            let Logic = require(logicFile);
            const logicInstance = new Logic(ctx);
            let logicMethod = actionName + 'Action';
            if (!logicInstance[logicMethod]) {
                logicMethod = '__call';
            }
            let allowMethods = logicInstance.allowMethods;
            if (!think.isEmpty(allowMethods)) {
                if (think.isString(allowMethods)) {
                    allowMethods = allowMethods.split(',').map(e => {
                        return e.trim().toUpperCase();
                    });
                }
                if (allowMethods.indexOf(ctx.method) === -1) {
                    return ctx.fail(ctx.config('validateDefaultErrno'), 'METHOD_NOT_ALLOWED');
                }
            }
            const rules = think.extend({}, logicInstance.scope, logicInstance.rules);
            if (!think.isEmpty(rules) && !logicInstance.validate(rules)) {
                return ctx.fail(ctx.config('validateDefaultErrno'), instance.validateErrors);
            }

        }
        //处理控制层
        let controllerFile = filePath + 'controller/' + controllerName + '.js';
        if (!think.isFile(controllerFile)) {
            return next();
        }
        //处理权限
        think.adminBase = require(path.join(think.ROOT_PATH, 'src/server/controller/base.js'));
        ctx.controller = controllerName;

        let Controller = require(controllerFile);
        const controllerInstance = new Controller(ctx);
        let controllerPromise = Promise.resolve();
        
        ctx.action = actionName;
        if (controllerInstance.__before) {
            controllerPromise = Promise.resolve(controllerInstance.__before());
        }
        return controllerPromise.then(data => {
            if (data === false) return false;
            let controllerMethod = actionName + 'Action';
            if (!controllerInstance[controllerMethod]) {
                controllerMethod = '__call';
            }

            if (controllerInstance[controllerMethod]) {
                // pre set request status
                if (ctx.body === undefined) {
                    ctx.status = 200;
                }
                return controllerInstance[controllerMethod]();
            }
        }).then(data => {
            if (data === false) return false;
            if (controllerInstance.__after) return instance.__after();
        }).then(data => {
            if (data !== false) return next();
        });

        //return next()
    }
}