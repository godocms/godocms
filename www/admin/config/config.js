const apiUrl = '/server/';
const TOKEN_NAME = 'rttoken';
const setToken = (res) => {
    localStorage.setItem(TOKEN_NAME, res.token);
    localStorage.setItem('_godocmsRoute', JSON.stringify(res.routeData))
}
const getRoute = () => {
    let data = localStorage.getItem('_godocmsRoute');
    if (data) {
        return JSON.parse(data)
    }
    return false;
}
const loginOutToken = () => {
    localStorage.removeItem("_godocmsRoute");
    localStorage.removeItem(TOKEN_NAME);
}
const getToken = () => {
    return localStorage.getItem(TOKEN_NAME);
}
const getHeader = () => {
    let token = getToken(),
        rt = {};
    if (token) {
        rt[TOKEN_NAME] = token;
    }
    return rt;
}
const errorStatus = (xhr, layui) => {
    //console.log(xhr)
    if (xhr.status === 400) {
        layui.layer.msg('未授权访问！', {
            icon: 2, time: 2000
        });
    }
    else if (xhr.status === 401) {
        layui.layer.msg('访问接口未带token！', {
            icon: 2, time: 2000
        });
        top.location.href = '/admin/index.html';
    }
    else if (xhr.status === 402) {
        layui.layer.msg('token校验失败！', {
            icon: 2, time: 2000
        });
        top.location.href = '/admin/index.html';
    }
    else if (xhr.status === 403) {
        layui.layer.msg('一段时间未操作，超过保活时间！', {
            icon: 2, time: 2000
        });
        top.location.href = '/admin/index.html';
    }
    else if (xhr.status === 406) {
        layui.layer.msg('一段时间未操作，超过保活时间！', {
            icon: 2, time: 2000
        });
        top.location.href = '/admin/index.html';
    }
    else if (xhr.status === 404) {
        layui.layer.msg('请求的地址不存在！', {
            icon: 2, time: 2000
        });
    }
    else {
        layui.layer.msg('通讯失败！请重试！', {
            icon: 2, time: 2000
        });
    }
}
const parseMsg = (msgs, layui) => {
    if(!msgs) {
        layui.layer.msg('系统错误', {
            icon: 2, time: 2000
        });
        return false;
    }
    if (msgs.constructor === Object) {
        //console.log('111')
        for (let p in msgs) {
            //console.log(msgs[p])
            layui.layer.msg(msgs[p], {
                icon: 2, time: 2000
            });
        }
    } else {
        layui.layer.msg(msgs, {
            icon: 2, time: 2000
        });
    }
}
const _get = (layui, url, suc, err) => {
    //console.log(`${apiUrl}${url}`)
    layui.$.ajax({
        type: "get",
        url: `${apiUrl}${url}`,
        headers: getHeader(),
        success: (res) => {
            //console.log(res)
            if (res.code === 0) {
                suc(res.data)
            } else {
                // layui.layer.msg(res.message, {
                //     icon: 2, time: 2000
                // });
                parseMsg(res.message, layui);
                err && err(res);
            }
        },
        error: (xhr) => {
            console.log(xhr)
            err && err(xhr);
            errorStatus(xhr, layui)
        },
        complete :(xhr, ts) => {
            //console.log(xhr)
            //console.log(ts)
        } 
    });
}
const _post = (layui, url, data, suc, err) => {
    //console.log(`${apiUrl}${url}`)
    layui.$.ajaxSetup({
        xhrFields: {
            withCredentials: true
        }
    });
    layui.$.ajax({
        type: "post",
        url: `${apiUrl}${url}`,
        headers: getHeader(),
        data,
        success: (res) => {
            //console.log(res)
            if (res.code === 0) {
                suc(res.data)
            } else {
                parseMsg(res.message, layui);
                
                if (res.code >= 400) {
                    errorStatus({ status: res.code }, layui)
                }
                err && err(res);
            }
        },
        error: (xhr) => {
            err && err(xhr);
            errorStatus(xhr, layui)
        }
    });
}
const _req = (param = '') => {
    var url = location.search; //获取url中"?"符后的字串
    var theRequest = new Object();
    if (url.indexOf("?") != -1) {
        var str = url.substr(1);
        strs = str.split("&");
        for (var i = 0; i < strs.length; i++) {
            theRequest[strs[i].split("=")[0]] = unescape(strs[i].split("=")[1]);
        }
    }
    if (param == '') {
        return theRequest;
    } else {
        if (theRequest[param]) {
            return theRequest[param];
        } else {
            return false;
        }
    }
    
}
const treeIds = (arr) => {
    for (const item of arr) {
        list.push(item.id);
        let subs = item.children;
        if (subs && subs.length > 0) {
            treeIds(subs, list);
        }
    }
    return list.join(',');	//以逗号拼接返回
}
const getTree = (arr) => {
    let list = [];
    let treeIds = function (arr) {
        for (const item of arr) {
            list.push(item.id);
            let subs = item.children;
            if (subs && subs.length > 0) {
                treeIds(subs, list);
            }
        }
        return list.join(',');	//以逗号拼接返回
    }
    return treeIds(arr);
}

