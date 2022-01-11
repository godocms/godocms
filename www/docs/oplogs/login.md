<a name="top"></a>
# <a name='login'></a> login

## <a name='获取验证码'></a> 获取验证码

<p>返回base64位图片</p>

```
GET login/captcha
```

## <a name='用户登录'></a> 用户登录

```
POST login/do
```

### 请求参数 - `Parameter`

| Name     | Type       | Description                           |
|----------|------------|---------------------------------------|
| username | `string` | <p>用户 必填</p> |
| password | `string` | <p>密码 必填</p> |
| captcha | `string` | <p>验证码 必填</p> |

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
"code": 0,
"message": "ok",
"data":token
}
```

