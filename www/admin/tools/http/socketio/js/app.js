var eventsToListen = [];
var socket = {};
var disconnectedInerval;
var url = '';
var options = '';
var title = document.title;
var localdb = null;


$(function() {
    $('#jsonData').hide();
    $('.emitted-msg').hide();
    $('.emitted-failure-msg').hide();
    $('.listen-failure-msg').hide();
    $('.listen-added-msg').hide();
    $('.disconnected-alert, .connected-alert').hide();
    $('input[type=radio][name=emitAs]').change(function() {
        if (this.value === 'JSON') {
            $('#plainTextData').hide();
            $('#jsonData').show();
        }
        if (this.value === 'plaintext') {
            $('#plainTextData').show();
            $('#jsonData').hide();
        }
    });

    $("#connect").submit(function(e) {
        e.preventDefault();
        if ($("#connect .btn").html().trim() === 'Connect') {
            url = $("#connect_server").val().trim();
            options = $("#connect_options").val().trim();
            var opt = options ? JSON.parse(options) : null;
            if (url === '') {
                console.error('Invalid URL given');
            } else {
                socket = io(url, opt);
                setHash();
                socket.on('connect', function() {
                    $("#submitEmit").prop('disabled', false);
                    clearInterval(disconnectedInerval);
                    document.title = title;
                    $('.disconnected-alert').hide();
                    $('.connected-alert').show().delay(5000).fadeOut(1000);
                    $("#connectionPanel").prepend('<p><span class="text-muted">' + getFormattedNowTime() + '</span> Connected</p>');
                    $("#connect .btn").html('Disconnect');
                    $("#connect .btn").removeClass('btn-success');
                    $("#connect .btn").addClass('btn-danger');
                    $("#slideOut .slideOutTab").addClass('slideConnectedTab');

                    $("#connect input").prop('disabled', true);
                });
                socket.on('disconnect', function(sock) {
                    $("#submitEmit").prop('disabled', true);
                    disconnectedInerval = setInterval(function() {
                        if (document.title === "Disconnected") {
                            document.title = title;
                        } else {
                            document.title = "Disconnected";
                        }
                    }, 800);
                    $('.disconnected-alert').hide();
                    $('.disconnected-alert').show();
                    $("#connectionPanel").prepend('<p><span class="text-muted">' + getFormattedNowTime() + '</span> Disconnected --> ' + sock + '</p>');
                    $("#connect .btn").html('Connect');
                    $("#connect .btn").removeClass('btn-danger');
                    $("#connect .btn").addClass('btn-success');
                    $("#slideOut .slideOutTab").removeClass('slideConnectedTab');

                    $("#connect input").prop('disabled', false);
                });
                registerEvents();
            }
        } else {
            socket.disconnect();
        }
    });

    $("#addListener").submit(function(e) {
        e.preventDefault();
        console.log('addListener')
        var event = $("#addListener input:first").val().trim();
        if (event.length !== 0 && eventsToListen.indexOf(event) === -1) {
            eventsToListen.push(event);
            $('#eventPanels').prepend(makePanel(event));
            $("#addListener input:first").val('');
            setHash();
            registerEvents();
            $('.listen-added-msg').show().delay(1000).fadeOut(1000);
        } else {
            $('.listen-failure-msg').show().delay(1500).fadeOut(1000);
            console.error('Invalid event name');
        }
    });

    $("#emitData").submit(function(e) {
        if (socket.io) {
            var event = $("#emitData #event-name").val().trim();
            var data = parseJSONForm(editor.getValue());
            if (event !== '' && data !== '') {
                var emitData = {
                    event: event,
                    request: data,
                    time: getFormattedNowTime()
                };

                postDataIntoDB(emitData);
                // addHistoryPanel(emitData);
                emit(event, data);

                $('.emitted-msg').show().delay(700).fadeOut(1000)
            } else {
                $('.emitted-failure-msg').show().delay(700).fadeOut(1000);
                console.error('Emitter - Invalid event name or data');
            }
        } else {
            console.error('Emitter - not connected');
        }
        e.preventDefault();
    });


    $("#clearHistory").submit(function(e) {
        e.preventDefault();
        initDB(true);
        $('#emitHistoryPanels').empty();
    });


    processHash();
    initHistory();
});

function setHash() {
    if (url !== '' && eventsToListen.length > 0) {
        location.hash = "url=" + window.btoa(url) + "&opt=" + window.btoa(options) + "&events=" + eventsToListen.join();
    }

    if (url !== '' && eventsToListen.length === 0) {
        location.hash = "url=" + window.btoa(url) + "&opt=" + window.btoa(options);
    }

}

