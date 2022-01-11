<a name="top"></a>
# <a name='menu'></a> menu

## <a name='编辑菜单'></a> 编辑菜单

```
POST menu/edit
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 请求参数 - `Parameter`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| id | `Number` | <p>菜单id</p> |
| pid | `Number` | <p>菜单上级id</p> |
| title | `String` | <p>菜单名称</p> |
| href | `String` | <p>前端模版</p> |
| route | `String` | <p>后端路由</p> |
| icon | `String` | <p>菜单icon</p> |
| type | `Number` | <p>类型 0 1 2 3</p> |
| order_num | `Number` | <p>排序</p> |

### 返回信息

#### 状态码 - `200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| name | `type` | <p>description</p> |

## <a name='菜单是否显示'></a> 菜单是否显示

```
POST menu/ifshow
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 请求参数 - `Parameter`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| id | `Number` | <p>菜单id</p> |
| ifshow | `Number` | <p>显示状态0或1</p> |

### 返回信息

#### 状态码 - `200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| name |  | <p>description</p> |

## <a name='获取单个菜单数据'></a> 获取单个菜单数据

```
GET menu/one
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 请求参数 - `Parameter`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| id | `Number` | <p>菜单id 可为0 为0时添加数据前拉取</p> |

### 返回信息

#### 状态码 - `200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| name | `type` | <p>description</p> |

## <a name='获取管理菜单列表'></a> 获取管理菜单列表

```
GET menu/oplist
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 返回信息

#### 状态码 - `Success 200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| code | `number` | <p>结果码</p> |
| data | `string` | <p>数据</p> |
| message | `string` | <p>提示</p> |

## <a name='获取管理界面菜单'></a> 获取管理界面菜单

```
GET menu/list
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 返回信息

#### 状态码 - `Success 200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| code | `number` | <p>结果码</p> |
| data | `string` | <p>数据</p> |
| message | `string` | <p>提示</p> |

### 返回事例

####  - `Success-Response:`

```json
{
"code": 200,
"message": "ok",
"data":{[
]}
}
```

## <a name='删除菜单'></a> 删除菜单

```
POST menu/del
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 请求参数 - `Parameter`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| id | `Number` | <p>菜单id</p> |

### 返回信息

#### 状态码 - `200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| name |  | <p>description</p> |

## <a name='添加菜单'></a> 添加菜单

```
POST menu/edit
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 请求参数 - `Parameter`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| pid | `Number` | <p>菜单上级id</p> |
| title | `String` | <p>菜单名称</p> |
| href | `String` | <p>前端模版</p> |
| route | `String` | <p>后端路由</p> |
| icon | `String` | <p>菜单icon</p> |
| type | `Number` | <p>类型 0 1 2 3</p> |
| order_num | `Number` | <p>排序</p> |

### 返回信息

#### 状态码 - `200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| name | `type` | <p>description</p> |

