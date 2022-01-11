# 地址跳转

#### 例子：
```
<u-cell-item icon="person-delete-fill" arrow="false" title="退出登录" @tap="$u.route('/pages/login/login','init')"></u-cell-item>
```

#### 功能描述

```
@tap="$u.route('/pages/login/login')"
```

#### 第二参数

1. 为空直接跳转
2. 'tap'跳到tab页面
3. 'init'重新启动跳转