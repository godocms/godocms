
#### 使用说明

1. 本项目基于Layui、Jquery、Sortable
2. 项目已经基本实现了拖动布局，父子布局
3. 项目实现了大部分基于Layui的Form表单控件布局，包括输入框、编辑器、下拉、单选、单选组、多选组、日期、滑块、评分、轮播、图片、颜色选择、图片上传、文件上传、日期范围、排序文本框、图标选择器、cron表达式、手写签名组件

#### 开发计划

1.  支持layui表单组件
2.  支持layui的扩展组件
3.  支持通过formDesigner对象的方法获取填写表单的数据或者回显表单数据
4.  支持代码自动生成
5.  支持通过url获取远程数据动态显示组件（如下拉框、编辑器、图片等）
6.  支持定制布局和背景


#### 入门案例（设计页面）


```
var render = formDesigner.render({
                data:[],//表单设计数据
                elem:'#formdesigner'
            });

//重新渲染数据
render.reload(options)

//获取相关配置信息
render.getOptions() 

//获取表单设计数据
render.getData()
//获取外部编辑器对象
render.geticeEditorObjects()
```

#### 入门案例（视图页面）


```
var render = formPreview.render({
          elem: '#testdemo',
          data: [],//表单设计数据
          formData: {"textarea_1":"123",
            "input_2":"123",
            "password_3":"123"}//要回显的表单数据
        });
//重新渲染数据
render.reload(options)

//获取相关配置信息
render.getOptions() 

//获取表单设计数据
render.getData()

//获取外部编辑器对象
render.geticeEditorObjects()

//获取上传图片的id与上传路径
render.getImages()
//数据案例 select 对应文件对象的id uploadUrl对应文件的上传路径
[{select: "imageimage_2",uploadUrl: ""}]

//获取上传文件的id与上传路径
render.getFiles()
//数据案例 select 对应文件对象的id uploadUrl对应文件的上传路径
[{select: ""filefile_1"",uploadUrl: ""}]

//获取表单数据 
**
注意: 当前方法会避开校验规则，最好放在表单提交里面 
form.on('submit(demo1)', function(data){}）；
** 
render.getFormData()

//回显表单数据 
render.setFormData(json)

//全局禁用表单
render.globalDisable()

//全局启用表单
render.globalNoDisable()

 ** 
说明：  这些方法有2个组件不受控制（文件组件和图片组件），
我把这两个组件通过方法单独提出来，因为文件上传的方式比较多，
提出来让使用者自己去定义和实现自己的文件上传方式，
具体的案例在preview.html里面已经写好，你们自己参考
** 
```

#### 基础参数

| 参数  | 类型  | 说明  |  示例值 |
|---|---|---|---|
|  elem |  String | 指定原始 table 容器的选择器，方法渲染方式必填  | "#elem"  |
|  data |  Array | 直接赋值数据  |  [{},{},...] |
|  formData|  Array | 回显的表单数据  |  [{},{},...] |

#### 组件参数

| 参数  | 类型  | 说明  |  示例值 |
|---|---|---|---|
|  id |  String | 指定组件标识（唯一），表单提交字段name值  | "field"  |
|  label | String  | 文本框标题  |  "姓名" |
|  tag | String  | 表单类型  |  "input" |
|  placeholder | String  | placeholder  |  "请输入" |
|  defaultValue | object  | 组件默认值  |  "姓名" |
|  width | String  | 组件宽度  |  "100%" |
|  labelWidth | String  | 文本框宽度  |  "250px" |
|  readonly | Boolean  | 只读  |  true,false |
|  disabled | Boolean  | 禁用  |  true,false |
|  required | Boolean  | 必填  |  true,false |
|  columns | number  | 栅格布局列数  |  true,false |
|  maxValue | object  | 最大值  |  "" |
|  minValue | object  | 最小值  |  "" |
|  expression | String  | 验证  |  "email" |
|  stepValue | number  | 滑块步长  |  2 |
|  isInput | Boolean  | 滑块显示输入框  |  true,false |
|  datetype | String  | 日期类型  |  "时间选择器" |
|  dateformat | String  | 日期格式  |  "yyyy-MM-dd" |
|  rateLength | number  | 星星个数  |  5 |
|  interval | number  | 轮播间隔毫秒  |  3000 |
|  autoplay | Boolean  | 轮播自动切换  |  true,false |
|  anim | object  | 切换方式  |  {text: '左右切换', value: 'default'} |
|  arrow | object  | 切换箭头  |  {text: '悬停显示', value: 'hover'} |
