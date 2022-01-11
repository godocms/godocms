// 获取 layui 官方图标清单，复制下面代码直接到浏览器F12控制台执行即可
// 什么？layui官网已经下线了？我早已经给你们备份好了！
// 镜像站点：https://layui-exts.gitee.io/layui-doc-layui/
// 项目地址：https://gitee.com/layui-exts/layui-doc-layui
// 拉去项目到本地：https://gitee.com/layui-exts/layui-doc-layui.git
// 饭我都喂到你嘴边了你还不会吃，那我就没办法了～

// ----------
// 本脚本需要在人类浏览器里面使用！什么叫人类浏览器？反正IE不是！
// ----------

// 数据集合
const rows = [];
// 遍历DOM获取数据
const elems = document.querySelectorAll("ul.site-doc-icon>li");
elems.forEach((elem) => {
    const i = elem.querySelector(".layui-icon");
    const name = elem.querySelector(".doc-icon-name");

    rows.push({
        classList: i.getAttribute("class"),
        name: name.innerText
    });
});
// 导出数据
const a = document.createElement("a");
const blob = new Blob([JSON.stringify(rows, null, 4)], { type: "application/json" });
const file = URL.createObjectURL(blob);
a.href = file;
a.download = "layui.json";
a.click();
