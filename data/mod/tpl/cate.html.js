module.exports = `<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>{{name}}分类管理</title>
		<link rel="stylesheet" href="../../component/ui/css/ui.css" />
	</head>
	<body class="pear-container">
		
		<div class="layui-card">
			<div class="layui-card-body">
				<table id="{{tags}}-catetable" lay-filter="{{tags}}-catetable"></table>
			</div>
		</div>

		<script type="text/html" id="{{tags}}-toolbar">
			<button class="layui-btn layui-btn-primary layui-border-red layui-btn-sm" lay-event="add">
		        <i class="layui-icon layui-icon-add-1"></i>
		        新增
		    </button>
		</script>

		<script type="text/html" id="{{tags}}-bar">
			<button class="pear-btn pear-btn-primary pear-btn-sm" lay-event="edit"><i class="layui-icon layui-icon-edit"></i></button>
		    <button class="pear-btn pear-btn-danger pear-btn-sm" lay-event="remove"><i class="layui-icon layui-icon-delete"></i></button>
		</script>
		<script src="../../config/config.js"></script>
		<script src="../../component/layui/layui.js"></script>
		<script src="../../component/ui/ui.js"></script>
		<script>
			layui.use(['table', 'form', 'jquery','common'], function() {
				let table = layui.table;
				let form = layui.form;
				let $ = layui.jquery;
				let common = layui.common;

				let MODULE_PATH = "./";

				let cols = [
					[
						{
							title: 'ID',
							field: 'id',
							align: 'center'
						},
						{
							title: '名称',
							field: 'title',
							align: 'center'
						},
						{
							title: '操作',
							toolbar: '#{{tags}}-bar',
							align: 'center',
							width: 130
						}
					]
				]

				table.render({
					elem: '#{{tags}}-catetable',
					url: apiUrl + '{{tags}}/list',
					headers : getHeader(),
					parseData: function(res) {
						//console.log(res)
						return {
							"code": res.code, //解析接口状态
							"msg": res.message, //解析提示文本
							"count": res.data.count, //解析数据长度
							"data": res.data.list //解析数据列表
						};
					},
					page: true,
					cols: cols,
					skin: 'line',

					toolbar: '#{{tags}}-toolbar',
					defaultToolbar: [{
						title: '刷新',
						layEvent: 'refresh',
						icon: 'layui-icon-refresh',
					}, 'filter', 'print', 'exports']
				});

				table.on('tool({{tags}}-table)', function(obj) {
					if (obj.event === 'remove') {
						window.remove(obj);
					} else if (obj.event === 'edit') {
						window.edit(obj);
					}
				});

				table.on('toolbar({{tags}}-table)', function(obj) {
					if (obj.event === 'add') {
						window.add();
					} else if (obj.event === 'refresh') {
						window.refresh();
					}
				});
				// 监听搜索操作

				form.on('submit({{tags}}-query)', function(data) {
					table.reload('{{tags}}-catetable', {
						where: {
							param : $('form').serialize()
						},
						page: {
					        curr: 1
					    }
					})
					return false;
				});
				form.on('submit({{tags}}-reset)', function(data){
					table.reload('{{tags}}-catetable', {
						where: {
							param : ''
						},
						page: {
					        curr: 1
					    }
					});
					return false;
				})

				window.add = function() {
					layer.open({
						type: 2,
						title: '新增',
						shade: 0.1,
						offset: 'rt',
						area: ['80%', '100%'],
						anim: 1,
						maxmin: true,
						content: MODULE_PATH + 'edit.html'
					});
				}

				window.edit = function(obj) {
					layer.open({
						type: 2,
						title: '修改',
						shade: 0.1,
						offset: 'rt',
						area: ['80%', '100%'],
						anim: 1,
						maxmin: true,
						content: MODULE_PATH + 'edit.html?id=' + obj.data.id
					});
				}
				window.remove = function(obj){
		            layer.confirm('确定要删除', {icon: 3, title:'提示'}, function(index){
		                layer.close(index);
		                _post(layui, '{{tags}}/del',{id : obj.data.id}, res => {
							layer.msg('删除成功',{icon:1,time:1000},() => {
								obj.del();
							});
						}, err => {
							//layer.msg('删除失败',{icon:2,time:1000});
						})
		            });
		        }


				window.refresh = function(param) {
					table.reload('{{tags}}-catetable');
				}
			})
		</script>
	</body>
</html>`