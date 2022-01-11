export function readTextFile(file, ext, cb) {
    let name = file.name;
    if (typeof ext === 'string') {
        let reg = new RegExp('.' + ext + '$', 'gi');
        if (!reg.test(name)) {
            alert('Please selects .' + ext + ' file');
            return;
        }
    } else if (ext instanceof Function) {
        cb = ext;
    }
    let fileReader = new FileReader();
    fileReader.onload = function (evt) {
        cb(fileReader.result);
    }
    fileReader.readAsText(file, 'utf-8');
}

let _isFileSaverSupported;

export function isBlobSupported(){
    if(_isFileSaverSupported === undefined){
        try {
            _isFileSaverSupported = !!new Blob;
        } catch (e) {}
    }
    return _isFileSaverSupported;
}

//https://stackoverflow.com/questions/24007073/open-links-made-by-createobjecturl-in-ie11
export function saveAs(blob, filename){
    if(!isBlobSupported()){
        throw 'file saver not be supported'
    }
    if(navigator.msSaveOrOpenBlob){
        return navigator.msSaveOrOpenBlob(blob, filename);
    }
    let a = document.createElement("a");
    a.style.display = 'none';
    document.body.appendChild(a);
    let csvUrl = URL.createObjectURL(blob);
    a.href =  csvUrl;
    a.download = filename;
    a.click();
    URL.revokeObjectURL(a.href)
    a.remove();

}