const jwt = require('jsonwebtoken');
/**
* @controller
* @apiDefine chat 聊天
*/
module.exports = class extends think.Controller {
    constructor(ctx) {
        super(ctx);
    }
    async __before() {
        this.io = this.ctx.req.io;
        this.socket = this.ctx.req.websocket;
    }
    async openAction() {
        //console.log(this.get())
        console.log('open', this.wsData)
        //console.log(this.wsData)
        //console.log(this.socket.id)
        //let salt = await this.getSession('salt');
        //console.log(salt)
        //this.socket.emit('open', { data: { pingInterval: 500, pingTimeout: 800 } })
    }
    async onlineAction() {
        console.log('online')
        let userId = await this.chkToken(this.wsData.rttoken);
        this.socket.emit('online', userId)
    }
    async addUserAction() {
        //console.log(this.wsData)
        console.log(this.socket.id)
        this.socket.emit('addUser', 'addUser success')
    }
    async messageAction() {
        this.io.emit('message', {
            nickname: this.wsData.nickname,
            type: 'message',
            message: this.wsData.message,
            id: this.socket.id
        })

    }
    async closeAction() {
        console.log('close')
        //this.socket.emit('open', 'websocket close')
        //this.socket.emit('close', 'websocket close')
        //console.log(this.socket)
        //this.io.disconnect(true);
    }
    
    // emit(action, data) {
    //     if (action === 'message') {
    //       this.io.emit(action, data)
    //     } else {
    //       this.socket.broadcast.emit(action, data);
    //     }
    // }
    async chkToken(token) {
        //console.log(token)
        let userId = await this.cache('token_' + think.md5(token));
        //let userId = await this.getSession('adminId');
        console.log(userId)
        if (!userId) return false;
        //console.log(userId)
        let salt = await this.cache('admin_' + userId);
        let rt = await jwt.verify(token, salt);
        if (rt.adminId != userId) return false;
        return userId;
    }
    async getSession(name){
        const cookies = {};
        this.websocket.handshake.headers.cookie
          .split(';')
          .forEach((text) => {
            const [k,v] = text.split('=');
            cookies[k] = v;
          });
        
        var sessionId = cookies['csrf_token'];
        if(sessionId){
          var session = await this.redis.get(sessionId);
          session = JSON.parse(session|| '{}');
          return session[name];
        }
    }
};