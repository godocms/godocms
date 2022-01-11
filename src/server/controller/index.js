const Base = require('./base.js');

module.exports = class extends Base {
  indexAction() {
    return 'Hi,godo!';
  }
  isLoginAction() {
    return this.success('ok')
  }
};
