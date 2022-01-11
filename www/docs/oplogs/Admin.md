<a name="top"></a>
# <a name='admin'></a> admin

## <a name='编辑管理员'></a> 编辑管理员

```
POST admin/edit
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 请求参数 - `Parameter`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| admin_id | `Number` | <p>管理员id</p> |
| username | `string` | <p>用户名</p> |
| password | `string` | <p>密码</p> |
| name | `string` | <p>真实姓名</p> |
| mobile | `Number` | <p>手机号</p> |
| status | `Number` | <p>状态</p> |

### 返回信息

#### 状态码 - `200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| name | `type` | <p>description</p> |

## <a name='编辑管理员前'></a> 编辑管理员前

```
GET admin/editBefore
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 请求参数 - `Parameter`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| id | `number` | <p>管理员id</p> |

### 返回信息

#### 状态码 - `200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| name | `type` | <p>description</p> |

## <a name='管理员列表'></a> 管理员列表

```
GET admin/list
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 请求参数 - `Parameter`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| page | `number` | <p>页码</p> |

### 返回信息

#### 状态码 - `200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| name | `type` | <p>description</p> |

## <a name='删除管理员'></a> 删除管理员

```
POST admin/del
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 请求参数 - `Parameter`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| id | `number` |  |

### 返回信息

#### 状态码 - `200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| name | `type` | <p>description</p> |

## <a name='设置管理员是否可用'></a> 设置管理员是否可用

```
POST admin/enable
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

## <a name='添加管理员'></a> 添加管理员

```
POST admin/add
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 请求参数 - `Parameter`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| username | `string` | <p>用户名</p> |
| password | `string` | <p>密码</p> |
| name | `string` | <p>真实姓名</p> |
| mobile | `Number` | <p>手机号</p> |
| status | `Number` | <p>状态</p> |

### 返回信息

#### 状态码 - `200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| name | `type` | <p>description</p> |

## <a name='添加管理员前'></a> 添加管理员前

```
GET admin/addBefore
```

### Headers - `Header`

| Name    | Type      | Description                          |
|---------|-----------|--------------------------------------|
| rttoken | `string` | <p>必填</p> |

### 请求参数 - `Parameter`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| null |  |  |

### 返回信息

#### 状态码 - `200`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| name | `type` | <p>description</p> |

