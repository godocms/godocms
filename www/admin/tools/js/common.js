
var st;
var url;
var clipboard = {type: "", content: "", url: ""};

var utf8text = function (text) {
    text = String(text).replace(
            /[\u0080-\u07ff]/g,
            function (c) {
                var cc = c.charCodeAt(0);
                return String.fromCharCode(0xc0 | cc >> 6, 0x80 | cc & 0x3f);
            }
    ).replace(
            /[\u0800-\uffff]/g,
            function (c) {
                var cc = c.charCodeAt(0);
                return String.fromCharCode(0xe0 | cc >> 12, 0x80 | cc >> 6 & 0x3f, 0x80 | cc & 0x3f);
            }
    );
    return text;
};

var buildqrcode = function (qrtext) {
    var size = 400;
    var div = $("<div id='tinytools-bg'></div>");
    var qrdiv = $("<div id='tinytools-qrimage'></div>");
    div.click(function () {
        div.remove();
        qrdiv.remove();
        $(document).unbind("keyup");
    });
    $(document).bind("keyup", function (e) {
        e = e || window.event;
        var k = e.keyCode;
        if (k == 32 || k == 27) {
            div.click();
        }
    });
    $("body").append(div);
    $("body").append(qrdiv);
    div.css({
        'position': 'fixed',
        'top': 0,
        'left': 0,
        'width': '100%',
        'height': '100%',
        'z-index': '9999'});
    $(div).css('background-color', 'rgba(0,0,0,.85)');
    $(qrdiv).css({
        top: div.height() / 2 - size / 2,
        left: div.width() / 2 - size / 2,
        width: size + 'px',
        height: size + 'px',
        position: 'fixed',
        background: 'white',
        'z-index': '10000'
    });
    $(qrdiv).qrcode({
        "render": "image",
        "size": size,
        "color": "#3a3",
        "text": utf8text(qrtext)
    });
};

var copy = function (str) {
    var sandbox = $('#sandbox').val(str).select();
    document.execCommand('copy');
    clipboard.type = "text";
    clipboard.content = sandbox;
    clipboard.url = "";
    sandbox.val('');
};

var paste = function () {
    var result = '',
            sandbox = $('#sandbox').val('').select();
    if (document.execCommand('paste')) {
        result = sandbox.val();
    }
    sandbox.val('');
    return result;
};