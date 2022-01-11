(function (window, Calendar) {
    var cal, resizeThrottled;
    var useCreationPopup = true;
    var useDetailPopup = true;
    var datePicker, selectedCalendar;
    'use strict';

    /*eslint-disable*/

    var ScheduleList = [];

    var SCHEDULE_CATEGORY = [
        'milestone',
        'task'
    ];

    function ScheduleInfo() {
        this.id = null;
        this.calendarId = null;

        this.title = null;
        this.body = null;
        this.location = null;
        this.isAllday = false;
        this.start = null;
        this.end = null;
        this.category = '';
        this.dueDateClass = '';

        this.color = null;
        this.bgColor = null;
        this.dragBgColor = null;
        this.borderColor = null;
        this.customStyle = '';

        this.isFocused = false;
        this.isPending = false;
        this.isVisible = true;
        this.isReadOnly = false;
        this.isPrivate = false;
        this.goingDuration = 0;
        this.comingDuration = 0;
        this.recurrenceRule = '';
        this.state = '';

        this.raw = {
            memo: '',
            hasToOrCc: false,
            hasRecurrenceRule: false,
            location: null,
            creator: {
                name: '',
                avatar: '',
                company: '',
                email: '',
                phone: ''
            }
        };
    }

    function generateTime(schedule, renderStart, renderEnd) {
        var startDate = moment(renderStart.getTime())
        var endDate = moment(renderEnd.getTime());
        var diffDate = endDate.diff(startDate, 'days');

        schedule.isAllday = chance.bool({ likelihood: 30 });
        if (schedule.isAllday) {
            schedule.category = 'allday';
        } else if (chance.bool({ likelihood: 30 })) {
            schedule.category = SCHEDULE_CATEGORY[chance.integer({ min: 0, max: 1 })];
            if (schedule.category === SCHEDULE_CATEGORY[1]) {
                schedule.dueDateClass = 'morning';
            }
        } else {
            schedule.category = 'time';
        }

        startDate.add(chance.integer({ min: 0, max: diffDate }), 'days');
        startDate.hours(chance.integer({ min: 0, max: 23 }))
        startDate.minutes(chance.bool() ? 0 : 30);
        schedule.start = startDate.toDate();

        endDate = moment(startDate);
        if (schedule.isAllday) {
            endDate.add(chance.integer({ min: 0, max: 3 }), 'days');
        }

        schedule.end = endDate
            .add(chance.integer({ min: 1, max: 4 }), 'hour')
            .toDate();

        if (!schedule.isAllday && chance.bool({ likelihood: 20 })) {
            schedule.goingDuration = chance.integer({ min: 30, max: 120 });
            schedule.comingDuration = chance.integer({ min: 30, max: 120 });;

            if (chance.bool({ likelihood: 50 })) {
                schedule.end = schedule.start;
            }
        }
    }

    function generateNames() {
        var names = [];
        var i = 0;
        var length = chance.integer({ min: 1, max: 10 });

        for (; i < length; i += 1) {
            names.push(chance.name());
        }

        return names;
    }

    function generateRandomSchedule(calendar, renderStart, renderEnd) {
        var schedule = new ScheduleInfo();

        schedule.id = chance.guid();
        schedule.calendarId = calendar.id;

        schedule.title = chance.sentence({ words: 3 });
        schedule.body = chance.bool({ likelihood: 20 }) ? chance.sentence({ words: 10 }) : '';
        schedule.isReadOnly = chance.bool({ likelihood: 20 });
        generateTime(schedule, renderStart, renderEnd);

        schedule.isPrivate = chance.bool({ likelihood: 10 });
        schedule.location = chance.address();
        schedule.attendees = chance.bool({ likelihood: 70 }) ? generateNames() : [];
        schedule.recurrenceRule = chance.bool({ likelihood: 20 }) ? 'repeated events' : '';
        schedule.state = chance.bool({ likelihood: 20 }) ? 'Free' : 'Busy';
        schedule.color = calendar.color;
        schedule.bgColor = calendar.bgColor;
        schedule.dragBgColor = calendar.dragBgColor;
        schedule.borderColor = calendar.borderColor;

        if (schedule.category === 'milestone') {
            schedule.color = schedule.bgColor;
            schedule.bgColor = 'transparent';
            schedule.dragBgColor = 'transparent';
            schedule.borderColor = 'transparent';
        }

        schedule.raw.memo = chance.sentence();
        schedule.raw.creator.name = chance.name();
        schedule.raw.creator.avatar = chance.avatar();
        schedule.raw.creator.company = chance.company();
        schedule.raw.creator.email = chance.email();
        schedule.raw.creator.phone = chance.phone();

        if (chance.bool({ likelihood: 20 })) {
            var travelTime = chance.minute();
            schedule.goingDuration = travelTime;
            schedule.comingDuration = travelTime;
        }
        console.log(schedule)
        ScheduleList.push(schedule);
    }
    function generateData(content, renderStart, renderEnd) {
        //console.log(content)
        var schedule = new ScheduleInfo();
        schedule = $.extend({}, content);
        schedule.start = new Date(content.start);
        schedule.end = new Date(content.end);
        if (calendar.category === 'milestone') {
            schedule.color = schedule.bgColor;
            schedule.bgColor = 'transparent';
            schedule.dragBgColor = 'transparent';
            schedule.borderColor = 'transparent';
        }
        ScheduleList.push(schedule);
    }
    function generateSchedule(viewName, renderStart, renderEnd) {
        ScheduleList = [];
        console.log(CalendarList)
        __get('planday/list?viewtype=' + viewName + '&start_time=' + renderStart + '&end_time=' + renderEnd, res => {
            console.log(res)
            if (res.code == 0 && res.data.length > 0) {
                //let rt = [];
                res.data.forEach(d => {
                    //let content = JSON.parse(d.content)
                    //rt.push(content)
                    //console.log(content)
                    generateData(d.content, renderStart, renderEnd);
                })
                //console.log(rt)
            }
        })
        /*
        CalendarList.forEach(function(calendar) {
            var i = 0, length = 10;
            if (viewName === 'month') {
                length = 3;
            } else if (viewName === 'day') {
                length = 4;
            }
            for (; i < length; i += 1) {
                generateRandomSchedule(calendar, renderStart, renderEnd);
            }
        });*/
    }

    // register templates
    var templates = {
        popupIsAllDay: function () {
            return '所有';
        },
        popupStateFree: function () {
            return '空闲';
        },
        popupStateBusy: function () {
            return '忙碌';
        },
        titlePlaceholder: function () {
            return '内容';
        },
        locationPlaceholder: function () {
            return '地点';
        },
        startDatePlaceholder: function () {
            return '开始日期';
        },
        endDatePlaceholder: function () {
            return '结束日期';
        },
        popupSave: function () {
            return '保存';
        },
        popupUpdate: function () {
            return '更新';
        },
        popupDetailDate: function (isAllDay, start, end) {
            var isSameDate = moment(start).isSame(end);
            var endFormat = (isSameDate ? '' : 'YYYY.MM.DD ') + 'hh:mm a';

            if (isAllDay) {
                return moment(start).format('YYYY.MM.DD') + (isSameDate ? '' : ' - ' + moment(end).format('YYYY.MM.DD'));
            }

            return (moment(start).format('YYYY.MM.DD hh:mm a') + ' - ' + moment(end).format(endFormat));
        },
        popupDetailLocation: function (schedule) {
            return '地点 : ' + schedule.location;
        },
        popupDetailUser: function (schedule) {
            return 'User : ' + (schedule.attendees || []).join(', ');
        },
        popupDetailState: function (schedule) {
            return '状态 : ' + schedule.state || 'Busy';
        },
        popupDetailRepeat: function (schedule) {
            return 'Repeat : ' + schedule.recurrenceRule;
        },
        popupDetailBody: function (schedule) {
            return 'Body : ' + schedule.body;
        },
        popupEdit: function () {
            return '编辑';
        },
        popupDelete: function () {
            return '删除';
        },
        milestone: function (model) {
            return '<span class="calendar-font-icon ic-milestone-b"></span> <span style="background-color: ' + model.bgColor + '">' + model.title + '</span>';
        },
        allday: function (schedule) {
            return getTimeTemplate(schedule, true);
        },
        time: function (schedule) {
            return getTimeTemplate(schedule, false);
        }
    };
    cal = new Calendar('#calendar', {
        defaultView: 'week',
        useCreationPopup: useCreationPopup,
        useDetailPopup: useDetailPopup,
        calendars: CalendarList,
        template: templates,
        week: {
            daynames: ['周日', '周一', '周二', '周三', '周四', '周五', '周六']
        },
        month: {
            daynames: ['周日', '周一', '周二', '周三', '周四', '周五', '周六']
        },
        // timezone: {
        //     zones: [
        //         {
        //             timezoneName: 'Asia/Shanghai',
        //             displayLabel: 'GMT+08:00',
        //             tooltip: '中国时间'
        //         }
        //     ],
        //     offsetCalculator: function (timezoneName, timestamp) {
        //         // matches 'getTimezoneOffset()' of Date API
        //         // e.g. +09:00 => -540, -04:00 => 240
        //         return moment.tz.zone(timezoneName).utcOffset(timestamp);
        //     },
        // }
    });

    // event handlers
    cal.on({
        'clickMore': function (e) {
            console.log('clickMore', e);
        },
        'clickSchedule': function (e) {
            console.log('clickSchedule', e);
        },
        'clickDayname': function (date) {
            console.log('clickDayname', date);
        },
        'beforeCreateSchedule': function (e) {
            //console.log('beforeCreateSchedule', e);
            saveNewSchedule(e);
        },
        'beforeUpdateSchedule': function (e) {
            var schedule = e.schedule;
            var changes = e.changes;

            //console.log('beforeUpdateSchedule', e);

            if (changes && !changes.isAllDay && schedule.category === 'allday') {
                changes.category = 'time';
            }
            //console.log(schedule)
            changes.id = schedule.id;
            __post('planday/edit', changes, res => {
                cal.updateSchedule(schedule.id, schedule.calendarId, changes);
                refreshScheduleVisibility();
            })
            
        },
        'beforeDeleteSchedule': function (e) {
            //console.log('beforeDeleteSchedule', e);
            __post('planday/del', { id: e.schedule.id}, res => {
                cal.deleteSchedule(e.schedule.id, e.schedule.calendarId);
            })
            
        },
        'afterRenderSchedule': function (e) {
            var schedule = e.schedule;
            // var element = cal.getElement(schedule.id, schedule.calendarId);
            // console.log('afterRenderSchedule', element);
        },
        'clickTimezonesCollapseBtn': function (timezonesCollapsed) {
            console.log('timezonesCollapsed', timezonesCollapsed);

            if (timezonesCollapsed) {
                cal.setTheme({
                    'week.daygridLeft.width': '77px',
                    'week.timegridLeft.width': '77px'
                });
            } else {
                cal.setTheme({
                    'week.daygridLeft.width': '60px',
                    'week.timegridLeft.width': '60px'
                });
            }

            return true;
        }
    });

    /**
     * Get time template for time and all-day
     * @param {Schedule} schedule - schedule
     * @param {boolean} isAllDay - isAllDay or hasMultiDates
     * @returns {string}
     */
    function getTimeTemplate(schedule, isAllDay) {
        var html = [];
        var start = moment(schedule.start.toUTCString());
        if (!isAllDay) {
            html.push('<strong>' + start.format('HH:mm') + '</strong> ');
        }
        if (schedule.isPrivate) {
            html.push('<span class="calendar-font-icon ic-lock-b"></span>');
            html.push(' Private');
        } else {
            if (schedule.isReadOnly) {
                html.push('<span class="calendar-font-icon ic-readonly-b"></span>');
            } else if (schedule.recurrenceRule) {
                html.push('<span class="calendar-font-icon ic-repeat-b"></span>');
            } else if (schedule.attendees.length) {
                html.push('<span class="calendar-font-icon ic-user-b"></span>');
            } else if (schedule.location) {
                html.push('<span class="calendar-font-icon ic-location-b"></span>');
            }
            html.push(' ' + schedule.title);
        }

        return html.join('');
    }

    /**
     * A listener for click the menu
     * @param {Event} e - click event
     */
    function onClickMenu(e) {
        var target = $(e.target).closest('a[role="menuitem"]')[0];
        var action = getDataAction(target);
        var options = cal.getOptions();
        var viewName = '';

        console.log(target);
        console.log(action);
        switch (action) {
            case 'toggle-daily':
                viewName = 'day';
                break;
            case 'toggle-weekly':
                viewName = 'week';
                break;
            case 'toggle-monthly':
                options.month.visibleWeeksCount = 0;
                viewName = 'month';
                break;
            case 'toggle-weeks2':
                options.month.visibleWeeksCount = 2;
                viewName = 'month';
                break;
            case 'toggle-weeks3':
                options.month.visibleWeeksCount = 3;
                viewName = 'month';
                break;
            case 'toggle-narrow-weekend':
                options.month.narrowWeekend = !options.month.narrowWeekend;
                options.week.narrowWeekend = !options.week.narrowWeekend;
                viewName = cal.getViewName();

                target.querySelector('input').checked = options.month.narrowWeekend;
                break;
            case 'toggle-start-day-1':
                options.month.startDayOfWeek = options.month.startDayOfWeek ? 0 : 1;
                options.week.startDayOfWeek = options.week.startDayOfWeek ? 0 : 1;
                viewName = cal.getViewName();

                target.querySelector('input').checked = options.month.startDayOfWeek;
                break;
            case 'toggle-workweek':
                options.month.workweek = !options.month.workweek;
                options.week.workweek = !options.week.workweek;
                viewName = cal.getViewName();

                target.querySelector('input').checked = !options.month.workweek;
                break;
            default:
                break;
        }

        cal.setOptions(options, true);
        cal.changeView(viewName, true);

        setDropdownCalendarType();
        setRenderRangeText();
        setSchedules();
    }

    function onClickNavi(e) {
        var action = getDataAction(e.target);

        switch (action) {
            case 'move-prev':
                cal.prev();
                break;
            case 'move-next':
                cal.next();
                break;
            case 'move-today':
                cal.today();
                break;
            default:
                return;
        }

        setRenderRangeText();
        setSchedules();
    }

    function onNewSchedule() {
        var title = $('#new-schedule-title').val();
        var location = $('#new-schedule-location').val();
        var isAllDay = document.getElementById('new-schedule-allday').checked;
        var start = datePicker.getStartDate();
        var end = datePicker.getEndDate();
        var calendar = selectedCalendar ? selectedCalendar : CalendarList[0];

        if (!title) {
            return;
        }

        cal.createSchedules([{
            id: String(chance.guid()),
            calendarId: calendar.id,
            title: title,
            isAllDay: isAllDay,
            location: location,
            start: start,
            end: end,
            category: isAllDay ? 'allday' : 'time',
            dueDateClass: '',
            color: calendar.color,
            bgColor: calendar.bgColor,
            dragBgColor: calendar.bgColor,
            borderColor: calendar.borderColor,
            state: 'Busy'
        }]);

        $('#modal-new-schedule').modal('hide');
    }

    function onChangeNewScheduleCalendar(e) {
        var target = $(e.target).closest('a[role="menuitem"]')[0];
        var calendarId = getDataAction(target);
        changeNewScheduleCalendar(calendarId);
    }

    function changeNewScheduleCalendar(calendarId) {
        var calendarNameElement = document.getElementById('calendarName');
        var calendar = findCalendar(calendarId);
        var html = [];

        html.push('<span class="calendar-bar" style="background-color: ' + calendar.bgColor + '; border-color:' + calendar.borderColor + ';"></span>');
        html.push('<span class="calendar-name">' + calendar.name + '</span>');

        calendarNameElement.innerHTML = html.join('');

        selectedCalendar = calendar;
    }

    function createNewSchedule(event) {
        var start = event.start ? new Date(event.start.getTime()) : new Date();
        var end = event.end ? new Date(event.end.getTime()) : moment().add(1, 'hours').toDate();

        if (useCreationPopup) {
            cal.openCreationPopup({
                start: start,
                end: end
            });
        }
    }
    function saveNewSchedule(scheduleData) {
        var calendar = scheduleData.calendar || findCalendar(scheduleData.calendarId);
        var schedule = {
            id: String(chance.guid()),
            title: scheduleData.title,
            isAllDay: scheduleData.isAllDay,
            start: scheduleData.start,
            end: scheduleData.end,
            category: scheduleData.isAllDay ? 'allday' : 'time',
            dueDateClass: '',
            color: calendar.color,
            bgColor: calendar.bgColor,
            dragBgColor: calendar.bgColor,
            borderColor: calendar.borderColor,
            location: scheduleData.location,
            isPrivate: scheduleData.isPrivate,
            state: scheduleData.state
        };
        if (calendar) {
            schedule.calendarId = calendar.id;
            schedule.color = calendar.color;
            schedule.bgColor = calendar.bgColor;
            schedule.borderColor = calendar.borderColor;
        }
        //console.log(schedule)
        
        //console.log(window)
        __post('planday/add', schedule,res => {
            //console.log(res)
            cal.createSchedules([schedule]);
            refreshScheduleVisibility();
        })





    }

    function onChangeCalendars(e) {
        var calendarId = e.target.value;
        var checked = e.target.checked;
        var viewAll = document.querySelector('.lnb-calendars-item input');
        var calendarElements = Array.prototype.slice.call(document.querySelectorAll('#calendarList input'));
        var allCheckedCalendars = true;

        if (calendarId === 'all') {
            allCheckedCalendars = checked;

            calendarElements.forEach(function (input) {
                var span = input.parentNode;
                input.checked = checked;
                span.style.backgroundColor = checked ? span.style.borderColor : 'transparent';
            });

            CalendarList.forEach(function (calendar) {
                calendar.checked = checked;
            });
        } else {
            findCalendar(calendarId).checked = checked;

            allCheckedCalendars = calendarElements.every(function (input) {
                return input.checked;
            });

            if (allCheckedCalendars) {
                viewAll.checked = true;
            } else {
                viewAll.checked = false;
            }
        }

        refreshScheduleVisibility();
    }

    function refreshScheduleVisibility() {
        var calendarElements = Array.prototype.slice.call(document.querySelectorAll('#calendarList input'));

        CalendarList.forEach(function (calendar) {
            cal.toggleSchedules(calendar.id, !calendar.checked, false);
        });

        cal.render(true);

        calendarElements.forEach(function (input) {
            var span = input.nextElementSibling;
            span.style.backgroundColor = input.checked ? span.style.borderColor : 'transparent';
        });
    }

    function setDropdownCalendarType() {
        var calendarTypeName = document.getElementById('calendarTypeName');
        var calendarTypeIcon = document.getElementById('calendarTypeIcon');
        var options = cal.getOptions();
        var type = cal.getViewName();
        var iconClassName;

        if (type === 'day') {
            type = 'Daily';
            iconClassName = 'calendar-icon ic_view_day';
        } else if (type === 'week') {
            type = 'Weekly';
            iconClassName = 'calendar-icon ic_view_week';
        } else if (options.month.visibleWeeksCount === 2) {
            type = '2 weeks';
            iconClassName = 'calendar-icon ic_view_week';
        } else if (options.month.visibleWeeksCount === 3) {
            type = '3 weeks';
            iconClassName = 'calendar-icon ic_view_week';
        } else {
            type = 'Monthly';
            iconClassName = 'calendar-icon ic_view_month';
        }

        calendarTypeName.innerHTML = type;
        calendarTypeIcon.className = iconClassName;
    }

    function currentCalendarDate(format) {
        var currentDate = moment([cal.getDate().getFullYear(), cal.getDate().getMonth(), cal.getDate().getDate()]);

        return currentDate.format(format);
    }

    function setRenderRangeText() {
        var renderRange = document.getElementById('renderRange');
        var options = cal.getOptions();
        var viewName = cal.getViewName();

        var html = [];
        if (viewName === 'day') {
            html.push(currentCalendarDate('YYYY.MM.DD'));
        } else if (viewName === 'month' &&
            (!options.month.visibleWeeksCount || options.month.visibleWeeksCount > 4)) {
            html.push(currentCalendarDate('YYYY.MM'));
        } else {
            html.push(moment(cal.getDateRangeStart().getTime()).format('YYYY.MM.DD'));
            html.push(' ~ ');
            html.push(moment(cal.getDateRangeEnd().getTime()).format(' MM.DD'));
        }
        renderRange.innerHTML = html.join('');
    }

    function setSchedules() {
        cal.clear();
        __get('planday/list?viewtype=' + cal.getViewName() + '&start_time=' + cal.getDateRangeStart() + '&end_time=' + cal.getDateRangeEnd(), res => {
            //console.log(res)
            if (res.code == 0 && res.data.length > 0) {
                //let rt = [];
                res.data.forEach(d => {
                    //let content = JSON.parse(d.content)
                    //rt.push(content)
                    //console.log(content)
                    generateData(d.content, cal.getDateRangeStart(), cal.getDateRangeEnd());
                })
                //console.log(rt)
            }
            cal.createSchedules(ScheduleList);

            refreshScheduleVisibility();

        })
    }

    function setEventListener() {
        $('#menu-navi').on('click', onClickNavi);
        $('.dropdown-menu a[role="menuitem"]').on('click', onClickMenu);
        $('#lnb-calendars').on('change', onChangeCalendars);

        $('#btn-save-schedule').on('click', onNewSchedule);
        $('#btn-new-schedule').on('click', createNewSchedule);

        $('#dropdownMenu-calendars-list').on('click', onChangeNewScheduleCalendar);

        window.addEventListener('resize', resizeThrottled);
    }

    function getDataAction(target) {
        return target.dataset ? target.dataset.action : target.getAttribute('data-action');
    }

    resizeThrottled = tui.util.throttle(function () {
        cal.render();
    }, 50);

    window.cal = cal;

    setDropdownCalendarType();
    setRenderRangeText();
    setSchedules();
    setEventListener();
})(window, tui.Calendar);

// set calendars
(function () {
    var calendarList = document.getElementById('calendarList');
    var html = [];
    CalendarList.forEach(function (calendar) {
        html.push('<div class="lnb-calendars-item"><label>' +
            '<input type="checkbox" class="tui-full-calendar-checkbox-round" value="' + calendar.id + '" checked>' +
            '<span style="border-color: ' + calendar.borderColor + '; background-color: ' + calendar.borderColor + ';"></span>' +
            '<span>' + calendar.name + '</span>' +
            '</label></div>'
        );
    });
    calendarList.innerHTML = html.join('\n');
})();
$('#changeleft').click(e => {
    $('#lnb').toggle();
    if ($('#lnb').css('display') == 'none') {
        $('#right').css('left', 0);
    } else {
        $('#right').css('left','200px');
    }

})

