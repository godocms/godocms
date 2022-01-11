module.exports = class extends think.Logic {
    listAction() {
        this.allowMethods = 'get';
    }
    updateAction() {
        this.allowMethods = 'post';
    }
    backupAction() {
        this.allowMethods = 'post';
    }
    backupFileAction() {
        this.allowMethods = 'get';
    }
    rebackAction() {
        this.allowMethods = 'post';
        this.rules = {
            file: {
                required : true,
                aliasName: '文件名'
            }
        }
    }
    delbackAction() {
        this.allowMethods = 'post';
        this.rules = {
            file: {
                required : true,
                aliasName: '文件名'
            }
        }
    }
    docAction() {
        this.allowMethods = 'get';
    }
    editTableAction() {
        this.allowMethods = 'post';
        this.rules = {
            table: {
                required : true,
                aliasName: '表名'
            },
            field : {
                required : true,
                aliasName:'字段名'
            },
            value : {
                required : true,
                aliasName:'修改的内容'
            },
            old : {
                aliasName:'旧值'
            }
        }
    }
    delTableAction() {
        this.allowMethods = 'post';
        this.rules = {
            table: {
                required : true,
                aliasName: '表名'
            }
        }
    }
    optimizeAction() {
        this.allowMethods = 'post';
        this.rules = {
            table: {
                required : true,
                aliasName: '表名'
            }
        }
    }
    opcopyAction() {
        this.allowMethods = 'post';
        this.rules = {
            table: {
                required : true,
                aliasName: '表名'
            }
        }
    }
    repairAction() {
        this.allowMethods = 'post';
        this.rules = {
            table: {
                required : true,
                aliasName: '表名'
            }
        }
    }
    clearAction() {
        this.allowMethods = 'post';
        this.rules = {
            table: {
                required : true,
                aliasName: '表名'
            }
        }
    }
    fieldListAction() {
        this.allowMethods = 'get';
        this.rules = {
            table: {
                required: true,
                aliasName: '表名'
            }
        }
    }
    fieldsAction() {
        this.allowMethods = 'get';
        this.rules = {
            table: {
                required: true,
                aliasName: '表名'
            }
        }
    }
    editDataAction() {
        this.allowMethods = 'post';
        this.rules = {
            table: {
                required: true,
                aliasName: '表名'
            },
            field: {
                required: true,
                aliasName: '字段名'
            },

            value: {
                required: true,
                aliasName: '修改的内容'
            },
            old: {
                aliasName: '旧值'
            }
        }
    }
    delDataAction() {
        this.allowMethods = 'post';
        this.rules = {
            table: {
                required: true,
                aliasName: '表名'
            },
            data: {
                aliasName: '字段名'
            }
        }
    }
    delFieldAction() {
        this.allowMethods = 'post';
        this.rules = {
            table: {
                required: true,
                aliasName: '表名'
            },
            field: {
                required: true,
                aliasName: '字段名'
            }
        }
    }
    sortFieldAction() {
        this.allowMethods = 'post';
        this.rules = {
            table: {
                required: true,
                aliasName: '表名'
            },
            row: {
                required: true,
                aliasName: '字段数据'
            },
            t: {
                required: true,
                aliasName: '排序方式'
            },
            sortField: {
                required: true,
                aliasName: '位置字段名'
            }
        }
    }
    changeFieldNameAction() {
        this.allowMethods = 'post';
        this.rules = {
            table: {
                required: true,
                aliasName: '表名'
            },
            name: {
                required: true,
                aliasName: '字段名'
            },
            field: {
                required: true,
                aliasName: '字段属性'
            },
            value: {
                required: true,
                aliasName: '更改值'
            }

        }
    }
    setStatusAction() {
        this.allowMethods = 'post';
        this.rules = {
            table: {
                required: true,
                aliasName: '表名'
            },
            name: {
                required: true,
                aliasName: '字段名'
            },
            type: {
                required: true,
                aliasName: '类型'
            },
            status: {
                int : {min:0,max:1},
                required: true,
                aliasName: '状态'
            }
        }
    }
    keysListAction() {
        this.allowMethods = 'get';
        this.rules = {
            table : {
                required : true,
                aliasName : '表名'
            }
        }
    }
    delKeyAction() {
        this.allowMethods = 'post';
        this.rules = {
            table : {
                required : true,
                aliasName : '表名'
            },
            name : {
                required : true,
                aliasName : '索引名'
            }
        }
    }
    setKeyAction() {
        this.allowMethods = 'post';
        this.rules = {
            table : {
                required : true,
                aliasName : '表名'
            },
            names : {
                required : true,
                aliasName : '索引名'
            },
            type : {
                required : true,
                aliasName : '操作'
            }
        }
    }
    createTableAction() {
        this.allowMethods = 'post';
        this.rules = {
            name : {
                required : true,
                aliasName : '表名'
            },
            comment : {
                required : true,
                aliasName : '表注释'
            },
            add_time : {
                aliasName : '添加时间'
            },
            update_time : {
                aliasName : '更新时间'
            },
            admin_id : {
                aliasName:'管理员id'
            },
            user_id : {
                aliasName : '用户id'
            }

        }
    }
    batchRemoveAction() {
        this.allowMethods = 'post';
        this.rules = {
            ids: {
                required: true,
                aliasName : '表名'
            }
        }
    }
}