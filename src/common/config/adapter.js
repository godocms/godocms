const fileCache = require('think-cache-file');
//const nunjucks = require('think-view-nunjucks');
const fileSession = require('think-session-file');
const mysql = require('think-model-mysql');
const { Console, File, DateFile } = require('think-logger3');
const path = require('path');
const isDev = think.env === 'development';
const redisSession = require('think-session-redis');
const redisCache = require('think-cache-redis');
//const sqlite = require('think-model-sqlite');
const socketio = require('think-websocket-socket.io');
const socketRedis = require('socket.io-redis');
const conf = require('./config.js');
/**
 * cache adapter config
 * @type {Object}
 */

exports.cache = {
  type: conf.cache.type,
  common: {
    timeout: conf.cache.timeout // millisecond
  },
  redis: {
    handle: redisCache,
    port: conf.redis.port,
    host: conf.redis.host,
    password: conf.redis.password
  },
  file: {
    handle: fileCache,
    cachePath: path.join(think.ROOT_PATH, 'runtime/cache'), // absoulte path is necessarily required
    pathDepth: 1,
    gcInterval: 24 * 60 * 60 * 1000 // gc interval
  }
};
/**
 * model adapter config
 * @type {Object}
 */
exports.model = {
  type: 'mysql',
  common: {
    logConnect: isDev,
    logSql: isDev,
    logger: msg => think.logger.info(msg)
  },
  mysql: {
    handle: mysql,
    database: conf.mysql.database,
    prefix: conf.mysql.prefix,
    encoding: conf.mysql.encoding,
    host: conf.mysql.host,
    port: conf.mysql.port,
    user: conf.mysql.user,
    password: conf.mysql.password,
    dateStrings: conf.mysql.dateStrings
  },
  // sqlite: {
  //   handle: sqlite, // Adapter handle
  //   path: path.join(think.ROOT_PATH, 'data/db/sqlite'), // sqlite 保存的目录
  //   database: 'godocms', // 数据库名
  //   connectionLimit: 1, // 连接池的连接个数，默认为 1
  //   prefix: 'rt_', // 数据表前缀，如果一个数据库里有多个项目，那项目之间的数据表可以通过前缀来区分
  // }
};
/**
 * session adapter config
 * @type {Object}
 */

exports.session = {
  type: conf.session.type,
  common: {
    cookie: {
      name: conf.cookie.name,
      maxAge: conf.session.maxAge,
      //expires: '',
      path: '/',  //a string indicating the path of the cookie
      //domain: '',
      //secure: false,
      //keys: [],
      httpOnly: true,
      sameSite: false,
      signed: false,
      overwrite: false
    }
  },
  redis: {
    handle: redisSession,
    maxAge: conf.session.maxAge, //session timeout, if not set, session will be persistent.
    autoUpdate: true, //update expired time when get session, default is false
  },
  file: {
    handle: fileSession,
    sessionPath: path.join(think.ROOT_PATH, 'runtime/session')
  }
}

/**
 * logger adapter config
 * @type {Object}
 */
exports.logger = {
  type: isDev ? 'console' : 'dateFile',
  console: {
    handle: Console
  },
  file: {
    handle: File,
    backups: 10, // max chunk number
    absolute: true,
    maxLogSize: 50 * 1024, // 50M
    filename: path.join(think.ROOT_PATH, 'logs/app.log')
  },
  dateFile: {
    handle: DateFile,
    level: 'ALL',
    absolute: true,
    pattern: '-yyyy-MM-dd',
    alwaysIncludePattern: true,
    filename: path.join(think.ROOT_PATH, 'logs/app.log')
  }
};

exports.websocket = {
  type: 'socketio',
  common: {
    // common config
    pingInterval: 5000,
    pingTimeout: 2000
  },
  socketio: {
    handle: socketio,
    allowOrigin: null, // any origin is allowed by default
    path: '/socket.io', // `/socket.io` by default.
    //adapter: null,
    adapter: socketRedis({ host: 'localhost', port: 6379 }),
    messages: [{
      open: '/server/chat/open', // websocket action when connected
      close: '/server/chat/close', // websocket action when close
      online : '/server/chat/online',
      addUser: '/server/chat/addUser', //websocket addUser action when event is addUser
    }]
  }
}
