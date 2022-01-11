const Base = require('./base.js');
/**
* @class apitest
*/
module.exports = class extends Base{
  // 列表函数
  async listAction(){
    let {page,limit,param} = this.get();
    let wsql = {}
    if (param) {
      wsql = this.parseSearch(param,wsql)
    }
    let list = await this.model('api_test').where(wsql).page(page,limit).order('id desc').select()

    let count = await this.model('api_test').where(wsql).count()

    return this.success({list,count});

  }
  async addBeforeAction(){
  }
  // 添加函数
  async addAction(){
    let post = this.post()
    let has = await this.model('api_test').where({id : post.id}).find()

    if (think.isEmpty(has)) {
      return this.fail('数据为空');
    }
    await this.model('api_test').add(post)
    return this.success();

  }
  async editAction(){
  }
  async editBeforeAction(){
  }

}