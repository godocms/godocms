## 关于godocms

godocms是刚东科技开发的一套开源办公套件，遵从Apache License 2.0开源协议，非常适合二次开发，内含word/excel/ppt/pdf/svg/思维导图/流程图/日程管理等多个办公系统解决方案。godocms也是一套低代码开发套件，内含模块管理/接口管理/代码拖拽/数据库管理/表单管理等一套完善的低代码开发工具流。内含两套风格界面，win10和传统软件界面，可随时切换。内置了很多对开发者有用的实用工具，也可以当作一个工具箱使用。

## 为什么做？

现在主流的办公套件要么不开源，要么需要授权，而且安装异常复杂。随着技术的日新月异，很多开源组件基本能够解决办公套件商用化的痛点甚至更好，但都是零碎的/单一的解决方案，为此我们沉心静气花耗半年时间打磨了这套产品。godocms基本实现了办公三套件（word/ppt/excel）的编辑流，无需服务器安装底层的模块。
低代码现在处在一个发展阶段，国内也涌现了一大批优秀的低代码套件，更接地气更平民化。但是要解决大型复杂的业务流时总是感觉有那么有点力不从心，为什么呢？我们做了认真的思考和研究，发现很多低代码套件都忽视了软件开发的基本流程和本质，一套软件的开发流程包含很多，需求分析/架构设计/开发/测试/交付等，这是一个大工程，因为每个子流程里面又包含很多小流程。反过来想，如果把每个流程都加进去那就还是低代码吗？其实google走在最前面，他们开发了blockly。但是blockly在国内并没有得到大面积的推广？why？学习成本和开发成本！blockly不能拿过来直接上项目，很多公司的开发都有自己的底层平台，如果要用那就要做二开。godocms基层很多模块都是用blockly开发的，并且完美的集成了进来。我们完全遵从控制层/模型层/逻辑层/服务层的基础软件开发框架，只要明白mvc的思想，就很容易上手。
为什么要用nodejs开发？godocms开发原则是“**易上手，容易改**”。前端工程师和后端工程师都可以上手，没有复杂的包，学习成本低，简单的做一下二次开发，可以实现大型的复杂项目。

## 项目地址