function processHash() {
    var hash = location.hash.substr(1);
    if (hash.indexOf('url=') !== -1 && hash.indexOf('events=') !== -1) {
        var hashUrl = window.atob(hash.substr(hash.indexOf('url=')).split('&')[0].split('=')[1]);
        var hashOpt = window.atob(hash.substr(hash.indexOf('opt=')).split('&')[0].split('=')[1]);
        var hashEvents = hash.substr(hash.indexOf('events=')).split('&')[0].split('=')[1].split(',');
        $.merge(eventsToListen, hashEvents);
        $.each(hashEvents, function(index, value) {
            if (value !== '') {
                $('#eventPanels').prepend(makePanel(value));
            }
        });
        $('#connect input:first').val(hashUrl);
        $('#connect_options').val(hashOpt);
        $('#connect').submit();
    }
}

function registerEvents() {
    if (socket.io) {
        $.each(eventsToListen, function(index, value) {
            socket.on(value, function(data) {
                if (!data) {
                    data = '-- NO DATA --'
                }
                var panelName = $("#eventPanels").find("[data-windowId='" + value + "']");
                var elementToExtend = panelName;
                elementToExtend.prepend('<p><span class="text-muted">' + getFormattedNowTime() + '</span></p>' +
                    '<pre><code class="json"> ' + hljs.highlightAuto(JSON.stringify(data)).value + '</code></pre>');
                $("#eventPanels").find("#heading-" + value + " span").text($("#eventPanels").find("[data-windowId='" + value + "'] .text-muted").length);
            });
        });
    }
}

function clearEvents(event) {
    if (event === 'connectionPanel') {
        $('#connectionPanel').empty();
    } else {
        $('#eventPanels').find("[data-windowId='" + event + "']").empty();
        $("#eventPanels").find("#heading-" + event + " span").text("0");
    }
}

function closeEventListener(event) {
    eventsToListen.splice(eventsToListen.indexOf(event),1);
    setHash();
}

function closeEventHistory(event) {
    deleteEventHistory(event);
}

function clearEventsHistory(event) {
    $('#emitHistoryPanels').find("[data-windowId='" + event + "']").empty();
}

function clearAllEvents() {
    console.log("clearAllEvents")
    $('#eventPanels').find('.panel-heading span')
        .each(function() {
            $(this).text("0");
        });
    $('#eventPanels').find('.panel-body')
        .each(function() {
            $(this).empty();
        });
}

function parseJSONForm(result) {
    console.log("json to emit " + result);
    return JSON.parse(result);
}

function makePanel(event) {
    return `
        <div class="panel panel-info">
            <div class="panel-heading" id="heading-`+ event+ `">
              <h4 class="panel-title">
                On "` + event + `" Events - (<span class="count" data-toggle="tooltip" title="number of events">0</span>)
                <div class="pull-right">
                  <a href="#" data-perform="panel-dismiss" onclick="closeEventListener('` + event + `')" class="btn btn-info btn-xs pull-right"><i class="fa fa-times"></i></a>
                  <a href="#" data-perform="panel-refresh" onclick="clearEvents('` + event + `')" class="btn btn-info btn-xs pull-right"><i class="fa fa-refresh"></i></a>
                  <a href="#" data-perform="panel-collapse" data-target="#panel-` + event + `-content" class="btn btn-info btn-xs pull-right"><i class="fa fa-minus"></i></a>
                </div>
              </h4>
            </div>

            <div class="panel-wrapper collapse in">
                <div data-windowId="` + event + `" class="panel-body" id="panel-` + event + `-content">
                </div>
            </div>
        </div>
    `;
}




function makePanelHistory(event) {
    return `
        <div class="panel panel-info">
            <div class="panel-heading">
              <h4 class="panel-title">
                On "` + event + `" Events
                <div class="pull-right">
                  <a href="#" data-perform="panel-dismiss" onclick="deleteEventHistory('` + event + `')" class="btn btn-info btn-xs pull-right"><i class="fa fa-times"></i></a>
                  <a href="#" data-perform="panel-refresh" onclick="clearEventsHistory('` + event + `')" class="btn btn-info btn-xs pull-right"><i class="fa fa-refresh"></i></a>
                  <a href="#" data-perform="panel-collapse" data-target="#panel-` + event + `-content" class="btn btn-info btn-xs pull-right"><i class="fa fa-minus"></i></a>
                </div>
              </h4>
            </div>

            <div class="panel-wrapper collapse in">
                <div data-windowId="` + event + `" class="panel-body" id="panel-` + event + `-contentHistory">
                </div>
            </div>
        </div>
    `;
}

