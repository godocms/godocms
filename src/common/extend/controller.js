/**
 * 获取当前时间撮
 */
function now(t = '') {
    if (t == '') {
        return parseInt((new Date().getTime()) / 1000);
    } else {
        return parseInt((new Date(t).getTime()) / 1000);
    }
}



/**
 * 列表搜索
 * @param {string} param 
 * @param {object} where 
 * @param {boolean} isTime 
 * @returns 
 */
function parseSearch(param, where = {}, isTime = true) {
    param = decodeURI(param);
    let arr = param.split('&');
    arr.forEach(item => {
        let k = item.split('=');
        //console.log(k);
        if (k[0].includes('<') && k[0].includes('>') && k[1]) {
            k[0] = k[0].replace('<', '').replace('>', '');
            k[1] = ['like', '%' + k[1] + '%'];
        }
        if (k[1] && k[1].includes('+-+')) {
            let kk = k[1].split('+-+');
            //console.log(kk);
            if (k[0].includes('time')) {
                if (isTime) {
                    kk[0] = parseInt(new Date(kk[0]).getTime() / 1000 - 8 * 3600);
                    kk[1] = parseInt(new Date(kk[1]).getTime() / 1000 + 86400 - 1 - 8 * 3600);
                }
            }
            k[1] = ['between', [kk[0], kk[1]]];
        }
        if (k[1]) {
            where[k[0]] = k[1];
        }
    })
    return where;
}
async function err(name, msg) {
    let data = {
        name: name,
        url: this.ctx.path,
        msg: msg,
        addtime: think.now()
    };
    await think.model('error').add(data);
}
module.exports = {
    now,
    parseSearch,
    err
}