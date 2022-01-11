/*
 * jQuery 老黄历
 *
 * Copyright (c) 2015 NavCat
 *
 * @author NavCat
 * @contact yima1006@foxmail.com
 *
 */

;(function($) {
    jQuery.fn.almanac = function(options){
    
    var Almanac = {
        // 农历1900-2100的润大小信息表
        lunarInfo: [
            0x4bd8, 0x4ae0, 0xa570, 0x54d5, 0xd260, 0xd950, 0x5554, 0x56af, 0x9ad0, 0x55d2,
            0x4ae0, 0xa5b6, 0xa4d0, 0xd250, 0xd255, 0xb54f, 0xd6a0, 0xada2, 0x95b0, 0x4977,
            0x497f, 0xa4b0, 0xb4b5, 0x6a50, 0x6d40, 0xab54, 0x2b6f, 0x9570, 0x52f2, 0x4970,
            0x6566, 0xd4a0, 0xea50, 0x6a95, 0x5adf, 0x2b60, 0x86e3, 0x92ef, 0xc8d7, 0xc95f,
            0xd4a0, 0xd8a6, 0xb55f, 0x56a0, 0xa5b4, 0x25df, 0x92d0, 0xd2b2, 0xa950, 0xb557,
            0x6ca0, 0xb550, 0x5355, 0x4daf, 0xa5b0, 0x4573, 0x52bf, 0xa9a8, 0xe950, 0x6aa0,
            0xaea6, 0xab50, 0x4b60, 0xaae4, 0xa570, 0x5260, 0xf263, 0xd950, 0x5b57, 0x56a0,
            0x96d0, 0x4dd5, 0x4ad0, 0xa4d0, 0xd4d4, 0xd250, 0xd558, 0xb540, 0xb6a0, 0x95a6,
            0x95bf, 0x49b0, 0xa974, 0xa4b0, 0xb27a, 0x6a50, 0x6d40, 0xaf46, 0xab60, 0x9570,
            0x4af5, 0x4970, 0x64b0, 0x74a3, 0xea50, 0x6b58, 0x5ac0, 0xab60, 0x96d5, 0x92e0,
            0xc960, 0xd954, 0xd4a0, 0xda50, 0x7552, 0x56a0, 0xabb7, 0x25d0, 0x92d0, 0xcab5,
            0xa950, 0xb4a0, 0xbaa4, 0xad50, 0x55d9, 0x4ba0, 0xa5b0, 0x5176, 0x52bf, 0xa930,
            0x7954, 0x6aa0, 0xad50, 0x5b52, 0x4b60, 0xa6e6, 0xa4e0, 0xd260, 0xea65, 0xd530,
            0x5aa0, 0x76a3, 0x96d0, 0x4afb, 0x4ad0, 0xa4d0, 0xd0b6, 0xd25f, 0xd520, 0xdd45,
            0xb5a0, 0x56d0, 0x55b2, 0x49b0, 0xa577, 0xa4b0, 0xaa50, 0xb255, 0x6d2f, 0xada0,
            0x4b63, 0x937f, 0x49f8, 0x4970, 0x64b0, 0x68a6, 0xea5f, 0x6b20, 0xa6c4, 0xaaef,
            0x92e0, 0xd2e3, 0xc960, 0xd557, 0xd4a0, 0xda50, 0x5d55, 0x56a0, 0xa6d0, 0x55d4,
            0x52d0, 0xa9b8, 0xa950, 0xb4a0, 0xb6a6, 0xad50, 0x55a0, 0xaba4, 0xa5b0, 0x52b0,
            0xb273, 0x6930, 0x7337, 0x6aa0, 0xad50, 0x4b55, 0x4b6f, 0xa570, 0x54e4, 0xd260,
            0xe968, 0xd520, 0xdaa0, 0x6aa6, 0x56df, 0x4ae0, 0xa9d4, 0xa4d0, 0xd150, 0xf252,
            0xd520],

        // 公历每个月份的天数普通表
        solarMonth: [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
        // 天干
        gan : ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"],
        // 地支
        zhi : ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"],
        // 生肖
        animals : ["鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪"],
        // 二十四节气
        solarTerm : ["小寒", "大寒", "立春", "雨水", "惊蛰", "春分", "清明", "谷雨", "立夏",
                    "小满", "芒种", "夏至", "小暑", "大暑", "立秋", "处暑", "白露", "秋分", 
                    "寒露", "霜降", "立冬", "小雪", "大雪", "冬至"],
        sTermInfo : [0, 21208, 42467, 63836, 85337, 107014, 128867, 150921, 173149, 195551, 
                    218072, 240693, 263343, 285989, 308563, 331033, 353350, 375494, 397447, 
                    419210, 440795, 462224, 483532, 504758],
        nStr1 : ['日', '一', '二', '三', '四', '五', '六', '七', '八', '九', '十'],
        nStr2 : ['初', '十', '廿', '卅', ' '],

        jcName0 : ['建', '除', '满', '平', '定', '执', '破', '危', '成', '收', '开', '闭'],
        jcName1 : ['闭', '建', '除', '满', '平', '定', '执', '破', '危', '成', '收', '开'],
        jcName2 : ['开', '闭', '建', '除', '满', '平', '定', '执', '破', '危', '成', '收'],
        jcName3 : ['收', '开', '闭', '建', '除', '满', '平', '定', '执', '破', '危', '成'],
        jcName4 : ['成', '收', '开', '闭', '建', '除', '满', '平', '定', '执', '破', '危'],
        jcName5 : ['危', '成', '收', '开', '闭', '建', '除', '满', '平', '定', '执', '破'],
        jcName6 : ['破', '危', '成', '收', '开', '闭', '建', '除', '满', '平', '定', '执'],
        jcName7 : ['执', '破', '危', '成', '收', '开', '闭', '建', '除', '满', '平', '定'],
        jcName8 : ['定', '执', '破', '危', '成', '收', '开', '闭', '建', '除', '满', '平'],
        jcName9 : ['平', '定', '执', '破', '危', '成', '收', '开', '闭', '建', '除', '满'],
        jcName10 : ['满', '平', '定', '执', '破', '危', '成', '收', '开', '闭', '建', '除'],
        jcName11 : ['除', '满', '平', '定', '执', '破', '危', '成', '收', '开', '闭', '建'],

        jcr: function (d) {
            var jcrjx;
            if (d == '建') jcrjx = {'suited': ['出行', '上任', '会友', '上书', '见工'], 'tapu': ['动土', '开仓', '嫁娶', '纳采']};
            if (d == '除') jcrjx = {'suited': ['除服', '疗病', '出行', '拆卸', '入宅'], 'tapu': ['求官', '上任', '开张', '搬家', '探病']};
            if (d == '满') jcrjx = {'suited': ['祈福', '祭祀', '结亲', '开市', '交易'], 'tapu': ['服药', '求医', '栽种', '动土', '迁移']};
            if (d == '平') jcrjx = {'suited': ['祭祀', '修填', '涂泥', '余事勿取'], 'tapu': ['移徙', '入宅', '嫁娶', '开市', '安葬']};
            if (d == '定') jcrjx = {'suited': ['易', '立券', '会友', '签约', '纳畜'], 'tapu': ['种植', '置业', '卖田', '掘井', '造船']};
            if (d == '执') jcrjx = {'suited': ['祈福', '祭祀', '求子', '结婚', '立约'], 'tapu': ['开市', '交易', '搬家', '远行']};
            if (d == '破') jcrjx = {'suited': ['求医', '赴考', '祭祀', '余事勿取'], 'tapu': ['动土', '出行', '移徙', '开市', '修造']};
            if (d == '危') jcrjx = {'suited': ['经营', '交易', '求官', '纳畜', '动土'], 'tapu': ['登高', '行船', '安床', '入宅', '博彩']};
            if (d == '成') jcrjx = {'suited': ['祈福', '入学', '开市', '求医', '成服'], 'tapu': ['词讼', '安门', '移徙']};
            if (d == '收') jcrjx = {'suited': ['祭祀', '求财', '签约', '嫁娶', '订盟'], 'tapu': ['开市', '安床', '安葬', '入宅', '破土']};
            if (d == '开') jcrjx = {'suited': ['疗病', '结婚', '交易', '入仓', '求职'], 'tapu': ['安葬', '动土', '针灸']};
            if (d == '闭') jcrjx = {'suited': ['祭祀', '交易', '收财', '安葬'], 'tapu': ['宴会', '安床', '出行', '嫁娶', '移徙']};
            return jcrjx;
        },

        //国历节日  *表示放假日
        sFtv : [
                "0101*元旦",
                "0106  中国13亿人口日",
                "0110  中国110宣传日",

                "0202  世界湿地日",
                "0204  世界抗癌症日",
                "0210  世界气象日",
                "0214  情人节",
                "0221  国际母语日",
                "0207  国际声援南非日",

                "0303  全国爱耳日",
                "0308  妇女节",
                "0312  植树节 孙中山逝世纪念日",
                "0315  消费者权益保护日",
                "0321  世界森林日",
                "0322  世界水日",
                "0323  世界气象日",
                "0324  世界防治结核病日",

                "0401  愚人节",
                "0407  世界卫生日",
                "0422  世界地球日",

                "0501*国际劳动节",
                "0504  中国青年节",
                "0505  全国碘缺乏病日",
                "0508  世界红十字日",
                "0512  国际护士节",
                "0515  国际家庭日",
                "0517  世界电信日",
                "0518  国际博物馆日",
                "0519  中国汶川地震哀悼日 全国助残日",
                "0520  全国学生营养日",
                "0522  国际生物多样性日",
                "0523  国际牛奶日",
                "0531  世界无烟日",

                "0601  国际儿童节",
                "0605  世界环境日",
                "0606  全国爱眼日",
                "0617  防治荒漠化和干旱日",
                "0623  国际奥林匹克日",
                "0625  全国土地日",
                "0626  国际反毒品日",

                "0701  建党节 香港回归纪念日",
                "0707  抗日战争纪念日",
                "0711  世界人口日",

                "0801  八一建军节",
                "0815  日本正式宣布无条件投降日",

                "0908  国际扫盲日",
                "0909  毛泽东逝世纪念日",
                "0910  教师节",
                "0916  国际臭氧层保护日",
                "0917  国际和平日",
                "0918  九·一八事变纪念日",
                "0920  国际爱牙日",
                "0927  世界旅游日",
                "0928  孔子诞辰",

                "1001*国庆节 国际音乐节 国际老人节",
                "1002  国际减轻自然灾害日",
                "1004  世界动物日",
                "1007  国际住房日",
                "1008  世界视觉日 全国高血压日",
                "1009  世界邮政日",
                "1010  辛亥革命纪念日 世界精神卫生日",
                "1015  国际盲人节",
                "1016  世界粮食节",
                "1017  世界消除贫困日",
                "1022  世界传统医药日",
                "1024  联合国日",
                "1025  人类天花绝迹日",
                "1026  足球诞生日",
                "1031  万圣节",

                "1107  十月社会主义革命纪念日",
                "1108  中国记者日",
                "1109  消防宣传日",
                "1110  世界青年节",
                "1112  孙中山诞辰",
                "1114  世界糖尿病日",
                "1117  国际大学生节",

                "1201  世界艾滋病日",
                "1203  世界残疾人日",
                "1209  世界足球日",
                "1210  世界人权日",
                "1212  西安事变纪念日",
                "1213  南京大屠杀",
                "1220  澳门回归纪念日",
                "1221  国际篮球日",
                "1224  平安夜",
                "1225  圣诞节 世界强化免疫日",
                "1226  毛泽东诞辰"],
        //农历节日  *表示放假日
        lFtv :[
            "0101*春节",
            "0102*大年初二",
            "0103*大年初三",
            "0105  路神生日",
            "0115  元宵节",
            "0202  龙抬头",
            "0219  观世音圣诞",
            "0404  寒食节",
            "0408  佛诞节 ",
            "0505*端午节",
            "0606  天贶节 姑姑节",
            "0624  彝族火把节",
            "0707  七夕情人节",
            "0714  鬼节(南方)",
            "0715  盂兰节",
            "0730  地藏节",
            "0815*中秋节",
            "0909  重阳节",
            "1001  祭祖节",
            "1117  阿弥陀佛圣诞",
            "1208  腊八节 释迦如来成道日",
            "1223  过小年",
            "0100*除夕"],
            //某月的第几个星期几; 5,6,7,8 表示到数第 1,2,3,4 个星期几
        wFtv : [
            "0110  黑人节",
            "0150  世界麻风日",
            "0121  日本成人节",
            "0520  母亲节",
            "0530  全国助残日",
            "0630  父亲节",
            "0716  合作节",
            "0730  被奴役国家周",
            "0932  国际和平日",
            "0940  国际聋人节 世界儿童日",
            "1011  国际住房日",
            "1144  感恩节"],

         /**
          * 今日
          */
         today : {
            date: new Date(),
            tY : function(){
                return this.date.getFullYear()
            },
            tM : function(){
                return this.date.getMonth()
            },
            tD : function(){
                return this.date.getDate()
            }
         },
        /**
         * 返回农历 y年的总天数
         * @param  int y 年
         * @return int
         */
        lYearDays: function (y) {
            var i, sum = 348;
            for (i = 0x8000; i > 0x8; i >>= 1) sum += (this.lunarInfo[y - 1900] & i) ? 1 : 0;
            return sum + this.leapDays(y);
        },

        /**
         * 返回农历 y年闰月的天数
         * @param  int y 年
         * @return int
         */
        leapDays: function (y) {
            if (this.leapMonth(y)) return (this.lunarInfo[y - 1899] & 0xf) == 0xf ? 30 : 29;
            else return 0;
        },

        /**
         * 返回农历 y年闰哪个月 1-12 , 没闰返回 0
         * @param  int y 年
         * @return int
         */
        leapMonth: function (y) {
            var lm = this.lunarInfo[y - 1900] & 0xf;
            return lm == 0xf ? 0 : lm;
        },

        /**
         * 农历 y年m月的总天数
         * @param  int y 年
         * @param  imt m 月
         * @return int y年m月的总天数
         */
        monthDays: function (y, m) {
            return (this.lunarInfo[y - 1900] & (0x10000 >> m)) ? 30 : 29 ;
        },

        /**
         * 算出农历, 传入日期控件, 返回农历日期控件
         * 该控件属性有 .year .month .day .isLeap
         */
        lunar: function (objDate) {
            var i, leap = 0, temp = 0, _this = {};
            var offset = (Date.UTC(objDate.getFullYear(), objDate.getMonth(), objDate.getDate()) - Date.UTC(1900, 0, 31)) / 86400000;

            for (i = 1900; i < 2100 && offset > 0; i++) {
                temp = this.lYearDays(i);
                offset -= temp;
            }

            if (offset < 0) {
                offset += temp;
                i--;
            }

            _this.year = i;

            leap = this.leapMonth(i); //闰哪个月
            _this.isLeap = false;

            for (i = 1; i < 13 && offset > 0; i++) {
                //闰月
                if (leap > 0 && i == (leap + 1) && _this.isLeap == false) {
                    --i;
                    _this.isLeap = true;
                    temp = this.leapDays(_this.year);
                }
                else {
                    temp = this.monthDays(_this.year, i);
                }

                //解除闰月
                if (_this.isLeap == true && i == (leap + 1)) _this.isLeap = false;

                offset -= temp;
            }

            if (offset == 0 && leap > 0 && i == leap + 1)
                if (_this.isLeap) {
                    _this.isLeap = false;
                }
                else {
                    _this.isLeap = true;
                    --i;
                }

            if (offset < 0) {
                offset += temp;
                --i;
            }

            _this.month = i;
            _this.day = offset + 1;
            return _this;
        },

        /**
         * 返回公历 y年某m+1月的天数
         */
        solarDays: function (y, m) {
            if (m == 1)
                return(((y % 4 == 0) && (y % 100 != 0) || (y % 400 == 0)) ? 29 : 28);
            else
                return(this.solarMonth[m]);
        },
        /**
         * 传入 offset 返回干支, 0=甲子
         */
        cyclical: function (num) {
            return(this.gan[num % 10] + this.zhi[num % 12]);
        },

        /**
         * 日历属性
         * 
         * @param  int sYear  公元年4位数字
         * @param  int sMonth 公元月数字
         * @param  int sDay   公元日数字
         * @param  string  week   星期, 1个中文
         * @param  int  lYear  公元年4位数字
         * @param  int  lMonth 农历月数字
         * @param  int  lDay   农历日数字
         * @param  bool isLeap 是否为农历闰月
         * @param  string  cYear  年柱, 2个中文
         * @param  string  cMonth 月柱, 2个中文
         * @param  string  cDay   日柱, 2个中文
         * @return object
         */
        calElement: function (sYear, sMonth, sDay, week, lYear, lMonth, lDay, isLeap, cYear, cMonth, cDay) {
            var _this = {};
            _this.isToday = false;
            //瓣句
            _this.sYear = sYear;     //公元年4位数字
            _this.sMonth = sMonth;   //公元月数字
            _this.sDay = sDay;       //公元日数字
            _this.week = week;       //星期, 1个中文
            //农历
            _this.lYear = lYear;     //公元年4位数字
            _this.lMonth = lMonth;   //农历月数字
            _this.lDay = lDay;       //农历日数字
            _this.isLeap = isLeap;   //是否为农历闰月?
            //八字
            _this.cYear = cYear;     //年柱, 2个中文
            _this.cMonth = cMonth;   //月柱, 2个中文
            _this.cDay = cDay;       //日柱, 2个中文

            _this.color = '';

            _this.lunarFestival = ''; //农历节日
            _this.solarFestival = ''; //公历节日
            _this.solarTerms = '';    //节气
            return _this;
        },

        /**
         * 某年的第n个节气为几日(从0小寒起算)
         * @param  int y 年
         * @param  int n 月
         * @return date
         */
        sTerm: function (y, n) {
            var offDate = new Date(( 31556925974.7 * (y - 1900) + this.sTermInfo[n] * 60000  ) + Date.UTC(1900, 0, 6, 2, 5));
            return(offDate.getUTCDate());
        },

        /**
         * 返回阴历 (y年,m+1月)
         */
        cyclical6: function (num, num2) {
            if (num == 0) return this.jcName0[num2];
            if (num == 1) return this.jcName1[num2];
            if (num == 2) return this.jcName2[num2];
            if (num == 3) return this.jcName3[num2];
            if (num == 4) return this.jcName4[num2];
            if (num == 5) return this.jcName5[num2];
            if (num == 6) return this.jcName6[num2];
            if (num == 7) return this.jcName7[num2];
            if (num == 8) return this.jcName8[num2];
            if (num == 9) return this.jcName9[num2];
            if (num == 10) return this.jcName10[num2];
            if (num == 11) return this.jcName11[num2];
        },

        calConv2: function (yy, mm, dd, y, d, m, dt, nm, nd) {
            var dy = d + '' + dd
            if ((yy == 0 && dd == 6) || (yy == 6 && dd == 0) || (yy == 1 && dd == 7) || (yy == 7 && dd == 1) || (yy == 2 && dd == 8) || (yy == 8 && dd == 2) || (yy == 3 && dd == 9) || (yy == 9 && dd == 3) || (yy == 4 && dd == 10) || (yy == 10 && dd == 4) || (yy == 5 && dd == 11) || (yy == 11 && dd == 5)) {
                return {'ban': ['日值岁破','大事不宜']};
            }
            else if ((mm == 0 && dd == 6) || (mm == 6 && dd == 0) || (mm == 1 && dd == 7) || (mm == 7 && dd == 1) || (mm == 2 && dd == 8) || (mm == 8 && dd == 2) || (mm == 3 && dd == 9) || (mm == 9 && dd == 3) || (mm == 4 && dd == 10) || (mm == 10 && dd == 4) || (mm == 5 && dd == 11) || (mm == 11 && dd == 5)) {
                return {'ban': ['日值月破','大事不宜']};
            }
            else if ((y == 0 && dy == '911') || (y == 1 && dy == '55') || (y == 2 && dy == '111') || (y == 3 && dy == '75') || (y == 4 && dy == '311') || (y == 5 && dy == '95') || (y == 6 && dy == '511') || (y == 7 && dy == '15') || (y == 8 && dy == '711') || (y == 9 && dy == '35')) {
                return {'ban': ['日值上朔','大事不宜']};
            }
            else if ((m == 1 && dt == 13) || (m == 2 && dt == 11) || (m == 3 && dt == 9) || (m == 4 && dt == 7) || (m == 5 && dt == 5) || (m == 6 && dt == 3) || (m == 7 && dt == 1) || (m == 7 && dt == 29) || (m == 8 && dt == 27) || (m == 9 && dt == 25) || (m == 10 && dt == 23) || (m == 11 && dt == 21) || (m == 12 && dt == 19)) {
                return {'ban': ['日值杨公十三忌','大事不宜']};
            }
            else {
                return 0;
            }
        },

        /**
         * 返回本月的所有数据
         * @param  int y 年
         * @param  int m 月
         * @return object 每一天的数据列表
         */
        calendar: function (y, m) {

            var sDObj, lDObj, lY, lM, lD = 1, lL, lX = 0, tmp1, tmp2, lM2,lY2,lD2,tmp3,dayglus,bsg,xs,xs1,fs,fs1,cs,cs1
            var cY, cM, cD; //年柱,月柱,日柱
            var lDPOS = new Array(3);
            var n = 0;
            var firstLM = 0;
            var _this = {};    // 日历对象

            sDObj = new Date(y, m, 1, 0, 0, 0, 0);    //当月一日日期

            _this.length = this.solarDays(y, m);      //公历当月天数
            _this.firstWeek = sDObj.getDay();    //公历当月1日星期几

            ////////年柱 1900年立春后为庚子年(60进制36)
            if (m < 2) cY = this.cyclical(y - 1900 + 36 - 1);
            else cY = this.cyclical(y - 1900 + 36);
            var term2 = this.sTerm(y, 2);            //立春日期

            ////////月柱 1900年1月小寒以前为 丙子月(60进制12)
            var firstNode = this.sTerm(y, m * 2)     //返回当月「节」为几日开始
            cM = this.cyclical((y - 1900) * 12 + m + 12);

            lM2 = (y - 1900) * 12 + m + 12;
            //当月一日与 1900/1/1 相差天数
            //1900/1/1与 1970/1/1 相差25567日, 1900/1/1 日柱为甲戌日(60进制10)
            var dayCyclical = Date.UTC(y, m, 1, 0, 0, 0, 0) / 86400000 + 25567 + 10;

            for (var i = 0; i < _this.length; i++) {
                if (lD > lX) {
                    sDObj = new Date(y, m, i + 1);      //当月一日日期
                    lDObj = this.lunar(sDObj);           //农历
                    lY = lDObj.year;                    //农历年
                    lM = lDObj.month;                   //农历月
                    lD = lDObj.day;                     //农历日
                    lL = lDObj.isLeap;                  //农历是否闰月
                    lX = lL ? this.leapDays(lY) : this.monthDays(lY, lM); //农历当月最后一天

                    if (n == 0) firstLM = lM;
                    lDPOS[n++] = i - lD + 1;
                }

                //依节气调整二月分的年柱, 以立春为界
                if (m == 1 && (i + 1) == term2) {
                    cY = this.cyclical(y - 1900 + 36);
                    lY2 = (y - 1900 + 36);
                }
                //依节气月柱, 以「节」为界
                if ((i + 1) == firstNode) {
                    cM = this.cyclical((y - 1900) * 12 + m + 13);
                    lM2 = (y - 1900) * 12 + m + 13;
                }
                //日柱
                cD = this.cyclical(dayCyclical + i);
                lD2 = (dayCyclical + i);

                // 获取日历属性
                _this[i] = this.calElement(y, m + 1, i + 1, this.nStr1[(i + _this.firstWeek) % 7],
                        lY, lM, lD++, lL,
                        cY, cM, cD);
                // 获取黄历的禁忌
                _this[i].sgz5 = this.calConv2(lY2 % 12, lM2 % 12, (lD2) % 12, lY2 % 10, (lD2) % 10, lM, lD - 1, m + 1, cs1);
                _this[i].sgz3 = this.cyclical6(lM2 % 12, (lD2) % 12);
            }

            //节气
            tmp1 = this.sTerm(y, m * 2) - 1;
            tmp2 = this.sTerm(y, m * 2 + 1) - 1;
            // 二十四节气表
            _this[tmp1].solarTerms = this.solarTerm[m * 2];
            _this[tmp2].solarTerms = this.solarTerm[m * 2 + 1];
            if (m == 3) _this[tmp1].color = 'red'; //清明颜色

            //国历节日
            for (i in this.sFtv){
                if (jQuery.type(this.sFtv[i])=='string'&&this.sFtv[i].match(/^(\d{2})(\d{2})([\s\*])(.+)$/))
                    if (Number(RegExp.$1) == (m + 1)) {
                        _this[Number(RegExp.$2) - 1].solarFestival += RegExp.$4 + '  '
                        if (RegExp.$3 == '*')  _this[Number(RegExp.$2) - 1].color = 'red'
                    }
            }

            //农历节日
            for (i in this.lFtv){
                if (jQuery.type(this.lFtv[i])=='string'&&this.lFtv[i].match(/^(\d{2})(.{2})([\s\*])(.+)$/)) {
                    tmp1 = Number(RegExp.$1) - firstLM
                    if (tmp1 == -11)  tmp1 = 1
                    if (tmp1 >= 0 && tmp1 < n) {
                        tmp2 = lDPOS[tmp1] + Number(RegExp.$2) - 1
                        if (tmp2 >= 0 && tmp2 < _this.length) {
                            _this[tmp2].lunarFestival += RegExp.$4 + '  '
                            if (RegExp.$3 == '*')  _this[tmp2].color = 'red'
                        }
                    }
                }
            }
            //复活节只出现在3或4月
            if (m == 2 || m == 3) {
                var estDay = this.easter(y);
                if (m == estDay.m)
                    _this[estDay.d - 1].solarFestival = _this[estDay.d - 1].solarFestival + ' 复活节(Easter Sunday)';
            }


            //黑色星期五
            if ((_this.firstWeek + 12) % 7 == 5)
                _this[12].solarFestival += '黑色星期五';

            //今日
            if (y == this.today.tY() && m == this.today.tM()) _this[this.today.tD() - 1].isToday = true;
            return _this;
        },

        /**
         * 返回该年的复活节(春分后第一次满月周后的第一主日)
         * @param  int y 年
         * @return object 包含月和日的 简单对象
         */
        easter: function (y) {
            var _this = {};
            var term2 = this.sTerm(y, 5); //取得春分日期
            var dayTerm2 = new Date(Date.UTC(y, 2, term2, 0, 0, 0, 0)); //取得春分的公历日期控件(春分一定出现在3月)
            var lDayTerm2 = this.lunar(dayTerm2); //取得取得春分农历

            if (lDayTerm2.day < 15) //取得下个月圆的相差天数
                var lMlen = 15 - lDayTerm2.day;
            else
                var lMlen = (lDayTerm2.isLeap ? this.leapDays(y) : this.monthDays(y, lDayTerm2.month)) - lDayTerm2.day + 15;

            //一天等于 1000*60*60*24 = 86400000 毫秒
            var l15 = new Date(dayTerm2.getTime() + 86400000 * lMlen); //求出第一次月圆为公历几日
            var dayEaster = new Date(l15.getTime() + 86400000 * ( 7 - l15.getUTCDay() )); //求出下个周日

            _this.m = dayEaster.getUTCMonth();
            _this.d = dayEaster.getUTCDate();
            return _this;

        },
        /**
         * 将日期格式化中文日期
         * @param  int m 月
         * @return string
         */
        cDay: function (d) {
            var s;
            switch (d) {
                case  10:
                    s = '初十';  break;
                case  20:
                    s = '二十';  break;
                case  30:
                    s = '三十';  break;
                default  :
                    s = this.nStr2[Math.floor(d / 10)];
                    s += this.nStr1[d % 10];
            }
            return s;
        },

        /**
         * 将农历iLunarMonth月格式化成农历表示的字符串
         * @param  int  iLunarMonth 月份
         * @return string
         */
        formatLunarMonth: function (iLunarMonth) {
            var szText = new String("正二三四五六七八九十");
            var strMonth;
            if (iLunarMonth <= 10) {
                strMonth = szText.substr(iLunarMonth - 1, 1);
            }
            else if (iLunarMonth == 11) strMonth = "十一";
            else strMonth = "十二";
            return strMonth + "月";
        },
        /**
         * 将农历iLunarDay日格式化成农历表示的字符串
         * @param  int iLunarDay 日
         * @return string
         */
        formatLunarDay: function (iLunarDay) {
            var szText1 = new String("初十廿三");
            var szText2 = new String("一二三四五六七八九十");
            var strDay;
            if ((iLunarDay != 20) && (iLunarDay != 30)) {
                strDay = szText1.substr((iLunarDay - 1) / 10, 1) + szText2.substr((iLunarDay - 1) % 10, 1);
            } else if (iLunarDay != 20) {
                strDay = szText1.substr(iLunarDay / 10, 1) + "十";
            } else {
                strDay = "二十";
            }
            return strDay;
        },
        /**
         * 画每月的日历
         * @param  int year 年
         * @param  int month 月
         * @param  function funct 操作完后执行的函数
         * @return null
         */
        drawCld: function (year, month, funct) {
            var i,sD,s,size;
            var cld = this.calendar(year, month);
            this.cld = cld;
            $("#GZ").html('  农历' + this.cyclical(year - 1900 + 36) + '年&nbsp;【' + this.animals[(year - 4) % 12] + '年】');

            for (i = 0; i < 42; i++) {
                sObj = $("#SD" + i);    // 阳历
                lObj = $("#LD" + i);    // 阴历
                var eDay = $("#GD" + i);   // 行 Li

                sD = i - cld.firstWeek;

                if (sD > -1 && sD < cld.length) {  //日期内
                    sObj.text(sD + 1);
                    eDay.attr({
                        'data-solor': sD + 1,   // 设置阳历日
                        'data-month': month + 1,   // 设置阳历月
                        'data-year': year,    // 设置阳历年
                    });  

                    if (cld[sD].isToday) {      // 今日
                        eDay.addClass("today");         //今日颜色
                        this.showAlmanacDetail(eDay);   // 显示右侧黄历
                    }

                    if (cld[sD].lDay == 1)  //显示农历月
                        lObj.html('<b>' + (cld[sD].isLeap ? '闰' : '') + cld[sD].lMonth + '月' + (this.monthDays(cld[sD].lYear, cld[sD].lMonth) == 29 ? '小' : '大') + '</b>');
                    else  //显示农历日
                        lObj.text(this.cDay(cld[sD].lDay));

                    s = cld[sD].lunarFestival;
                    if (s.length > 0) {  //农历节日
                        if (s.length > 8)  s = s.substr(0, 5) + '...';
                        eDay.addClass('lunar-style');
                    } else {  //国历节日
                        s = cld[sD].solarFestival;
                        if (s.length > 0) {
                            if (s.length > 8)  s = s.substr(0, 5) + '...';
                            s == '黑色星期五' ? eDay.addClass('black-style') : eDay.addClass('solar-style');
                        }else {  //廿四节气
                            s = cld[sD].solarTerms;
                            if (s.length > 0)  eDay.addClass('lunar-style');;
                            // if (s.length > 0)  s = s.fontcolor('limegreen');
                        }
                    }
                    if (cld[sD].solarTerms == '清明') s = '清明节'.fontcolor('red');
                    if (cld[sD].solarTerms == '芒种') s = '芒种'.fontcolor('red');
                    if (cld[sD].solarTerms == '夏至') s = '夏至'.fontcolor('red');
                    if (cld[sD].solarTerms == '冬至') s = '冬至'.fontcolor('red');

                    if (s.length > 0)  lObj.html(s);
                }
                else {  //非日期
                    eDay.addClass("unover");
                }
            }
            if(funct) funct(year, month);
        },
        /**
         * 显示详细日期资料
         * @param  jQuery object sObj 日历的天 li
         * @return null
         */
        showAlmanacDetail: function (sObj) {
            var sObj = $(sObj);
            var s, almanac;

            if (sObj.attr('data-solor')) {
                var d = sObj.attr('data-solor') - 1;   // 阳历天
                var cld = this.cld;
                // 禁忌
                if (cld[d].sgz5 != 0) {
                    almanac = cld[d].sgz5;
                } else {
                    almanac = this.jcr(cld[d].sgz3);
                }

                var container = $(".almanac-tips");    // 右侧显示容器
                // 显示节日名称
                if (cld[d].solarTerms == '' && cld[d].solarFestival == '' && cld[d].lunarFestival == ''){
                    // 没有节日
                    $(".lunar-term", container).text('');
                }else{
                    $(".lunar-term", container).text(cld[d].solarTerms + ' ' + cld[d].solarFestival + ' ' + cld[d].lunarFestival);
                }
                // 显示日
                $('.date-show-panel', container).text(cld[d].sDay);
                // 显示年月日
                $('.dates-bar .date', container).text(cld[d].sYear + '-' + cld[d].sMonth + '-' + cld[d].sDay);
                // 显示星期
                $('.dates-bar .weekday', container).text('星期' + cld[d].week);
                // 显示农历
                $(".lunar", container).text('农历' + (cld[d].isLeap ? '闰' : ' ') + this.formatLunarMonth(cld[d].lMonth) + this.formatLunarDay(cld[d].lDay));
                // 显示干支
                $(".lunar-ganzhi", container).text(cld[d].cYear + '年 ' + cld[d].cMonth + '月 ' + cld[d].cDay + '日');

                // 显示禁忌
                if (almanac.ban){   // 大事不宜
                    $(".ban").removeClass('hidden').siblings().addClass('hidden');
                    $(".ban .st-items").attr('title', almanac.ban.toString())
                        .html('<li>' + almanac.ban.join('</li><li>') +'</li>');
                }else{
                    $(".ban").addClass('hidden').siblings().removeClass('hidden');
                    if(almanac.suited){    // 宜
                        $(".suited .st-items").attr('title', almanac.suited.toString())
                        .html('<li>' + almanac.suited.join('</li><li>') +'</li>');
                    }
                    if (almanac.tapu){     // 忌
                        $(".tapu .st-items").attr('title', almanac.tapu.toString())
                        .html('<li>' + almanac.tapu.join('</li><li>') +'</li>');
                    }
                }
            }
        },

        /**
         * 画表格轮廓
         * @return null
         */
        drawOutline: function(opts){
            var wktitle = $('.dates-hd');    // 星期标题
            var outline = $(".dates-bd");
            var gNum;
            var _this = this;
            for (var i = 0; i < 6; i++) {   // 6行
              for (var j = 0; j < 7; j++) {
                gNum = i * 7 + j;
                var className = ""
                if($('li[data-id="' + (j-1>=0? j-1 : 6) + '"]', wktitle).hasClass('weekend')){
                    className = "weekend";
                }
                // 如果该单元格已经存在，则不需要重画
                var li = $('li[data-id="' + gNum + '"]', outline);
                var hasli = li.size() > 0;
                if (!hasli){
                    // 周日 周六
                    // if (j == 0 || j == 6) className = "weekend";
                    li = $('<li/>').attr({
                        'id': 'GD' + gNum,
                        'data-id': gNum,
                        'class': className
                    }).append($('<div class="layer"/>'))
                    .append($('<span class="border"/>'))
                    .append($('<span/>').attr({
                        'id': 'SD' + gNum,
                        'class': 'solar'
                    })).append($('<span/>').attr({
                        'id': 'LD' + gNum,
                        'class': 'lunar'
                    }));
                }
                // 重新绑定事件
                li.hover(function() {          // 鼠标滑过事件
                    _this.showAlmanacDetail(this);
                }).unbind('click').bind('click', function(event) {   // 单击事件
                    if(opts && opts.clickDay){
                        opts.clickDay(this);
                    }
                }).unbind('dblclick').bind('dblclick', function(event) {   // 双击事件
                    if(opts && opts.dbClickDay){
                        opts.dbClickDay(this);
                    }
                });
                if(!hasli) li.appendTo(outline);
              }
            }
        },

        /**
         * 清除日历数据
         */
        clear: function () {
            for (i = 0; i < 42; i++) {
                $("#SD" + i).html('');    // 清除阳历
                $("#LD" + i).html('');    // 清除农历
                // 清除相关class
                var gd = $("#GD" + i)
                if (gd.hasClass('weekend')){
                    gd.removeAttr('data-solor class').addClass('weekend');
                }else{
                    gd.removeAttr('data-solor class');
                }
            }
        },

        initRiliIndex: function () {
            global.currYear = this.today.tY();    // 当前年
            global.currMonth = this.today.tM();   // 当前月

            // 先删除
            this.clear()

            this.drawOutline(global);
            // 初始化顶部的工具栏
            this.initControlBar();

            DateSelection.init();
        },

        /**
         * 初始化顶部的工具栏
         */
        initControlBar: function(){
            // 设置选中的年为当前的年
            var tM = this.today.tM() + 1;
            $(".field.year").text(this.today.tY()+'年');
            // 设置年的选项
            var htmlYear = "";
            for(i=1901; i<=2100; i++){
                if(i == this.today.tY())
                    htmlYear += '<li val="' + i +'" class="on">' + i + '年</li>';
                else{
                    htmlYear += '<li val="' + i +'">' + i + '年</li>';
                }
            }
            $(".year-list").html(htmlYear);

            // 设置选中的月为当前的月
            $(".field.month").text(tM+'月');
            // 设置月的选项
            var htmlMonth = "";
            for(i=1; i<=12; i++){
                if(i == tM)
                    htmlMonth += '<li val="' + i +'" class="on">' + i+ '月</li>';
                else{
                    htmlMonth += '<li val="' + i +'">' + i+ '月</li>';
                }
            }
            $(".month-list").html(htmlMonth);

            // 绑定事件
            $(".control").unbind('click').bind('click', function(event) {
                $(this).nextAll('.list').toggleClass('hidden');
                // 当前年/月距离顶部的距离
                $(".list").scrollTop(($(".list li[class=on]").attr('val') - $(".list li:first").attr('val')) * 20);

            });

        }

    }


    var DateSelection = {
        currYear : -1,
        currMonth : -1,

        minYear : 1901,
        maxYear : 2100,

        tmpYear : -1,
        tmpMonth : -1,

        init : function(year, month) {
            if (typeof year == 'undefined' || typeof month == 'undefined') {
                year = global.currYear;
                month = global.currMonth;
            }
            this.setYear(year);
            this.setMonth(month);
        },
        setYear : function(value) {
            if (this.tmpYear == -1 && this.currYear != -1) {
                this.tmpYear = this.currYear;
            }
            this.currYear = value;
        },
        setMonth : function(value) {
            if (this.tmpMonth == -1 && this.currMonth != -1) {
                this.tmpMonth = this.currMonth;
            }
            this.currMonth = value;
        },
        today : function() {
            var today = new Date();
            var year = today.getFullYear();
            var month = today.getMonth();

            if (this.currYear != year || this.currMonth != month) {
                if (this.tmpYear == year && this.tmpMonth == month) {
                    this.rollback();
                } else {
                    this.init(year, month);
                    this.commit();
                }
            }
        },
        goToday : function() {
            this.today();
        },
        goYear: function(year){
            this.setYear(year);
            this.commit();
        },
        goMonth: function(month){
            this.setMonth(month);
            this.commit();
        },
        goPrevMonth : function() {
            this.prevMonth();
            this.commit();
        },
        goNextMonth : function() {
            this.nextMonth();
            this.commit();
        },
        goPrevYear : function() {
            this.prevYear();
            this.commit();
        },
        goNextYear : function() {
            this.nextYear();
            this.commit();
        },
        /**
         * 重新画取日历
         * @return {[type]} [description]
         */
        changeView : function() {
            global.currYear = this.currYear;
            global.currMonth = this.currMonth;
            Almanac.clear();
            Almanac.drawCld(global.currYear, global.currMonth, global.afterDrawCld);
        },
        /**
         * 刷新工具栏
         */
        freshControlBar: function(){
            // 设置当前选中的年
            $(".field.year").text(global.currYear + '年').attr('val', global.currYear);
            $(".year-list li[val='" + global.currYear + "']").addClass('on').siblings().removeClass('on');
            
            // 设置当前选中的月
            var month = global.currMonth + 1;      // 实际月
            $(".field.month").text(month + '月').attr('val', month);
            $(".month-list li[val='" + month + "']").addClass('on').siblings().removeClass('on');
        },
        commit : function() {
            if (this.tmpYear != -1 || this.tmpMonth != -1) {
                // 如果发生了变化
                if (this.currYear != this.tmpYear || this.currMonth != this.tmpMonth) {
                    // 执行某操作
                    this.changeView();
                    this.freshControlBar();
                }
                this.tmpYear = -1;
                this.tmpMonth = -1;
            }
        },
        rollback : function() {
            if (this.tmpYear != -1) {
                this.setYear(this.tmpYear);
            }
            if (this.tmpMonth != -1) {
                this.setMonth(this.tmpMonth);
            }
            this.tmpYear = -1;
            this.tmpMonth = -1;
        },
        prevMonth : function() {
            var month = this.currMonth - 1;
            if (month == -1) {
                var year = this.currYear - 1;
                if (year >= this.minYear) {
                    month = 11;
                    this.setYear(year);
                } else {
                    month = 0;
                }
            }
            this.setMonth(month);
        },
        nextMonth : function() {
            var month = this.currMonth + 1;
            if (month == 12) {
                var year = this.currYear + 1;
                if (year <= this.maxYear) {
                    month = 0;
                    this.setYear(year);
                } else {
                    month = 11;
                }
            }
            this.setMonth(month);
        },
        prevYear : function() {
            var year = this.currYear - 1;
            if (year >= this.minYear) {
                this.setYear(year);
            }
        },
        nextYear : function() {
            var year = this.currYear + 1;
            if (year <= this.maxYear) {
                this.setYear(year);
            }
        }
        
    };


    var global = {
        currYear : -1,              // 当前年
        currMonth : -1,             // 当前月，0-11
        afterDrawCld : null,        // 画日历之后调用函数
        dbClickDay: null,           // 双击某一天执行事件
        clickDay: null,             // 单击某一天执行事件
        callFunc: null              // 调用函数
    };

    global = $.extend({}, global, options); // 扩展options选项

    return this.each(function(){
        Almanac.initRiliIndex();
        Almanac.drawCld(Almanac.today.tY(), Almanac.today.tM(), global.afterDrawCld);

        if (global.callFunc) global.callFunc();

        /*年份递减*/
        $("#nianjian").unbind('click').bind('click', function() {
            DateSelection.goPrevYear();
        });
        /*年份递加*/
        $("#nianjia").unbind('click').bind('click', function() {
            DateSelection.goNextYear();
        });

        /*月份递减*/
        $("#yuejian").unbind('click').bind('click', function() {
            DateSelection.goPrevMonth();
        });

        /*月份递加*/
        $("#yuejia").unbind('click').bind('click', function() {
            DateSelection.goNextMonth();
        });

        // 返回今天
        $(".btn-today").unbind('click').bind('click', function() {
            DateSelection.goToday();
        });

        // 去某一年
        $(".year-list li").unbind('click').bind('click', function() {
            var _this = $(this);
            _this.parent().addClass('hidden');
            DateSelection.goYear(_this.attr('val'));
        });

        // 去某一月
        $(".month-list li").unbind('click').bind('click', function() {
            var _this = $(this);
            _this.parent().addClass('hidden');
            DateSelection.goMonth(parseInt(_this.attr('val')) -1 );
        });
    });
  }

})(jQuery);

