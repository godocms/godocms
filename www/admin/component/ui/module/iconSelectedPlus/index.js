/**
 * iconSelectedPlus 更好的图标选择器
 * @author 黄俊杰
 * @version 1.0.0.20211026
 */
layui.define(["jquery"], function (exports) {
    var $ = layui.jquery;
    var id = 0;

    // 内置图标库
    var icons = {
        // layui 镜像站：https://layui-exts.gitee.io/layui-doc-layui/
        // 图标页面：https://layui-exts.gitee.io/layui-doc-layui/www.layui.com/doc/element/icon.html
        // 脚本学习：scripts/layui.js
        layui: [
            {
                classList: "layui-icon layui-icon-heart-fill",
                name: "实心",
            },
            {
                classList: "layui-icon layui-icon-heart",
                name: "空心",
            },
            {
                classList: "layui-icon layui-icon-light",
                name: "亮度/晴",
            },
            {
                classList: "layui-icon layui-icon-time",
                name: "时间/历史",
            },
            {
                classList: "layui-icon layui-icon-bluetooth",
                name: "蓝牙",
            },
            {
                classList: "layui-icon layui-icon-at",
                name: "@艾特",
            },
            {
                classList: "layui-icon layui-icon-mute",
                name: "静音",
            },
            {
                classList: "layui-icon layui-icon-mike",
                name: "录音/麦克风",
            },
            {
                classList: "layui-icon layui-icon-key",
                name: "密钥/钥匙",
            },
            {
                classList: "layui-icon layui-icon-gift",
                name: "礼物/活动",
            },
            {
                classList: "layui-icon layui-icon-email",
                name: "邮箱",
            },
            {
                classList: "layui-icon layui-icon-rss",
                name: "RSS",
            },
            {
                classList: "layui-icon layui-icon-wifi",
                name: "WiFi",
            },
            {
                classList: "layui-icon layui-icon-logout",
                name: "退出/注销",
            },
            {
                classList: "layui-icon layui-icon-android",
                name: "Android 安卓",
            },
            {
                classList: "layui-icon layui-icon-ios",
                name: "Apple IOS 苹果",
            },
            {
                classList: "layui-icon layui-icon-windows",
                name: "Windows",
            },
            {
                classList: "layui-icon layui-icon-transfer",
                name: "穿梭框",
            },
            {
                classList: "layui-icon layui-icon-service",
                name: "客服",
            },
            {
                classList: "layui-icon layui-icon-subtraction",
                name: "减",
            },
            {
                classList: "layui-icon layui-icon-addition",
                name: "加",
            },
            {
                classList: "layui-icon layui-icon-slider",
                name: "滑块",
            },
            {
                classList: "layui-icon layui-icon-print",
                name: "打印",
            },
            {
                classList: "layui-icon layui-icon-export",
                name: "导出",
            },
            {
                classList: "layui-icon layui-icon-cols",
                name: "列",
            },
            {
                classList: "layui-icon layui-icon-screen-restore",
                name: "退出全屏",
            },
            {
                classList: "layui-icon layui-icon-screen-full",
                name: "全屏",
            },
            {
                classList: "layui-icon layui-icon-rate-half",
                name: "半星",
            },
            {
                classList: "layui-icon layui-icon-rate",
                name: "星星-空心",
            },
            {
                classList: "layui-icon layui-icon-rate-solid",
                name: "星星-实心",
            },
            {
                classList: "layui-icon layui-icon-cellphone",
                name: "手机",
            },
            {
                classList: "layui-icon layui-icon-vercode",
                name: "验证码",
            },
            {
                classList: "layui-icon layui-icon-login-wechat",
                name: "微信",
            },
            {
                classList: "layui-icon layui-icon-login-qq",
                name: "QQ",
            },
            {
                classList: "layui-icon layui-icon-login-weibo",
                name: "微博",
            },
            {
                classList: "layui-icon layui-icon-password",
                name: "密码",
            },
            {
                classList: "layui-icon layui-icon-username",
                name: "用户名",
            },
            {
                classList: "layui-icon layui-icon-refresh-3",
                name: "刷新-粗",
            },
            {
                classList: "layui-icon layui-icon-auz",
                name: "授权",
            },
            {
                classList: "layui-icon layui-icon-spread-left",
                name: "左向右伸缩菜单",
            },
            {
                classList: "layui-icon layui-icon-shrink-right",
                name: "右向左伸缩菜单",
            },
            {
                classList: "layui-icon layui-icon-snowflake",
                name: "雪花",
            },
            {
                classList: "layui-icon layui-icon-tips",
                name: "提示说明",
            },
            {
                classList: "layui-icon layui-icon-note",
                name: "便签",
            },
            {
                classList: "layui-icon layui-icon-home",
                name: "主页",
            },
            {
                classList: "layui-icon layui-icon-senior",
                name: "高级",
            },
            {
                classList: "layui-icon layui-icon-refresh",
                name: "刷新",
            },
            {
                classList: "layui-icon layui-icon-refresh-1",
                name: "刷新",
            },
            {
                classList: "layui-icon layui-icon-flag",
                name: "旗帜",
            },
            {
                classList: "layui-icon layui-icon-theme",
                name: "主题",
            },
            {
                classList: "layui-icon layui-icon-notice",
                name: "消息-通知",
            },
            {
                classList: "layui-icon layui-icon-website",
                name: "网站",
            },
            {
                classList: "layui-icon layui-icon-console",
                name: "控制台",
            },
            {
                classList: "layui-icon layui-icon-face-surprised",
                name: "表情-惊讶",
            },
            {
                classList: "layui-icon layui-icon-set",
                name: "设置-空心",
            },
            {
                classList: "layui-icon layui-icon-template-1",
                name: "模板",
            },
            {
                classList: "layui-icon layui-icon-app",
                name: "应用",
            },
            {
                classList: "layui-icon layui-icon-template",
                name: "模板",
            },
            {
                classList: "layui-icon layui-icon-praise",
                name: "赞",
            },
            {
                classList: "layui-icon layui-icon-tread",
                name: "踩",
            },
            {
                classList: "layui-icon layui-icon-male",
                name: "男",
            },
            {
                classList: "layui-icon layui-icon-female",
                name: "女",
            },
            {
                classList: "layui-icon layui-icon-camera",
                name: "相机-空心",
            },
            {
                classList: "layui-icon layui-icon-camera-fill",
                name: "相机-实心",
            },
            {
                classList: "layui-icon layui-icon-more",
                name: "菜单-水平",
            },
            {
                classList: "layui-icon layui-icon-more-vertical",
                name: "菜单-垂直",
            },
            {
                classList: "layui-icon layui-icon-rmb",
                name: "金额-人民币",
            },
            {
                classList: "layui-icon layui-icon-dollar",
                name: "金额-美元",
            },
            {
                classList: "layui-icon layui-icon-diamond",
                name: "钻石-等级",
            },
            {
                classList: "layui-icon layui-icon-fire",
                name: "火",
            },
            {
                classList: "layui-icon layui-icon-return",
                name: "返回",
            },
            {
                classList: "layui-icon layui-icon-location",
                name: "位置-地图",
            },
            {
                classList: "layui-icon layui-icon-read",
                name: "办公-阅读",
            },
            {
                classList: "layui-icon layui-icon-survey",
                name: "调查",
            },
            {
                classList: "layui-icon layui-icon-face-smile",
                name: "表情-微笑",
            },
            {
                classList: "layui-icon layui-icon-face-cry",
                name: "表情-哭泣",
            },
            {
                classList: "layui-icon layui-icon-cart-simple",
                name: "购物车",
            },
            {
                classList: "layui-icon layui-icon-cart",
                name: "购物车",
            },
            {
                classList: "layui-icon layui-icon-next",
                name: "下一页",
            },
            {
                classList: "layui-icon layui-icon-prev",
                name: "上一页",
            },
            {
                classList: "layui-icon layui-icon-upload-drag",
                name: "上传-空心-拖拽",
            },
            {
                classList: "layui-icon layui-icon-upload",
                name: "上传-实心",
            },
            {
                classList: "layui-icon layui-icon-download-circle",
                name: "下载-圆圈",
            },
            {
                classList: "layui-icon layui-icon-component",
                name: "组件",
            },
            {
                classList: "layui-icon layui-icon-file-b",
                name: "文件-粗",
            },
            {
                classList: "layui-icon layui-icon-user",
                name: "用户",
            },
            {
                classList: "layui-icon layui-icon-find-fill",
                name: "发现-实心",
            },
            {
                classList: "layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop",
                name: "loading",
            },
            {
                classList: "layui-icon layui-icon-loading-1 layui-anim layui-anim-rotate layui-anim-loop",
                name: "loading",
            },
            {
                classList: "layui-icon layui-icon-add-1",
                name: "添加",
            },
            {
                classList: "layui-icon layui-icon-play",
                name: "播放",
            },
            {
                classList: "layui-icon layui-icon-pause",
                name: "暂停",
            },
            {
                classList: "layui-icon layui-icon-headset",
                name: "音频-耳机",
            },
            {
                classList: "layui-icon layui-icon-video",
                name: "视频",
            },
            {
                classList: "layui-icon layui-icon-voice",
                name: "语音-声音",
            },
            {
                classList: "layui-icon layui-icon-speaker",
                name: "消息-通知-喇叭",
            },
            {
                classList: "layui-icon layui-icon-fonts-del",
                name: "删除线",
            },
            {
                classList: "layui-icon layui-icon-fonts-code",
                name: "代码",
            },
            {
                classList: "layui-icon layui-icon-fonts-html",
                name: "HTML",
            },
            {
                classList: "layui-icon layui-icon-fonts-strong",
                name: "字体加粗",
            },
            {
                classList: "layui-icon layui-icon-unlink",
                name: "删除链接",
            },
            {
                classList: "layui-icon layui-icon-picture",
                name: "图片",
            },
            {
                classList: "layui-icon layui-icon-link",
                name: "链接",
            },
            {
                classList: "layui-icon layui-icon-face-smile-b",
                name: "表情-笑-粗",
            },
            {
                classList: "layui-icon layui-icon-align-left",
                name: "左对齐",
            },
            {
                classList: "layui-icon layui-icon-align-right",
                name: "右对齐",
            },
            {
                classList: "layui-icon layui-icon-align-center",
                name: "居中对齐",
            },
            {
                classList: "layui-icon layui-icon-fonts-u",
                name: "字体-下划线",
            },
            {
                classList: "layui-icon layui-icon-fonts-i",
                name: "字体-斜体",
            },
            {
                classList: "layui-icon layui-icon-tabs",
                name: "Tabs 选项卡",
            },
            {
                classList: "layui-icon layui-icon-radio",
                name: "单选框-选中",
            },
            {
                classList: "layui-icon layui-icon-circle",
                name: "单选框-候选",
            },
            {
                classList: "layui-icon layui-icon-edit",
                name: "编辑",
            },
            {
                classList: "layui-icon layui-icon-share",
                name: "分享",
            },
            {
                classList: "layui-icon layui-icon-delete",
                name: "删除",
            },
            {
                classList: "layui-icon layui-icon-form",
                name: "表单",
            },
            {
                classList: "layui-icon layui-icon-cellphone-fine",
                name: "手机-细体",
            },
            {
                classList: "layui-icon layui-icon-dialogue",
                name: "聊天 对话 沟通",
            },
            {
                classList: "layui-icon layui-icon-fonts-clear",
                name: "文字格式化",
            },
            {
                classList: "layui-icon layui-icon-layer",
                name: "窗口",
            },
            {
                classList: "layui-icon layui-icon-date",
                name: "日期",
            },
            {
                classList: "layui-icon layui-icon-water",
                name: "水 下雨",
            },
            {
                classList: "layui-icon layui-icon-code-circle",
                name: "代码-圆圈",
            },
            {
                classList: "layui-icon layui-icon-carousel",
                name: "轮播组图",
            },
            {
                classList: "layui-icon layui-icon-prev-circle",
                name: "翻页",
            },
            {
                classList: "layui-icon layui-icon-layouts",
                name: "布局",
            },
            {
                classList: "layui-icon layui-icon-util",
                name: "工具",
            },
            {
                classList: "layui-icon layui-icon-templeate-1",
                name: "选择模板",
            },
            {
                classList: "layui-icon layui-icon-upload-circle",
                name: "上传-圆圈",
            },
            {
                classList: "layui-icon layui-icon-tree",
                name: "树",
            },
            {
                classList: "layui-icon layui-icon-table",
                name: "表格",
            },
            {
                classList: "layui-icon layui-icon-chart",
                name: "图表",
            },
            {
                classList: "layui-icon layui-icon-chart-screen",
                name: "图标 报表 屏幕",
            },
            {
                classList: "layui-icon layui-icon-engine",
                name: "引擎",
            },
            {
                classList: "layui-icon layui-icon-triangle-d",
                name: "下三角",
            },
            {
                classList: "layui-icon layui-icon-triangle-r",
                name: "右三角",
            },
            {
                classList: "layui-icon layui-icon-file",
                name: "文件",
            },
            {
                classList: "layui-icon layui-icon-set-sm",
                name: "设置-小型",
            },
            {
                classList: "layui-icon layui-icon-reduce-circle",
                name: "减少-圆圈",
            },
            {
                classList: "layui-icon layui-icon-add-circle",
                name: "添加-圆圈",
            },
            {
                classList: "layui-icon layui-icon-404",
                name: "404",
            },
            {
                classList: "layui-icon layui-icon-about",
                name: "关于",
            },
            {
                classList: "layui-icon layui-icon-up",
                name: "箭头 向上",
            },
            {
                classList: "layui-icon layui-icon-down",
                name: "箭头 向下",
            },
            {
                classList: "layui-icon layui-icon-left",
                name: "箭头 向左",
            },
            {
                classList: "layui-icon layui-icon-right",
                name: "箭头 向右",
            },
            {
                classList: "layui-icon layui-icon-circle-dot",
                name: "圆点",
            },
            {
                classList: "layui-icon layui-icon-search",
                name: "搜索",
            },
            {
                classList: "layui-icon layui-icon-set-fill",
                name: "设置-实心",
            },
            {
                classList: "layui-icon layui-icon-group",
                name: "群组",
            },
            {
                classList: "layui-icon layui-icon-friends",
                name: "好友",
            },
            {
                classList: "layui-icon layui-icon-reply-fill",
                name: "回复 评论 实心",
            },
            {
                classList: "layui-icon layui-icon-menu-fill",
                name: "菜单 隐身 实心",
            },
            {
                classList: "layui-icon layui-icon-log",
                name: "记录",
            },
            {
                classList: "layui-icon layui-icon-picture-fine",
                name: "图片-细体",
            },
            {
                classList: "layui-icon layui-icon-face-smile-fine",
                name: "表情-笑-细体",
            },
            {
                classList: "layui-icon layui-icon-list",
                name: "列表",
            },
            {
                classList: "layui-icon layui-icon-release",
                name: "发布 纸飞机",
            },
            {
                classList: "layui-icon layui-icon-ok",
                name: "对 OK",
            },
            {
                classList: "layui-icon layui-icon-help",
                name: "帮助",
            },
            {
                classList: "layui-icon layui-icon-chat",
                name: "客服",
            },
            {
                classList: "layui-icon layui-icon-top",
                name: "top 置顶",
            },
            {
                classList: "layui-icon layui-icon-star",
                name: "收藏-空心",
            },
            {
                classList: "layui-icon layui-icon-star-fill",
                name: "收藏-实心",
            },
            {
                classList: "layui-icon layui-icon-close-fill",
                name: "关闭-实心",
            },
            {
                classList: "layui-icon layui-icon-close",
                name: "关闭-空心",
            },
            {
                classList: "layui-icon layui-icon-ok-circle",
                name: "正确",
            },
            {
                classList: "layui-icon layui-icon-add-circle-fine",
                name: "添加-圆圈-细体",
            },
        ],
        // fontAwesome4 中文网：http://www.fontawesome.com.cn/
        // 图标发布页面：http://www.fontawesome.com.cn/faicons/
        // 脚本学习：scripts/fontAwesome4.js
        fontAwesome4: [
            {
                classList: "fa fa-address-book",
                name: "address-book",
            },
            {
                classList: "fa fa-address-book-o",
                name: "address-book-o",
            },
            {
                classList: "fa fa-address-card",
                name: "address-card",
            },
            {
                classList: "fa fa-address-card-o",
                name: "address-card-o",
            },
            {
                classList: "fa fa-bandcamp",
                name: "bandcamp",
            },
            {
                classList: "fa fa-bath",
                name: "bath",
            },
            {
                classList: "fa fa-bathtub",
                name: "bathtub (alias)",
            },
            {
                classList: "fa fa-drivers-license",
                name: "drivers-license (alias)",
            },
            {
                classList: "fa fa-drivers-license-o",
                name: "drivers-license-o (alias)",
            },
            {
                classList: "fa fa-eercast",
                name: "eercast",
            },
            {
                classList: "fa fa-envelope-open",
                name: "envelope-open",
            },
            {
                classList: "fa fa-envelope-open-o",
                name: "envelope-open-o",
            },
            {
                classList: "fa fa-etsy",
                name: "etsy",
            },
            {
                classList: "fa fa-free-code-camp",
                name: "free-code-camp",
            },
            {
                classList: "fa fa-grav",
                name: "grav",
            },
            {
                classList: "fa fa-handshake-o",
                name: "handshake-o",
            },
            {
                classList: "fa fa-id-badge",
                name: "id-badge",
            },
            {
                classList: "fa fa-id-card",
                name: "id-card",
            },
            {
                classList: "fa fa-id-card-o",
                name: "id-card-o",
            },
            {
                classList: "fa fa-imdb",
                name: "imdb",
            },
            {
                classList: "fa fa-linode",
                name: "linode",
            },
            {
                classList: "fa fa-meetup",
                name: "meetup",
            },
            {
                classList: "fa fa-microchip",
                name: "microchip",
            },
            {
                classList: "fa fa-podcast",
                name: "podcast",
            },
            {
                classList: "fa fa-quora",
                name: "quora",
            },
            {
                classList: "fa fa-ravelry",
                name: "ravelry",
            },
            {
                classList: "fa fa-s15",
                name: "s15 (alias)",
            },
            {
                classList: "fa fa-shower",
                name: "shower",
            },
            {
                classList: "fa fa-snowflake-o",
                name: "snowflake-o",
            },
            {
                classList: "fa fa-superpowers",
                name: "superpowers",
            },
            {
                classList: "fa fa-telegram",
                name: "telegram",
            },
            {
                classList: "fa fa-thermometer",
                name: "thermometer (alias)",
            },
            {
                classList: "fa fa-thermometer-0",
                name: "thermometer-0 (alias)",
            },
            {
                classList: "fa fa-thermometer-1",
                name: "thermometer-1 (alias)",
            },
            {
                classList: "fa fa-thermometer-2",
                name: "thermometer-2 (alias)",
            },
            {
                classList: "fa fa-thermometer-3",
                name: "thermometer-3 (alias)",
            },
            {
                classList: "fa fa-thermometer-4",
                name: "thermometer-4 (alias)",
            },
            {
                classList: "fa fa-thermometer-empty",
                name: "thermometer-empty",
            },
            {
                classList: "fa fa-thermometer-full",
                name: "thermometer-full",
            },
            {
                classList: "fa fa-thermometer-half",
                name: "thermometer-half",
            },
            {
                classList: "fa fa-thermometer-quarter",
                name: "thermometer-quarter",
            },
            {
                classList: "fa fa-thermometer-three-quarters",
                name: "thermometer-three-quarters",
            },
            {
                classList: "fa fa-times-rectangle",
                name: "times-rectangle (alias)",
            },
            {
                classList: "fa fa-times-rectangle-o",
                name: "times-rectangle-o (alias)",
            },
            {
                classList: "fa fa-user-circle",
                name: "user-circle",
            },
            {
                classList: "fa fa-user-circle-o",
                name: "user-circle-o",
            },
            {
                classList: "fa fa-user-o",
                name: "user-o",
            },
            {
                classList: "fa fa-vcard",
                name: "vcard (alias)",
            },
            {
                classList: "fa fa-vcard-o",
                name: "vcard-o (alias)",
            },
            {
                classList: "fa fa-window-close",
                name: "window-close",
            },
            {
                classList: "fa fa-window-close-o",
                name: "window-close-o",
            },
            {
                classList: "fa fa-window-maximize",
                name: "window-maximize",
            },
            {
                classList: "fa fa-window-minimize",
                name: "window-minimize",
            },
            {
                classList: "fa fa-window-restore",
                name: "window-restore",
            },
            {
                classList: "fa fa-wpexplorer",
                name: "wpexplorer",
            },
            {
                classList: "fa fa-address-book",
                name: "address-book",
            },
            {
                classList: "fa fa-address-book-o",
                name: "address-book-o",
            },
            {
                classList: "fa fa-address-card",
                name: "address-card",
            },
            {
                classList: "fa fa-address-card-o",
                name: "address-card-o",
            },
            {
                classList: "fa fa-adjust",
                name: "adjust",
            },
            {
                classList: "fa fa-american-sign-language-interpreting",
                name: "american-sign-language-interpreting",
            },
            {
                classList: "fa fa-anchor",
                name: "anchor",
            },
            {
                classList: "fa fa-archive",
                name: "archive",
            },
            {
                classList: "fa fa-area-chart",
                name: "area-chart",
            },
            {
                classList: "fa fa-arrows",
                name: "arrows",
            },
            {
                classList: "fa fa-arrows-h",
                name: "arrows-h",
            },
            {
                classList: "fa fa-arrows-v",
                name: "arrows-v",
            },
            {
                classList: "fa fa-asl-interpreting",
                name: "asl-interpreting (alias)",
            },
            {
                classList: "fa fa-assistive-listening-systems",
                name: "assistive-listening-systems",
            },
            {
                classList: "fa fa-asterisk",
                name: "asterisk",
            },
            {
                classList: "fa fa-at",
                name: "at",
            },
            {
                classList: "fa fa-audio-description",
                name: "audio-description",
            },
            {
                classList: "fa fa-automobile",
                name: "automobile (alias)",
            },
            {
                classList: "fa fa-balance-scale",
                name: "balance-scale",
            },
            {
                classList: "fa fa-ban",
                name: "ban",
            },
            {
                classList: "fa fa-bank",
                name: "bank (alias)",
            },
            {
                classList: "fa fa-bar-chart",
                name: "bar-chart",
            },
            {
                classList: "fa fa-bar-chart-o",
                name: "bar-chart-o (alias)",
            },
            {
                classList: "fa fa-barcode",
                name: "barcode",
            },
            {
                classList: "fa fa-bars",
                name: "bars",
            },
            {
                classList: "fa fa-bath",
                name: "bath",
            },
            {
                classList: "fa fa-bathtub",
                name: "bathtub (alias)",
            },
            {
                classList: "fa fa-battery",
                name: "battery (alias)",
            },
            {
                classList: "fa fa-battery-0",
                name: "battery-0 (alias)",
            },
            {
                classList: "fa fa-battery-1",
                name: "battery-1 (alias)",
            },
            {
                classList: "fa fa-battery-2",
                name: "battery-2 (alias)",
            },
            {
                classList: "fa fa-battery-3",
                name: "battery-3 (alias)",
            },
            {
                classList: "fa fa-battery-4",
                name: "battery-4 (alias)",
            },
            {
                classList: "fa fa-battery-empty",
                name: "battery-empty",
            },
            {
                classList: "fa fa-battery-full",
                name: "battery-full",
            },
            {
                classList: "fa fa-battery-half",
                name: "battery-half",
            },
            {
                classList: "fa fa-battery-quarter",
                name: "battery-quarter",
            },
            {
                classList: "fa fa-battery-three-quarters",
                name: "battery-three-quarters",
            },
            {
                classList: "fa fa-bed",
                name: "bed",
            },
            {
                classList: "fa fa-beer",
                name: "beer",
            },
            {
                classList: "fa fa-bell",
                name: "bell",
            },
            {
                classList: "fa fa-bell-o",
                name: "bell-o",
            },
            {
                classList: "fa fa-bell-slash",
                name: "bell-slash",
            },
            {
                classList: "fa fa-bell-slash-o",
                name: "bell-slash-o",
            },
            {
                classList: "fa fa-bicycle",
                name: "bicycle",
            },
            {
                classList: "fa fa-binoculars",
                name: "binoculars",
            },
            {
                classList: "fa fa-birthday-cake",
                name: "birthday-cake",
            },
            {
                classList: "fa fa-blind",
                name: "blind",
            },
            {
                classList: "fa fa-bluetooth",
                name: "bluetooth",
            },
            {
                classList: "fa fa-bluetooth-b",
                name: "bluetooth-b",
            },
            {
                classList: "fa fa-bolt",
                name: "bolt",
            },
            {
                classList: "fa fa-bomb",
                name: "bomb",
            },
            {
                classList: "fa fa-book",
                name: "book",
            },
            {
                classList: "fa fa-bookmark",
                name: "bookmark",
            },
            {
                classList: "fa fa-bookmark-o",
                name: "bookmark-o",
            },
            {
                classList: "fa fa-braille",
                name: "braille",
            },
            {
                classList: "fa fa-briefcase",
                name: "briefcase",
            },
            {
                classList: "fa fa-bug",
                name: "bug",
            },
            {
                classList: "fa fa-building",
                name: "building",
            },
            {
                classList: "fa fa-building-o",
                name: "building-o",
            },
            {
                classList: "fa fa-bullhorn",
                name: "bullhorn",
            },
            {
                classList: "fa fa-bullseye",
                name: "bullseye",
            },
            {
                classList: "fa fa-bus",
                name: "bus",
            },
            {
                classList: "fa fa-cab",
                name: "cab (alias)",
            },
            {
                classList: "fa fa-calculator",
                name: "calculator",
            },
            {
                classList: "fa fa-calendar",
                name: "calendar",
            },
            {
                classList: "fa fa-calendar-check-o",
                name: "calendar-check-o",
            },
            {
                classList: "fa fa-calendar-minus-o",
                name: "calendar-minus-o",
            },
            {
                classList: "fa fa-calendar-o",
                name: "calendar-o",
            },
            {
                classList: "fa fa-calendar-plus-o",
                name: "calendar-plus-o",
            },
            {
                classList: "fa fa-calendar-times-o",
                name: "calendar-times-o",
            },
            {
                classList: "fa fa-camera",
                name: "camera",
            },
            {
                classList: "fa fa-camera-retro",
                name: "camera-retro",
            },
            {
                classList: "fa fa-car",
                name: "car",
            },
            {
                classList: "fa fa-caret-square-o-down",
                name: "caret-square-o-down",
            },
            {
                classList: "fa fa-caret-square-o-left",
                name: "caret-square-o-left",
            },
            {
                classList: "fa fa-caret-square-o-right",
                name: "caret-square-o-right",
            },
            {
                classList: "fa fa-caret-square-o-up",
                name: "caret-square-o-up",
            },
            {
                classList: "fa fa-cart-arrow-down",
                name: "cart-arrow-down",
            },
            {
                classList: "fa fa-cart-plus",
                name: "cart-plus",
            },
            {
                classList: "fa fa-cc",
                name: "cc",
            },
            {
                classList: "fa fa-certificate",
                name: "certificate",
            },
            {
                classList: "fa fa-check",
                name: "check",
            },
            {
                classList: "fa fa-check-circle",
                name: "check-circle",
            },
            {
                classList: "fa fa-check-circle-o",
                name: "check-circle-o",
            },
            {
                classList: "fa fa-check-square",
                name: "check-square",
            },
            {
                classList: "fa fa-check-square-o",
                name: "check-square-o",
            },
            {
                classList: "fa fa-child",
                name: "child",
            },
            {
                classList: "fa fa-circle",
                name: "circle",
            },
            {
                classList: "fa fa-circle-o",
                name: "circle-o",
            },
            {
                classList: "fa fa-circle-o-notch",
                name: "circle-o-notch",
            },
            {
                classList: "fa fa-circle-thin",
                name: "circle-thin",
            },
            {
                classList: "fa fa-clock-o",
                name: "clock-o",
            },
            {
                classList: "fa fa-clone",
                name: "clone",
            },
            {
                classList: "fa fa-close",
                name: "close (alias)",
            },
            {
                classList: "fa fa-cloud",
                name: "cloud",
            },
            {
                classList: "fa fa-cloud-download",
                name: "cloud-download",
            },
            {
                classList: "fa fa-cloud-upload",
                name: "cloud-upload",
            },
            {
                classList: "fa fa-code",
                name: "code",
            },
            {
                classList: "fa fa-code-fork",
                name: "code-fork",
            },
            {
                classList: "fa fa-coffee",
                name: "coffee",
            },
            {
                classList: "fa fa-cog",
                name: "cog",
            },
            {
                classList: "fa fa-cogs",
                name: "cogs",
            },
            {
                classList: "fa fa-comment",
                name: "comment",
            },
            {
                classList: "fa fa-comment-o",
                name: "comment-o",
            },
            {
                classList: "fa fa-commenting",
                name: "commenting",
            },
            {
                classList: "fa fa-commenting-o",
                name: "commenting-o",
            },
            {
                classList: "fa fa-comments",
                name: "comments",
            },
            {
                classList: "fa fa-comments-o",
                name: "comments-o",
            },
            {
                classList: "fa fa-compass",
                name: "compass",
            },
            {
                classList: "fa fa-copyright",
                name: "copyright",
            },
            {
                classList: "fa fa-creative-commons",
                name: "creative-commons",
            },
            {
                classList: "fa fa-credit-card",
                name: "credit-card",
            },
            {
                classList: "fa fa-credit-card-alt",
                name: "credit-card-alt",
            },
            {
                classList: "fa fa-crop",
                name: "crop",
            },
            {
                classList: "fa fa-crosshairs",
                name: "crosshairs",
            },
            {
                classList: "fa fa-cube",
                name: "cube",
            },
            {
                classList: "fa fa-cubes",
                name: "cubes",
            },
            {
                classList: "fa fa-cutlery",
                name: "cutlery",
            },
            {
                classList: "fa fa-dashboard",
                name: "dashboard (alias)",
            },
            {
                classList: "fa fa-database",
                name: "database",
            },
            {
                classList: "fa fa-deaf",
                name: "deaf",
            },
            {
                classList: "fa fa-deafness",
                name: "deafness (alias)",
            },
            {
                classList: "fa fa-desktop",
                name: "desktop",
            },
            {
                classList: "fa fa-diamond",
                name: "diamond",
            },
            {
                classList: "fa fa-dot-circle-o",
                name: "dot-circle-o",
            },
            {
                classList: "fa fa-download",
                name: "download",
            },
            {
                classList: "fa fa-drivers-license",
                name: "drivers-license (alias)",
            },
            {
                classList: "fa fa-drivers-license-o",
                name: "drivers-license-o (alias)",
            },
            {
                classList: "fa fa-edit",
                name: "edit (alias)",
            },
            {
                classList: "fa fa-ellipsis-h",
                name: "ellipsis-h",
            },
            {
                classList: "fa fa-ellipsis-v",
                name: "ellipsis-v",
            },
            {
                classList: "fa fa-envelope",
                name: "envelope",
            },
            {
                classList: "fa fa-envelope-o",
                name: "envelope-o",
            },
            {
                classList: "fa fa-envelope-open",
                name: "envelope-open",
            },
            {
                classList: "fa fa-envelope-open-o",
                name: "envelope-open-o",
            },
            {
                classList: "fa fa-envelope-square",
                name: "envelope-square",
            },
            {
                classList: "fa fa-eraser",
                name: "eraser",
            },
            {
                classList: "fa fa-exchange",
                name: "exchange",
            },
            {
                classList: "fa fa-exclamation",
                name: "exclamation",
            },
            {
                classList: "fa fa-exclamation-circle",
                name: "exclamation-circle",
            },
            {
                classList: "fa fa-exclamation-triangle",
                name: "exclamation-triangle",
            },
            {
                classList: "fa fa-external-link",
                name: "external-link",
            },
            {
                classList: "fa fa-external-link-square",
                name: "external-link-square",
            },
            {
                classList: "fa fa-eye",
                name: "eye",
            },
            {
                classList: "fa fa-eye-slash",
                name: "eye-slash",
            },
            {
                classList: "fa fa-eyedropper",
                name: "eyedropper",
            },
            {
                classList: "fa fa-fax",
                name: "fax",
            },
            {
                classList: "fa fa-feed",
                name: "feed (alias)",
            },
            {
                classList: "fa fa-female",
                name: "female",
            },
            {
                classList: "fa fa-fighter-jet",
                name: "fighter-jet",
            },
            {
                classList: "fa fa-file-archive-o",
                name: "file-archive-o",
            },
            {
                classList: "fa fa-file-audio-o",
                name: "file-audio-o",
            },
            {
                classList: "fa fa-file-code-o",
                name: "file-code-o",
            },
            {
                classList: "fa fa-file-excel-o",
                name: "file-excel-o",
            },
            {
                classList: "fa fa-file-image-o",
                name: "file-image-o",
            },
            {
                classList: "fa fa-file-movie-o",
                name: "file-movie-o (alias)",
            },
            {
                classList: "fa fa-file-pdf-o",
                name: "file-pdf-o",
            },
            {
                classList: "fa fa-file-photo-o",
                name: "file-photo-o (alias)",
            },
            {
                classList: "fa fa-file-picture-o",
                name: "file-picture-o (alias)",
            },
            {
                classList: "fa fa-file-powerpoint-o",
                name: "file-powerpoint-o",
            },
            {
                classList: "fa fa-file-sound-o",
                name: "file-sound-o (alias)",
            },
            {
                classList: "fa fa-file-video-o",
                name: "file-video-o",
            },
            {
                classList: "fa fa-file-word-o",
                name: "file-word-o",
            },
            {
                classList: "fa fa-file-zip-o",
                name: "file-zip-o (alias)",
            },
            {
                classList: "fa fa-film",
                name: "film",
            },
            {
                classList: "fa fa-filter",
                name: "filter",
            },
            {
                classList: "fa fa-fire",
                name: "fire",
            },
            {
                classList: "fa fa-fire-extinguisher",
                name: "fire-extinguisher",
            },
            {
                classList: "fa fa-flag",
                name: "flag",
            },
            {
                classList: "fa fa-flag-checkered",
                name: "flag-checkered",
            },
            {
                classList: "fa fa-flag-o",
                name: "flag-o",
            },
            {
                classList: "fa fa-flash",
                name: "flash (alias)",
            },
            {
                classList: "fa fa-flask",
                name: "flask",
            },
            {
                classList: "fa fa-folder",
                name: "folder",
            },
            {
                classList: "fa fa-folder-o",
                name: "folder-o",
            },
            {
                classList: "fa fa-folder-open",
                name: "folder-open",
            },
            {
                classList: "fa fa-folder-open-o",
                name: "folder-open-o",
            },
            {
                classList: "fa fa-frown-o",
                name: "frown-o",
            },
            {
                classList: "fa fa-futbol-o",
                name: "futbol-o",
            },
            {
                classList: "fa fa-gamepad",
                name: "gamepad",
            },
            {
                classList: "fa fa-gavel",
                name: "gavel",
            },
            {
                classList: "fa fa-gear",
                name: "gear (alias)",
            },
            {
                classList: "fa fa-gears",
                name: "gears (alias)",
            },
            {
                classList: "fa fa-gift",
                name: "gift",
            },
            {
                classList: "fa fa-glass",
                name: "glass",
            },
            {
                classList: "fa fa-globe",
                name: "globe",
            },
            {
                classList: "fa fa-graduation-cap",
                name: "graduation-cap",
            },
            {
                classList: "fa fa-group",
                name: "group (alias)",
            },
            {
                classList: "fa fa-hand-grab-o",
                name: "hand-grab-o (alias)",
            },
            {
                classList: "fa fa-hand-lizard-o",
                name: "hand-lizard-o",
            },
            {
                classList: "fa fa-hand-paper-o",
                name: "hand-paper-o",
            },
            {
                classList: "fa fa-hand-peace-o",
                name: "hand-peace-o",
            },
            {
                classList: "fa fa-hand-pointer-o",
                name: "hand-pointer-o",
            },
            {
                classList: "fa fa-hand-rock-o",
                name: "hand-rock-o",
            },
            {
                classList: "fa fa-hand-scissors-o",
                name: "hand-scissors-o",
            },
            {
                classList: "fa fa-hand-spock-o",
                name: "hand-spock-o",
            },
            {
                classList: "fa fa-hand-stop-o",
                name: "hand-stop-o (alias)",
            },
            {
                classList: "fa fa-handshake-o",
                name: "handshake-o",
            },
            {
                classList: "fa fa-hard-of-hearing",
                name: "hard-of-hearing (alias)",
            },
            {
                classList: "fa fa-hashtag",
                name: "hashtag",
            },
            {
                classList: "fa fa-hdd-o",
                name: "hdd-o",
            },
            {
                classList: "fa fa-headphones",
                name: "headphones",
            },
            {
                classList: "fa fa-heart",
                name: "heart",
            },
            {
                classList: "fa fa-heart-o",
                name: "heart-o",
            },
            {
                classList: "fa fa-heartbeat",
                name: "heartbeat",
            },
            {
                classList: "fa fa-history",
                name: "history",
            },
            {
                classList: "fa fa-home",
                name: "home",
            },
            {
                classList: "fa fa-hotel",
                name: "hotel (alias)",
            },
            {
                classList: "fa fa-hourglass",
                name: "hourglass",
            },
            {
                classList: "fa fa-hourglass-1",
                name: "hourglass-1 (alias)",
            },
            {
                classList: "fa fa-hourglass-2",
                name: "hourglass-2 (alias)",
            },
            {
                classList: "fa fa-hourglass-3",
                name: "hourglass-3 (alias)",
            },
            {
                classList: "fa fa-hourglass-end",
                name: "hourglass-end",
            },
            {
                classList: "fa fa-hourglass-half",
                name: "hourglass-half",
            },
            {
                classList: "fa fa-hourglass-o",
                name: "hourglass-o",
            },
            {
                classList: "fa fa-hourglass-start",
                name: "hourglass-start",
            },
            {
                classList: "fa fa-i-cursor",
                name: "i-cursor",
            },
            {
                classList: "fa fa-id-badge",
                name: "id-badge",
            },
            {
                classList: "fa fa-id-card",
                name: "id-card",
            },
            {
                classList: "fa fa-id-card-o",
                name: "id-card-o",
            },
            {
                classList: "fa fa-image",
                name: "image (alias)",
            },
            {
                classList: "fa fa-inbox",
                name: "inbox",
            },
            {
                classList: "fa fa-industry",
                name: "industry",
            },
            {
                classList: "fa fa-info",
                name: "info",
            },
            {
                classList: "fa fa-info-circle",
                name: "info-circle",
            },
            {
                classList: "fa fa-institution",
                name: "institution (alias)",
            },
            {
                classList: "fa fa-key",
                name: "key",
            },
            {
                classList: "fa fa-keyboard-o",
                name: "keyboard-o",
            },
            {
                classList: "fa fa-language",
                name: "language",
            },
            {
                classList: "fa fa-laptop",
                name: "laptop",
            },
            {
                classList: "fa fa-leaf",
                name: "leaf",
            },
            {
                classList: "fa fa-legal",
                name: "legal (alias)",
            },
            {
                classList: "fa fa-lemon-o",
                name: "lemon-o",
            },
            {
                classList: "fa fa-level-down",
                name: "level-down",
            },
            {
                classList: "fa fa-level-up",
                name: "level-up",
            },
            {
                classList: "fa fa-life-bouy",
                name: "life-bouy (alias)",
            },
            {
                classList: "fa fa-life-buoy",
                name: "life-buoy (alias)",
            },
            {
                classList: "fa fa-life-ring",
                name: "life-ring",
            },
            {
                classList: "fa fa-life-saver",
                name: "life-saver (alias)",
            },
            {
                classList: "fa fa-lightbulb-o",
                name: "lightbulb-o",
            },
            {
                classList: "fa fa-line-chart",
                name: "line-chart",
            },
            {
                classList: "fa fa-location-arrow",
                name: "location-arrow",
            },
            {
                classList: "fa fa-lock",
                name: "lock",
            },
            {
                classList: "fa fa-low-vision",
                name: "low-vision",
            },
            {
                classList: "fa fa-magic",
                name: "magic",
            },
            {
                classList: "fa fa-magnet",
                name: "magnet",
            },
            {
                classList: "fa fa-mail-forward",
                name: "mail-forward (alias)",
            },
            {
                classList: "fa fa-mail-reply",
                name: "mail-reply (alias)",
            },
            {
                classList: "fa fa-mail-reply-all",
                name: "mail-reply-all (alias)",
            },
            {
                classList: "fa fa-male",
                name: "male",
            },
            {
                classList: "fa fa-map",
                name: "map",
            },
            {
                classList: "fa fa-map-marker",
                name: "map-marker",
            },
            {
                classList: "fa fa-map-o",
                name: "map-o",
            },
            {
                classList: "fa fa-map-pin",
                name: "map-pin",
            },
            {
                classList: "fa fa-map-signs",
                name: "map-signs",
            },
            {
                classList: "fa fa-meh-o",
                name: "meh-o",
            },
            {
                classList: "fa fa-microchip",
                name: "microchip",
            },
            {
                classList: "fa fa-microphone",
                name: "microphone",
            },
            {
                classList: "fa fa-microphone-slash",
                name: "microphone-slash",
            },
            {
                classList: "fa fa-minus",
                name: "minus",
            },
            {
                classList: "fa fa-minus-circle",
                name: "minus-circle",
            },
            {
                classList: "fa fa-minus-square",
                name: "minus-square",
            },
            {
                classList: "fa fa-minus-square-o",
                name: "minus-square-o",
            },
            {
                classList: "fa fa-mobile",
                name: "mobile",
            },
            {
                classList: "fa fa-mobile-phone",
                name: "mobile-phone (alias)",
            },
            {
                classList: "fa fa-money",
                name: "money",
            },
            {
                classList: "fa fa-moon-o",
                name: "moon-o",
            },
            {
                classList: "fa fa-mortar-board",
                name: "mortar-board (alias)",
            },
            {
                classList: "fa fa-motorcycle",
                name: "motorcycle",
            },
            {
                classList: "fa fa-mouse-pointer",
                name: "mouse-pointer",
            },
            {
                classList: "fa fa-music",
                name: "music",
            },
            {
                classList: "fa fa-navicon",
                name: "navicon (alias)",
            },
            {
                classList: "fa fa-newspaper-o",
                name: "newspaper-o",
            },
            {
                classList: "fa fa-object-group",
                name: "object-group",
            },
            {
                classList: "fa fa-object-ungroup",
                name: "object-ungroup",
            },
            {
                classList: "fa fa-paint-brush",
                name: "paint-brush",
            },
            {
                classList: "fa fa-paper-plane",
                name: "paper-plane",
            },
            {
                classList: "fa fa-paper-plane-o",
                name: "paper-plane-o",
            },
            {
                classList: "fa fa-paw",
                name: "paw",
            },
            {
                classList: "fa fa-pencil",
                name: "pencil",
            },
            {
                classList: "fa fa-pencil-square",
                name: "pencil-square",
            },
            {
                classList: "fa fa-pencil-square-o",
                name: "pencil-square-o",
            },
            {
                classList: "fa fa-percent",
                name: "percent",
            },
            {
                classList: "fa fa-phone",
                name: "phone",
            },
            {
                classList: "fa fa-phone-square",
                name: "phone-square",
            },
            {
                classList: "fa fa-photo",
                name: "photo (alias)",
            },
            {
                classList: "fa fa-picture-o",
                name: "picture-o",
            },
            {
                classList: "fa fa-pie-chart",
                name: "pie-chart",
            },
            {
                classList: "fa fa-plane",
                name: "plane",
            },
            {
                classList: "fa fa-plug",
                name: "plug",
            },
            {
                classList: "fa fa-plus",
                name: "plus",
            },
            {
                classList: "fa fa-plus-circle",
                name: "plus-circle",
            },
            {
                classList: "fa fa-plus-square",
                name: "plus-square",
            },
            {
                classList: "fa fa-plus-square-o",
                name: "plus-square-o",
            },
            {
                classList: "fa fa-podcast",
                name: "podcast",
            },
            {
                classList: "fa fa-power-off",
                name: "power-off",
            },
            {
                classList: "fa fa-print",
                name: "print",
            },
            {
                classList: "fa fa-puzzle-piece",
                name: "puzzle-piece",
            },
            {
                classList: "fa fa-qrcode",
                name: "qrcode",
            },
            {
                classList: "fa fa-question",
                name: "question",
            },
            {
                classList: "fa fa-question-circle",
                name: "question-circle",
            },
            {
                classList: "fa fa-question-circle-o",
                name: "question-circle-o",
            },
            {
                classList: "fa fa-quote-left",
                name: "quote-left",
            },
            {
                classList: "fa fa-quote-right",
                name: "quote-right",
            },
            {
                classList: "fa fa-random",
                name: "random",
            },
            {
                classList: "fa fa-recycle",
                name: "recycle",
            },
            {
                classList: "fa fa-refresh",
                name: "refresh",
            },
            {
                classList: "fa fa-registered",
                name: "registered",
            },
            {
                classList: "fa fa-remove",
                name: "remove (alias)",
            },
            {
                classList: "fa fa-reorder",
                name: "reorder (alias)",
            },
            {
                classList: "fa fa-reply",
                name: "reply",
            },
            {
                classList: "fa fa-reply-all",
                name: "reply-all",
            },
            {
                classList: "fa fa-retweet",
                name: "retweet",
            },
            {
                classList: "fa fa-road",
                name: "road",
            },
            {
                classList: "fa fa-rocket",
                name: "rocket",
            },
            {
                classList: "fa fa-rss",
                name: "rss",
            },
            {
                classList: "fa fa-rss-square",
                name: "rss-square",
            },
            {
                classList: "fa fa-s15",
                name: "s15 (alias)",
            },
            {
                classList: "fa fa-search",
                name: "search",
            },
            {
                classList: "fa fa-search-minus",
                name: "search-minus",
            },
            {
                classList: "fa fa-search-plus",
                name: "search-plus",
            },
            {
                classList: "fa fa-send",
                name: "send (alias)",
            },
            {
                classList: "fa fa-send-o",
                name: "send-o (alias)",
            },
            {
                classList: "fa fa-server",
                name: "server",
            },
            {
                classList: "fa fa-share",
                name: "share",
            },
            {
                classList: "fa fa-share-alt",
                name: "share-alt",
            },
            {
                classList: "fa fa-share-alt-square",
                name: "share-alt-square",
            },
            {
                classList: "fa fa-share-square",
                name: "share-square",
            },
            {
                classList: "fa fa-share-square-o",
                name: "share-square-o",
            },
            {
                classList: "fa fa-shield",
                name: "shield",
            },
            {
                classList: "fa fa-ship",
                name: "ship",
            },
            {
                classList: "fa fa-shopping-bag",
                name: "shopping-bag",
            },
            {
                classList: "fa fa-shopping-basket",
                name: "shopping-basket",
            },
            {
                classList: "fa fa-shopping-cart",
                name: "shopping-cart",
            },
            {
                classList: "fa fa-shower",
                name: "shower",
            },
            {
                classList: "fa fa-sign-in",
                name: "sign-in",
            },
            {
                classList: "fa fa-sign-language",
                name: "sign-language",
            },
            {
                classList: "fa fa-sign-out",
                name: "sign-out",
            },
            {
                classList: "fa fa-signal",
                name: "signal",
            },
            {
                classList: "fa fa-signing",
                name: "signing (alias)",
            },
            {
                classList: "fa fa-sitemap",
                name: "sitemap",
            },
            {
                classList: "fa fa-sliders",
                name: "sliders",
            },
            {
                classList: "fa fa-smile-o",
                name: "smile-o",
            },
            {
                classList: "fa fa-snowflake-o",
                name: "snowflake-o",
            },
            {
                classList: "fa fa-soccer-ball-o",
                name: "soccer-ball-o (alias)",
            },
            {
                classList: "fa fa-sort",
                name: "sort",
            },
            {
                classList: "fa fa-sort-alpha-asc",
                name: "sort-alpha-asc",
            },
            {
                classList: "fa fa-sort-alpha-desc",
                name: "sort-alpha-desc",
            },
            {
                classList: "fa fa-sort-amount-asc",
                name: "sort-amount-asc",
            },
            {
                classList: "fa fa-sort-amount-desc",
                name: "sort-amount-desc",
            },
            {
                classList: "fa fa-sort-asc",
                name: "sort-asc",
            },
            {
                classList: "fa fa-sort-desc",
                name: "sort-desc",
            },
            {
                classList: "fa fa-sort-down",
                name: "sort-down (alias)",
            },
            {
                classList: "fa fa-sort-numeric-asc",
                name: "sort-numeric-asc",
            },
            {
                classList: "fa fa-sort-numeric-desc",
                name: "sort-numeric-desc",
            },
            {
                classList: "fa fa-sort-up",
                name: "sort-up (alias)",
            },
            {
                classList: "fa fa-space-shuttle",
                name: "space-shuttle",
            },
            {
                classList: "fa fa-spinner",
                name: "spinner",
            },
            {
                classList: "fa fa-spoon",
                name: "spoon",
            },
            {
                classList: "fa fa-square",
                name: "square",
            },
            {
                classList: "fa fa-square-o",
                name: "square-o",
            },
            {
                classList: "fa fa-star",
                name: "star",
            },
            {
                classList: "fa fa-star-half",
                name: "star-half",
            },
            {
                classList: "fa fa-star-half-empty",
                name: "star-half-empty (alias)",
            },
            {
                classList: "fa fa-star-half-full",
                name: "star-half-full (alias)",
            },
            {
                classList: "fa fa-star-half-o",
                name: "star-half-o",
            },
            {
                classList: "fa fa-star-o",
                name: "star-o",
            },
            {
                classList: "fa fa-sticky-note",
                name: "sticky-note",
            },
            {
                classList: "fa fa-sticky-note-o",
                name: "sticky-note-o",
            },
            {
                classList: "fa fa-street-view",
                name: "street-view",
            },
            {
                classList: "fa fa-suitcase",
                name: "suitcase",
            },
            {
                classList: "fa fa-sun-o",
                name: "sun-o",
            },
            {
                classList: "fa fa-support",
                name: "support (alias)",
            },
            {
                classList: "fa fa-tablet",
                name: "tablet",
            },
            {
                classList: "fa fa-tachometer",
                name: "tachometer",
            },
            {
                classList: "fa fa-tag",
                name: "tag",
            },
            {
                classList: "fa fa-tags",
                name: "tags",
            },
            {
                classList: "fa fa-tasks",
                name: "tasks",
            },
            {
                classList: "fa fa-taxi",
                name: "taxi",
            },
            {
                classList: "fa fa-television",
                name: "television",
            },
            {
                classList: "fa fa-terminal",
                name: "terminal",
            },
            {
                classList: "fa fa-thermometer",
                name: "thermometer (alias)",
            },
            {
                classList: "fa fa-thermometer-0",
                name: "thermometer-0 (alias)",
            },
            {
                classList: "fa fa-thermometer-1",
                name: "thermometer-1 (alias)",
            },
            {
                classList: "fa fa-thermometer-2",
                name: "thermometer-2 (alias)",
            },
            {
                classList: "fa fa-thermometer-3",
                name: "thermometer-3 (alias)",
            },
            {
                classList: "fa fa-thermometer-4",
                name: "thermometer-4 (alias)",
            },
            {
                classList: "fa fa-thermometer-empty",
                name: "thermometer-empty",
            },
            {
                classList: "fa fa-thermometer-full",
                name: "thermometer-full",
            },
            {
                classList: "fa fa-thermometer-half",
                name: "thermometer-half",
            },
            {
                classList: "fa fa-thermometer-quarter",
                name: "thermometer-quarter",
            },
            {
                classList: "fa fa-thermometer-three-quarters",
                name: "thermometer-three-quarters",
            },
            {
                classList: "fa fa-thumb-tack",
                name: "thumb-tack",
            },
            {
                classList: "fa fa-thumbs-down",
                name: "thumbs-down",
            },
            {
                classList: "fa fa-thumbs-o-down",
                name: "thumbs-o-down",
            },
            {
                classList: "fa fa-thumbs-o-up",
                name: "thumbs-o-up",
            },
            {
                classList: "fa fa-thumbs-up",
                name: "thumbs-up",
            },
            {
                classList: "fa fa-ticket",
                name: "ticket",
            },
            {
                classList: "fa fa-times",
                name: "times",
            },
            {
                classList: "fa fa-times-circle",
                name: "times-circle",
            },
            {
                classList: "fa fa-times-circle-o",
                name: "times-circle-o",
            },
            {
                classList: "fa fa-times-rectangle",
                name: "times-rectangle (alias)",
            },
            {
                classList: "fa fa-times-rectangle-o",
                name: "times-rectangle-o (alias)",
            },
            {
                classList: "fa fa-tint",
                name: "tint",
            },
            {
                classList: "fa fa-toggle-down",
                name: "toggle-down (alias)",
            },
            {
                classList: "fa fa-toggle-left",
                name: "toggle-left (alias)",
            },
            {
                classList: "fa fa-toggle-off",
                name: "toggle-off",
            },
            {
                classList: "fa fa-toggle-on",
                name: "toggle-on",
            },
            {
                classList: "fa fa-toggle-right",
                name: "toggle-right (alias)",
            },
            {
                classList: "fa fa-toggle-up",
                name: "toggle-up (alias)",
            },
            {
                classList: "fa fa-trademark",
                name: "trademark",
            },
            {
                classList: "fa fa-trash",
                name: "trash",
            },
            {
                classList: "fa fa-trash-o",
                name: "trash-o",
            },
            {
                classList: "fa fa-tree",
                name: "tree",
            },
            {
                classList: "fa fa-trophy",
                name: "trophy",
            },
            {
                classList: "fa fa-truck",
                name: "truck",
            },
            {
                classList: "fa fa-tty",
                name: "tty",
            },
            {
                classList: "fa fa-tv",
                name: "tv (alias)",
            },
            {
                classList: "fa fa-umbrella",
                name: "umbrella",
            },
            {
                classList: "fa fa-universal-access",
                name: "universal-access",
            },
            {
                classList: "fa fa-university",
                name: "university",
            },
            {
                classList: "fa fa-unlock",
                name: "unlock",
            },
            {
                classList: "fa fa-unlock-alt",
                name: "unlock-alt",
            },
            {
                classList: "fa fa-unsorted",
                name: "unsorted (alias)",
            },
            {
                classList: "fa fa-upload",
                name: "upload",
            },
            {
                classList: "fa fa-user",
                name: "user",
            },
            {
                classList: "fa fa-user-circle",
                name: "user-circle",
            },
            {
                classList: "fa fa-user-circle-o",
                name: "user-circle-o",
            },
            {
                classList: "fa fa-user-o",
                name: "user-o",
            },
            {
                classList: "fa fa-user-plus",
                name: "user-plus",
            },
            {
                classList: "fa fa-user-secret",
                name: "user-secret",
            },
            {
                classList: "fa fa-user-times",
                name: "user-times",
            },
            {
                classList: "fa fa-users",
                name: "users",
            },
            {
                classList: "fa fa-vcard",
                name: "vcard (alias)",
            },
            {
                classList: "fa fa-vcard-o",
                name: "vcard-o (alias)",
            },
            {
                classList: "fa fa-video-camera",
                name: "video-camera",
            },
            {
                classList: "fa fa-volume-control-phone",
                name: "volume-control-phone",
            },
            {
                classList: "fa fa-volume-down",
                name: "volume-down",
            },
            {
                classList: "fa fa-volume-off",
                name: "volume-off",
            },
            {
                classList: "fa fa-volume-up",
                name: "volume-up",
            },
            {
                classList: "fa fa-warning",
                name: "warning (alias)",
            },
            {
                classList: "fa fa-wheelchair",
                name: "wheelchair",
            },
            {
                classList: "fa fa-wheelchair-alt",
                name: "wheelchair-alt",
            },
            {
                classList: "fa fa-wifi",
                name: "wifi",
            },
            {
                classList: "fa fa-window-close",
                name: "window-close",
            },
            {
                classList: "fa fa-window-close-o",
                name: "window-close-o",
            },
            {
                classList: "fa fa-window-maximize",
                name: "window-maximize",
            },
            {
                classList: "fa fa-window-minimize",
                name: "window-minimize",
            },
            {
                classList: "fa fa-window-restore",
                name: "window-restore",
            },
            {
                classList: "fa fa-wrench",
                name: "wrench",
            },
            {
                classList: "fa fa-american-sign-language-interpreting",
                name: "american-sign-language-interpreting",
            },
            {
                classList: "fa fa-asl-interpreting",
                name: "asl-interpreting (alias)",
            },
            {
                classList: "fa fa-assistive-listening-systems",
                name: "assistive-listening-systems",
            },
            {
                classList: "fa fa-audio-description",
                name: "audio-description",
            },
            {
                classList: "fa fa-blind",
                name: "blind",
            },
            {
                classList: "fa fa-braille",
                name: "braille",
            },
            {
                classList: "fa fa-cc",
                name: "cc",
            },
            {
                classList: "fa fa-deaf",
                name: "deaf",
            },
            {
                classList: "fa fa-deafness",
                name: "deafness (alias)",
            },
            {
                classList: "fa fa-hard-of-hearing",
                name: "hard-of-hearing (alias)",
            },
            {
                classList: "fa fa-low-vision",
                name: "low-vision",
            },
            {
                classList: "fa fa-question-circle-o",
                name: "question-circle-o",
            },
            {
                classList: "fa fa-sign-language",
                name: "sign-language",
            },
            {
                classList: "fa fa-signing",
                name: "signing (alias)",
            },
            {
                classList: "fa fa-tty",
                name: "tty",
            },
            {
                classList: "fa fa-universal-access",
                name: "universal-access",
            },
            {
                classList: "fa fa-volume-control-phone",
                name: "volume-control-phone",
            },
            {
                classList: "fa fa-wheelchair",
                name: "wheelchair",
            },
            {
                classList: "fa fa-wheelchair-alt",
                name: "wheelchair-alt",
            },
            {
                classList: "fa fa-hand-grab-o",
                name: "hand-grab-o (alias)",
            },
            {
                classList: "fa fa-hand-lizard-o",
                name: "hand-lizard-o",
            },
            {
                classList: "fa fa-hand-o-down",
                name: "hand-o-down",
            },
            {
                classList: "fa fa-hand-o-left",
                name: "hand-o-left",
            },
            {
                classList: "fa fa-hand-o-right",
                name: "hand-o-right",
            },
            {
                classList: "fa fa-hand-o-up",
                name: "hand-o-up",
            },
            {
                classList: "fa fa-hand-paper-o",
                name: "hand-paper-o",
            },
            {
                classList: "fa fa-hand-peace-o",
                name: "hand-peace-o",
            },
            {
                classList: "fa fa-hand-pointer-o",
                name: "hand-pointer-o",
            },
            {
                classList: "fa fa-hand-rock-o",
                name: "hand-rock-o",
            },
            {
                classList: "fa fa-hand-scissors-o",
                name: "hand-scissors-o",
            },
            {
                classList: "fa fa-hand-spock-o",
                name: "hand-spock-o",
            },
            {
                classList: "fa fa-hand-stop-o",
                name: "hand-stop-o (alias)",
            },
            {
                classList: "fa fa-thumbs-down",
                name: "thumbs-down",
            },
            {
                classList: "fa fa-thumbs-o-down",
                name: "thumbs-o-down",
            },
            {
                classList: "fa fa-thumbs-o-up",
                name: "thumbs-o-up",
            },
            {
                classList: "fa fa-thumbs-up",
                name: "thumbs-up",
            },
            {
                classList: "fa fa-ambulance",
                name: "ambulance",
            },
            {
                classList: "fa fa-automobile",
                name: "automobile (alias)",
            },
            {
                classList: "fa fa-bicycle",
                name: "bicycle",
            },
            {
                classList: "fa fa-bus",
                name: "bus",
            },
            {
                classList: "fa fa-cab",
                name: "cab (alias)",
            },
            {
                classList: "fa fa-car",
                name: "car",
            },
            {
                classList: "fa fa-fighter-jet",
                name: "fighter-jet",
            },
            {
                classList: "fa fa-motorcycle",
                name: "motorcycle",
            },
            {
                classList: "fa fa-plane",
                name: "plane",
            },
            {
                classList: "fa fa-rocket",
                name: "rocket",
            },
            {
                classList: "fa fa-ship",
                name: "ship",
            },
            {
                classList: "fa fa-space-shuttle",
                name: "space-shuttle",
            },
            {
                classList: "fa fa-subway",
                name: "subway",
            },
            {
                classList: "fa fa-taxi",
                name: "taxi",
            },
            {
                classList: "fa fa-train",
                name: "train",
            },
            {
                classList: "fa fa-truck",
                name: "truck",
            },
            {
                classList: "fa fa-wheelchair",
                name: "wheelchair",
            },
            {
                classList: "fa fa-wheelchair-alt",
                name: "wheelchair-alt",
            },
            {
                classList: "fa fa-genderless",
                name: "genderless",
            },
            {
                classList: "fa fa-intersex",
                name: "intersex (alias)",
            },
            {
                classList: "fa fa-mars",
                name: "mars",
            },
            {
                classList: "fa fa-mars-double",
                name: "mars-double",
            },
            {
                classList: "fa fa-mars-stroke",
                name: "mars-stroke",
            },
            {
                classList: "fa fa-mars-stroke-h",
                name: "mars-stroke-h",
            },
            {
                classList: "fa fa-mars-stroke-v",
                name: "mars-stroke-v",
            },
            {
                classList: "fa fa-mercury",
                name: "mercury",
            },
            {
                classList: "fa fa-neuter",
                name: "neuter",
            },
            {
                classList: "fa fa-transgender",
                name: "transgender",
            },
            {
                classList: "fa fa-transgender-alt",
                name: "transgender-alt",
            },
            {
                classList: "fa fa-venus",
                name: "venus",
            },
            {
                classList: "fa fa-venus-double",
                name: "venus-double",
            },
            {
                classList: "fa fa-venus-mars",
                name: "venus-mars",
            },
            {
                classList: "fa fa-file",
                name: "file",
            },
            {
                classList: "fa fa-file-archive-o",
                name: "file-archive-o",
            },
            {
                classList: "fa fa-file-audio-o",
                name: "file-audio-o",
            },
            {
                classList: "fa fa-file-code-o",
                name: "file-code-o",
            },
            {
                classList: "fa fa-file-excel-o",
                name: "file-excel-o",
            },
            {
                classList: "fa fa-file-image-o",
                name: "file-image-o",
            },
            {
                classList: "fa fa-file-movie-o",
                name: "file-movie-o (alias)",
            },
            {
                classList: "fa fa-file-o",
                name: "file-o",
            },
            {
                classList: "fa fa-file-pdf-o",
                name: "file-pdf-o",
            },
            {
                classList: "fa fa-file-photo-o",
                name: "file-photo-o (alias)",
            },
            {
                classList: "fa fa-file-picture-o",
                name: "file-picture-o (alias)",
            },
            {
                classList: "fa fa-file-powerpoint-o",
                name: "file-powerpoint-o",
            },
            {
                classList: "fa fa-file-sound-o",
                name: "file-sound-o (alias)",
            },
            {
                classList: "fa fa-file-text",
                name: "file-text",
            },
            {
                classList: "fa fa-file-text-o",
                name: "file-text-o",
            },
            {
                classList: "fa fa-file-video-o",
                name: "file-video-o",
            },
            {
                classList: "fa fa-file-word-o",
                name: "file-word-o",
            },
            {
                classList: "fa fa-file-zip-o",
                name: "file-zip-o (alias)",
            },
            {
                classList: "fa fa-circle-o-notch",
                name: "circle-o-notch",
            },
            {
                classList: "fa fa-cog",
                name: "cog",
            },
            {
                classList: "fa fa-gear",
                name: "gear (alias)",
            },
            {
                classList: "fa fa-refresh",
                name: "refresh",
            },
            {
                classList: "fa fa-spinner",
                name: "spinner",
            },
            {
                classList: "fa fa-check-square",
                name: "check-square",
            },
            {
                classList: "fa fa-check-square-o",
                name: "check-square-o",
            },
            {
                classList: "fa fa-circle",
                name: "circle",
            },
            {
                classList: "fa fa-circle-o",
                name: "circle-o",
            },
            {
                classList: "fa fa-dot-circle-o",
                name: "dot-circle-o",
            },
            {
                classList: "fa fa-minus-square",
                name: "minus-square",
            },
            {
                classList: "fa fa-minus-square-o",
                name: "minus-square-o",
            },
            {
                classList: "fa fa-plus-square",
                name: "plus-square",
            },
            {
                classList: "fa fa-plus-square-o",
                name: "plus-square-o",
            },
            {
                classList: "fa fa-square",
                name: "square",
            },
            {
                classList: "fa fa-square-o",
                name: "square-o",
            },
            {
                classList: "fa fa-cc-amex",
                name: "cc-amex",
            },
            {
                classList: "fa fa-cc-diners-club",
                name: "cc-diners-club",
            },
            {
                classList: "fa fa-cc-discover",
                name: "cc-discover",
            },
            {
                classList: "fa fa-cc-jcb",
                name: "cc-jcb",
            },
            {
                classList: "fa fa-cc-mastercard",
                name: "cc-mastercard",
            },
            {
                classList: "fa fa-cc-paypal",
                name: "cc-paypal",
            },
            {
                classList: "fa fa-cc-stripe",
                name: "cc-stripe",
            },
            {
                classList: "fa fa-cc-visa",
                name: "cc-visa",
            },
            {
                classList: "fa fa-credit-card",
                name: "credit-card",
            },
            {
                classList: "fa fa-credit-card-alt",
                name: "credit-card-alt",
            },
            {
                classList: "fa fa-google-wallet",
                name: "google-wallet",
            },
            {
                classList: "fa fa-paypal",
                name: "paypal",
            },
            {
                classList: "fa fa-area-chart",
                name: "area-chart",
            },
            {
                classList: "fa fa-bar-chart",
                name: "bar-chart",
            },
            {
                classList: "fa fa-bar-chart-o",
                name: "bar-chart-o (alias)",
            },
            {
                classList: "fa fa-line-chart",
                name: "line-chart",
            },
            {
                classList: "fa fa-pie-chart",
                name: "pie-chart",
            },
            {
                classList: "fa fa-bitcoin",
                name: "bitcoin (alias)",
            },
            {
                classList: "fa fa-btc",
                name: "btc",
            },
            {
                classList: "fa fa-cny",
                name: "cny (alias)",
            },
            {
                classList: "fa fa-dollar",
                name: "dollar (alias)",
            },
            {
                classList: "fa fa-eur",
                name: "eur",
            },
            {
                classList: "fa fa-euro",
                name: "euro (alias)",
            },
            {
                classList: "fa fa-gbp",
                name: "gbp",
            },
            {
                classList: "fa fa-gg",
                name: "gg",
            },
            {
                classList: "fa fa-gg-circle",
                name: "gg-circle",
            },
            {
                classList: "fa fa-ils",
                name: "ils",
            },
            {
                classList: "fa fa-inr",
                name: "inr",
            },
            {
                classList: "fa fa-jpy",
                name: "jpy",
            },
            {
                classList: "fa fa-krw",
                name: "krw",
            },
            {
                classList: "fa fa-money",
                name: "money",
            },
            {
                classList: "fa fa-rmb",
                name: "rmb (alias)",
            },
            {
                classList: "fa fa-rouble",
                name: "rouble (alias)",
            },
            {
                classList: "fa fa-rub",
                name: "rub",
            },
            {
                classList: "fa fa-ruble",
                name: "ruble (alias)",
            },
            {
                classList: "fa fa-rupee",
                name: "rupee (alias)",
            },
            {
                classList: "fa fa-shekel",
                name: "shekel (alias)",
            },
            {
                classList: "fa fa-sheqel",
                name: "sheqel (alias)",
            },
            {
                classList: "fa fa-try",
                name: "try",
            },
            {
                classList: "fa fa-turkish-lira",
                name: "turkish-lira (alias)",
            },
            {
                classList: "fa fa-usd",
                name: "usd",
            },
            {
                classList: "fa fa-won",
                name: "won (alias)",
            },
            {
                classList: "fa fa-yen",
                name: "yen (alias)",
            },
            {
                classList: "fa fa-align-center",
                name: "align-center",
            },
            {
                classList: "fa fa-align-justify",
                name: "align-justify",
            },
            {
                classList: "fa fa-align-left",
                name: "align-left",
            },
            {
                classList: "fa fa-align-right",
                name: "align-right",
            },
            {
                classList: "fa fa-bold",
                name: "bold",
            },
            {
                classList: "fa fa-chain",
                name: "chain (alias)",
            },
            {
                classList: "fa fa-chain-broken",
                name: "chain-broken",
            },
            {
                classList: "fa fa-clipboard",
                name: "clipboard",
            },
            {
                classList: "fa fa-columns",
                name: "columns",
            },
            {
                classList: "fa fa-copy",
                name: "copy (alias)",
            },
            {
                classList: "fa fa-cut",
                name: "cut (alias)",
            },
            {
                classList: "fa fa-dedent",
                name: "dedent (alias)",
            },
            {
                classList: "fa fa-eraser",
                name: "eraser",
            },
            {
                classList: "fa fa-file",
                name: "file",
            },
            {
                classList: "fa fa-file-o",
                name: "file-o",
            },
            {
                classList: "fa fa-file-text",
                name: "file-text",
            },
            {
                classList: "fa fa-file-text-o",
                name: "file-text-o",
            },
            {
                classList: "fa fa-files-o",
                name: "files-o",
            },
            {
                classList: "fa fa-floppy-o",
                name: "floppy-o",
            },
            {
                classList: "fa fa-font",
                name: "font",
            },
            {
                classList: "fa fa-header",
                name: "header",
            },
            {
                classList: "fa fa-indent",
                name: "indent",
            },
            {
                classList: "fa fa-italic",
                name: "italic",
            },
            {
                classList: "fa fa-link",
                name: "link",
            },
            {
                classList: "fa fa-list",
                name: "list",
            },
            {
                classList: "fa fa-list-alt",
                name: "list-alt",
            },
            {
                classList: "fa fa-list-ol",
                name: "list-ol",
            },
            {
                classList: "fa fa-list-ul",
                name: "list-ul",
            },
            {
                classList: "fa fa-outdent",
                name: "outdent",
            },
            {
                classList: "fa fa-paperclip",
                name: "paperclip",
            },
            {
                classList: "fa fa-paragraph",
                name: "paragraph",
            },
            {
                classList: "fa fa-paste",
                name: "paste (alias)",
            },
            {
                classList: "fa fa-repeat",
                name: "repeat",
            },
            {
                classList: "fa fa-rotate-left",
                name: "rotate-left (alias)",
            },
            {
                classList: "fa fa-rotate-right",
                name: "rotate-right (alias)",
            },
            {
                classList: "fa fa-save",
                name: "save (alias)",
            },
            {
                classList: "fa fa-scissors",
                name: "scissors",
            },
            {
                classList: "fa fa-strikethrough",
                name: "strikethrough",
            },
            {
                classList: "fa fa-subscript",
                name: "subscript",
            },
            {
                classList: "fa fa-superscript",
                name: "superscript",
            },
            {
                classList: "fa fa-table",
                name: "table",
            },
            {
                classList: "fa fa-text-height",
                name: "text-height",
            },
            {
                classList: "fa fa-text-width",
                name: "text-width",
            },
            {
                classList: "fa fa-th",
                name: "th",
            },
            {
                classList: "fa fa-th-large",
                name: "th-large",
            },
            {
                classList: "fa fa-th-list",
                name: "th-list",
            },
            {
                classList: "fa fa-underline",
                name: "underline",
            },
            {
                classList: "fa fa-undo",
                name: "undo",
            },
            {
                classList: "fa fa-unlink",
                name: "unlink (alias)",
            },
            {
                classList: "fa fa-angle-double-down",
                name: "angle-double-down",
            },
            {
                classList: "fa fa-angle-double-left",
                name: "angle-double-left",
            },
            {
                classList: "fa fa-angle-double-right",
                name: "angle-double-right",
            },
            {
                classList: "fa fa-angle-double-up",
                name: "angle-double-up",
            },
            {
                classList: "fa fa-angle-down",
                name: "angle-down",
            },
            {
                classList: "fa fa-angle-left",
                name: "angle-left",
            },
            {
                classList: "fa fa-angle-right",
                name: "angle-right",
            },
            {
                classList: "fa fa-angle-up",
                name: "angle-up",
            },
            {
                classList: "fa fa-arrow-circle-down",
                name: "arrow-circle-down",
            },
            {
                classList: "fa fa-arrow-circle-left",
                name: "arrow-circle-left",
            },
            {
                classList: "fa fa-arrow-circle-o-down",
                name: "arrow-circle-o-down",
            },
            {
                classList: "fa fa-arrow-circle-o-left",
                name: "arrow-circle-o-left",
            },
            {
                classList: "fa fa-arrow-circle-o-right",
                name: "arrow-circle-o-right",
            },
            {
                classList: "fa fa-arrow-circle-o-up",
                name: "arrow-circle-o-up",
            },
            {
                classList: "fa fa-arrow-circle-right",
                name: "arrow-circle-right",
            },
            {
                classList: "fa fa-arrow-circle-up",
                name: "arrow-circle-up",
            },
            {
                classList: "fa fa-arrow-down",
                name: "arrow-down",
            },
            {
                classList: "fa fa-arrow-left",
                name: "arrow-left",
            },
            {
                classList: "fa fa-arrow-right",
                name: "arrow-right",
            },
            {
                classList: "fa fa-arrow-up",
                name: "arrow-up",
            },
            {
                classList: "fa fa-arrows",
                name: "arrows",
            },
            {
                classList: "fa fa-arrows-alt",
                name: "arrows-alt",
            },
            {
                classList: "fa fa-arrows-h",
                name: "arrows-h",
            },
            {
                classList: "fa fa-arrows-v",
                name: "arrows-v",
            },
            {
                classList: "fa fa-caret-down",
                name: "caret-down",
            },
            {
                classList: "fa fa-caret-left",
                name: "caret-left",
            },
            {
                classList: "fa fa-caret-right",
                name: "caret-right",
            },
            {
                classList: "fa fa-caret-square-o-down",
                name: "caret-square-o-down",
            },
            {
                classList: "fa fa-caret-square-o-left",
                name: "caret-square-o-left",
            },
            {
                classList: "fa fa-caret-square-o-right",
                name: "caret-square-o-right",
            },
            {
                classList: "fa fa-caret-square-o-up",
                name: "caret-square-o-up",
            },
            {
                classList: "fa fa-caret-up",
                name: "caret-up",
            },
            {
                classList: "fa fa-chevron-circle-down",
                name: "chevron-circle-down",
            },
            {
                classList: "fa fa-chevron-circle-left",
                name: "chevron-circle-left",
            },
            {
                classList: "fa fa-chevron-circle-right",
                name: "chevron-circle-right",
            },
            {
                classList: "fa fa-chevron-circle-up",
                name: "chevron-circle-up",
            },
            {
                classList: "fa fa-chevron-down",
                name: "chevron-down",
            },
            {
                classList: "fa fa-chevron-left",
                name: "chevron-left",
            },
            {
                classList: "fa fa-chevron-right",
                name: "chevron-right",
            },
            {
                classList: "fa fa-chevron-up",
                name: "chevron-up",
            },
            {
                classList: "fa fa-exchange",
                name: "exchange",
            },
            {
                classList: "fa fa-hand-o-down",
                name: "hand-o-down",
            },
            {
                classList: "fa fa-hand-o-left",
                name: "hand-o-left",
            },
            {
                classList: "fa fa-hand-o-right",
                name: "hand-o-right",
            },
            {
                classList: "fa fa-hand-o-up",
                name: "hand-o-up",
            },
            {
                classList: "fa fa-long-arrow-down",
                name: "long-arrow-down",
            },
            {
                classList: "fa fa-long-arrow-left",
                name: "long-arrow-left",
            },
            {
                classList: "fa fa-long-arrow-right",
                name: "long-arrow-right",
            },
            {
                classList: "fa fa-long-arrow-up",
                name: "long-arrow-up",
            },
            {
                classList: "fa fa-toggle-down",
                name: "toggle-down (alias)",
            },
            {
                classList: "fa fa-toggle-left",
                name: "toggle-left (alias)",
            },
            {
                classList: "fa fa-toggle-right",
                name: "toggle-right (alias)",
            },
            {
                classList: "fa fa-toggle-up",
                name: "toggle-up (alias)",
            },
            {
                classList: "fa fa-arrows-alt",
                name: "arrows-alt",
            },
            {
                classList: "fa fa-backward",
                name: "backward",
            },
            {
                classList: "fa fa-compress",
                name: "compress",
            },
            {
                classList: "fa fa-eject",
                name: "eject",
            },
            {
                classList: "fa fa-expand",
                name: "expand",
            },
            {
                classList: "fa fa-fast-backward",
                name: "fast-backward",
            },
            {
                classList: "fa fa-fast-forward",
                name: "fast-forward",
            },
            {
                classList: "fa fa-forward",
                name: "forward",
            },
            {
                classList: "fa fa-pause",
                name: "pause",
            },
            {
                classList: "fa fa-pause-circle",
                name: "pause-circle",
            },
            {
                classList: "fa fa-pause-circle-o",
                name: "pause-circle-o",
            },
            {
                classList: "fa fa-play",
                name: "play",
            },
            {
                classList: "fa fa-play-circle",
                name: "play-circle",
            },
            {
                classList: "fa fa-play-circle-o",
                name: "play-circle-o",
            },
            {
                classList: "fa fa-random",
                name: "random",
            },
            {
                classList: "fa fa-step-backward",
                name: "step-backward",
            },
            {
                classList: "fa fa-step-forward",
                name: "step-forward",
            },
            {
                classList: "fa fa-stop",
                name: "stop",
            },
            {
                classList: "fa fa-stop-circle",
                name: "stop-circle",
            },
            {
                classList: "fa fa-stop-circle-o",
                name: "stop-circle-o",
            },
            {
                classList: "fa fa-youtube-play",
                name: "youtube-play",
            },
            {
                classList: "fa fa-500px",
                name: "500px",
            },
            {
                classList: "fa fa-adn",
                name: "adn",
            },
            {
                classList: "fa fa-amazon",
                name: "amazon",
            },
            {
                classList: "fa fa-android",
                name: "android",
            },
            {
                classList: "fa fa-angellist",
                name: "angellist",
            },
            {
                classList: "fa fa-apple",
                name: "apple",
            },
            {
                classList: "fa fa-bandcamp",
                name: "bandcamp",
            },
            {
                classList: "fa fa-behance",
                name: "behance",
            },
            {
                classList: "fa fa-behance-square",
                name: "behance-square",
            },
            {
                classList: "fa fa-bitbucket",
                name: "bitbucket",
            },
            {
                classList: "fa fa-bitbucket-square",
                name: "bitbucket-square",
            },
            {
                classList: "fa fa-bitcoin",
                name: "bitcoin (alias)",
            },
            {
                classList: "fa fa-black-tie",
                name: "black-tie",
            },
            {
                classList: "fa fa-bluetooth",
                name: "bluetooth",
            },
            {
                classList: "fa fa-bluetooth-b",
                name: "bluetooth-b",
            },
            {
                classList: "fa fa-btc",
                name: "btc",
            },
            {
                classList: "fa fa-buysellads",
                name: "buysellads",
            },
            {
                classList: "fa fa-cc-amex",
                name: "cc-amex",
            },
            {
                classList: "fa fa-cc-diners-club",
                name: "cc-diners-club",
            },
            {
                classList: "fa fa-cc-discover",
                name: "cc-discover",
            },
            {
                classList: "fa fa-cc-jcb",
                name: "cc-jcb",
            },
            {
                classList: "fa fa-cc-mastercard",
                name: "cc-mastercard",
            },
            {
                classList: "fa fa-cc-paypal",
                name: "cc-paypal",
            },
            {
                classList: "fa fa-cc-stripe",
                name: "cc-stripe",
            },
            {
                classList: "fa fa-cc-visa",
                name: "cc-visa",
            },
            {
                classList: "fa fa-chrome",
                name: "chrome",
            },
            {
                classList: "fa fa-codepen",
                name: "codepen",
            },
            {
                classList: "fa fa-codiepie",
                name: "codiepie",
            },
            {
                classList: "fa fa-connectdevelop",
                name: "connectdevelop",
            },
            {
                classList: "fa fa-contao",
                name: "contao",
            },
            {
                classList: "fa fa-css3",
                name: "css3",
            },
            {
                classList: "fa fa-dashcube",
                name: "dashcube",
            },
            {
                classList: "fa fa-delicious",
                name: "delicious",
            },
            {
                classList: "fa fa-deviantart",
                name: "deviantart",
            },
            {
                classList: "fa fa-digg",
                name: "digg",
            },
            {
                classList: "fa fa-dribbble",
                name: "dribbble",
            },
            {
                classList: "fa fa-dropbox",
                name: "dropbox",
            },
            {
                classList: "fa fa-drupal",
                name: "drupal",
            },
            {
                classList: "fa fa-edge",
                name: "edge",
            },
            {
                classList: "fa fa-eercast",
                name: "eercast",
            },
            {
                classList: "fa fa-empire",
                name: "empire",
            },
            {
                classList: "fa fa-envira",
                name: "envira",
            },
            {
                classList: "fa fa-etsy",
                name: "etsy",
            },
            {
                classList: "fa fa-expeditedssl",
                name: "expeditedssl",
            },
            {
                classList: "fa fa-fa",
                name: "fa (alias)",
            },
            {
                classList: "fa fa-facebook",
                name: "facebook",
            },
            {
                classList: "fa fa-facebook-f",
                name: "facebook-f (alias)",
            },
            {
                classList: "fa fa-facebook-official",
                name: "facebook-official",
            },
            {
                classList: "fa fa-facebook-square",
                name: "facebook-square",
            },
            {
                classList: "fa fa-firefox",
                name: "firefox",
            },
            {
                classList: "fa fa-first-order",
                name: "first-order",
            },
            {
                classList: "fa fa-flickr",
                name: "flickr",
            },
            {
                classList: "fa fa-font-awesome",
                name: "font-awesome",
            },
            {
                classList: "fa fa-fonticons",
                name: "fonticons",
            },
            {
                classList: "fa fa-fort-awesome",
                name: "fort-awesome",
            },
            {
                classList: "fa fa-forumbee",
                name: "forumbee",
            },
            {
                classList: "fa fa-foursquare",
                name: "foursquare",
            },
            {
                classList: "fa fa-free-code-camp",
                name: "free-code-camp",
            },
            {
                classList: "fa fa-ge",
                name: "ge (alias)",
            },
            {
                classList: "fa fa-get-pocket",
                name: "get-pocket",
            },
            {
                classList: "fa fa-gg",
                name: "gg",
            },
            {
                classList: "fa fa-gg-circle",
                name: "gg-circle",
            },
            {
                classList: "fa fa-git",
                name: "git",
            },
            {
                classList: "fa fa-git-square",
                name: "git-square",
            },
            {
                classList: "fa fa-github",
                name: "github",
            },
            {
                classList: "fa fa-github-alt",
                name: "github-alt",
            },
            {
                classList: "fa fa-github-square",
                name: "github-square",
            },
            {
                classList: "fa fa-gitlab",
                name: "gitlab",
            },
            {
                classList: "fa fa-gittip",
                name: "gittip (alias)",
            },
            {
                classList: "fa fa-glide",
                name: "glide",
            },
            {
                classList: "fa fa-glide-g",
                name: "glide-g",
            },
            {
                classList: "fa fa-google",
                name: "google",
            },
            {
                classList: "fa fa-google-plus",
                name: "google-plus",
            },
            {
                classList: "fa fa-google-plus-circle",
                name: "google-plus-circle (alias)",
            },
            {
                classList: "fa fa-google-plus-official",
                name: "google-plus-official",
            },
            {
                classList: "fa fa-google-plus-square",
                name: "google-plus-square",
            },
            {
                classList: "fa fa-google-wallet",
                name: "google-wallet",
            },
            {
                classList: "fa fa-gratipay",
                name: "gratipay",
            },
            {
                classList: "fa fa-grav",
                name: "grav",
            },
            {
                classList: "fa fa-hacker-news",
                name: "hacker-news",
            },
            {
                classList: "fa fa-houzz",
                name: "houzz",
            },
            {
                classList: "fa fa-html5",
                name: "html5",
            },
            {
                classList: "fa fa-imdb",
                name: "imdb",
            },
            {
                classList: "fa fa-instagram",
                name: "instagram",
            },
            {
                classList: "fa fa-internet-explorer",
                name: "internet-explorer",
            },
            {
                classList: "fa fa-ioxhost",
                name: "ioxhost",
            },
            {
                classList: "fa fa-joomla",
                name: "joomla",
            },
            {
                classList: "fa fa-jsfiddle",
                name: "jsfiddle",
            },
            {
                classList: "fa fa-lastfm",
                name: "lastfm",
            },
            {
                classList: "fa fa-lastfm-square",
                name: "lastfm-square",
            },
            {
                classList: "fa fa-leanpub",
                name: "leanpub",
            },
            {
                classList: "fa fa-linkedin",
                name: "linkedin",
            },
            {
                classList: "fa fa-linkedin-square",
                name: "linkedin-square",
            },
            {
                classList: "fa fa-linode",
                name: "linode",
            },
            {
                classList: "fa fa-linux",
                name: "linux",
            },
            {
                classList: "fa fa-maxcdn",
                name: "maxcdn",
            },
            {
                classList: "fa fa-meanpath",
                name: "meanpath",
            },
            {
                classList: "fa fa-medium",
                name: "medium",
            },
            {
                classList: "fa fa-meetup",
                name: "meetup",
            },
            {
                classList: "fa fa-mixcloud",
                name: "mixcloud",
            },
            {
                classList: "fa fa-modx",
                name: "modx",
            },
            {
                classList: "fa fa-odnoklassniki",
                name: "odnoklassniki",
            },
            {
                classList: "fa fa-odnoklassniki-square",
                name: "odnoklassniki-square",
            },
            {
                classList: "fa fa-opencart",
                name: "opencart",
            },
            {
                classList: "fa fa-openid",
                name: "openid",
            },
            {
                classList: "fa fa-opera",
                name: "opera",
            },
            {
                classList: "fa fa-optin-monster",
                name: "optin-monster",
            },
            {
                classList: "fa fa-pagelines",
                name: "pagelines",
            },
            {
                classList: "fa fa-paypal",
                name: "paypal",
            },
            {
                classList: "fa fa-pied-piper",
                name: "pied-piper",
            },
            {
                classList: "fa fa-pied-piper-alt",
                name: "pied-piper-alt",
            },
            {
                classList: "fa fa-pied-piper-pp",
                name: "pied-piper-pp",
            },
            {
                classList: "fa fa-pinterest",
                name: "pinterest",
            },
            {
                classList: "fa fa-pinterest-p",
                name: "pinterest-p",
            },
            {
                classList: "fa fa-pinterest-square",
                name: "pinterest-square",
            },
            {
                classList: "fa fa-product-hunt",
                name: "product-hunt",
            },
            {
                classList: "fa fa-qq",
                name: "qq",
            },
            {
                classList: "fa fa-quora",
                name: "quora",
            },
            {
                classList: "fa fa-ra",
                name: "ra (alias)",
            },
            {
                classList: "fa fa-ravelry",
                name: "ravelry",
            },
            {
                classList: "fa fa-rebel",
                name: "rebel",
            },
            {
                classList: "fa fa-reddit",
                name: "reddit",
            },
            {
                classList: "fa fa-reddit-alien",
                name: "reddit-alien",
            },
            {
                classList: "fa fa-reddit-square",
                name: "reddit-square",
            },
            {
                classList: "fa fa-renren",
                name: "renren",
            },
            {
                classList: "fa fa-resistance",
                name: "resistance (alias)",
            },
            {
                classList: "fa fa-safari",
                name: "safari",
            },
            {
                classList: "fa fa-scribd",
                name: "scribd",
            },
            {
                classList: "fa fa-sellsy",
                name: "sellsy",
            },
            {
                classList: "fa fa-share-alt",
                name: "share-alt",
            },
            {
                classList: "fa fa-share-alt-square",
                name: "share-alt-square",
            },
            {
                classList: "fa fa-shirtsinbulk",
                name: "shirtsinbulk",
            },
            {
                classList: "fa fa-simplybuilt",
                name: "simplybuilt",
            },
            {
                classList: "fa fa-skyatlas",
                name: "skyatlas",
            },
            {
                classList: "fa fa-skype",
                name: "skype",
            },
            {
                classList: "fa fa-slack",
                name: "slack",
            },
            {
                classList: "fa fa-slideshare",
                name: "slideshare",
            },
            {
                classList: "fa fa-snapchat",
                name: "snapchat",
            },
            {
                classList: "fa fa-snapchat-ghost",
                name: "snapchat-ghost",
            },
            {
                classList: "fa fa-snapchat-square",
                name: "snapchat-square",
            },
            {
                classList: "fa fa-soundcloud",
                name: "soundcloud",
            },
            {
                classList: "fa fa-spotify",
                name: "spotify",
            },
            {
                classList: "fa fa-stack-exchange",
                name: "stack-exchange",
            },
            {
                classList: "fa fa-stack-overflow",
                name: "stack-overflow",
            },
            {
                classList: "fa fa-steam",
                name: "steam",
            },
            {
                classList: "fa fa-steam-square",
                name: "steam-square",
            },
            {
                classList: "fa fa-stumbleupon",
                name: "stumbleupon",
            },
            {
                classList: "fa fa-stumbleupon-circle",
                name: "stumbleupon-circle",
            },
            {
                classList: "fa fa-superpowers",
                name: "superpowers",
            },
            {
                classList: "fa fa-telegram",
                name: "telegram",
            },
            {
                classList: "fa fa-tencent-weibo",
                name: "tencent-weibo",
            },
            {
                classList: "fa fa-themeisle",
                name: "themeisle",
            },
            {
                classList: "fa fa-trello",
                name: "trello",
            },
            {
                classList: "fa fa-tripadvisor",
                name: "tripadvisor",
            },
            {
                classList: "fa fa-tumblr",
                name: "tumblr",
            },
            {
                classList: "fa fa-tumblr-square",
                name: "tumblr-square",
            },
            {
                classList: "fa fa-twitch",
                name: "twitch",
            },
            {
                classList: "fa fa-twitter",
                name: "twitter",
            },
            {
                classList: "fa fa-twitter-square",
                name: "twitter-square",
            },
            {
                classList: "fa fa-usb",
                name: "usb",
            },
            {
                classList: "fa fa-viacoin",
                name: "viacoin",
            },
            {
                classList: "fa fa-viadeo",
                name: "viadeo",
            },
            {
                classList: "fa fa-viadeo-square",
                name: "viadeo-square",
            },
            {
                classList: "fa fa-vimeo",
                name: "vimeo",
            },
            {
                classList: "fa fa-vimeo-square",
                name: "vimeo-square",
            },
            {
                classList: "fa fa-vine",
                name: "vine",
            },
            {
                classList: "fa fa-vk",
                name: "vk",
            },
            {
                classList: "fa fa-wechat",
                name: "wechat (alias)",
            },
            {
                classList: "fa fa-weibo",
                name: "weibo",
            },
            {
                classList: "fa fa-weixin",
                name: "weixin",
            },
            {
                classList: "fa fa-whatsapp",
                name: "whatsapp",
            },
            {
                classList: "fa fa-wikipedia-w",
                name: "wikipedia-w",
            },
            {
                classList: "fa fa-windows",
                name: "windows",
            },
            {
                classList: "fa fa-wordpress",
                name: "wordpress",
            },
            {
                classList: "fa fa-wpbeginner",
                name: "wpbeginner",
            },
            {
                classList: "fa fa-wpexplorer",
                name: "wpexplorer",
            },
            {
                classList: "fa fa-wpforms",
                name: "wpforms",
            },
            {
                classList: "fa fa-xing",
                name: "xing",
            },
            {
                classList: "fa fa-xing-square",
                name: "xing-square",
            },
            {
                classList: "fa fa-y-combinator",
                name: "y-combinator",
            },
            {
                classList: "fa fa-y-combinator-square",
                name: "y-combinator-square (alias)",
            },
            {
                classList: "fa fa-yahoo",
                name: "yahoo",
            },
            {
                classList: "fa fa-yc",
                name: "yc (alias)",
            },
            {
                classList: "fa fa-yc-square",
                name: "yc-square (alias)",
            },
            {
                classList: "fa fa-yelp",
                name: "yelp",
            },
            {
                classList: "fa fa-yoast",
                name: "yoast",
            },
            {
                classList: "fa fa-youtube",
                name: "youtube",
            },
            {
                classList: "fa fa-youtube-play",
                name: "youtube-play",
            },
            {
                classList: "fa fa-youtube-square",
                name: "youtube-square",
            },
            {
                classList: "fa fa-ambulance",
                name: "ambulance",
            },
            {
                classList: "fa fa-h-square",
                name: "h-square",
            },
            {
                classList: "fa fa-heart",
                name: "heart",
            },
            {
                classList: "fa fa-heart-o",
                name: "heart-o",
            },
            {
                classList: "fa fa-heartbeat",
                name: "heartbeat",
            },
            {
                classList: "fa fa-hospital-o",
                name: "hospital-o",
            },
            {
                classList: "fa fa-medkit",
                name: "medkit",
            },
            {
                classList: "fa fa-plus-square",
                name: "plus-square",
            },
            {
                classList: "fa fa-stethoscope",
                name: "stethoscope",
            },
            {
                classList: "fa fa-user-md",
                name: "user-md",
            },
            {
                classList: "fa fa-wheelchair",
                name: "wheelchair",
            },
            {
                classList: "fa fa-wheelchair-alt",
                name: "wheelchair-alt",
            },
        ],
    };
    // 扩展入口
    function Plugin() {
        this.name = "iconSelectedPlus";
        this.version = "1.0.0.20211026";
        this.package = this.name.replace(/([A-Z])/g, "-$1").toLowerCase();
        this.icons = icons;
        this.options = {
            // 默认提示文字
            placeholder: "选择图标",
            // 显示的图标，默认layui+fontAwesome4
            icons: [].concat(icons.layui, icons.fontAwesome4),
            // 选中图标后是否自动关闭弹层
            autoClose: true,
            // 是否是简约模式，简约模式就一个图标，没搜索用的输入框
            simple: false,
            // 图标容器的定位，默认下方，可设置为top
            position: "bottom",
            // 是否允许回车键快速选择第一个图标
            enterSelected: true,
            // 是否允许在按下esc后快速关闭容器
            escClose: true,
            // 事件托管
            event: {
                // DOM准备创建但还没有创建，虚晃一枪
                beforeCreate: function () {},
                // DOM已经创建但还没有塞到页面上，双喜临门！
                created: function () {},
                // DOM准备挂载了！但实际还没有挂载！三阳开泰！
                beforeMount: function () {},
                // DOM这回挂载了，简称：真实的DOM！nice！
                mounted: function () {},
                // 当某个图标被选择
                selected: function () {},
                // 当点击清理按钮
                clear: function () {},
            },
        };
    }

    // 构建路径, 通常用于自定义DOM的classList或id
    Plugin.prototype.buildPath = function () {
        var path = [this.package].concat(Array.apply(this, arguments));
        return path.join("-");
    };

    /**
     * 合并对象
     * @param {*} obj1 对象1
     * @param {*} obj2 对象2
     * @returns
     */
    Plugin.prototype.mergeObject = function (obj1, obj2) {
        var _this = this;
        if (!obj1) obj1 = {};
        if (!obj2) obj2 = {};

        var result = {};

        Object.keys(obj1).forEach(function (key) {
            if (obj2[key]) {
                if (_this.isObject(obj1[key])) {
                    result[key] = _this.mergeObject(obj1[key], obj2[key]);
                } else {
                    result[key] = obj2[key];
                }
            } else {
                result[key] = obj1[key];
            }
        });
        return result;
    };

    /**
     * 检查是否是对象
     * @param {*} data
     * @returns
     */
    Plugin.prototype.isObject = function (data) {
        return Object.prototype.toString.call(data) === "[object Object]";
    };

    /**
     * 激活配置中的函数
     * @param {*} reference 参考配置
     * @param {*} funcName 函数名
     */
    Plugin.prototype.activeFunction = function (reference, funcName, args) {
        if (typeof reference !== "undefined" && this.isObject(reference)) {
            if (typeof reference[funcName] === "function") {
                reference[funcName](args);
            }
        }
    };

    // 渲染入口
    Plugin.prototype.render = function (elem, opt) {
        if (!elem) throw new Error("丢失必要参数: elem");
        if (!opt) opt = {};

        var $elems = $(elem);

        var _this = this;

        $elems.each(function () {
            id++;
            main($(this), _this.mergeObject(_this.options, opt || {}), _this, id);
        });
    };

    // 入口
    function main(elem, opt, plugin, id) {
        var _this = plugin;

        // 初始化配置
        var placeholder = elem.attr("placeholder") || opt.placeholder;
        var readonly = elem.attr("readonly") ? true : false;
        var enterSelected = opt.enterSelected;
        var escClose = opt.escClose;
        var event = opt.event;
        var icons = opt.icons || [];
        var autoClose = opt.autoClose;
        var position = opt.position;
        var simple = opt.simple;
        var selectedClass = _this.buildPath("selected");
        var iconClass = _this.buildPath("icon");
        var iconContainerClass = _this.buildPath("icon-container");
        var value = elem.val();

        // 初始化必要节点
        var $parent = elem.parent();
        var $elem = elem.clone();

        // 隐藏本身dom
        elem.hide();

        // 渲染图标
        function renderIcons(icons) {
            $iconContainer.empty();

            // 填充图标容器
            icons.forEach(function (icon) {
                var $icon = $("<div>").addClass(iconClass).attr("data-value", icon.classList);
                var $i = $("<i>").addClass(_this.buildPath("icon-ico")).addClass(icon.classList);
                var $span = $("<span>").addClass(_this.buildPath("icon-name")).text(icon.name);
                $icon.append($i).append($span);
                $iconContainer.append($icon);
            });
        }

        // 选中图标
        function selectedIcon(val) {
            if (!val) val = "";
            elem.val(val);
            $input.val(val);
            $iconContainer.find(">div").removeClass(selectedClass);
            if (val) {
                _this.activeFunction(event, "selected", createData({ value: val }));
                var $icon = $("<i>").addClass(val);
                $iconEcho.empty().append($icon);
                $iconContainer.find(">div[data-value='" + val + "']").addClass(selectedClass);
                if (!readonly) $delBtn.show();
            } else {
                _this.activeFunction(event, "clear", createData());
                $iconEcho.empty();
                $delBtn.hide();
            }
        }

        // 创建 data 数据结构
        function createData(extData) {
            return {
                dom: {
                    $container,
                    $inputContainer,
                    $iconContainer,
                    $input,
                    $echoContainer,
                    $iconEcho,
                    $delBtn,
                },
                target: { elem, opt, plugin, id },
                data: extData,
            };
        }

        // 触发事件：beforeCreate
        _this.activeFunction(event, "beforeCreate", createData());

        // 创建容器
        var $container = $("<div>")
            .addClass(_this.buildPath("container"))
            .attr("id", _this.buildPath(id + ""))
            .addClass(_this.buildPath("position-" + position));
        var $inputContainer = $("<div>").addClass(_this.buildPath("input-container"));
        var $iconContainer = $("<div>").addClass(iconContainerClass);

        // 创建新的输入框容器和清理按钮
        var $input = $("<input>").addClass(_this.buildPath("input")).addClass("layui-input");
        var $echoContainer = $("<div>").addClass(_this.buildPath("echo-container"));
        var $iconEcho = $("<div>").addClass(_this.buildPath("icon-echo"));
        var $delBtn = $("<i>").addClass("layui-icon layui-icon-close-fill");

        // 删除按钮事件
        $delBtn.on("click", function () {
            selectedIcon();
        });

        // 填充容器
        $echoContainer.append($iconEcho).append($delBtn);

        // 只读模式
        if (readonly) {
            $input.attr("readonly", true);
            $delBtn.hide();
        }

        // 是否有值
        if (!value) {
            $delBtn.hide();
        }

        // 关闭弹窗
        $(document).on("click", function () {
            $iconContainer.hide();
        });

        // 宣传图标
        renderIcons(icons);

        // 默认选中
        if (value) selectedIcon(value);

        // 配置输入框
        $input.attr("placeholder", placeholder);
        $iconContainer
            .hide()
            .on("click", "." + iconClass, function () {
                var $elem = $(this);
                var val = $elem.attr("data-value");
                if (val) selectedIcon(val);
            })
            .on("click", function (e) {
                if (!autoClose) e.stopPropagation();
            });

        // 填充输入框容器
        if (simple) {
            $container.addClass(_this.buildPath("simple"));
            $inputContainer.append($echoContainer);

            $iconEcho.on("click", function (e) {
                e.stopPropagation();
                $("." + iconContainerClass).hide();
                $iconContainer.show();
            });
        } else {
            $inputContainer.append($input).append($echoContainer);

            if (!readonly) {
                $input
                    .on("click", function (e) {
                        e.stopPropagation();
                        $("." + iconContainerClass).hide();
                        $iconContainer.show();
                    })
                    .on("focus", function () {
                        $(this).trigger("select");
                    })
                    .on("input", function () {
                        var val = $(this).val();

                        if (val) {
                            var matchIcons = [];
                            icons.forEach(function (icon) {
                                var key1 = val.toLowerCase();
                                var key2 = icon.classList.toLowerCase();
                                var key3 = icon.name.toLowerCase();

                                if (key2.indexOf(key1) !== -1 || key3.indexOf(key1) !== -1) {
                                    matchIcons.push(icon);
                                }
                            });

                            renderIcons(matchIcons);
                        } else {
                            renderIcons(icons);
                            $iconEcho.empty();
                        }
                    })
                    .on("keypress", function (e) {
                        if (e.keyCode === 13 && enterSelected) {
                            var val = $iconContainer.find(">div:eq(0)").attr("data-value");
                            selectedIcon(val);
                            e.stopPropagation();
                            $iconContainer.hide();
                            return false;
                        }
                    })
                    .on("keydown", function (e) {
                        if (e.keyCode === 27 && escClose) {
                            $iconContainer.hide();
                        }
                    });
            }
        }

        // 填充总容器
        $container.append($inputContainer).append($iconContainer);

        // 触发事件，DOM创建完毕，即将塞到页面上
        _this.activeFunction(event, "created", createData());

        // 准备挂载DOM但实际还没有挂载
        _this.activeFunction(event, "beforeMount", createData());

        // 塞入页面
        $parent.append($container);

        // 触发事件，DOM创建完毕，即将塞到页面上
        _this.activeFunction(event, "mounted", createData());
    }

    // 创建一个女朋友
    var plugin = new Plugin();
    // 给女朋友穿上漂亮小衣服
    layui.link(layui.cache.base + plugin.name + "/css/index.css");
    // 发个朋友圈秀一下恩爱 ❤
    exports(plugin.name, plugin);
});
