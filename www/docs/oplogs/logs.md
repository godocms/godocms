<a name="top"></a>
# <a name='logs'></a> logs

## <a name='操作日志列表'></a> 操作日志列表

```
GET logs/op
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

## <a name='错误日志列表'></a> 错误日志列表

```
GET logs/err
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

## <a name='行为日志列表'></a> 行为日志列表

```
GET logs/view
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

