var onClickHandler = function (info, tab) {
    var data = "";
    if (info.menuItemId == "tinytools-page") {
        data = info.pageUrl;
    } else if (info.menuItemId == "tinytools-selection") {
        data = info.selectionText;
    } else if (info.menuItemId == "tinytools-link") {
        data = info.linkUrl;
    }
    data = data.replace(/"/g, '\\"');
    chrome.tabs.executeScript(tab.id, {"code": "typeof buildqrcode"}, function (context) {
        if (context && context[0] == "undefined") {
            chrome.tabs.executeScript(tab.id, {"file": "js/jquery.min.js"}, function () {
                chrome.tabs.executeScript(tab.id, {"file": "js/jquery.qrcode.js"}, function () {
                    chrome.tabs.executeScript(tab.id, {"file": "js/common.js"}, function () {
                        chrome.tabs.executeScript(tab.id, {"code": "buildqrcode(\"" + data + "\");"});
                    });
                });
            });
        } else {
            chrome.tabs.executeScript(tab.id, {"code": "buildqrcode(\"" + data + "\");"});
        }
    });
};

var onInstallHandler = function () {
    var contexts = ["page", "selection", "link"];
    var texts = ["当前页面", "所选文本", "所选链接"];
    for (var i = 0; i < contexts.length; i++) {
        var title = "为" + texts[i] + "生成二维码";
        var context = contexts[i];
        chrome.contextMenus.create({"title": title, "contexts": [context], "id": "tinytools-" + context});
    }
};

var onBeforeRequestHandler = function (details) {
    var url = details.url;
    var domain = url.match(/^(http|https)\:\/\/([a-zA-Z0-9\.\-])+/g);
    var judge = false;
    var replaceobj = {
        'fonts.googleapis.com': 'fonts.lug.ustc.edu.cn',
        'ajax.googleapis.com': 'ajax.lug.ustc.edu.cn',
        'themes.googleusercontent.com': 'google-themes.lug.ustc.edu.cn',
        'fonts.gstatic.com': 'fonts-gstatic.lug.ustc.edu.cn',
        'www.gravatar.com': 'gravatar.lug.ustc.edu.cn'
    };
    var search = "";
    for (var key in replaceobj) {
        if (replaceobj.hasOwnProperty(key)) {
            judge = domain && domain[0].indexOf(key) > -1;
            if (judge) {
                search = key;
                break;
            }
        }
    }

    if (judge) {
        url = url.replace(search, replaceobj[search]);
        return {redirectUrl: url};
    }
};

//添加右键菜单事件
chrome.contextMenus.onClicked.addListener(onClickHandler);
//添加事件
chrome.runtime.onInstalled.addListener(onInstallHandler);
//替换GoogleAPI https://servers.blog.ustc.edu.cn/2015/09/google-revproxy-add-cache/
//chrome.webRequest.onBeforeRequest.addListener(onBeforeRequestHandler, {urls: ["<all_urls>"]}, ["blocking"]);
