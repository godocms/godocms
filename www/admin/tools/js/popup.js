$(function () {
    var rebuild = function () {
        var type = $("input[name=type]:checked").val();
        var mode = $("#mode option:selected").val();
        var inputobj = $("#inputtext");
        var inputtext = $("#inputtext").val();
        var outputobj = $("#outputtext");
        var result = "";
        try {
            switch (type) {
                case "qrcode":
                    inputtext = inputtext.length == 0 && url.length > 0 ? url : inputtext;
                    if (mode == 'auto') {
                        if (clipboard.type == "file") {
                            mode = 'qrdecode';
                        } else {
                            mode = 'qrencode';
                        }
                    }
                    if (mode == 'qrdecode') {
                        outputobj.show();
                        result = "Decoding...";
                        $("#qrcode").hide();
                        var data = new FormData();
                        data.append('upload_ctn', "on");
                        data.append('url', inputtext);
                        data.append('qrcode', clipboard.content);
                        $.ajax({
                            url: "http://tool.oschina.net/action/qrcode/decode",
                            type: 'POST',
                            data: data,
                            dataType: 'json',
                            contentType: false,
                            enctype: 'multipart/form-data',
                            processData: false,
                            success: function (data) {
                                if (data[0] != undefined) {
                                    outputobj.val(data[0].text);
                                } else {
                                    outputobj.val("Decode failue");
                                }
                            }, error: function () {
                                outputobj.val("An error occurred");
                            }
                        });
                    } else {
                        outputobj.hide();
                        $("#qrcode").html('').show();
                        $("#qrcode").qrcode({
                            "render": "image",
                            "size": 200,
                            "color": "#3a3",
                            "text": utf8text(inputtext)
                        });
                        var url = inputtext.indexOf(".") > -1 ? inputtext : $("#url").val();
                        var a = document.createElement('a');
                        a.href = url;
                        var domain = a.hostname;
                        var baiduurl = 'https://www.baidu.com/s?ie=UTF-8&wd=' + encodeURIComponent("site:" + domain);
                        var aizhanurl = 'http://www.aizhan.com/cha/' + domain + '/';

                        $('<div class="row btn-alimama" id="extend-url"></div>').prependTo("#qrcode");
                        $('<div class="col-xs-3"><a class="btn btn-info btn-block" href="' + baiduurl + '" target="_blank">百度收录</a></div>').appendTo("#extend-url");
                        $('<div class="col-xs-3"><a class="btn btn-info btn-block" href="' + aizhanurl + '" target="_blank">SEO查询</a></div>').appendTo("#extend-url");
                        if (url.match(/taobao|tmall/)) {
                            var normalurl = 'http://pub.alimama.com/promo/search/index.htm?q=' + encodeURIComponent(url);
                            var highurl = 'http://pub.alimama.com/promo/item/channel/index.htm?q=' + encodeURIComponent(url);
                            $('<div class="col-xs-3"><a class="btn btn-danger btn-block" href="' + normalurl + '" target="_blank">通用推广</a></div>').appendTo("#extend-url");
                            $('<div class="col-xs-3"><a class="btn btn-danger btn-block" href="' + highurl + '" target="_blank">高佣推广</a></div>').appendTo("#extend-url");
                        }
                    }
                    break;
                case "url":
                    var tounicode = function (text) {
                        console.log(text);
                        var result = "";
                        for (var i = 0; i < text.length; i++) {
                            var partial = text[i].charCodeAt(0).toString(16);
                            while (partial.length !== 4)
                                partial = "0" + partial;
                            result += "\\u" + partial;
                        }
                        return result;
                    };
                    if (mode == 'auto') {
                        if (inputtext.match(/^[0-9a-zA-Z\-_\*%\.]+$/)) {
                            mode = 'urldecode';
                        } else if (inputtext.match(/^\\u[0-9a-fA-F]{4}(.*)/)) {
                            mode = 'unidecode';
                        } else {
                            mode = 'urlencode';
                        }
                    }
                    switch (mode) {
                        case "urlencode":
                            result = encodeURIComponent(inputtext);
                            break;
                        case "urldecode":
                            result = decodeURIComponent(inputtext);
                            break;
                        case "uniencode":
                            result = tounicode(inputtext);
                            break;
                        case "unidecode":
                            result = unescape(JSON.parse('"' + inputtext + '"'));
                            break;
                        default:
                            result = inputtext;
                    }
                    break;
                case "timestamp":
                    if (inputtext.length == 0 || inputtext.match(/^[0-9]{10,13}$/)) {
                        var timeobj;
                        if (inputtext.length == 0) {
                            timeobj = new Date();
                        } else if (inputtext.length == 10) {
                            timeobj = new Date(parseInt(inputtext) * 1000);
                        } else {
                            timeobj = new Date(parseFloat(inputtext));
                        }
                        if (inputtext.length == 0) {
                            inputobj.val(parseInt(timeobj.getTime() / 1000));
                        }
                        var year = timeobj.getFullYear();
                        var month = timeobj.getMonth() + 1;
                        var day = timeobj.getDate();
                        var hours = timeobj.getHours();
                        var minutes = timeobj.getMinutes();
                        var seconds = timeobj.getSeconds();
                        month = month < 10 ? "0" + month : month;
                        day = day < 10 ? "0" + day : day;
                        hours = hours < 10 ? "0" + hours : hours;
                        minutes = minutes < 10 ? "0" + minutes : minutes;
                        seconds = seconds < 10 ? "0" + seconds : seconds;
                        result += year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
                    } else if (inputtext.match(/^[0-9]{4}\-[0-9]{1,2}\-[0-9]{1,2}\s[0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}$/)) {
                        var timeobj = inputtext.replace(/(:|\s)/g, "-").split("-");
                        result = parseInt(new Date(Date.UTC(timeobj[0], timeobj[1] - 1, timeobj[2], timeobj[3] - 8, timeobj[4], timeobj[5])).getTime() / 1000);
                    } else {
                        result = "Invalid format";
                    }
                    break;
                case "base64":
                    console.log(clipboard);
                    if (mode == "auto" && clipboard.type != "text" && clipboard.url.substring(0, 10) == 'data:image') {
                        //result = clipboard.url.replace(/data:image\/([a-z]+);base64\,/, '');
                        result = clipboard.url;
                    } else {
                        if (mode == 'auto') {
                            if (clipboard != "text" || inputtext.match(/^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{4}|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)$/)) {
                                mode = 'base64decode';
                            } else {
                                mode = 'base64encode';
                            }
                        }
                        result = mode == 'base64encode' ? $.endecode.base64Encode($.endecode.utf8Encode(inputtext)) : $.endecode.utf8Decode($.endecode.base64Decode(inputtext));
                    }

                    break;
                case "translate":
                    if (inputtext.length > 0) {
                        clearTimeout(st);
                        st = setTimeout(function () {
                            var from = "auto";
                            var to = "auto";
                            if (/.*[\u4e00-\u9fa5]+.*$/.test(inputtext)) {
                                to = "en";
                            }
                            if (mode !== 'auto') {
                                var arr = mode.split('-');
                                from = arr[0];
                                to = arr[1];
                            }
                            to = to == "zh" ? "zh-CN" : to;
                            var data = {
                                client: "gtx",
                                sl: from,
                                tl: to,
                                hl: "zh-CN",
                                dj: 1,
                                source: "icon",
                                q: inputtext
                            };
                            $.ajax({
                                url: "https://translate.google.cn/translate_a/single?dt=t&dt=bd",
                                data: data,
                                success: function (ret) {
                                    if (ret.sentences) {
                                        var arr = new Array();
                                        $.each(ret.sentences, function (i, j) {
                                            arr.push(j.trans);
                                        });
                                        result = arr.join('');
                                    } else if (ret.dict) {
                                        result = ret.dict[0].terms.join(",");
                                    } else {
                                        result = "无法翻译";
                                    }
                                    outputobj.val(result);
                                }, error: function (ret) {
                                    result = "unknown format";
                                }
                            });
                        }, 500);
                    }
                    break;
                case "format":
                    if (mode == 'auto') {
                        mode = "javascript";
                    }
                    switch (mode) {
                        case "html":
                        case "xml":
                        case "sql":
                            result = "Decoding...";
                            $("#qrcode").hide();
                            var data = new FormData();
                            data.append(mode, inputtext);
                            if (mode == "sql") {
                                data.append("f" + mode, "");
                            } else {
                                data.append("sqlType", "mysql");
                            }
                            $.ajax({
                                url: "http://tool.oschina.net/action/format/" + mode,
                                type: 'POST',
                                data: data,
                                dataType: 'json',
                                contentType: false,
                                processData: false,
                                success: function (data) {
                                    if (data["f" + mode] != undefined) {
                                        outputobj.val(data["f" + mode]);
                                    } else {
                                        outputobj.val("Format failue:" + data["msg"]);
                                    }
                                }, error: function () {
                                    outputobj.val("An error occurred");
                                }
                            });
                            break;
                        case "json":
                            try {
                                var jsonobj = $.parseJSON(inputtext);
                                var str = JSON.stringify(jsonobj, undefined, 4);
                                result = str;
                            } catch (e) {
                                result = "An error occurred:" + e.message;
                            }
                            break;
                        case "javascript":
                            result = jsbeautify(inputtext, 4, '');
                            break;
                        case "css":
                            var options = {
                                indent: '\t'
                            };
                            result = cssbeautify(inputtext, options);
                            break;
                    }
                    break;
                case "json":
                    location.href = "jsonedit/index.html";
                    break;
                case "regex":
                    location.href = "regex/index.html";
                    break;
                default:
                    outputobj.val(inputtext);
                    break;
            }
        } catch (e) {
            console.log(e);
            result = "An error occurred:" + e.message;
        }
        outputobj.val(result);
    };

    if ($('[data-toggle="select"]').length) {
        $('[data-toggle="select"]').select2();
    }
    $("#exchange").on("click", function () {
        $("#inputtext").val($("#outputtext").val());
        rebuild();
    });
    $("#inputtext").bind("input propertychange", function () {
        rebuild();
    });
    $("input[name=type]").on("click", function () {
        $("#mode").select2('data', []);
        $("#mode option").remove();
        var selectlist = $(this).data("select");
        $(selectlist.split("|")).each(function (i, j) {
            $("<option value='" + j + "'>" + j + "</option>").appendTo($("#mode"));
        });
        $("#mode").select2('val', 'auto');
        if ($(this).val() == "qrcode") {
            $("#outputtext").hide();
            $("#qrcode").show();
        } else {
            $("#outputtext").show();
            $("#qrcode").hide();
        }
        rebuild();
    });
    $("#truncate").on("click", function () {
        $("#inputtext").val('').focus();
        clipboard.type = "text";
        clipboard.content = "";
        clipboard.url = "";
        rebuild();
    });
    $("#copy").on("click", function () {
        copy($("#outputtext").val());
    });
    $("#mode").change(function () {
        rebuild();
    });
    $(document).bind('paste', function (e) {
        var event = (e.clipboardData || e.originalEvent.clipboardData);
        var type = "type";
        var content = "";
        try {
            if (event.items[0].type === "text/plain") {
                type = "text";
                content = event.getData('text/plain');
            } else {
                type = "file";
                content = event.items[0].getAsFile();
                var reader = new FileReader();
                reader.onload = function (evt) {
                    clipboard.url = evt.target.result;
                };
                reader.readAsDataURL(content);
                $("#inputtext").val("read file from clipboard");
            }
            clipboard.type = type;
            clipboard.content = content;
        } catch (exc) {
            console.log("An error occurred:" + e.message);
        }
        rebuild();
    });

    var pastetext = paste();

    chrome.tabs.query({
        currentWindow: true,
        active: true
    },
            function (tab) {
                url = tab[0].url;
                $("input[name=type][value=qrcode]").attr("checked", "checked");
                var inputtext = $("#inputtext");
                if (pastetext.match(/^[0-9]{10,13}$/)) {
                    $("input[name=type][value=timestamp]").attr("checked", "checked");
                    inputtext.val(pastetext).focus();
                } else if (clipboard.type == "text") {
                    $("#url").val(url);
                    if (($.trim(pastetext).length == 0 || !pastetext.match(/^[a-zA-Z0-9]{6,10}$/)) && url.match(/^((https|http|ftp)?:\/\/)(.*)/)) {
                        pastetext = url;
                    }
                    inputtext.val(pastetext).focus();
                    $("input[name=type][value=qrcode]").attr("checked", "checked");
                }
                $("input[name=type]:checked").click();
            });

});
