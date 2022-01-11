## 模版内容约束

> 模版内容content字段以JSON格式提交，对象提交前要做JSON.stringify()处理


### 模版字段类型说明

- id 必填，数字，类似数据库字段名，可自定义，唯一性
- type 必填，字符串，可自定义，非唯一，用于识别前端的展示类型
- title 必填，字符串，可自定义，非唯一，用于前端的标题
- placehold 非必填，字符串，可自定义，用于提示
- params 非必填，字符串，对于多选/单选等适配
- default 非必填，字符串，默认值，如果用户不填写则默认该值
- required 必填，布尔型，true或false，用户添加日志时提交根据该值做判断
- order 非必填，数字，排序用



``` json

[
	{
		"id" : 1,
		"type": "text",
		"title": "模版内容",
		"placehold": "请输入工作内容",
		"params": "",
		"default":"",
		"required" : true,
		"order" : 1
	}, 
	{
		"id" : 2,
		"type": "radio",
		"title": "单选题目",
		"placehold": "请选择题目",
		"params": "简单|容易",
		"default":"简单",
		"required" : false,
		"order" : 2
	},
	{
		"id" : 3,
		"type": "checkbox",
		"title": "多选",
		"placehold": "请选择题目",
		"params": "简单|容易|中等",
		"default":"简单|中等",
		"required" : true,
		"order" : 3
	},
	{
		"id" : 4,
		"type": "texarea",
		"title": "输入框",
		"placehold": "请输入题目",
		"params": "",
		"default":"",
		"required" : true,
		"order" : 3
	},
	{
		"id" : 5,
		"type": "file",
		"title": "文件",
		"placehold": "请添加文件",
		"params": "",
		"default":"",
		"required" : true,
		"order" : 3
	},
	{
		"id" : 6,
		"type": "image",
		"title": "文件",
		"placehold": "请添加文件",
		"params": "",
		"default":"",
		"required" : true,
		"order" : 6
	}
]


```
