// default config
module.exports = {
    workers: 1,
    port: 8200, //启动端口
    statusTime: 12 * 60 * 60, //保活时间，默认12小时
    adminDir: 'server', //后端目录
    csrf: {
        headerName: 'csrf_token',
        enable: true
    },
    helmet: {
        enable: true
    },
    ratelimit: {
        enable: true,
        interval: 1 * 60 * 1000, // 1 minutes
        max: 1000,
        prefixKey: 'login/captcha'
    },
    cache: {
        type: 'redis', //or 'file'
        timeout: 24 * 3600 * 1000
    },
    cookie: {
        name: 'csrf_token',
        maxAge: 12 * 3600 * 1000
    },
    session: {
        type: 'redis', //or 'file'
        maxAge: 12 * 3600 * 1000
    },
    mysql: {
        database: 'gdcms',
        prefix: 'rt_',
        encoding: 'utf8',
        host: '127.0.0.1',
        port: '8889',
        user: 'root',
        password: 'root',
        dateStrings: true
    },
    redis: {
        host: '127.0.0.1',
        port: 6379,
        password: '',
        db: 1
    },
    errnoField: 'code', // errno field
    errmsgField: 'message', // errmsg field
    defaultErrno: 201, // default errno
    validateDefaultErrno: 202, // validate default errno
    stickyCluster: true,//websocket
};