let requestObj = {
  url: '',
  type: '',
  cross_origin: false,
  jsonType: false,
  parameter: {},
  headers: {},
}

$(document).ready(function(){
  //提交按钮触发
  $('#submit').click(function(){
    // console.log('ok');
    setSend();
  });

  //提示框初始化
  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
  })

  //初始化弹窗
  toastr.options = {
    positionClass : 'toast-top-center',
    closeButton : true, //关闭按钮
    progressBar : true,//进度条
    newestOnTop : false, //新消息置顶
    preventDuplicates : false, //阻止点击取消
  }
})

//获取输入框中参数值
function getTableValue(){
  //清空requestObj参数
  requestObj.parameter = {};

  let rowLength =  $('.key').length;

  for(let i = 0; i < rowLength; i++){

    let key = $('[name = keys]')[i].value;
    let value = $('[name = values]')[i].value;
    let paramsType = $("input[name='paramsType"+ i +"']:checked").val();

    switch(paramsType){
      case "string" :
        //不做处理
        break;
      case "array" : 
        value = value.split(','); //转换数组
        break;
      case "object" :
        value = JSON.parse(value); //转换成对象
        break;
      default : break;
    }

    requestObj.parameter[key] = value;

  }

}

//获取headers输入框中参数值
function getHeadersTableValue(){
  //清空requestObj参数
  requestObj.headers = {};

  let rowLength =  $('.key_headers').length;

  for(let i = 0; i < rowLength; i++){

    let key = $('[name = keys_headers]')[i].value;
    let value = $('[name = values_headers]')[i].value;

    requestObj.headers[key] = value;
  }
}

function getCheckedStatus(){
  //不发送参数
  if($('#openParameter').prop('checked') === false){
    requestObj.parameter = {};
  }
}

function setCrossOriginStatus(){
  if($('#crossOrigin').prop('checked') === true){
    requestObj.cross_origin = true;
  }else {
    requestObj.cross_origin = false;
  }
}

function setRequestJsonMode(){
  if($('#jsonStatus').prop('checked') === true){
    requestObj.parameter = JSON.stringify(requestObj.parameter); //json序列化
    requestObj.jsonType = true;
  }else {
    requestObj.jsonType = false;
  }
}

//按钮触发
function setSend(){
  let url = $('#url').val(); //获取输入框url
  let httpType = $('#type').val(); //获取请求类型
  requestObj.url = url;
  requestObj.type = httpType;

  getTableValue();//获取参数数据
  getHeadersTableValue();//获取headers头参数
  getCheckedStatus();//判断是否发送数据
  setCrossOriginStatus();//判断是否跨域请求
  setRequestJsonMode();//判断请求格式是否为json

  sendRequest();//发送请求
}

//发送请求
function sendRequest(){

  console.log(requestObj);

  $.ajax({
    type: requestObj.type,
    url: requestObj.url,
    dataType: 'json',
    crossDomain: requestObj.cross_origin,
    data: requestObj.parameter,
    headers: requestObj.headers,
    success: (response) => {
      $('#json_input').val(formatJson(JSON.stringify(response)));
      console.log(response);
      toastr.success('请求成功',{timeout: 3000})
    },
    error: function (jqXHR, textStatus, errorThrown) {
      console.log('textStatus:'+ textStatus + ' - errorThrown:' + errorThrown);
      $('#json_input').val(formatJson(JSON.stringify(jqXHR)));
      if(textStatus === 'timeout'){
          console.log('请求超时！');
          ajaxRequest.abort();
      }
      toastr.error('请求错误',{timeout: 3000})
    }
  })

}


//添加参数事件
function add_url_parameter(that){
  let element = that.parentNode.parentNode;
  let rowLength =  $('.key').length;
  // console.log(element);
  let Trhtml = '<tr class="key">' + 
  '<td><input k="" value="" name="keys" class="form-control" type="text" maxlength="100" placeholder="参数名称"></td> ' +
  '<td>' +
    '<input value="" v="" name="values" class="form-control" type="text" maxlength="5000" style="width: 60%;float: left;" placeholder="参数数值">' +
    '<button type="button" onclick="del(this);" class="btn btn-primary btn-sm del_btn">删除参数</button>' +
    '<input type="radio" name="paramsType'+ rowLength +'" checked="checked" value="string">字符串' +
    '<input type="radio" name="paramsType'+ rowLength +'" value="array">数组' +
    '<input type="radio" name="paramsType'+ rowLength +'" value="object">对象' +
    '</td>' +
  '</tr>'
  $(element).before(Trhtml);
}

//添加headers头参数事件
function addHeadersParameter(that){
  let element = that.parentNode.parentNode;
  // console.log(element);
  let Trhtml = '<tr class="key_headers">' + 
  '<td><input k="" value="" name="keys_headers" class="form-control" type="text" maxlength="100" placeholder="参数名称"></td> ' +
  '<td>' +
    '<input value="" v="" name="values_headers" class="form-control" type="text" maxlength="5000" style="width: 60%;float: left;" placeholder="参数数值">' +
    '<button type="button" onclick="del(this);" class="btn btn-primary btn-sm del_btn">删除参数</button>' +
    '</td>' +
  '</tr>'
  $(element).before(Trhtml);
}

function del(that){
  let element = that.parentNode.parentNode;
  // console.log(element);
  $(element).remove();
}

//格式化代码函数,已经用原生方式写好了不需要改动,直接引用就好
var formatJson = function (json, options) {
  var reg = null,
          formatted = '',
          pad = 0,
          PADDING = '    ';
  options = options || {};
  options.newlineAfterColonIfBeforeBraceOrBracket = (options.newlineAfterColonIfBeforeBraceOrBracket === true) ? true : false;
  options.spaceAfterColon = (options.spaceAfterColon === false) ? false : true;
  if (typeof json !== 'string') {
      json = JSON.stringify(json);
  } else {
      json = JSON.parse(json);
      json = JSON.stringify(json);
  }
  reg = /([\{\}])/g;
  json = json.replace(reg, '\r\n$1\r\n');
  reg = /([\[\]])/g;
  json = json.replace(reg, '\r\n$1\r\n');
  reg = /(\,)/g;
  json = json.replace(reg, '$1\r\n');
  reg = /(\r\n\r\n)/g;
  json = json.replace(reg, '\r\n');
  reg = /\r\n\,/g;
  json = json.replace(reg, ',');
  if (!options.newlineAfterColonIfBeforeBraceOrBracket) {
      reg = /\:\r\n\{/g;
      json = json.replace(reg, ':{');
      reg = /\:\r\n\[/g;
      json = json.replace(reg, ':[');
  }
  if (options.spaceAfterColon) {
      reg = /\:/g;
      json = json.replace(reg, ':');
  }
  (json.split('\r\n')).forEach(function (node, index) {
              var i = 0,
                      indent = 0,
                      padding = '';

              if (node.match(/\{$/) || node.match(/\[$/)) {
                  indent = 1;
              } else if (node.match(/\}/) || node.match(/\]/)) {
                  if (pad !== 0) {
                      pad -= 1;
                  }
              } else {
                  indent = 0;
              }

              for (i = 0; i < pad; i++) {
                  padding += PADDING;
              }

              formatted += padding + node + '\r\n';
              pad += indent;
          }
  );
  return formatted;
};