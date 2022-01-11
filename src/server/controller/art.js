/**
* @controller
* @apiDefine art 文章
*/
const Base = require('./base.js');
module.exports = class extends Base {
	/**
	* @name 文章列表
	*/
	async listAction(){
		let data = this.post()
		if (think.isEmpty(data)) {
		  console.log(data);
		  return this.fail("数据为空");
		}
		switch (this.post()) {
		  case this.get() :
		      let data = 'ddd'
		
		    break;
		}
			}
	/**
	* @name 文章分类列表
	*/
	async artcateAction(){
		let data
			}
};