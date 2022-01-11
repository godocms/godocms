const Base = require('./base.js');
/**
 * @class
 * @apiDefine auth 角色管理
 */
module.exports = class extends Base {
    /**
     * @api {get} auth/list 角色列表
     * @apiGroup auth
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {number} page 页码
     * @apiParam  {number} limit 每页显示数据
     *
     * @apiSuccess (200) {type} name description
     *
     */
    async listAction() {
        let { page, limit } = this.get();
        let list = await this.model('admin_auth')
            .page(page, limit)
            .select();
        let count = await think.model('admin_auth').count();
        await this.adminViewLog('角色列表');
        return this.success({ list, count })
    }
    /**
     * @api {post} auth/add 添加角色
     * @apiGroup auth
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {string} name 角色名
     * @apiParam  {number} status 是否可用0可用1不可用
     * @apiParam  {string} rules 菜单id集合，逗号隔开
     * @apiParam  {string} remark 备注
     * @apiSuccess (200) {type} name description
     *
     */
    async addAction() {
        let post = this.post();
        let rt = await this.model('admin_auth').add(post);
        await this.adminOpLog('添加角色');
        return this.success(rt);
    }
    /**
     * @api {post} auth/addTree 角色添加前
     * @apiGroup auth
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  null
     *
     * @apiSuccess (200) {type} name description
     *
     */
    async addTreeAction() {
        let menus = await this.model('menu').tree();
        await this.adminViewLog('添加角色');
        return this.success(menus);
    }
    /**
     * @api {post} auth/beforEdit 角色编辑前
     * @apiGroup auth
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {number} id
     *
     * @apiSuccess (200) {type} name description
     *
     */
    async beforEditAction() {
        let id = this.get('id');

        let data = await this.model('admin_auth').where({ id }).find()
        if (think.isEmpty(data)) return this.fail('the data none')
        //console.log(data.rules.split(','))
        data.menus = await this.model('menu').tree()
        await this.adminViewLog('编辑角色');
        return this.success(data)
    }
    /**
     * @api {post} auth/eidt 编辑角色
     * @apiGroup auth
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {string} name 角色名
     * @apiParam  {number} status 是否可用0可用1不可用
     * @apiParam  {string} rules 菜单id集合，逗号隔开
     * @apiParam  {string} remark 备注
     * @apiSuccess (200) {type} name description
     *
     */
    async editAction() {
        let post = this.post(),
            id = post.id;
        if (!await this.hasData('admin_auth', { id }))
            return this.fail("数据不存在");
        
        let rt = await this.model('admin_auth')
            .where({ id })
            .update(post);
        await this.adminOpLog('编辑角色');
        return this.success(rt)
    }
    /**
     * @api {post} auth/enable 设置角色是否可用
     * @apiGroup auth
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {number} status 状态
     * @apiParam  {number} id
     * 
     * @apiSuccess (200) {type} name description
     *
     */
    async enableAction() {
        let post = this.post(),
            id = post.id;
        
        if (!await this.hasData('admin_auth', { id }))
            return this.fail("数据不存在");
        
        let rt = await this.model('admin_auth')
            .where({ id })
            .update({
                status: post.status
            })
        await this.adminOpLog('设置角色可用');
        return this.success(rt)
    }
    /**
     * @api {post} auth/del 删除角色
     * @apiGroup auth
     *
     * @apiHeader {string} rttoken 必填
     *
     * @apiParam  {number} id
     *
     * @apiSuccess (200) {type} name description
     *
     */
    async delAction() {
        let post = this.post(),
            id = post.id;
        if (!await this.hasData('admin_auth', { id }))
            return this.fail("数据不存在");
        
        if (await this.hasData('admin_map', { auth_id:  id }))
            return this.fail("请先删除角色下的管理员");

        let rt = await this.model('admin_auth').where({ id }).delete();
        await this.adminOpLog('删除角色');
        return this.success(rt)
    }

}