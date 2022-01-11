module.exports = class extends think.Logic {
    listAction() {
        this.allowMethods = 'get';
        this.rules = {
        }
    }

    addAction() {
        this.allowMethods = 'post';
        this.rules = {}
    }

    editAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                required: true
            }
        }
    }


    delAction() {
        this.allowMethods = 'post';
        this.rules = {
            id: {
                required: true
            }
        }
    }
}