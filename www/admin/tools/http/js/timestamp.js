$(document).ready(function(){
  updataInterval(); //开启定时器

  //转日期按钮
  $('#d_button').click(function(){
    transformTimestamp();
  });
  //转时间戳按钮
  $('#t_button').click(function(){
    transformDate();
  });

})

function setNowTimestampHtml(){
  var timestamp = Math.round(new Date().getTime()/1000);
  $('#nowTimestamp').val(timestamp);

}

//定时器
function updataInterval(){
  var timer = setInterval(function(){
    setNowTimestampHtml(); // 渲染HTML
    clearInterval(timer); // 释放定时器
    updataInterval();
  }, 1000);
}

//时间戳转日期
function transformTimestamp(){
  var timestamp = $('#d_timestamp').val() * 1000;
  var timeString = new Date(timestamp);
  var date = formatDate(timeString);
  console.log(timestamp);
  console.log(date);

  $('#d_date').val(date);
}

function formatDate(now) {  
  var year = now.getFullYear();  
  var month = now.getMonth() + 1;  
  var date = now.getDate();  
  var hour = now.getHours();  
  var minute = now.getMinutes();  
  var second = now.getSeconds();  
  return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;  
}  

//日期转时间戳
function transformDate(){
  var timeDate = $('#t_date').val();
  var timestamp = Date.parse(new Date(timeDate)) /1000;
  console.log(timeDate);
  console.log(timestamp);

  $('#t_timestamp').val(timestamp);
}