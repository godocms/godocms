const fs = require('fs');
const path = require('path');
const confpath = path.join(think.ROOT_PATH, 'data/db/config.js');
//const setConf = require(confpath);
const sysSafe = ['admin', 'admin_auth', 'admin_map', 'admin_oplog', 'admin_viewlog', 'error', 'menu', 'set', 'form', 'crons'];
module.exports = class extends think.Service {
    getConfig() {
        if (think.isFile(confpath)) {
            let conf = require(confpath);
            return conf;
        } else {
            let data = think.config('mysql');
            data.safeList = sysSafe;
            data.isdef = 1;
            data.id = 1;
            data.dateStrings = 0;
            fs.writeFileSync(confpath, `module.exports = ` + JSON.stringify(data));
            return data;
        }
    }
    setConfig(data) {
        fs.writeFileSync(confpath, `module.exports = ` + JSON.stringify(data));
    }
}