// 这就是个抓取 fontAwesome4 全部图标的 js 脚本
// 与实际使用扩展无关，仅用于扩展学习，复制内容到控制台执行使用
// fontAwesome4 中文网：http://www.fontawesome.com.cn/
// 图标发布页面：http://www.fontawesome.com.cn/faicons/

// 数据集合
const rows = [];
// 遍历DOM获取数据
const elems = document.querySelectorAll(".fontawesome-icon-list a");
elems.forEach((elem) => {
    const i = elem.querySelector(".fa");
    const name = elem.cloneNode(true);
    name.removeChild(name.querySelector("i"));
    name.removeChild(name.querySelector("span"));

    rows.push({
        classList: i.getAttribute("class"),
        name: name.innerText.replace(/^\s+|\s+$/g, "")
    });
});
// 导出数据
const a = document.createElement("a");
const blob = new Blob([JSON.stringify(rows, null, 4)], { type: "application/json" });
const file = URL.createObjectURL(blob);
a.href = file;
a.download = "fontAwesome4.json";
a.click();
