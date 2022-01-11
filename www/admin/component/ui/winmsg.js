(function () {
    let _urlParams = (function (url) {
        var result = new Object();
        var idx = url.lastIndexOf('?');

        if (idx > 0) {
            var params = url
                .substring(idx + 1)
                .split('&');

            for (var i = 0; i < params.length; i++) {
                idx = params[i].indexOf('=');

                if (idx > 0) {
                    result[params[i].substring(0, idx)] = params[i].substring(idx + 1);
                }
            }
        }

        return result;
    })(window.location.href);
    this.winMsg = function () {
        var winMsg = {
            /**
             * Init the script, assign custom functions to window object
             * @returns {object} modelAlert
             */
            init: function () {
                if (typeof arguments[0] === 'object') {
                    for (var key in arguments[0]) {
                        if (this.args.hasOwnProperty(key)) {
                            this.args[key] = arguments[0][key];
                        }
                    }
                }

                this.head.insertBefore(this.getStyleTag(), this.head.firstChild);
                /*
                if (this.args.overrideNative === true) {
                    window.alert = this.alert;
                    window.confirm = this.confirm;
                    window.prompt = this.prompt;
                }

                window.winMsg.alert = this.alert;
                window.winMsg.confirm = this.confirm;
                window.winMsg.prompt = this.prompt;
                */
                window.alert = this.alert;
                window.confirm = this.confirm;
                window.prompt = this.prompt;
                window._ProId = _urlParams.id ? _urlParams.id : false;
                return this;
            },

            /**
             * Defualt arguments
             */
            args: {
                backgroundColor: '#fff',
                color: '#555',
                borderColor: '#ccc',
                titleBackgroundColor: '#2D8CF0',
                titleColor: '#fff',
                defaultButtonsText: { ok: '确认', cancel: '取消' },
                overlayColor: 'rgba(0, 0, 0, 0.5)',
                overlayBlur: 2,
                overrideNative: true
            },

            /**
             * Get head tag
             */
            head: document.head || document.getElementsByTagName('head')[0],

            /**
             * get style tag with CSS
             * @returns {object} style element
             */
            getStyleTag: function () {
                var styleTag = document.createElement('style');
                styleTag.type = 'text/css';
                styleTag.appendChild(document.createTextNode(this.getCSS()));
                return styleTag;
            },

            /**
             * build CSS based on user arguments
             * @returns {string} CSS for mordenAlert
             */
            getCSS: function () {
                var css = ".winMsgWrapper {background: " + this.args.backgroundColor + "; color: " + this.args.color + "; border: 1px solid " + this.args.borderColor + "; box-shadow: 0 0 5px rgba(0, 0, 0, 0.3); left: 50%; min-height: 120px; min-width: 240px; position: fixed; text-align: center; top: 50%; z-index: 999;font-size:14px;padding-bottom: 15px;}";
                css += ".winMsgWrapper h4 {background: " + this.args.titleBackgroundColor + "; color: " + this.args.titleColor + "; margin: 0; padding: 5px; font-size:16px;}";
                css += ".winMsgWrapper p {margin: 0;padding: 5px 10px;}";
                css += ".maInputWrapper input {width: 100%; max-width: 300px;height:30px;line-height:30px}";
                css += ".maInputWrapper input .button {padding:5px 12px;margin:5px}";
                css += ".winMsgOverlay {background: " + this.args.overlayColor + "; cursor: wait;height: 100%;left: 0;position: fixed;top: 0;width: 100%;z-index: 998;}";
                if (this.args.overlayBlur !== false) {
                    css += "body.maActive > *:not(script):not(link):not(.winMsgOverlay):not(.winMsgWrapper) {-webkit-filter: blur(" + this.args.overlayBlur + "px); filter: blur(" + this.args.overlayBlur + "px);}";
                }

                return css;
            },

            /**
             * extract arguments and assign default value for keys msg, title, callback, extra_var, buttons
             * @param {array} arguments
             * @returns {Object} args
             */
            extract_vars: function (fun_args) {
                var args = new Object();

                args.msg = fun_args[0] || '';
                args.title = fun_args[1] || 'Message';
                args.callback = typeof fun_args[2] === 'function' ? fun_args[2] : null;
                args.extra_var = typeof fun_args[3] !== 'undefined' ? fun_args[3] : '';
                args.buttons = typeof fun_args[4] === 'object' && fun_args[4] !== null ? fun_args[4] : this.args.defaultButtonsText;

                return args;
            },

            /**
             * Generate and return a unique ID
             * @param {String} [prefix=winMsg] - Prefix for ID 
             * @returns {String} unique ID
             */
            generateId: function (prefix) {
                prefix = typeof prefix !== 'undefined' ? prefix : 'winMsg';
                var time = new Date().getTime();
                return prefix + time;
            },

            /**
             * Bind a callback function on click of buttons
             * @param {String} id - ID of winMsg wrapper
             * @param {function} callbackFunc - A callback function
             * @param {*} paramA - First argument for callback function
             * @param {*} paramB - Second argument for callback function
             * @returns {(Boolean|NULL)} - Return false if no callback function provided else NULL
             */
            onClickFunction: function (id, callbackFunc, paramA, paramB) {
                window.winMsg.close(id);
                if (typeof callbackFunc !== 'function') {
                    return false;
                }

                if (typeof paramA === 'object' && 'value' in paramA) {
                    paramA = paramA.value;
                }

                callbackFunc(paramA, paramB);
            },

            /**
             * Custom alert function
             * @returns {NULL}
             */
            alert: function () {
                var args, html, inputOK, id, input_id;

                id = winMsg.generateId();
                input_id = winMsg.generateId('mAFocus');
                args = winMsg.extract_vars(arguments, 'alert');
                html = '<h4>' + args.title + '</h4><p>' + args.msg + '</p><input id="' + input_id + '" class="button btn btn-default" type="button" value="' + args.buttons.ok + '" />';

                window.winMsg.addRemoveClass('maActive');
                winMsg.createInsertHtml('div', 'winMsgOverlay', '', false, true);
                winMsg.createInsertHtml('div', 'winMsgWrapper', html, id);
                inputOK = document.getElementById(input_id);
                inputOK.focus();

                inputOK.onclick = winMsg.onClickFunction.bind(null, id, args.callback, true, args.extra_var);
            },

            /**
             * Custom confirm function
             * @returns {NULL}
             */
            confirm: function () {
                var args, html, wrapper, inputYes, inputNo, id, input_id;

                id = winMsg.generateId();
                input_id = winMsg.generateId('mAFocus');
                args = winMsg.extract_vars(arguments);
                html = '<h4>' + args.title + '</h4><p>' + args.msg + '</p>\n\
                <input id="'+ input_id + '" class="button btn btn-default maYes" type="button" value="' + args.buttons.ok + '" />\n\
                <input class="button btn btn-default maNo" type="button" value="'+ args.buttons.cancel + '" />';

                window.winMsg.addRemoveClass('maActive');
                winMsg.createInsertHtml('div', 'winMsgOverlay', '', false, true);
                wrapper = winMsg.createInsertHtml('div', 'winMsgWrapper', html, id);
                inputYes = document.getElementById(input_id);
                inputNo = wrapper.getElementsByClassName('maNo');

                inputYes.focus();
                inputYes.onclick = winMsg.onClickFunction.bind(null, id, args.callback, true, args.extra_var);
                inputNo[0].onclick = winMsg.onClickFunction.bind(null, id, args.callback, false, args.extra_var);
            },

            /**
             * Custom prompt function
             * @returns {NULL}
             */
            prompt: function () {
                var args, html, wrapper, inputYes, inputNo, inputStr, id, input_id, defval;

                id = winMsg.generateId();
                input_id = winMsg.generateId('mAFocus');
                args = winMsg.extract_vars(arguments);
                defval = args.extra_var || '';
                html = '<h4>' + args.title + '</h4><p>' + args.msg + '</p>\n\
                <p class="maInputWrapper"><input id="'+ input_id + '" class="maInput" type="text" value="' + defval +'" /></p>\n\
                <input class="button btn btn-default maNo" type="button" value="' + args.buttons.cancel + '" />\n\
                <input class="button btn btn-default maYes" type="button" value="'+ args.buttons.ok + '" />';

                window.winMsg.addRemoveClass('maActive');
                winMsg.createInsertHtml('div', 'winMsgOverlay', '', false, true);
                wrapper = winMsg.createInsertHtml('div', 'winMsgWrapper', html, id);
                inputStr = document.getElementById(input_id);
                inputYes = wrapper.getElementsByClassName('maYes');
                inputNo = wrapper.getElementsByClassName('maNo');

                inputStr.focus();
                inputYes[0].onclick = winMsg.onClickFunction.bind(null, id, args.callback, inputStr, args.extra_var);
                inputNo[0].onclick = winMsg.onClickFunction.bind(null, id, args.callback, false, args.extra_var);
                inputStr.addEventListener('keypress', function (e) {
                    if (e.key === 'Enter') {
                        inputYes[0].click();
                    }
                });
            },

            /**
             * Create an element and append to body
             * @param {string} elementType tagname
             * @param {string} cssClass class name for element
             * @param {string} html inner html
             * @param {string} id ID of popup
             * @param {boolean} is_overlay Flag to include an overlay
             * @returns {object} created element
             */
            createInsertHtml: function (elementType, cssClass, html, id, is_overlay) {
                is_overlay = (typeof is_overlay !== 'undefined') ? is_overlay : false;
                id = (typeof id !== 'undefined') ? id : false;
                var wrapper = document.createElement(elementType);
                wrapper.className = cssClass;
                if (id !== false) {
                    wrapper.id = id;
                }
                wrapper.innerHTML = html;
                document.body.appendChild(wrapper);
                if (is_overlay === false) {
                    wrapper.style.cssText = "margin-left: -" + (wrapper.offsetWidth / 2) + "px; margin-top: -" + (wrapper.offsetHeight / 2) + "px;";
                }
                return wrapper;
            }
        };

        /**
         * Init and return the modelAlert object
         */
        return winMsg.init(arguments[0]);
    };

    /* Public functions */

    /**
     * Close popup
     * @param {string} ID of popup to close
     * @returns {NULL}
     */
    this.winMsg.close = function (elemId) {
        var overlay = document.getElementsByClassName('winMsgOverlay');
        var elem = false;

        window.winMsg.addRemoveClass('maActive', true);

        if (elemId && (elem = document.getElementById(elemId))) {
            elem.remove();
        }

        if (typeof overlay[0] === 'object') {
            overlay[0].remove();
        }
    };

    /**
     * Add or remove CSS class from given element
     * @param {string} className Name of the CSS class to add or remove.
     * @param {boolean} remove Flag weather to remove or add default is true.
     * @param {object} tag Element object default is body
     * @returns {NULL}
     */
    this.winMsg.addRemoveClass = function (className, remove, tag) {
        if (typeof className === 'undefined') {
            return false;
        }

        remove = typeof remove !== 'undefined' ? remove : false;
        tag = typeof tag !== 'undefined' ? tag : (document.body || document.getElementsByTagName('body')[0]);

        if (remove === true) {
            tag.classList.remove(className);
        } else {
            tag.classList.add(className);
        }
    }
})();
winMsg();