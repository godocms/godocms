<a name="top"></a>
# <a name='demo'></a> demo

## <a name='编辑事例'></a> 编辑事例

```
POST demo/edit
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 请求参数 - `Parameter`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| id | `number` | <p>id</p> |

### 返回信息

#### 状态码 - `200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| name | `type` | <p>description</p> |

## <a name='编辑事例前'></a> 编辑事例前

```
GET demo/edit
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 请求参数 - `Parameter`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| id | `number` | <p>id</p> |

### 返回信息

#### 状态码 - `200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| name | `type` | <p>description</p> |

## <a name='删除事例'></a> 删除事例

```
POST demo/delete
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 请求参数 - `Parameter`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| id | `number` | <p>id</p> |

### 返回信息

#### 状态码 - `200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| name | `type` | <p>description</p> |

## <a name='事例列表'></a> 事例列表

```
GET demo/list
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
| param | `string` | <p>每页显示数据</p> |

### 返回信息

#### 状态码 - `200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| name | `type` | <p>description</p> |

