module.exports = class extends think.Model {
    /**
     * 前台渲染递归 表结构必须有id pid title
     * @param {array} tid 
     * @returns 
     */
    async getTree() {
        let data = await this.model('area').select()
        //根据 id取出某一个分类的子集
        //console.log(tid)
        const findById = (id) => {
            let child = [];
            data.forEach((value) => {
                if (value.pid == id) {
                    let d = {
                        title: value.name,
                        id: value.id
                    }
                    child.push(d);
                }
            });
            return child;
        };
        // 递归查询到数据并将数据存储到数组 
        const deeploop = function (id) {
            let dataArr = findById(id);
            if (dataArr.length <= 0) {
                return null;
            } else {
                dataArr.forEach((value) => {
                    if (deeploop(value.id) != null) {
                        value["child"] = deeploop(value.id);
                    }
                });
            }
            return dataArr;
        };
        return deeploop(0);
    }
}