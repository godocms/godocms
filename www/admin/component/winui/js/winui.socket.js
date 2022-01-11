layui.define(['layer', 'winui'], function (exports) {
    let $ = layui.$,
        layer = layui.layer;
    let socket;
    winui.getDomain = () => {
        let url = document.location.toString(),
            arrUrl = url.split("//");
        return arrUrl[0] + '//' + window.location.host;
    }
    const serverUrl = winui.getDomain();
    winui.hasSocket = false;
    winui.startSocket = () => {
        return;
        if (winui.hasSocket) return;
        winui.hasSocket = true;
        if (window.localStorage.getItem("lockscreen") == "true") return;
        socket = io(serverUrl, {
            reconnect : false,
            autoConnect: false,
            transports: ['websocket']
        });
        winui.socket = socket;
        socket.open();
        socket.on('messgae', function (data) {
            console.log(data)
        })
        socket.on('open', function (data) {
            console.log('open:', data);
            socket.emit('online', { rttoken: getToken() });
        });
        socket.on('close', data => {
            console.log('close',data)
        })
        socket.on('online', userId => {
            console.log('online:', userId)
        })
        socket.on('ping', () => {
            console.log(`ping`)
            socket.emit('online', { rttoken: getToken() });
        })
        socket.on('pong', () => {
            console.log(`pong`)
            //socket.emit('online', { rttoken: getToken() });
        })
        socket.on("disconnect", (reson) => {
            console.log(`disconnect` + reson);
        });

        socket.on('disconnected', () => {
            console.log(`disconnected`);
        })
        socket.on('connect_error', (error) => {
            socket.close();
        });
        socket.on('reconnect_attempt', () => {
            socket.io.opts.transports = ['polling', 'websocket'];
        });
        //socket.emit('addUser', { ddd: '112' });
    }
    
    winui.closeSocket = () => {
        socket && socket.close();
    }
    exports('winuisocket', {})
 })