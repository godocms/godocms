module.exports = class extends think.Service {
    //创建密码
    createPassword(password, salt = '') {
        if(!salt) salt = this.randomString()
        return think.md5(think.md5(password) + salt);
    }
    //校验密码
    checkPassword(ckpwd, password, salt) {
        let xpassword = this.createPassword(ckpwd, salt);
        if (xpassword == password) {
            return true;
        }
        return false;
    }
    //生成一个随机字符串
    randomString(len = 16) {
        let $chars = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678',
            maxPos = $chars.length,
            pwd = '',
            i = 0;
        for (; i < len; i++) {
            pwd += $chars.charAt(Math.floor(Math.random() * maxPos));
        }
        return pwd;
    }
}