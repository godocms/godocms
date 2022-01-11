let _lastTimestamp = 0; //上传时间增量
let _lastLoaded = 0;    //上传进度增量

// 上传配置项
let uploadOption = {
    action:"word/openFile", //上传接口
    filter:"",                          //文件类型过滤器
    maxsize:50,                         //文件上传大小限制，单位：M
    params:null,                        //请求参数
    startCallback:null,                 //开始上传的回调函数
    progressCallback:null,              //上传进度回调函数
    successCallback:null,               //上传成功回调函数
    errorCallback:null                  //上传错误的回调函数
}

//配置方法
let config = (action, params, filter, maxsize, startcb)=>{
    if(action!=null && action!=""){
        uploadOption.action = action;
    }
    if(filter!=null){
        uploadOption.filter = filter;
    }
    if(maxsize!=null && !isNaN(maxsize)){
        uploadOption.maxsize = maxsize;
    }
    if(params!=null){
        uploadOption.params = params;
    }
    uploadOption.startCallback = startcb;
}

//设置配置对象，建议使用
let setOption = (opt)=>{
    if(opt!=undefined && opt!=null){
        uploadOption.action = opt.action || "word/openFile";
        uploadOption.filter = opt.filter || "";
        uploadOption.maxsize = opt.maxsize || 50;
        uploadOption.params = opt.params || null;
        uploadOption.startCallback = opt.startCallback || null;
        uploadOption.progressCallback = opt.progressCallback || null;
        uploadOption.successCallback = opt.successCallback || null;
        uploadOption.errorCallback = opt.errorCallback || null;
    }
}

//上传方法
let upload = (resolve, reject)=>{
    let input = document.createElement("input");
    input.type = "file";
    input.name = "file";
    input.click();
    input.onchange = function(){
        let file = input.files[0];
        let tmparr = file.name.split(".");
        let fileType =  tmparr[tmparr.length-1].toLowerCase();
        if(uploadOption.filter!=null && uploadOption.filter!=""){
            let filterArr = uploadOption.filter.split(",");
            let notFilter = true;
            for(let i=0; i<filterArr.length; i++){
                if(fileType == filterArr[i].toLowerCase()){
                    notFilter = false;
                    break;
                }
            }
            if(notFilter){
                //文件类型不符合要求
                if(uploadOption.errorCallback!=undefined && uploadOption.errorCallback!=null){
                    uploadOption.errorCallback("文件类型不符合要求");
                }
                //reject("文件类型不符合要求");
                return;
            }
        }
        let sizeM = file.size/1024/1024;
        if(sizeM > uploadOption.maxsize){
            //文件大小不符合要求
            if(uploadOption.errorCallback!=undefined && uploadOption.errorCallback!=null){
                uploadOption.errorCallback("文件大小不符合要求");
            }
            //reject("文件大小不符合要求");
            return;
        }
        var form = new FormData();
        form.append("file", file);
        form.append("fileName", file.name);
        form.append("size", file.size);
        if(uploadOption.params!=null){
            for(let key in uploadOption.params){
                form.append(key, uploadOption.params[key]);
            }
        }
        var xhr = new XMLHttpRequest();
        var action = apiUrl + uploadOption.action;
        console.log(action)
        xhr.open("POST", action);
        xhr.withCredentials = true;
        // ****** 各种事件的监听 ******
        //开始上传
        xhr.upload.onloadstart = function(event){
            _lastTimestamp = event.timeStamp;
            _lastLoaded = 0;
            if(uploadOption.startCallback!=undefined && uploadOption.startCallback!=null){
                uploadOption.startCallback(file);
            }
        };
        //上传进度
        xhr.upload.onprogress = function(event){
            var offtimestamp = event.timeStamp - _lastTimestamp;
            _lastTimestamp = event.timeStamp;
            var offloaded = event.loaded - _lastLoaded;
            _lastLoaded = event.loaded;
            offtimestamp = offtimestamp / 1000; //转换成秒
            offloaded = offloaded / 1024; //转换成KB
            var speed = Math.round(offloaded/offtimestamp); // KB/S
            var progress = event.loaded / event.total; // 0~1
            var total = Math.round(event.total/1024); // KB
            if(uploadOption.progressCallback!=undefined && uploadOption.progressCallback!=null){
                uploadOption.progressCallback({
                    computable: event.lengthComputable,
                    speed: speed,
                    progress: progress,
                    total: total,
                    event: event
                });
            }
        };
        //上传完成
        xhr.onload = function(event){
            if(uploadOption.successCallback!=undefined && uploadOption.successCallback!=null){
                var resultObj;
                try {
                    resultObj = JSON.parse(xhr.responseText);
                } catch (error) {
                    resultObj = xhr.responseText;
                }
                uploadOption.successCallback(resultObj);
            }
        };
        //上传错误
        xhr.onerror =  function(event){
            if(uploadOption.errorCallback!=undefined && uploadOption.errorCallback!=null){
                uploadOption.errorCallback();
            }
        };
        //状态变化
        xhr.onreadystatechange = function(){
            if(xhr.readyState==4){
                if(xhr.status==200){
                    try {
                        var resultObj = JSON.parse(xhr.responseText);
                        resolve(resultObj);
                    } catch (error) {
                        resolve(xhr.responseText);
                    }
                }
                // else{
                //     reject("上传失败，网络错误");
                // }
            }
        }
        xhr.setRequestHeader(TOKEN_NAME, getToken());
        xhr.send(form);
    }
}

//创建一个返回Promise的上传方法
let uploadPr = ()=>{
    return new Promise(upload);
}

window.easyuploader = {
    config: config,
    setOption: setOption,
    upload: uploadPr
}