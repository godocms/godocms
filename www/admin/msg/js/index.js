let ws, siteUrl = '/admin/chat/', client = {
    id: '<?php echo $user["id"]?>',
        truename: '<?php echo $user["truename"]?>',
        name: '<?php echo $user["name"]?>',
        head_img: '<?php echo site_url() . $user["head_img"]?>',
        province: '<?php echo $user["province"]?>',
        city: '<?php echo $user["city"]?>',
    }, is_open = 0;

    // 连接服务端
    function connect() {
        // 创建websocket
        ws = new WebSocket("ws://127.0.0.1:8282");
        // 当socket连接打开时，输入用户名
        ws.onopen = onopen;
        // 当有消息时根据消息类型显示不同信息
        ws.onmessage = onmessage;
        ws.onclose = function () {
            is_open = 0;
            console.log("连接关闭，定时重连");
            connect();
        };
        ws.onerror = function () {
            is_open = 0;
            console.log("出现错误");
        };
    }

    function onopen() {
        if (is_open == 0) {
            // 登录
            let login_data = '{"type":"login","client_id":"' + client.id + '", "client_name":"' + client.name.replace(/"/g, '\\"') + '","client_truename":"' + client.truename + '","client_head_img":"' + client.head_img + '"}';
            console.log("websocket握手成功，发送登录数据:" + login_data);
            ws.send(login_data);
        }
    }

    function onmessage(e) {
        let data = JSON.parse(e.data);
        console.log("类型：" + data['type']);
        switch (data['type']) {
            case 'ping':
                console.log("已连接");
                break;
            case 'notify':
                if (data['status'] == 0) {
                    layer.msg(data['msg'], {icon: 2});
                } else {
                    layer.msg(data['msg'], {icon: 1});
                }
                break;
            case 'init':
                //设置聊天列表
                updateChatList(data);
                //设置聊天框
                setChatMessage(data['message_list']);
                //设置待添加朋友数量
                setFriendStatus(data['friend_num']);
                is_open = 1;
                break;
            case 'chat_msg':
                if (data['status'] == 1) {
                    //发送消息成功，客户端显示消息内容

                    //设置左侧交谈列表中的消息内容和数据
                    if (data['uid'] == client.id) {
                        //发送者,设置聊天列表中的消息和事件
                        setChatMsgAndTime(data['chat_id'], data['left_msg'], data['send_time']);
                        //设置发送的聊天内容
                        $("#chatbox").append('<li oncontextmenu="operateMsg(' + data['msg_id'] + ', ' + data['msg_type'] + ')" class="mid-' + data['msg_id'] + ' me">' +
                            '<img src="' + data['head_img'] + '">' +
                            '<span>' + data['msg'] + '</span>' +
                            '</li>');
                    } else {
                        //判断是否已经存在聊天列表中
                        if ($("li.uid-" + data['chat_id']).length == 0) {
                            doUpdateChatList();
                        } else {
                            //接受者，设置聊天列表中的消息和事件
                            setChatMsgAndTime(data['chat_id'], data['left_msg'], data['send_time']);
                            //判断是否选中当前聊天列表，选中则滚动条滚动到底部，没有选中则标记未读
                            let flag = $(".user_active").hasClass("uid-" + data['chat_id']);
                            if (flag == true) {
                                //设置接收的聊天内容
                                $("#chatbox").append('<li oncontextmenu="operateMsg(' + data['msg_id'] + ', ' + data['msg_type'] + ')" class="mid-' + data['msg_id'] + ' other">' +
                                    '<img src="' + data['head_img'] + '">' +
                                    '<span>' + data['msg'] + '</span>' +
                                    '</li>');
                            } else {
                                //设置未读消息
                                setNoReadMsgShow(data['chat_id']);
                            }
                        }
                    }
                    //滚动条滚动到底部
                    setScrollToBottom();
                } else {
                    //发送消息失败
                    layer.msg(data['msg'], {icon: 2});
                }
                break;
            case 'send_msg_to_friends':
                doUpdateChatList();
                break;
            case 'chat_msg_list':
                setChatMessage(data['message_list']);
                break;
            case 'delete_chat':
                //删除聊天
                if (data['status'] == 1) {
                    let obj = $(".uid-" + data['chat_id']);
                    let flag = obj.hasClass("user_active");
                    obj.remove();
                    //判断当前选中的是否是删除的聊天，如果是，则重新选中一聊天
                    if (flag == true) {
                        let oLi = $(".user_list li").eq(0);
                        let chat_id = oLi.data("chat_id");
                        let type = oLi.data("type");
                        setMessageBox(chat_id, type);
                    }
                    layer.msg(data['msg'], {icon: 1});
                } else {
                    //删除失败
                    layer.msg(data['msg'], {icon: 2});
                }
                break;
            case 'delete_chat_msg':
                // 删除聊天信息
                if (data['status'] == 1) {
                    $(".mid-" + data['msg_id']).remove();
                    layer.msg(data['msg'], {icon: 1});
                } else {
                    //删除失败
                    layer.msg(data['msg'], {icon: 2});
                }
                break;
            case 'add_friend':
                //添加朋友反馈
                if (data['status'] == 0) {
                    layer.msg(data['msg'], {icon: 2});
                } else {
                    layer.msg(data['msg'], {icon: 1});
                }
                break;
            case 'add_friend_ok':
                //发送给申请人是否通过
                if (data['status'] == 0) {
                    setFriendList(data);
                    layer.msg(data['msg'], {icon: 2});
                } else {
                    layer.msg(data['msg'], {icon: 1});
                }
                break;
            case 'user_is_notify':
                //发送给朋友消息处理人
                setFriendList(data);
                setFriendStatus(data['friend_num']);
                break;
            case 'friend_list':
                setFriendList(data);
                break;
            case 'delete_friend':
                //删除朋友
                if (data['status'] == 0) {
                    layer.msg(data['msg'], {icon: 2});
                } else {
                    getFriendList();
                    layer.msg(data['msg'], {icon: 1});
                }
                break;
            case 'collection_chat_msg':
                // 收藏聊天信息
                if (data['status'] == 1) {
                    layer.msg(data['msg'], {icon: 1});
                } else {
                    //收藏失败
                    layer.msg(data['msg'], {icon: 2});
                }
                break;
            case 'collection_list':
                //收藏列表
                html = "";
                for (let i = 0; i < data['collection_list'].length; i++) {
                    html += `<li class="cid-` + data['collection_list'][i].id + `" oncontextmenu="operateCollection(` + data['collection_list'][i].id + `, ` + data['collection_list'][i].msg_id + `)" onclick="collectionInfo(` + data['collection_list'][i].id + `)">
                            <div class="collection-msg">
                                <span>
                                    ` + data['collection_list'][i].msg + `
                                </span>
                            </div>
                            <div class="collection-source" >
                                <div>
                                    <span>
                                        ` + data['collection_list'][i].date + `
                                    </span>
                                </div>
                                <div class="ellipsis">
                                    <span>来自：` + data['collection_list'][i].from + `</span>
                                </div>
                            </div>
                        </li>`;
                }
                $("#collection-box ul.content").html(html);
                break;
            case 'delete_collection':
                //删除收藏
                if (data['status'] == 0) {
                    layer.msg(data['msg'], {icon: 2});
                } else {
                    $(".cid-" + data['collection_id']).remove();
                    layer.msg(data['msg'], {icon: 1});
                }
                break;
            case 'send_msg_to_user':
                //在通讯录用户信息中发消息回调
                updateChatList(data, 'update');
                break;
            case 'update_chat_list':
                //设置聊天列表
                updateChatList(data, 'active_update');
                //设置聊天框
                setChatMessage(data['message_list']);
                break;
        }
    }

    //显示群聊列表框
    function getMyQunList() {
        $(".talk_window").hide();
        $("#qun-list-box").show();
    }

    //显示聊天记录
    function showMsgHistory() {
        let chat_id = $("#chat-msg-chat_id").val();
        let name = $("#chat-truename").html();
        let loadT = layer.msg('正在加载数据...', {time: 0, icon: 16, shade: [0.6, '#000']});
        $.get(siteUrl + "/home/chat/getMessageList?chat_id=" + chat_id + "&name=" + name, function (res) {
            layer.close(loadT);
            $("#modal-box").html(res);
            $("#modal-box").modal({closeViaDimmer: 0});
        });
    }

    //更新聊天列表
    function doUpdateChatList() {
        //获取当前选中的聊天id
        let active_chat_id = $(".user_active").data("chat_id");
        //更新聊天列表
        let msg_data = '{"type":"update_chat_list","active_chat_id": "' + active_chat_id + '", "user_id": "' + client.id + '"}';
        ws.send(msg_data);
    }

    function updateMessageList(data, i) {
        $("#chat-msg-chat_id").val(data['user_list'][i].chat_id);
        if (data['user_list'][i].type == 0) {
            $("#chat-truename").html(data['user_list'][i].truename);
        } else {
            //群聊
            $("#chat-truename").html('群聊(' + data['user_list'][i].group_count + ')');
        }
    }

    //更新聊天列表
    function updateChatList(data, flag = 'init') {
        let html = "";
        let len = data['user_list'].length;
        if (len > 0)
            for (let i = 0; i < len; i++) {
                let is_active = "";
                if (flag == "init") {
                    if (i == 0) {
                        is_active = "user_active";
                        updateMessageList(data, i);
                    }
                } else if (flag == "update") {
                    if (data['to_user_id'] == data['user_list'][i].uid) {
                        is_active = "user_active";
                        updateMessageList(data, i);
                    }
                } else if (flag == "active_update") {
                    if (data['user_list'][i].chat_id == data['active_chat_id']) {
                        is_active = "user_active";
                        updateMessageList(data, i);
                    }
                }
                html += `<li oncontextmenu="rightClick('` + data['user_list'][i].chat_id + `', ` + data['user_list'][i].type + `)" onclick="setMessageBox('` + data['user_list'][i].chat_id + `', ` + data['user_list'][i].type + `)" class="` + is_active + ` uid-` + data['user_list'][i].chat_id + ` user-id-` + data['user_list'][i].uid + `" data-truename = "` + data['user_list'][i].truename + `" data-group_count = "` + data['user_list'][i].group_count + `" data-chat_id = "` + data['user_list'][i].chat_id + `" data-type = "` + data['user_list'][i].type + `" data-uid="` + data['user_list'][i].uid + `">
                        <div class="user_head">`;
                if (data['user_list'][i].type == 0) {
                    html += `<img src="` + data['user_list'][i].head_img + `"/>`;
                } else {
                    for (let k = 0; k < data['user_list'][i].head_img.length; k++) {
                        if (data['user_list'][i].count == 3) {
                            html += `<div class="am-u-sm-3" style="padding:0;margin:0;height: 33.333333333%;float: left;">
                                    <img style="width: 100%;height: 100%" src="` + data['user_list'][i].head_img[k] + `" alt="">
                                </div>`;
                        } else {
                            html += `<div class="am-u-sm-6" style="padding:0;margin:0;height: 50%;float: left;">
                                    <img style="width: 100%;height: 100%" src="` + data['user_list'][i].head_img[k] + `" alt="">
                                </div>`;
                        }
                    }
                }
                html += `</div>`;
                if (data['user_list'][i].no_read > 0) {
                    html += `<span class="no-read" style="display: block !important;">` + data['user_list'][i].no_read + `</span>`;
                } else {
                    html += `<span class="no-read">0</span>`;
                }
                html += `
                        <div class="user_text">
                            <p class="user_name">` + data['user_list'][i].truename + `</p>
                            <p class="user_message">` + data['user_list'][i].last_msg + `</p>
                        </div>
                        <div class="user_time">` + data['user_list'][i].time + `</div>
                    </li>`;
            }
        $(".user_list").html(html);
    }

    // 选择图片
    function chooseFolder() {
        let inputObj = document.createElement('input');
        inputObj.setAttribute('id', '_ef');
        inputObj.setAttribute('type', 'file');
        inputObj.setAttribute("style", 'visibility:hidden');
        inputObj.setAttribute("onchange", "geiPicPath(this)");
        document.body.appendChild(inputObj);
        inputObj.click();
    }

    // 获取当前选中的聊天信息
    function getActiveChatInfo(name = '') {
        let data = $("li.user_active").data();
        if (name == '') {
            return data;
        }
        return data[name];
    }

    // 获取图片地址
    function geiPicPath(obj) {
        let type = getType(obj.value);
        if (type != 'png' && type != 'jpg' && type != 'jpeg' && type != 'gif') {
            layer.msg("文件类型不正确", {icon: 2});
            return;
        }
        let fileObj = obj.files[0];
        console.log(fileObj);
        let fileName = fileObj.name;
        let fileSize = getFileSize(fileObj.size);
        let reader = new FileReader();
        reader.readAsDataURL(fileObj);//发起异步请求
        reader.onload = function () {
            //读取完成后，将结果赋值给img的src
            let file = this.result;
            let html = "<img class='doUpload' src='" + file + "' style='width: 100%;'/>";
            let sign = getActiveChatInfo('type');
            let uid = getActiveChatInfo('uid');
            let chat_id = getActiveChatInfo('chat_id');
            let msg_data = '{"type":"chat_msg","msg": "' + html + '","anthor_id":"' + uid + '","sign":"' + sign + '","file_type":"' + type + '", "chat_id":"' + chat_id + '","file_name":"' + fileName + '","file_size":"' + fileSize + '"}';
            ws.send(msg_data);
        };
        $("#_ef").remove();
    }

    // 获取文件后缀名称
    function getType(filename) {
        let index1 = filename.lastIndexOf(".");
        let index2 = filename.length;
        return filename.substring(index1 + 1, index2);
    }

    //获取文件名称
    function getFileName(filename) {
        let index1 = filename.lastIndexOf("/");
        let index2 = filename.length;
        return filename.substring(index1 + 1, index2);
    }

    //获取文件大小
    function getFileSize(size) {
        let ji1 = size / 1024;
        let ji2 = size / 1024 / 1024;
        if (ji2 > 1) {
            return ji2.toFixed(2) + "M";
        }
        return ji1.toFixed(2) + "kb";
    }

    //设置朋友列表
    function setFriendList(data) {
        $(".friend_list_li").remove();
        //好友列表
        let list = Object.keys(data['friend_list']);
        console.log(list);
        var html = "";
        for (let i = 0; i < list.length; i++) {
            html += `<li class="friend_list_li">
                        <p>` + list[i] + `</p>`;
            for (let j = 0; j < data['friend_list'][list[i]].length; j++) {
                let userInfo = JSON.stringify(data['friend_list'][list[i]][j]);
                html += `<div oncontextmenu="operateFriend(` + data['friend_list'][list[i]][j]['id'] + `)" class="friends_box" onclick='showUserInfoBox(` + userInfo + `)'>
                            <div class="user_head"><img src="` + data['friend_list'][list[i]][j].head_img + `"/>
                            </div>
                            <div class="friends_text">
                                <p class="user_name">` + data['friend_list'][list[i]][j].truename + `</p>
                            </div>
                        </div>`
            }
            html += `</li>`;
        }
        $(".friends_list").append(html);
    }

    //设置待处理朋友数量
    function setFriendStatus(num) {
        if (num > 0) {
            $(".friends_list .no-read").html(num).css("display", "block");
            $("#no-ok-friend").html(num).css("display", "block");
        } else {
            $(".friends_list .no-read").css("display", "none");
            $("#no-ok-friend").css("display", "none");
        }
    }

    //退出操作
    function logout() {
        $("#my-logout-confirm").modal({
            closeViaDimmer: 0,
            width: 230,
            onConfirm: function (options) {
                console.log(options);
                window.location.href = "<?php echo site_url('home/chat/logout')?>"
            }
        })
    }

    //收藏详情
    function collectionInfo(collection_id) {

    }

    //右键操作收藏
    function operateCollection(collection_id, msg_id) {
        event.preventDefault();
        let html = `<li onclick="sendMsgToFriendBox(` + msg_id + `)"><a href="#">转发</a></li><li onclick="deleteCollection(` + collection_id + `)"><a href="#">删除</a></li>`;
        $(".contextmenu").html(html);
        //显示弹出框
        let left = event.clientX;
        let top = event.clientY;
        //设置弹出框显示位置
        $(".contextmenu").css({"left": left, "top": top}).show();
    }

    //删除收藏
    function deleteCollection(collection_id) {
        let msg_data = '{"type":"delete_collection","collection_id": "' + collection_id + '"}';
        ws.send(msg_data);
    }

    //删除朋友操作
    function deleteFriend(friend_id) {
        let msg_data = '{"type":"delete_friend","sign": "friend", "friend_id": "' + friend_id + '"}';
        ws.send(msg_data);
    }

    //右键点击操作朋友列表
    function operateFriend(friend_id) {
        event.preventDefault();
        let html = `
                <li onclick="fromFriendSendMsgToUser(` + friend_id + `)"><a href="#">发送消息</a></li>
                <li onclick="deleteFriend(` + friend_id + `)"><a href="#">删除朋友</a></li>`;
        $(".contextmenu").html(html);
        //显示弹出框
        let left = event.clientX;
        let top = event.clientY;
        //设置弹出框显示位置
        $(".contextmenu").css({"left": left, "top": top}).show();
    }

    //发送消息给朋友
    function fromFriendSendMsgToUser(friend_id) {
        $("#user-info-id").val(friend_id);
        sendMsgToUser();
    }

    //显示右键点击操作聊天信息框
    function operateMsg(msg_id, msg_type) {
        //阻止默认事件
        event.preventDefault();
        let html = `<li onclick="sendMsgToFriendBox(` + msg_id + `)"><a href="#">发送给朋友</a></li>
                <li onclick="copyMsg(` + msg_id + `)"><a href="#">复制</a></li>
                <li onclick="collectionMsg(` + msg_id + `)"><a href="#">收藏</a></li>`;
        if (msg_type == 1 || msg_type == 2) {
            html += `<li onclick="saveAsMsg(` + msg_id + `, ` + msg_type + `)"><a href="#">下载</a></li>`
        }
        html += `<li onclick="deleteMsg(` + msg_id + `)"><a href="#">删除</a></li>`;
        $(".contextmenu").html(html);
        //显示弹出框
        let left = event.clientX;
        let top = event.clientY;
        //设置弹出框显示位置
        $(".contextmenu").css({"left": left, "top": top}).show();
    }

    //图片下载
    function saveAsMsg(msg_id, msg_type) {
        if (msg_type == 1) {
            let saveAs = $(".mid-" + msg_id + " img.doUpload").attr("src");
            let tempa = document.createElement('a');
            tempa.href = saveAs;
            let file_name = getFileName(saveAs);
            tempa.download = file_name.split(".")[0];
            document.body.append(tempa);
            tempa.click();
            tempa.remove();
        }

    }

    //发送给朋友弹框
    function sendMsgToFriendBox(msg_id) {
        let loadT = layer.msg('正在加载数据...', {time: 0, icon: 16, shade: [0.6, '#000']});
        $.get(siteUrl + "/home/chat/sendMsgToFriend?msg_id=" + msg_id, function (res) {
            layer.close(loadT);
            $("#modal-box").html(res);
            $("#modal-box").modal({closeViaDimmer: 0});
        });
    }

    //复制信息
    function copyMsg(msg_id) {
        let content = $(".mid-" + msg_id + ">span").html();
        var aux = document.createElement("input");
        aux.setAttribute("value", content);
        document.body.appendChild(aux);
        aux.select();
        document.execCommand("copy");
        document.body.removeChild(aux)
        layer.msg("复制成功", {icon: 1});
    }

    //收藏信息
    function collectionMsg(msg_id) {
        let data = $("li.user_active ").data();
        let from_user_id = data['uid'];
        let type = data['type'];
        let msg_data = '{"type":"collection_chat_msg","sign":"' + type + '","msg_id": "' + msg_id + '","from_user_id":"' + from_user_id + '"}';
        ws.send(msg_data);
    }

    //删除聊天信息
    function deleteMsg(msg_id) {
        let msg_data = '{"type":"delete_chat_msg","msg_id": "' + msg_id + '"}';
        ws.send(msg_data);
    }

    //显示给某个人发消息框
    function sendMsgToUser() {
        let user_id = $("#user-info-id").val();
        let flag = $(".user_list > li").hasClass("user-id-" + user_id);
        if (flag == false) {
            let msg_data = '{"type":"send_msg_to_user","to_user_id": "' + user_id + '"}';
            ws.send(msg_data);
        } else {
            let oLi = $("li.user-id-" + user_id);
            let chat_id = oLi.data("chat_id");
            let type = oLi.data("type");
            setMessageBox(chat_id, type);
        }
        $("#si_1").css("background", "url(<?php echo base_url()?>static/chat/images/icon/head_2_1.png) no-repeat");
        $("#si_2").css("background", "");
        $("#si_3").css("background", "");
        $(".middle").hide();
        $(".middle").eq(0).show();
        $(".talk_window").hide();
        $("#chat-box").show();
    }

    //显示会员信息框
    function showUserInfoBox(userInfo) {
        $("#user-info-truename").html(userInfo.truename);
        $("#user-info-province").html(userInfo.province);
        $("#user-info-city").html(userInfo.city);
        $("#user-info-name").html(userInfo.name);
        $("#user-info-id").val(userInfo.id);
        $("#user-head_img").attr('src', userInfo.head_img);
        $(".talk_window").hide();
        $("#user-info-box").show();
    }

    //获取我的新朋友
    function getMyNewFriend() {
        let loadT = layer.msg('正在加载数据...', {time: 0, icon: 16, shade: [0.6, '#000']});
        $.get(siteUrl + "/home/chat/newfriend", function (res) {
            layer.close(loadT);
            $("#modal-box").html(res);
            $("#modal-box").modal({closeViaDimmer: 0});
        });
    }

    //添加朋友和分组
    function addFriendOrGroup() {
        let loadT = layer.msg('正在加载数据...', {time: 0, icon: 16, shade: [0.6, '#000']});
        $.get(siteUrl + "/home/chat/addfriend", function (res) {
            layer.close(loadT);
            $("#modal-box").html(res);
            $("#modal-box").modal({closeViaDimmer: 0});
        });
    }

    //删除当前聊天
    function deleteChat() {
        let chat_id = $("#operate-uid").val();
        let msg_data = '{"type":"delete_chat","chat_id": "' + chat_id + '"}';
        ws.send(msg_data);
    }

    //设置2s提示不能输入空白内容
    function sendMsgTips() {
        layer.msg("不能输入空白内容", {icon: 2});
    }

    //鼠标点击聊天右键
    function rightClick(uid) {
        //阻止默认事件
        event.preventDefault();
        let html = `<li id="contextmenu-delete" onclick="deleteChat()"><a href="#">删除聊天</a></li>`;
        $("#operate-uid").val(uid);
        //显示弹出框
        let left = event.clientX;
        let top = event.clientY;
        //设置弹出框显示位置
        $(".contextmenu").css({"left": left, "top": top}).html(html).show();
    }

    //设置交谈人的最后消息和时间
    function setChatMsgAndTime(uid, msg, time) {
        $(".uid-" + uid + " .user_message").html(msg);
        $(".uid-" + uid + " .user_time").html(time);
    }

    //设置某用户的未读消息
    function setNoReadMsgShow(uid) {
        let no_read = $(".uid-" + uid + " span.no-read");
        no_read.show();
        no_read.html(parseInt(no_read.html()) + 1);
    }

    //设置消息已读
    function setNoReadMsgHide(chat_id) {
        let no_read = $(".uid-" + chat_id + " span.no-read");
        no_read.hide();
        no_read.html(0);
    }

    //设置聊天记录滚动条到底部
    function setScrollToBottom() {
        setTimeout(function () {
            let chat_box = $("#chatbox");
            chat_box[0].scrollTop = chat_box[0].scrollHeight
        }, 50);
    }

    //设置显示聊天数据
    function setChatMessage(message_list) {
        let chat = "";
        let len = message_list.length;
        if (len > 0) {
            for (let i = 0; i < message_list.length; i++) {
                let who = "";
                if (message_list[i].is_me == 0) {
                    who = "other";
                } else {
                    who = "me";
                }
                chat += `<li oncontextmenu="operateMsg(` + message_list[i].id + `, ` + message_list[i].msg_type + `)" class="mid-` + message_list[i].id + ' ' + who + `"><img src="` + message_list[i].head_img + `" title="` + message_list[i].truename + `"><span>` + message_list[i].msg + `</span></li>`;
            }
            setNoReadMsgHide(message_list[0].chat_id);
        }
        $("#chatbox").html(chat);
        setScrollToBottom();
    }

    //点击左侧好友列表，右侧显示聊天信息
    function setMessageBox(chat_id, type) {
        $(".user_list li").removeClass("user_active");
        $(".uid-" + chat_id).addClass("user_active");
        if (type == 0) {
            let truename = $(".uid-" + chat_id).data("truename");
            $("#chat-truename").html(truename);
        } else {
            let group_count = $(".uid-" + chat_id).data("group_count");
            $("#chat-truename").html("群聊(" + group_count + ")");
        }
        $("#chat-msg-chat_id").val(chat_id);
        $("#user-info-box").hide();
        $("#chat-box").show();
        let msg_data = '{"type":"chat_msg_list","sign": "' + type + '", "chat_id": "' + chat_id + '"}';
        console.log("获取所有的聊天数据:" + msg_data);
        ws.send(msg_data);
        setMsgTextAreaShow();
    }

    //点击enter键发送消息
    function enterSendMsg(e) {
        e.stopPropagation();
        //e.preventDefault();
        if (e.keyCode == 13) {
            //发送消息
            sendMessage();
        }
    }

    //设置输入框背景为白色
    function setMsgTextAreaShow() {
        $("#talkbox").css("background", "#fff");
        $("#input_box").css("background", "#fff");
    }

    //隐藏输入框背景色
    function setMsgTextAreaHide() {
        $("#talkbox").css("background", "");
        $("#input_box").css("background", "");
    }

    //点击发送消息
    function sendMessage() {
        //event.stopPropagation();
        let chat_id = $("#chat-msg-chat_id").val();
        let type = $(".uid-" + chat_id).data("type");
        let value = $("#input_box").html();
        console.log(value.length);
        if (value.length == 0) {
            sendMsgTips();
        } else {
            value = value.replace(/"/g, "'");
            value = value.replace(/\n/g, "");
            let uid = $(".uid-" + chat_id).data("uid");
            let msg_data = '{"type":"chat_msg","msg":"' + value + '","sign": "' + type + '","chat_id": "' + chat_id + '","anthor_id":"' + uid + '", "file_type": ""}';
            console.log("发送聊天数据:" + msg_data);
            ws.send(msg_data);
            setScrollToBottom();
            $("#input_box").html("");
        }
    }

    //初始化表情数据
    function initEmotion() {
        $.getJSON(siteUrl + "/static/chat/emotion/emotion.json", function (data) {
            let emotion = "";
            $.each(data, function (i, item) {
                console.log();
                emotion += `<li onclick="selectEmotion(this)" data-url="/static/chat/emotion/` + item.name + `.png">
                <img style='width:24px;height:24px;' src='/static/chat/emotion/` + item.name + `.png'>
            </li>`;
            });
            $(".emotion-list").html(emotion);
        });

    }

    // 显示表情弹框
    function showEmotion(e) {
        e.preventDefault();
        e.stopPropagation();
        let x = event.clientX;
        let y = event.clientY;
        $(".emotion-box").css({left: parseFloat(x) - 150, top: parseFloat(y) - 320}).show();
        setMsgTextAreaShow();
    }

    // 隐藏表情弹框
    function hideEmotion() {
        $(".emotion-box").hide();
    }

    //选择表情
    function selectEmotion(obj) {
        let url = $(obj).data("url");
        let sHtml = "<img src='" + url + "' style='width:20px;height:20px;'/>";
        $("#input_box").append(sHtml);
        setMsgTextAreaShow();
    }

    //获取朋友列表
    function getFriendList() {
        //获取朋友列表
        var msg_data = '{"type":"friend_list", "sign": "friend"}';
        ws.send(msg_data);
    }

    //三图标
    window.onload = function () {
        //连接socket
        connect();

        //初始化表情
        initEmotion();

        $(document).click(function () {
            //隐藏右键显示的弹出框
            $(".contextmenu").hide();
            // 隐藏表情弹框
            hideEmotion();
        });

        $("#input_box").on("click", function () {
            setMsgTextAreaShow();
        });

        $(".windows_body").on("click", function () {
            setMsgTextAreaHide();
        });

        //设置选项背景
        function a() {
            var si1 = document.getElementById('si_1');
            var si2 = document.getElementById('si_2');
            var si3 = document.getElementById('si_3');
            si1.onclick = function () {
                si1.style.background = "url(<?php echo base_url()?>static/chat/images/icon/head_2_1.png) no-repeat"
                si2.style.background = "";
                si3.style.background = "";
                $(".talk_window").hide();
                $("#chat-box").show();
                //获取当前选中的聊天列表
                let data = $(".user_active ").data();
                console.log(data);
                let msg_data = '{"type":"chat_msg_list","sign": "' + data['type'] + '", "chat_id": "' + data['chat_id'] + '"}';
                ws.send(msg_data);
            };
            si2.onclick = function () {
                si2.style.background = "url(<?php echo base_url()?>static/chat/images/icon/head_3_1.png) no-repeat"
                si1.style.background = "";
                si3.style.background = "";
                $(".talk_window").hide();
                $("#default-box").show();
                //获取朋友列表
                getFriendList();
            };
            si3.onclick = function () {
                si3.style.background = "url(<?php echo base_url()?>static/chat/images/icon/head_4_1.png) no-repeat"
                si1.style.background = "";
                si2.style.background = "";
                $(".talk_window").hide();
                $("#collection-box").show();
                //获取我的收藏
                var msg_data = '{"type":"collection_list"}';
                ws.send(msg_data);
            };
        };

        a();
    };