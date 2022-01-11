window.rtf2html = (function () {
    //formathtml

    function rt_subclass(child, parent) {
        function ctor() { this.constructor = child; }
        ctor.prototype = parent.prototype;
        child.prototype = new ctor();
    }

    function SyntaxError(message, expected, found, offset, line, column) {
        this.message = message;
        this.expected = expected;
        this.found = found;
        this.offset = offset;
        this.line = line;
        this.column = column;

        this.name = "SyntaxError";
    }

    rt_subclass(SyntaxError, Error);

    function parse(input) {
        //console.log(input)
        var options = arguments.length > 1 ? arguments[1] : {},

            rt_FAILED = {},

            rt_startRuleFunctions = { document: rt_parsedocument },
            rt_startRuleFunction = rt_parsedocument,

            rt_c0 = rt_FAILED,
            rt_c1 = [],
            rt_c2 = function (group) { return group },
            rt_c3 = "{",
            rt_c4 = { type: "literal", value: "{", description: "\"{\"" },
            rt_c5 = "}",
            rt_c6 = { type: "literal", value: "}", description: "\"}\"" },
            rt_c7 = function (items) { return { group: items } },
            rt_c8 = function (group) { return group },
            rt_c9 = function (codes) { return codes },
            rt_c10 = function (text) { return text },
            rt_c11 = "\\",
            rt_c12 = { type: "literal", value: "\\", description: "\"\\\\\"" },
            rt_c13 = /^[0-9a-z\n*]/,
            rt_c14 = { type: "class", value: "[0-9a-z\\n*]", description: "[0-9a-z\\n*]" },
            rt_c15 = null,
            rt_c16 = function (code, optional) { return code.join('').replace('\n', '').replace('\r', '') + (optional || '') },
            rt_c17 = "\\'",
            rt_c18 = { type: "literal", value: "\\'", description: "\"\\\\'\"" },
            rt_c19 = /^[0-9a-f]/,
            rt_c20 = { type: "class", value: "[0-9a-f]", description: "[0-9a-f]" },
            rt_c21 = function (hex1, hex2) { return '\'' + hex1 + hex2 },
            rt_c22 = "?",
            rt_c23 = { type: "literal", value: "?", description: "\"?\"" },
            rt_c24 = function () { return '?' },
            rt_c25 = function (words) { return words.join('') },
            rt_c26 = /^[0-9A-Za-z.;:\-,!*&%@#()]/,
            rt_c27 = { type: "class", value: "[0-9A-Za-z.;:\\-,!*&%@#()]", description: "[0-9A-Za-z.;:\\-,!*&%@#()]" },
            rt_c28 = function (leadingSpace, chars, trailingSpace) { return (leadingSpace ? leadingSpace.join('') : '') + chars.join('') + (trailingSpace ? trailingSpace.join('') : '') },
            rt_c29 = " ",
            rt_c30 = { type: "literal", value: " ", description: "\" \"" },
            rt_c31 = function () { return " " },
            rt_c32 = "\n",
            rt_c33 = { type: "literal", value: "\n", description: "\"\\n\"" },
            rt_c34 = function () { return "" },
            rt_c35 = "\t",
            rt_c36 = { type: "literal", value: "\t", description: "\"\\t\"" },
            rt_c37 = function () { return "\t" },
            rt_c38 = "\r",
            rt_c39 = { type: "literal", value: "\r", description: "\"\\r\"" },

            rt_currPos = 0,
            rt_reportedPos = 0,
            rt_cachedPos = 0,
            rt_cachedPosDetails = { line: 1, column: 1, seenCR: false },
            rt_maxFailPos = 0,
            rt_maxFailExpected = [],
            rt_silentFails = 0,

            rt_result;

        if ("startRule" in options) {
            if (!(options.startRule in rt_startRuleFunctions)) {
                throw new Error("Can't start parsing from rule \"" + options.startRule + "\".");
            }

            rt_startRuleFunction = rt_startRuleFunctions[options.startRule];
        }

        function text() {
            return input.substring(rt_reportedPos, rt_currPos);
        }

        function offset() {
            return rt_reportedPos;
        }

        function line() {
            return rt_computePosDetails(rt_reportedPos).line;
        }

        function column() {
            return rt_computePosDetails(rt_reportedPos).column;
        }

        function expected(description) {
            throw rt_buildException(
                null,
                [{ type: "other", description: description }],
                rt_reportedPos
            );
        }

        function error(message) {
            throw rt_buildException(message, null, rt_reportedPos);
        }

        function rt_computePosDetails(pos) {
            function advance(details, startPos, endPos) {
                var p, ch;

                for (p = startPos; p < endPos; p++) {
                    ch = input.charAt(p);
                    if (ch === "\n") {
                        if (!details.seenCR) { details.line++; }
                        details.column = 1;
                        details.seenCR = false;
                    } else if (ch === "\r" || ch === "\u2028" || ch === "\u2029") {
                        details.line++;
                        details.column = 1;
                        details.seenCR = true;
                    } else {
                        details.column++;
                        details.seenCR = false;
                    }
                }
            }

            if (rt_cachedPos !== pos) {
                if (rt_cachedPos > pos) {
                    rt_cachedPos = 0;
                    rt_cachedPosDetails = { line: 1, column: 1, seenCR: false };
                }
                advance(rt_cachedPosDetails, rt_cachedPos, pos);
                rt_cachedPos = pos;
            }

            return rt_cachedPosDetails;
        }

        function rt_fail(expected) {
            if (rt_currPos < rt_maxFailPos) { return; }

            if (rt_currPos > rt_maxFailPos) {
                rt_maxFailPos = rt_currPos;
                rt_maxFailExpected = [];
            }

            rt_maxFailExpected.push(expected);
        }

        function rt_buildException(message, expected, pos) {
            function cleanupExpected(expected) {
                var i = 1;

                expected.sort(function (a, b) {
                    if (a.description < b.description) {
                        return -1;
                    } else if (a.description > b.description) {
                        return 1;
                    } else {
                        return 0;
                    }
                });

                while (i < expected.length) {
                    if (expected[i - 1] === expected[i]) {
                        expected.splice(i, 1);
                    } else {
                        i++;
                    }
                }
            }

            function buildMessage(expected, found) {
                function stringEscape(s) {
                    function hex(ch) { return ch.charCodeAt(0).toString(16).toUpperCase(); }

                    return s
                        .replace(/\\/g, '\\\\')
                        .replace(/"/g, '\\"')
                        .replace(/\x08/g, '\\b')
                        .replace(/\t/g, '\\t')
                        .replace(/\n/g, '\\n')
                        .replace(/\f/g, '\\f')
                        .replace(/\r/g, '\\r')
                        .replace(/[\x00-\x07\x0B\x0E\x0F]/g, function (ch) { return '\\x0' + hex(ch); })
                        .replace(/[\x10-\x1F\x80-\xFF]/g, function (ch) { return '\\x' + hex(ch); })
                        .replace(/[\u0180-\u0FFF]/g, function (ch) { return '\\u0' + hex(ch); })
                        .replace(/[\u1080-\uFFFF]/g, function (ch) { return '\\u' + hex(ch); });
                }

                var expectedDescs = new Array(expected.length),
                    expectedDesc, foundDesc, i;

                for (i = 0; i < expected.length; i++) {
                    expectedDescs[i] = expected[i].description;
                }

                expectedDesc = expected.length > 1
                    ? expectedDescs.slice(0, -1).join(", ")
                    + " or "
                    + expectedDescs[expected.length - 1]
                    : expectedDescs[0];

                foundDesc = found ? "\"" + stringEscape(found) + "\"" : "end of input";

                return "Expected " + expectedDesc + " but " + foundDesc + " found.";
            }

            var posDetails = rt_computePosDetails(pos),
                found = pos < input.length ? input.charAt(pos) : null;

            if (expected !== null) {
                cleanupExpected(expected);
            }

            return new SyntaxError(
                message !== null ? message : buildMessage(expected, found),
                expected,
                found,
                pos,
                posDetails.line,
                posDetails.column
            );
        }

        function rt_parsedocument() {
            var s0, s1, s2, s3;

            s0 = rt_currPos;
            s1 = rt_parsegroup();
            if (s1 !== rt_FAILED) {
                s2 = [];
                s3 = rt_parsespace();
                while (s3 !== rt_FAILED) {
                    s2.push(s3);
                    s3 = rt_parsespace();
                }
                if (s2 !== rt_FAILED) {
                    rt_reportedPos = s0;
                    s1 = rt_c2(s1);
                    s0 = s1;
                } else {
                    rt_currPos = s0;
                    s0 = rt_c0;
                }
            } else {
                rt_currPos = s0;
                s0 = rt_c0;
            }

            return s0;
        }

        function rt_parsegroup() {
            var s0, s1, s2, s3, s4, s5;

            s0 = rt_currPos;
            s1 = [];
            s2 = rt_parsespace();
            while (s2 !== rt_FAILED) {
                s1.push(s2);
                s2 = rt_parsespace();
            }
            if (s1 !== rt_FAILED) {
                if (input.charCodeAt(rt_currPos) === 123) {
                    s2 = rt_c3;
                    rt_currPos++;
                } else {
                    s2 = rt_FAILED;
                    if (rt_silentFails === 0) { rt_fail(rt_c4); }
                }
                if (s2 !== rt_FAILED) {
                    s3 = [];
                    s4 = rt_parseitem();
                    while (s4 !== rt_FAILED) {
                        s3.push(s4);
                        s4 = rt_parseitem();
                    }
                    if (s3 !== rt_FAILED) {
                        s4 = [];
                        s5 = rt_parsespace();
                        while (s5 !== rt_FAILED) {
                            s4.push(s5);
                            s5 = rt_parsespace();
                        }
                        if (s4 !== rt_FAILED) {
                            if (input.charCodeAt(rt_currPos) === 125) {
                                s5 = rt_c5;
                                rt_currPos++;
                            } else {
                                s5 = rt_FAILED;
                                if (rt_silentFails === 0) { rt_fail(rt_c6); }
                            }
                            if (s5 !== rt_FAILED) {
                                rt_reportedPos = s0;
                                s1 = rt_c7(s3);
                                s0 = s1;
                            } else {
                                rt_currPos = s0;
                                s0 = rt_c0;
                            }
                        } else {
                            rt_currPos = s0;
                            s0 = rt_c0;
                        }
                    } else {
                        rt_currPos = s0;
                        s0 = rt_c0;
                    }
                } else {
                    rt_currPos = s0;
                    s0 = rt_c0;
                }
            } else {
                rt_currPos = s0;
                s0 = rt_c0;
            }

            return s0;
        }

        function rt_parseitem() {
            var s0, s1;

            s0 = rt_currPos;
            s1 = rt_parsegroup();
            if (s1 !== rt_FAILED) {
                rt_reportedPos = s0;
                s1 = rt_c8(s1);
            }
            s0 = s1;
            if (s0 === rt_FAILED) {
                s0 = rt_currPos;
                s1 = rt_parsecodes();
                if (s1 !== rt_FAILED) {
                    rt_reportedPos = s0;
                    s1 = rt_c9(s1);
                }
                s0 = s1;
                if (s0 === rt_FAILED) {
                    s0 = rt_currPos;
                    s1 = rt_parsetext();
                    if (s1 !== rt_FAILED) {
                        rt_reportedPos = s0;
                        s1 = rt_c10(s1);
                    }
                    s0 = s1;
                }
            }

            return s0;
        }

        function rt_parsecodes() {
            var s0, s1, s2;

            s0 = rt_currPos;
            s1 = [];
            s2 = rt_parsecode();
            if (s2 !== rt_FAILED) {
                while (s2 !== rt_FAILED) {
                    s1.push(s2);
                    s2 = rt_parsecode();
                }
            } else {
                s1 = rt_c0;
            }
            if (s1 !== rt_FAILED) {
                rt_reportedPos = s0;
                s1 = rt_c9(s1);
            }
            s0 = s1;

            return s0;
        }

        function rt_parsecode() {
            var s0, s1, s2, s3, s4;

            s0 = rt_currPos;
            s1 = [];
            s2 = rt_parsespace();
            while (s2 !== rt_FAILED) {
                s1.push(s2);
                s2 = rt_parsespace();
            }
            if (s1 !== rt_FAILED) {
                if (input.charCodeAt(rt_currPos) === 92) {
                    s2 = rt_c11;
                    rt_currPos++;
                } else {
                    s2 = rt_FAILED;
                    if (rt_silentFails === 0) { rt_fail(rt_c12); }
                }
                if (s2 !== rt_FAILED) {
                    s3 = [];
                    if (rt_c13.test(input.charAt(rt_currPos))) {
                        s4 = input.charAt(rt_currPos);
                        rt_currPos++;
                    } else {
                        s4 = rt_FAILED;
                        if (rt_silentFails === 0) { rt_fail(rt_c14); }
                    }
                    if (s4 !== rt_FAILED) {
                        while (s4 !== rt_FAILED) {
                            s3.push(s4);
                            if (rt_c13.test(input.charAt(rt_currPos))) {
                                s4 = input.charAt(rt_currPos);
                                rt_currPos++;
                            } else {
                                s4 = rt_FAILED;
                                if (rt_silentFails === 0) { rt_fail(rt_c14); }
                            }
                        }
                    } else {
                        s3 = rt_c0;
                    }
                    if (s3 !== rt_FAILED) {
                        s4 = rt_parseoptional();
                        if (s4 === rt_FAILED) {
                            s4 = rt_c15;
                        }
                        if (s4 !== rt_FAILED) {
                            rt_reportedPos = s0;
                            s1 = rt_c16(s3, s4);
                            s0 = s1;
                        } else {
                            rt_currPos = s0;
                            s0 = rt_c0;
                        }
                    } else {
                        rt_currPos = s0;
                        s0 = rt_c0;
                    }
                } else {
                    rt_currPos = s0;
                    s0 = rt_c0;
                }
            } else {
                rt_currPos = s0;
                s0 = rt_c0;
            }
            if (s0 === rt_FAILED) {
                s0 = rt_currPos;
                s1 = [];
                s2 = rt_parsespace();
                while (s2 !== rt_FAILED) {
                    s1.push(s2);
                    s2 = rt_parsespace();
                }
                if (s1 !== rt_FAILED) {
                    if (input.substr(rt_currPos, 2) === rt_c17) {
                        s2 = rt_c17;
                        rt_currPos += 2;
                    } else {
                        s2 = rt_FAILED;
                        if (rt_silentFails === 0) { rt_fail(rt_c18); }
                    }
                    if (s2 !== rt_FAILED) {
                        if (rt_c19.test(input.charAt(rt_currPos))) {
                            s3 = input.charAt(rt_currPos);
                            rt_currPos++;
                        } else {
                            s3 = rt_FAILED;
                            if (rt_silentFails === 0) { rt_fail(rt_c20); }
                        }
                        if (s3 !== rt_FAILED) {
                            if (rt_c19.test(input.charAt(rt_currPos))) {
                                s4 = input.charAt(rt_currPos);
                                rt_currPos++;
                            } else {
                                s4 = rt_FAILED;
                                if (rt_silentFails === 0) { rt_fail(rt_c20); }
                            }
                            if (s4 !== rt_FAILED) {
                                rt_reportedPos = s0;
                                s1 = rt_c21(s3, s4);
                                s0 = s1;
                            } else {
                                rt_currPos = s0;
                                s0 = rt_c0;
                            }
                        } else {
                            rt_currPos = s0;
                            s0 = rt_c0;
                        }
                    } else {
                        rt_currPos = s0;
                        s0 = rt_c0;
                    }
                } else {
                    rt_currPos = s0;
                    s0 = rt_c0;
                }
            }

            return s0;
        }

        function rt_parseoptional() {
            var s0, s1, s2;

            s0 = rt_currPos;
            s1 = [];
            s2 = rt_parsespace();
            while (s2 !== rt_FAILED) {
                s1.push(s2);
                s2 = rt_parsespace();
            }
            if (s1 !== rt_FAILED) {
                if (input.charCodeAt(rt_currPos) === 63) {
                    s2 = rt_c22;
                    rt_currPos++;
                } else {
                    s2 = rt_FAILED;
                    if (rt_silentFails === 0) { rt_fail(rt_c23); }
                }
                if (s2 !== rt_FAILED) {
                    rt_reportedPos = s0;
                    s1 = rt_c24();
                    s0 = s1;
                } else {
                    rt_currPos = s0;
                    s0 = rt_c0;
                }
            } else {
                rt_currPos = s0;
                s0 = rt_c0;
            }

            return s0;
        }

        function rt_parsetext() {
            var s0, s1, s2;

            s0 = rt_currPos;
            s1 = [];
            s2 = rt_parseword();
            if (s2 !== rt_FAILED) {
                while (s2 !== rt_FAILED) {
                    s1.push(s2);
                    s2 = rt_parseword();
                }
            } else {
                s1 = rt_c0;
            }
            if (s1 !== rt_FAILED) {
                rt_reportedPos = s0;
                s1 = rt_c25(s1);
            }
            s0 = s1;

            return s0;
        }

        function rt_parseword() {
            var s0, s1, s2, s3, s4;

            s0 = rt_currPos;
            s1 = [];
            s2 = rt_parsespace();
            while (s2 !== rt_FAILED) {
                s1.push(s2);
                s2 = rt_parsespace();
            }
            if (s1 !== rt_FAILED) {
                s2 = [];
                if (rt_c26.test(input.charAt(rt_currPos))) {
                    s3 = input.charAt(rt_currPos);
                    rt_currPos++;
                } else {
                    s3 = rt_FAILED;
                    if (rt_silentFails === 0) { rt_fail(rt_c27); }
                }
                if (s3 !== rt_FAILED) {
                    while (s3 !== rt_FAILED) {
                        s2.push(s3);
                        if (rt_c26.test(input.charAt(rt_currPos))) {
                            s3 = input.charAt(rt_currPos);
                            rt_currPos++;
                        } else {
                            s3 = rt_FAILED;
                            if (rt_silentFails === 0) { rt_fail(rt_c27); }
                        }
                    }
                } else {
                    s2 = rt_c0;
                }
                if (s2 !== rt_FAILED) {
                    s3 = [];
                    s4 = rt_parsespace();
                    while (s4 !== rt_FAILED) {
                        s3.push(s4);
                        s4 = rt_parsespace();
                    }
                    if (s3 !== rt_FAILED) {
                        rt_reportedPos = s0;
                        s1 = rt_c28(s1, s2, s3);
                        s0 = s1;
                    } else {
                        rt_currPos = s0;
                        s0 = rt_c0;
                    }
                } else {
                    rt_currPos = s0;
                    s0 = rt_c0;
                }
            } else {
                rt_currPos = s0;
                s0 = rt_c0;
            }

            return s0;
        }

        function rt_parsespace() {
            var s0, s1;

            s0 = rt_currPos;
            if (input.charCodeAt(rt_currPos) === 32) {
                s1 = rt_c29;
                rt_currPos++;
            } else {
                s1 = rt_FAILED;
                if (rt_silentFails === 0) { rt_fail(rt_c30); }
            }
            if (s1 !== rt_FAILED) {
                rt_reportedPos = s0;
                s1 = rt_c31();
            }
            s0 = s1;
            if (s0 === rt_FAILED) {
                s0 = rt_currPos;
                if (input.charCodeAt(rt_currPos) === 10) {
                    s1 = rt_c32;
                    rt_currPos++;
                } else {
                    s1 = rt_FAILED;
                    if (rt_silentFails === 0) { rt_fail(rt_c33); }
                }
                if (s1 !== rt_FAILED) {
                    rt_reportedPos = s0;
                    s1 = rt_c34();
                }
                s0 = s1;
                if (s0 === rt_FAILED) {
                    s0 = rt_currPos;
                    if (input.charCodeAt(rt_currPos) === 9) {
                        s1 = rt_c35;
                        rt_currPos++;
                    } else {
                        s1 = rt_FAILED;
                        if (rt_silentFails === 0) { rt_fail(rt_c36); }
                    }
                    if (s1 !== rt_FAILED) {
                        rt_reportedPos = s0;
                        s1 = rt_c37();
                    }
                    s0 = s1;
                    if (s0 === rt_FAILED) {
                        s0 = rt_currPos;
                        if (input.charCodeAt(rt_currPos) === 13) {
                            s1 = rt_c38;
                            rt_currPos++;
                        } else {
                            s1 = rt_FAILED;
                            if (rt_silentFails === 0) { rt_fail(rt_c39); }
                        }
                        if (s1 !== rt_FAILED) {
                            rt_reportedPos = s0;
                            s1 = rt_c34();
                        }
                        s0 = s1;
                    }
                }
            }

            return s0;
        }

        rt_result = rt_startRuleFunction();
        //console.log(rt_result)
        if (rt_result !== rt_FAILED && rt_currPos === input.length) {
            return rt_result;
        } else {
            if (rt_result !== rt_FAILED && rt_currPos < input.length) {
                rt_fail({ type: "end", description: "end of input" });
            }

            throw rt_buildException(null, rt_maxFailExpected, rt_maxFailPos);
        }
    }

    return {
        SyntaxError: SyntaxError,
        parse: parse
    };
})();

window.rtfFormat = ((parsedRtf, options) => {
    class StyleManager {
        constructor(content) {
            this._content = content;
            this._stack = [{}];
            this._started = false;
            this._applied = undefined;
        }

        static formatStyles(styles) {
            let style = '';
            for (var key in styles) {
                if (!this.ignoreStyle(key, styles[key])) {
                    if (style) {
                        style += ' ';
                    }
                    style += key + ': ' + styles[key] + ';'
                }
            }
            return style;
        }

        static isLineStyle(style) {
            if ((style === 'text-indent') ||
                (style === 'text-align') ||
                (style === 'white-space')) {
                return true;
            }
        }

        static ignoreStyle(style, value) {
            switch (style) {
                case 'text-indent': return !value;
                case 'white-space': return value === 'normal';
                case 'font-weight': return value === 'normal';
                case 'font-style': return value === 'normal';
                case 'color': return value === 'inherit';
            }
        }

        set(style, value) {
            this._stack[this._stack.length - 1][style] = value;
        }

        getLineStyles(newStyles) {
            newStyles = newStyles || {};
            newStyles.display = newStyles.display || 'inline-block';
            for (var i = this._stack.length - 1; i >= 0; i--) {
                const styles = this._stack[i];
                for (var key in styles) {
                    if (StyleManager.isLineStyle(key)) {
                        newStyles[key] = newStyles[key] || styles[key];
                    }
                }
            }
            return StyleManager.formatStyles(newStyles);
        }

        push() {
            this._stack.push({});
        }

        pop() {
            //assert.equal(!!this._stack.pop(), true);
            return !!this._stack.pop() === true;
        }

        apply() {
            const newStyles = {};
            for (var i = this._stack.length - 1; i >= 0; i--) {
                const styles = this._stack[i];
                for (var key in styles) {
                    if (!StyleManager.isLineStyle(key)) {
                        newStyles[key] = newStyles[key] || styles[key];
                    }
                }
            }
            const formattedStyles = StyleManager.formatStyles(newStyles);
            if (this._applied === undefined) {
                this._content.push('<span style="' + formattedStyles + '">');
            }
            else if (this._applied !== formattedStyles) {
                this._content.push('</span><span style="' + formattedStyles + '">');
            }
            this._applied = formattedStyles;
        }

        begin() {
            this._started = true;
            this._applied = undefined;
        }

        end() {
            this._started = false;
            if (this._applied !== undefined) {
                this._content.push('</span>');
            }
            this._applied = undefined;
        }
    }

    function twipToPx(twip) {
        return Math.floor(twip / 9);
    }

    function beginRightAlignedTab(context) {
        context.rightAlignedTab = true;
        context.res[context.divIndex] = '<div style="' + context.styles.getLineStyles({ 'text-align': 'right' }) + ' width: ' + getTabWidth(context) + 'px;">';
    }

    function endRightAlignedTab(context) {
        if (context.rightAlignedTab) {
            context.rightAlignedTab = false;
        }
    }

    function getTabWidth(context) {
        const begin = (context.tabIndex === 0) ? 0 : context.tabs[context.tabIndex - 1].pos;
        const end = ((context.tabIndex + 1) < context.tabs.length) ? context.tabs[context.tabIndex].pos : getContentWidth(context);
        return end - begin;
    }

    function getContentWidth(context) {
        return twipToPx((context.width || context.paperWidth) - context.margins[3] - context.margins[1]);
    }

    function getContentHeight(context) {
        return twipToPx((context.height || context.paperHeight) - context.margins[0] - context.margins[2]);
    }

    function parseIntCode(code, prefix) {
        if (code.substring(0, prefix.length) === prefix) {
            //console.log(code);
            return parseInt(code.substring(prefix.length));
        }
    }

    function rgbToHex(r, g, b) {
        r = r.toString(16);
        r = r.length == 1 ? '0' + r : r;
        g = g.toString(16);
        g = g.length == 1 ? '0' + g : g;
        b = b.toString(16);
        b = b.length == 1 ? '0' + b : b;
        return '#' + r + g + b;
    }

    const GroupType = {
        ROOT: -1,
        NORMAL: 0,
        COLORTABLE: 1,
        FONTTABLE: 2
    }

    function processFontTable(context, data) {
        const font = {
            index: 0
        };
        for (var i = 0; i < data.length; i++) {
            const item = data[i];
            if (Array.isArray(item)) {
                for (var j = 0; j < item.length; j++) {
                    const code = item[j];
                    font.index = parseIntCode(code, 'f') || font.index;
                }
            }
            else if (typeof item === 'string') {
                font.name = item.substring(0, item.length - 1); // trim ';'
                const dashIndex = font.name.indexOf('-');
                if (dashIndex >= 0) {
                    font.name = font.name.substring(0, dashIndex);
                }
            }
        }
        if (font.index !== undefined) {
            context.fonts.length = Math.max(context.fonts.length, font.index + 1);
            context.fonts[font.index] = font;
        }
    }

    function processString(context, localState, item) {
        if (localState.childGroupType === GroupType.COLORTABLE) {
            context.colors.push(rgbToHex(context.redColor, context.greenColor, context.blueColor));
            context.redColor = 0;
            context.greenColor = 0;
            context.blueColor = 0;
        }
        else if (!localState.ignoreNextText) {
            if (context.divIndex < 0) {
                context.divIndex = context.res.length;
                context.res.push('<div style="' + context.styles.getLineStyles() + ' width: ' + getContentWidth(context) + 'px;">');
                context.styles.begin();
            }
            context.styles.apply();
            context.res.push(item);
        }
        else {
            localState.ignoreNextText = false;
        }
    }

    function format(context, data, groupType) {
        const localState = {
            childGroupType: GroupType.NORMAL
        };
        for (var i = 0; i < data.length; i++) {
            const item = data[i];
            if (Array.isArray(item)) {
                let resetTabs = true;
                let tabAlign;
                let insertText;
                for (var j = 0; j < item.length; j++) {
                    const code = item[j];
                    switch (code) {
                        case 'par':
                            endRightAlignedTab(context);
                            if (context.divIndex >= 0) {
                                context.styles.end();
                                context.res.push('</div>');
                                context.divIndex = -1;
                            }
                            context.tabIndex = 0;
                            context.res.push('<br>\n');
                            break;
                        case 'tab':
                            if (context.tabIndex < context.tabs.length) {
                                if (context.divIndex < 0) {
                                    context.divIndex = context.res.length;
                                    context.res.push('<div style="' + context.styles.getLineStyles() + ' width: ' + getContentWidth(context) + 'px;">');
                                    context.styles.begin();
                                }
                                if (context.rightAlignedTab) {
                                    endRightAlignedTab(context);
                                    context.styles.end();
                                    context.res.push('</div>');
                                    context.divIndex = context.res.length;
                                    context.res.push('<div style="' + context.styles.getLineStyles() + '">');
                                    context.styles.begin();
                                }
                                const tab = context.tabs[context.tabIndex];
                                context.res[context.divIndex] = '<div style="' + context.styles.getLineStyles() + ' width: ' + getTabWidth(context) + 'px;">';
                                if (tab.align === 'right') {
                                    beginRightAlignedTab(context);
                                    context.tabIndex++;
                                }
                                else {
                                    context.tabIndex++;
                                    context.styles.end();
                                    context.res.push('</div>');
                                    context.divIndex = context.res.length;
                                    context.res.push('<div style="' + context.styles.getLineStyles() + ' width: ' + (getContentWidth(context) - tab.pos) + 'px;">');
                                    context.styles.begin();
                                }
                            }
                            break;
                        case 'fonttbl':
                            localState.childGroupType = GroupType.FONTTABLE;
                            context.fonts = [];
                            break;
                        case 'colortbl':
                            localState.childGroupType = GroupType.COLORTABLE;
                            context.colors = [];
                            context.redColor = 0;
                            context.greenColor = 0;
                            context.blueColor = 0;
                            break;
                        case 'stylesheet':
                            localState.ignoreAll = true;
                            break;
                        case 'expndtw':
                        case 'up':
                            localState.ignoreNextText = true;
                            break;
                        case 'tqr':
                            context.tabs = resetTabs ? [] : context.tabs;
                            resetTabs = false;
                            tabAlign = 'right';
                            break;
                        case 'i': context.styles.set('font-style', 'italic'); break;
                        case 'i0': context.styles.set('font-style', 'normal'); break;
                        case 'b': context.styles.set('font-weight', 'bold'); break;
                        case 'b0': context.styles.set('font-weight', 'normal'); break;
                        case 'ql':
                        case 'qc':
                        case 'qr':
                            context.styles.set('text-align', (code === 'qc') ? 'center' : (code === 'qr') ? 'right' : 'left');
                            break;
                        case '\'8e': insertText = '&#xe9'; break;
                        case '\'8f': insertText = '&#xe8'; break;
                        case '\'90': insertText = '&#xeA'; break;
                        case '\'91': insertText = '&#xeA'; break;
                        case '\'95': insertText = '&#xeE'; break;
                        case '\'ca': insertText = '&nbsp;'; break;
                        case '\'d0': insertText = '&ndash;'; break;
                    }
                    if (groupType === GroupType.ROOT) {
                        context.paperWidth = parseIntCode(code, 'paperw') || context.paperWidth;
                        context.paperHeight = parseIntCode(code, 'paperh') || context.paperHeight;
                        context.marginLeft = parseIntCode(code, 'margl') || context.marginLeft;
                        context.marginRight = parseIntCode(code, 'margr') || context.marginRight;
                        context.marginTop = parseIntCode(code, 'margt') || context.marginTop;
                        context.marginBottom = parseIntCode(code, 'margb') || context.marginBottom;
                    }
                    else if (localState.childGroupType === GroupType.COLORTABLE) {
                        context.redColor = parseIntCode(code, 'red') || context.redColor;
                        context.greenColor = parseIntCode(code, 'green') || context.greenColor;
                        context.blueColor = parseIntCode(code, 'blue') || context.blueColor;
                    }
                    let fontSize = code.match(/fs(\d+)/);
                    if (fontSize) {
                        context.styles.set('font-size', fontSize[0].substring(2) + 'px');
                    }
                    let tabStop = code.match(/tx(\d+)/);
                    if (tabStop) {
                        context.tabs = resetTabs ? [] : context.tabs;
                        resetTabs = false;
                        context.tabs.push({
                            pos: twipToPx(tabStop[0].substring(2)),
                            align: tabAlign || 'left'
                        });
                        tabAlign = undefined;
                    }
                    let leftIndent = parseIntCode(code, 'li');
                    if (leftIndent !== undefined) {
                        context.styles.set('text-indent', leftIndent ? (twipToPx(leftIndent) + 'px') : 0);
                        context.styles.set('white-space', leftIndent ? 'nowrap' : 'normal');
                    }
                    let colorIndex = parseIntCode(code, 'cf');
                    if ((colorIndex !== undefined) && (colorIndex < context.colors.length)) {
                        if (context.colors[colorIndex] !== context.colors[0]) {
                            context.styles.set('color', context.colors[colorIndex]);
                        }
                        else {
                            context.styles.set('color', 'inherit');
                        }
                    }
                    if (insertText) {
                        if (!localState.ignoreAll) {
                            processString(context, localState, insertText);
                        }
                        insertText = undefined;
                    }
                }
            }
            else {
                if (!localState.ignoreAll) {
                    if (typeof item === 'string') {
                        processString(context, localState, item);
                    }
                    else {
                        if (localState.childGroupType === GroupType.FONTTABLE) {
                            context.styles.push();
                            processFontTable(context, item.group);
                            context.styles.pop();
                        }
                        else {
                            context.styles.push();
                            format(context, item.group, localState.childGroupType);
                            context.styles.pop();
                        }
                    }
                }
            }
        }
        return context.res;
    }
    return function (parsedRtf, options) {
        //console.log(parsedRtf)
        //return;
        const res = [];
        const context = {
            res: res,
            divIndex: -1,
            styles: new StyleManager(res),
            tabIndex: 0,
            tabs: [],
            colors: [],
            fonts: [],
            margins: options.margins,
            width: options.width,
            height: options.height
        };
        format(context, parsedRtf.group, GroupType.ROOT);
        const bodyStyles = {
            'margin': 0,
            'width': twipToPx(context.width || context.paperWidth) + 'px',
            'height': twipToPx(context.height || context.paperHeight) + 'px',
            'color': context.colors.length ? context.colors[0] : '#000000'
        };
        const font = context.fonts.length ? context.fonts[0].name : undefined;
        if (font) {
            bodyStyles['font-family'] = font;
        }
        const mainDivStyles = {
            'position': 'absolute',
            'left': twipToPx(context.margins[3]) + 'px',
            'top': twipToPx(context.margins[0]) + 'px',
            'width': getContentWidth(context) + 'px',
            'height': getContentHeight(context) + 'px'
        };
        let innerDivStyles = {};
        switch (options.vertAlign) {
            case 'center':
                innerDivStyles = {
                    'position': 'relative',
                    'top': '50%',
                    '-webkit-transform': 'translateY(-50%)',
                    '-moz-transform': 'translateY(-50%)',
                    '-ms-transform': 'translateY(-50%)',
                    '-o-transform': 'translateY(-50%)',
                    'transform': 'translateY(-50%)',
                    'display': 'block'
                };
                break;
            case 'bottom':
                innerDivStyles = {
                    'position': 'absolute',
                    'bottom': '0'
                };
                break;
        }
        //return context.res.join('');
        
        return '' +
            '<html>\n' +
            '<body style="' + StyleManager.formatStyles(bodyStyles) + '">\n' +
            ' <div style="' + StyleManager.formatStyles(mainDivStyles) + '">\n' +
            '  <div style="' + StyleManager.formatStyles(innerDivStyles) + '">\n' +
            context.res.join('') +
            '  </div>\n' +
            ' </div>\n' +
            '</body>\n' +
            '</html>';
        
    };
})();