[https://gitee.com/ruitao_admin/godocms](https://gitee.com/ruitao_admin/godocms)

## 项目演示

[https://demo.godocms.com](https://demo.godocms.com)

登录名：admin
密码 ：admin

![recording.gif](/docs/oplogs/img/1641868653561.gif)



## 功能介绍

#### 一 文档管理

文档管理可以理解成使用说明书/开发文档/文集的生成工具。集成了`Docsify`，可以自动生成，可以回写，可以书写多个说明文档，可以做为一个说明文档的管理工具使用。

#### 二 数据库设计器

数据库设计器其实就是一个小型的navicat，是一个mysql数据库管理工具。支持数据备份还原；支持自动生成数据库设计文档，md 格式以及实时预览，可以下载成 pdf/word文件；支持数据表名/注释/autoid 的更改，支持优化表/修复表/删除表/清空表；可查看/编辑/新增/复制任意表数据；可更改字段名/注释/默认值/排序，可拖拽排序字段，可删除字段；支持连接/管理外部数据库，可通过ssh连接外部数据库；支持数据库表保护。

#### 三 思维导图

一套完善的思维导图管理工具。支持增/删/改/查，进入后自动添加/自动保存文件；支持逻辑结构图、思维导图、组织结构图、目录组织图四种结构； 内置多种主题，允许高度自定义样式；支持快捷键；节点内容支持图片、图标、超链接、备注、标签；支持前进后退；支持拖动、缩放；支持右键多选；支持节点拖拽；支持 json 格式的导入导出，png/svg 导出。

#### 四 excel表格管理

excel表格管理工具。支持增/删/改/查，导入/导出excel；格式设置：样式，条件格式，文本对齐及旋转，文本截断、溢出、自动换行，多种数据类型，单元格内多样式；单元格：拖拽，下拉填充，多选区，查找和替换，定位，合并单元格，数据验证；行和列操作：隐藏、插入、删除行或列，冻结，文本分列；操作体验：撤销、重做，复制、粘贴、剪切，快捷键，格式刷，选区拖拽；公式和函数：内置公式，远程公式，自定义公式；表格操作：筛选，排序。

#### 五 ppt演示文稿

在线演示文稿（幻灯片ppt）应用。支持增/删/改/查，还原了大部分 Office PowerPoint 常用功能，支持文字、图片、形状、线条、图表、表格、视频、公式几种最常用的元素类型，每一种元素都拥有高度可编辑能力，同时支持丰富的快捷键和右键菜单，尽可能还原本地桌面应用的使用体验。内置了一些常用模版，支持导出 ppt 文件。

#### 六 文档编辑器

不仅仅是word编辑器，也可以作为一个简单的pdf编辑器，还可以编辑md/rtf/text/html等文本文件，基于tesseract可以打开几乎任何的文档文件，支持**ocr文字识别**，可以打开png/jpg等图片文件，打开后直接显示为文字，无需第三方api，简洁实用。

#### 七 流程图编辑器

项目经理的硬核工具，包含**图形/拓扑图/图表/权限流/工作流**五个流程图编辑工具，基于mxgraph，支持增/删/改/查，内置demo。更多功能请看演示。

#### 八 文本编辑器

text文本编辑器，支持打开text/html/css/js/svg/xml/md等，支持预览/增/删/改/查，可以当作一个简单的在线editplus。

#### 九 图片编辑器

一个在线图片编辑器，基于tui.image-editor。支持增/删/改/查，支持裁剪、翻转、旋转、绘图、形状、图标、文本、遮罩过滤器、图像过滤器。

#### 十 svg编辑器

svg在线编辑器，基于svgedit。支持增/删/改/查，支持导入/导出svg，功能强大，具体可查看demo。

#### 十一 甘特图

甘特图编辑器。支持增/删/改/查，支持自定义项目人员和角色，支持拖拽/管理分配（资源、角色、工作）等。

#### 十二 日程计划

在线日程计划表。支持增/删/改。基于tui.calendar，支持各种视图类型：每日、每周、每月（6周、2周、3周）；支持里程碑和任务计划的高效管理；支持周末宽度；支持更改一周的开始日期；支持自定义日期和日程信息界面（包括网格单元的页眉和页脚）；支持通过鼠标拖动调整明细表。

#### 十三 开发工具箱

开发工具箱，包含了很多有用的工具，如 QR 码生成器，QR 码解码、翻译，时间戳转换，源格式，JSON 管理工具，正则管理工具，图像 base64 字符编码等。

#### 十四 接口开发工具

内置HTTP接口，WEBSOCKET接口，SOCKET.IO接口调试工具。开发工具利器。

#### 十五 字体编辑器

在线字体编辑器，支持ttf, woff, woff2, otf, svg font, eot字体的编辑。

#### 十六 办公白板工具

一个小型的办公白板工具。支持画笔/橡皮擦/便签等。

#### 十七 录屏工具

一个实用的在线录屏工具。支持谷歌/火狐浏览器，直接生成gif。

#### 十八 其他小工具

便签/番茄时钟/计算器/万年历等。

#### 十九 程序设计器

基于google的blockly，支持增删改查，支持类/函数/对象/数组，**支持thinkjs的大部分内置对象拖拽**，支持自动生成项目文件，内置demo。

#### 二十 模块设计器

支持四层架构设计，支持**一键生成curd**，支持全局常量生成，是接口设计器的底层支撑。

#### 二十一 接口设计器

**一个模块就是一个文件或类，一个接口就是一个函数**。可以理解为**函数设计器**。分为基本配置/入口参数/逻辑设计/测试管理四个部分。基本配置就是配置函数的名称及其方法，入口参数即该函数的logic层定义，可直接从数据库导入并自动识别类型。逻辑设计即函数的主体部分，采用blockly直接通过拖拽代码实现。测试管理包含入参/headers/预想/结果/备注五个部分，是一套完善的测试工具流，预想可直接从数据库导入数据结构以及数据深度测试，预想并未完成数据校验（第二期完成）

#### 二十二 表单设计器

支持组件拖拽，支持表单回写，支持生成 html 以及代码预览，支持数据来源，支持自定义接收参数和发送附加参数。

#### 二十三 其他

系统配置：基于表单生成器做的demo。
计划任务：系统的计划任务实现。
菜单管理：系统权限管理的核心部分。
角色管理：系统内置的角色权限管理。
部门管理：和角色管理类似。
公司管理：和角色管理类似。
岗位管理：和角色管理类似。
支持csrf，支持ratelimit 实现访问速率限制，保护程序免受暴力攻击，支持helmet，避免 XSS 跨站脚本攻击。

## 第二期开发计划

1. 完成接口设计的测试工具。
2. 完成表单设计器和接口设计器的对接。
3. 基于接口设计器实现表格设计器。
4. 完成ppt的导入。
5. 完成聊天模块。
6. 完成任务看板模块。
7. 完成简单的原型设计模块。
8. 完成文件夹管理。
9. 修复系统bug。

## 开发环境

> nodejs v16.13  mysql 5.7  redis5.03

项目解压到server根目录

```bash
cd server
npm i
```

## 初始化项目

用工具导入`data/init.sql`，然后更改`src/common/config/config.js`

```bash
mysql: {
    handle: mysql,
    database: 'godocms',//改成自己的数据库
    prefix: 'rt_',
    encoding: 'utf8',
    host: '127.0.0.1',
    port: '3306',
    user: 'root',//改自己的用户名
    password: 'root',//改密码
    dateStrings: true
  }
```

## 本地预览

通过运行 `npm start` 启动一个本地服务器。默认访问地址 http://localhost:8200 。

```bash
npm start
```

## 正式环境

```bash
pm2 start pm2.json
```

## 特别鸣谢

[https://thinkjs.org](https://thinkjs.org/)

[https://github.com/google/blockly](https://github.com/google/blockly)

[https://gitee.com/sentsin/layui](https://gitee.com/sentsin/layui)

[https://gitee.com/pear-admin/Pear-Admin-Layui](https://gitee.com/pear-admin/Pear-Admin-Layui)

[https://docsify.js.org/#/zh-cn/](https://docsify.js.org/#/zh-cn/)

[https://gitee.com/ayq947/ayq-layui-form-designer](https://gitee.com/ayq947/ayq-layui-form-designer)

[https://github.com/wanglin2/mind-map](https://github.com/wanglin2/mind-map)

[https://github.com/mengshukeji/Luckysheet](https://github.com/mengshukeji/Luckysheet)

[https://github.com/pipipi-pikachu/PPTist](https://github.com/pipipi-pikachu/PPTist)

[https://github.com/jgraph/mxgraph](https://github.com/jgraph/mxgraph)

[https://github.com/Vanessa219/vditor](https://github.com/Vanessa219/vditor)

[https://github.com/nhn/tui.image-editor](https://github.com/nhn/tui.image-editor)

[https://github.com/nhn/tui.calendar](https://github.com/nhn/tui.calendar)

[https://github.com/joaomoreno/gifcap](https://github.com/joaomoreno/gifcap)

[https://github.com/naptha/tesseract.js](https://github.com/naptha/tesseract.js)

[https://github.com/qunee/graph.editor_vue](https://github.com/qunee/graph.editor_vue)

[https://github.com/SVG-Edit/svgedit](https://github.com/SVG-Edit/svgedit)

[https://github.com/robicch/jQueryGantt](https://github.com/robicch/jQueryGantt)

[https://gitee.com/karson/tinytools](https://gitee.com/karson/tinytools)

[https://github.com/ecomfe/fonteditor](https://github.com/ecomfe/fonteditor)
[https://github.com/tldraw/tldraw](https://github.com/tldraw/tldraw)

如有侵权或需要二次开发请联系微信**ruitao580** 邮箱 xpbb@qq.com