function getFormattedNowTime() {
    var now = new Date();
    return now.getHours() + ":" +
        now.getMinutes() + ":" +
        now.getSeconds() ;
}

function initDB(clear) {
    var dbName = 'socketioClientDB';
    if (clear) {
        localdb.destroy().then(function() {
            localdb = new PouchDB(dbName);
        });
    } else {
        localdb = new PouchDB(dbName);
    }
}


function deleteEventHistory(event) {
    initDB(false);
    var ddoc = {
        _id: '_design/index',
        views: {
            index: {
                map: function mapFun(doc) {
                    emit(doc._id, doc);
                }.toString()
            }
        }
    };
    localdb.put(ddoc).catch(function(err) {
        if (err.name !== 'conflict') {
            throw err;
        }
    }).then(function() {
        return localdb.query('index');
    }).then(function(result) {
        var rows = result.rows;
        for (var i in rows) {
            var doc = rows[i].value;
            if(doc.event === event) {
                return localdb.remove(doc._id, doc._rev)
            }
        }
    }).catch(function(err) {
        console.log(err);
    });
}

function initHistory() {
    initDB(false);
    var ddoc = {
        _id: '_design/index',
        views: {
            index: {
                map: function mapFun(doc) {
                    emit(doc._id, doc);
                }.toString()
            }
        }
    };
    localdb.put(ddoc).catch(function(err) {
        if (err.name !== 'conflict') {
            throw err;
        }
    }).then(function() {
        return localdb.query('index', {
            descending: true,
            limit: 20
        });
    }).then(function(result) {
        var rows = result.rows;
        for (var i in rows) {
            var history = rows[i].value;
            addHistoryPanel(history);
        }
    }).catch(function(err) {
        console.log(err);
    });
}

function postDataIntoDB(data, callback) {
    if (localdb == null) {
        localdb = new PouchDB("socketioClientDB");
    }

    localdb.find({
        // selector: { event: data.event}
        selector: { event: data.event}
    }, function (err, result) {
        if (err) { return console.log(err); }
        let updated = false;
        result.docs.map(doc => {
            if (equals(doc.request,data.request)) {
                data._rev = doc._rev;
                data._id = doc._id;
                localdb.put(data).then(callback);
                updated = true;
            };
        });

        if (!updated) localdb.post(data).then(callback);
    });
}

function equals(obj1, obj2) {
    function _equals(obj1, obj2) {
        var clone = $.extend(true, {}, obj1),
            cloneStr = JSON.stringify(clone);
        return cloneStr === JSON.stringify($.extend(true, clone, obj2));
    }

    return _equals(obj1, obj2) && _equals(obj2, obj1);
}

function emit(event, data) {
    console.log('Emitter - emitted: ' + JSON.stringify(data));
    socket.emit(event, data);

}


function addHistoryPanel(history) {
    var histPanelId = history.event;
    var panel = $("#emitHistoryPanels").find("[data-windowId='" + histPanelId + "']");
    if (panel.length == 0) {
        $('#emitHistoryPanels').prepend(makePanelHistory(histPanelId));
    }
    var elementToExtend = $("#emitHistoryPanels").find("[data-windowId='" + histPanelId + "']");
    var historyContent = $('#historyContent').text();
    var id = 'hist-' + new Date().getTime();
    historyContent = historyContent.split('[[id]]').join(id);
    historyContent = historyContent.split('[[time]]').join(history.time);
    historyContent = historyContent.split('[[reqData]]').join(JSON.stringify(history.request));
    historyContent = historyContent.split('[[event]]').join(history.event);
    elementToExtend.prepend(historyContent);
    $("#form" + id).submit(function(e) {
        e.preventDefault();
        var id = $(this).find('[name="historyId"]').val();
        var data = $(this).find('[name="reqData"]').val();
        var event = $(this).find('[name="event"]').val();

        if (socket.io) {
            if (event !== '' && data !== '') {
                emit(event, JSON.parse(data));
                $('.emitted-msg-' + id).show().delay(700).fadeOut(1000)
            } else {
                $('.emitted-failure-msg-' + id).show().delay(700).fadeOut(1000);
                console.error('Emitter - Invalid event name or data');
            }
        } else {
            $('.emitted-failure-msg-' + id).show().delay(700).fadeOut(1000);
            console.error('Emitter - not connected');
        }
    });
}

// load stored history
$('.tab a').on('click', function (e) {
    if ($(this).attr("href") === '#history') {
        $('#emitHistoryPanels').empty();
        initHistory();
    }
});


