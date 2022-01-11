<a name="top"></a>
# <a name='set'></a> set

## <a name='设置是否可用'></a> 设置是否可用

```
POST set/enable
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 请求参数 - `Parameter`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| status | `number` | <p>状态</p> |
| id | `number` |  |

### 返回信息

#### 状态码 - `200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| name | `type` | <p>description</p> |

## <a name='添加系统配置类目'></a> 添加系统配置类目

```
GET set/cateAdd
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 请求参数 - `Parameter`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| key | `string` | <p>类目键值</p> |
| name | `string` | <p>类目名</p> |

### 返回信息

#### 状态码 - `200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| name | `type` | <p>description</p> |

## <a name='系统配置类目列表'></a> 系统配置类目列表

```
GET set/cate
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 请求参数 - `Parameter`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| page | `number` | <p>页码</p> |
| limit | `number` | <p>每页显示数据</p> |

### 返回信息

#### 状态码 - `200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| name | `type` | <p>description</p> |

