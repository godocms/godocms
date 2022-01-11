## 日志内容约束

> 日志内容content字段以JSON格式提交，对象提交前要做JSON.stringify()处理


### 日志字段类型说明

- id 必填，数字，类似数据库字段名，可自定义，唯一性
- type 必填，字符串，可自定义，非唯一，用于识别前端的展示类型
- title 必填，字符串，可自定义，非唯一，用于前端的标题
- content 非必填，字符串，日志字段的内容
- params 非必填，字符串，对于多选/单选等适配显示
- order 必填，数字，排序用



``` json

[
	{
		"id" : 1,
		"type": "text",
		"title": "模版内容",
		"content": "1 工作内容一 2 工作内容二",
		"params": "",
		"order" : 1
	}, 
	{
		"id" : 2,
		"type": "radio",
		"title": "单选题目",
		"content":"简单",
		"params": "简单|容易",
		"order" : 2
	},
	{
		"id" : 3,
		"type": "checkbox",
		"title": "多选",
		"content":"简单|中等",
		"params": "简单|容易|中等",
		"order" : 3
	},
	{
		"id" : 4,
		"type": "texarea",
		"title": "输入框",
		"content": "请输入题目",
		"params": "",
		"order" : 4
	},
	{
		"id" : 5,
		"type": "file",
		"title": "文件",
		"content": "http://xxx.com/xxx/file.zip",
		"params": "",
		"order" : 5
	},
	{
		"id" : 6,
		"type": "image",
		"title": "图片",
		"content": "http://xxx.com/xxx/file.jpg",
		"params": "",
		"order" : 6
	}
]


```
