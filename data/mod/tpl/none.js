let controllerTpl = `const Base = require('./base.js');
/**
 * @controller
 * @apiDefine {{key}} {{name}}
 */
module.exports = class extends Base {
    
};`;
let logicTpl = `/**
 * @logic
 * @apiDefine {{key}} {{name}}
 */
module.exports = class extends think.Logic {
    
};`;
let modelTpl = `/**
 * @model
 * @apiDefine {{key}} {{name}}
 */
module.exports = class extends think.Model {
    
};`;
let serviceTpl = `/**
 * @service
 * @apiDefine {{key}} {{name}}
 */
module.exports = class extends think.Service {
    
};`;
module.exports = {
    controllerTpl,
    logicTpl,
    modelTpl,
    serviceTpl
}