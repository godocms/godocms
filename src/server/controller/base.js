const jwt = require('jsonwebtoken');
/**
 * @class 基础类
 */
module.exports = class extends think.Controller {
  constructor(ctx) {
    super(ctx);
    this.adminId = 0;
  }
  async __before() {
    //token校验
    if (!await this.checkToken()) return false;
    //权限验证
    if (!await this.checkAuth()) return false;
    //判断保活
    if (!await this.checkStatusTime()) return false;
  }
  /**
   * 权限校验
   * @returns boolean 
   */
  async checkAuth() {
    let url = `${this.ctx.controller}/${this.ctx.action}`;
    //console.log(url)
    if (this.ctx.module) {
      url = this.ctx.module + '/' + url;
    }
    if (this.ctx.pluginName) {
      url = this.ctx.pluginName + '/' + url;
    }
    //console.log(url)
    let perms = await this.cache('perms_' + this.adminId);
    if (!perms.includes(url)) {
      this.status = 400;
      this.ctx.body = {
        code: 400,
        message: 'auth error!'
      };
      return false;
    }
    return true;
  }
  /**
   * token校验
   * @returns boolean
   */
  async checkToken() {
    let headers = this.ctx.headers;
    //console.log(headers)
    if (!headers.rttoken || headers.rttoken == 'undefined') {
      this.status = 401;
      this.ctx.body = {
        code: 401,
        message: 'token none!'
      };
      return false;
    }
    //token验证
    let jwtChk = await this.chkJwt(headers.rttoken);
    if (jwtChk.code != 0) {
      this.status = 402;
      this.ctx.body = jwtChk;
      return false;
    }

    return true;
  }
  /**
   * 判断保活
   * @returns boolean
   */
  async checkStatusTime() {
    let preTime = await this.session('statusTime'),
      configTime = this.config('statusTime') || 60 * 60;
    //过期
    if (!preTime || this.now() - preTime > configTime) {
      await this.session('statusTime', null);
      this.status = 406;
      this.ctx.body = {
        code: 406,
        message: '超过保活时间!'
      };
      return false;
    } else {
      //没过期则加时间
      await this.session('statusTime', this.now() + configTime)
      return true;
    }
  }
  /**
   * 校验jwt
   * @param {*} token 
   * @returns object
   */
  async chkJwt(token) {
    let salt = await this.session('salt'),
      adminId = await this.session('adminId');
    if (!salt || !adminId) {
      return {
        code: 4021,
        message: 'session 不存在'
      };
    }
    //只允许一个帐号在一个端下登录
    let chkSalt = await this.cache('admin_' + adminId);
    if (!chkSalt || salt != chkSalt) {
      await this.clearSatus(adminId);
      return {
        code: 4022,
        message: '有其他用户登录该账户'
      };
    }
    //校验
    try {
      let rt = await jwt.verify(token, salt);
      //过期
      if (rt.adminId != adminId) {
        await this.clearSatus(adminId);
        await this.cache('admin_' + adminId, null);
        return {
          code: 4023,
          message: '认证过期'
        };
      }
      this.adminId = adminId;
      return {
        code: 0
      };
    } catch (e) {
      return {
        code: 4024,
        message: e.message
      };
    }

  }
  /**
   * 清除状态
   * @param {number} adminId 
   */
  async clearSatus(adminId) {
    await this.session(null);
    //await this.cache('admin_' + adminId, null);

  }
  /**
   * 记录操作日志
   * @param {string} msg 
   * @param {array} out 
   */
  async adminOpLog(msg, out = []) {
    try {
      let postData = this.post();
      //删除敏感字段
      if (out.length > 0) {
        out.forEach(e => {
          delete postData[e];
        })
      }
      let saveData = {
        admin_id: this.adminId,
        log: msg,
        data: JSON.stringify(postData),
        ip: this.ctx.ip,
        agent: this.ctx.userAgent,
        url: this.ctx.path,
        method: this.ctx.method,
        addtime: this.now()
      };
      await think.model('admin_oplog').add(saveData);
    } catch (error) {
      console.log(error)
    }

  }
  /**
   * 记录查看日志
   * @param {sting} msg 
   */
  async adminViewLog(msg) {
    try {
      let url = this.ctx.path,
        ip = this.ctx.ip;
      let has = await this.model('admin_viewlog').where({
        admin_id: this.adminId
      }).order("addtime desc").find();
      let saveData = {
        admin_id: this.adminId,
        log: msg,
        ip: ip,
        agent: this.ctx.userAgent,
        url,
        method: this.ctx.method,
        addtime: this.now()
      };
      //如果之前没有访问
      if (think.isEmpty(has)) {
        await think.model('admin_viewlog').add(saveData);
      } else {
        //过滤掉刷新
        if (has.url != url || has.log != msg) {
          //先添加新访问的页面
          await think.model('admin_viewlog').add(saveData);
          //更新离开时间
          await think.model('admin_viewlog')
            .where({ id: has.id })
            .update({
              leavetime: this.now()
            })
        }
      }

    } catch (error) {
      console.log(error)
    }
  }
  /**
   * 判断是否有数据
   * @param {string} tableName 
   * @param {object} sql 
   * @returns 
   */

  async hasData(tableName, sql) {
    let has = await this.model(tableName).where(sql).find();
    //console.log(has)
    if (!think.isEmpty(has)) {
      return true;
    }
    return false;
  }
  __after() {

  }
};
