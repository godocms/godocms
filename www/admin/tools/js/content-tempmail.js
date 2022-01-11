/*使用页面中邮箱地址从vppn.us申请一个账号*/
$('<div class="ui-block-a" style="position:absolute;top:-4px;right:0px;"><a id="getvpn" data-icon="back" data-role="button" class="ui-link ui-btn ui-icon-back ui-btn-icon-left ui-shadow ui-corner-all" role="button">Get VPN</a></div>').insertAfter($("#txt_mail"));
$("#txt_mail").parent().css({position: "relative"});
$("#getvpn").on("click", function () {
    $.ajax({
        url: "https://vppn.us/index/trial",
        data: {userid: $("#txt_mail").val()},
        dataType: 'json',
        success: function (ret) {
            if (ret.resultCode == 0) {
                alert("获取成功,请查看邮件");
            } else {
                alert("获取VPN信息失败");
            }
        }, error: function (ret) {
            alert("发生错误");
        }
    });
});