const _msg = (msg) => {
    let m = document.createElement('div');
    m.innerHTML = msg;
    m.style.cssText = "font-size: .9rem;color: rgb(255, 255, 255);background-color: rgba(0, 0, 0, 0.6);padding: 10px 15px;margin: 0 0 0 -60px;border-radius: 4px;position: fixed;    top: 50%;left: 50%;text-align: center;z-index:20211223";
    document.body.appendChild(m);
    setTimeout(() => {
        let d = 0.5;
        m.style.opacity = '0';
        setTimeout( () => { document.body.removeChild(m) }, d * 1000);
    }, 2000);
}
const _ajax = (url, method = "GET", params, callback) => {
    // 创建XMLHttpRequest对象  
    let createRequest = function () {
        var xmlhttp;
        try {
            xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");// IE6以上版本  
        } catch (e) {
            try {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");// IE6以下版本  
            } catch (e) {
                try {
                    xmlhttp = new XMLHttpRequest();
                    // if (xmlhttp.overrideMimeType) {
                    //     xmlhttp.overrideMimeType("text/xml");
                    // }
                } catch (e) {
                    _msg("您的浏览器不支持Ajax");
                }
            }
        }
        return xmlhttp;
    };
        // 格式化请求参数  
    let formateParameters = function () {
        let paramsArray = [];
        //console.log(params)
        for (let pro in params) {
            var paramValue = params[pro];
            paramsArray.push(pro + "=" + paramValue);
        }
        return paramsArray.join("&");
    };

    // 发送Ajax请求  
    
    // 创建XMLHttpRequest对象  
    let xmlhttp = createRequest();

        // 设置回调函数  
    xmlhttp.onreadystatechange = function () {
        let returnValue;
        try {
            
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                //console.log(xmlhttp)
                let jsonText = xmlhttp.responseText;
                //console.log(xmlhttp)
                if (jsonText) {
                    //returnValue = eval("(" + jsonText + ")");
                    returnValue = JSON.parse(jsonText);
                }
                callback(returnValue);
            } else {
                callback(xmlhttp);
            }
        } catch (e) {
            console.log(e.message)
        }
        
    };

    // 格式化参数  
    let formateParams = formateParameters();
    //console.log(formateParams)
    // 请求的方式  
    url = apiUrl + url;

    if ("GET" === method.toUpperCase() && params != '') {
        url += "?" + formateParams;
    }

    // 建立连接  
    xmlhttp.open(method, url, true);
    xmlhttp.withCredentials = true;
    xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    //xmlhttp.setRequestHeader("Content-type", "application/json");
    xmlhttp.setRequestHeader(TOKEN_NAME, getToken());
    //xmlhttp.setRequestHeader("Content-Type", "application/json");
    if ("GET" === method.toUpperCase()) {
        xmlhttp.send(null);
    }
    
    else if ("POST" === method.toUpperCase()) {
        // 如果是POST提交，设置请求头信息  
        
        xmlhttp.send(formateParams);
    }
    
    
}
const __post = (url, params, callback) => {
    _ajax(url, "POST", params, callback)
}
const __get = (url, callback) => {
    _ajax(url, "GET", '', callback)
}