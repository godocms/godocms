module.exports = `<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>添加{{name}}</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../component/ui/css/ui.css" />
</head>
<body>
<form class="layui-form" action="" lay-filter="editform">
    <div class="mainBox">
        <div class="main-container">
            <div class="main-container">
            <div class="layui-form-item">
                <label class="layui-form-label">名称</label>
                <div class="layui-input-block">
                    <input type="text" name="title" lay-verify="required|len" autocomplete="off" min="3" placeholder="请输入名称" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">所属分类</label>
                <div class="layui-input-block">
                    <button class="layui-btn" id="chooseCate">
                        <span id="cateText">选择分类</span>
                        <i class="layui-icon layui-icon-down layui-font-12"></i>
                    </button>
                </div>
            </div>

			<div class="layui-form-item layui-form-text">
				<label class="layui-form-label">备注</label>
				<div class="layui-input-block">
				<textarea name="remark" placeholder="请输入内容" class="layui-textarea"></textarea>
				</div>
			</div>

            </div>
        </div>
    </div>
    <div class="bottom">
        <div class="button-container">
            <input type="hidden" name="cid" value="0" id="cid">
            <button type="submit" class="pear-btn pear-btn-primary pear-btn-sm" lay-submit="" lay-filter="{{tags}}-save">
                <i class="layui-icon layui-icon-ok"></i>
                提交
            </button>
        </div>
    </div>
</form>
<script src="../../config/config.js"></script>
<script src="../../component/layui/layui.js"></script>
<script src="../../component/ui/ui.js"></script>
<script>
    layui.use(['form','layer','dropdown'], function () {
        let form = layui.form
            , layer = layui.layer
			, $ = layui.$
			, dropdown = layui.dropdown,
            , req = _req();
        form.verify({
            len : (val, item) => {
                let min = item.getAttribute("min")
                if(val.length < min) {
                    return '长度不能小于' + min;
                }
            }
        })
        //渲染
        if(req.id) {
            _get(layui, '{{tags}}/editBefore', res => {
                dropdown.render({
                    elem: '#chooseCate',
                    data: res.cate,
                    trigger: 'hover',
                    click: (d, el) => {
                        $('#cateText').text(d.title);
                        $('#cid').val(d.id);
                    }
                });
                form.val('editform', res.data);
                $('#cateText').text(res.data.cateName);
            });
        } else {
            _get(layui, '{{tags}}/addBefore', res => {
                dropdown.render({
                    elem: '#chooseCate',
                    data: res.authTree,
                    trigger: 'hover',
                    click: (d, el) => {
                        $('#cateText').text(d.title);
                        $('#cid').val(d.id);
                    }
                })
            });
        }
		


        //监听提交
        form.on('submit({{tags}}-save)', function (data) {
			data = data.field;
            let postUrl;
            if(req.id) {
                postUrl = '{{tags}}/edit';
            }else{
                postUrl = '{{tags}}/add';
            }
			_post(layui, postUrl, data, res => {
				//console.log(res)
				parent.layui.table.reload("{{tags}}-table");
				parent.layer.close(parent.layer.getFrameIndex(window.name));//关闭当前页

			})

            return false;
        });

    });
</script>

</body>
</html>`