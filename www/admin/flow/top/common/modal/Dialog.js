import {createElement} from "../utils.js";

let currentDialog;

export function hide() {
    if (!currentDialog) {
        return
    }
    if (!currentDialog.parentNode) {
        currentDialog = null;
        return;
    }
    currentDialog.parentNode.classList.remove('modal-open');
    currentDialog.parentNode.removeChild(currentDialog);
    currentDialog = null;
}

const ModalTemplate = `<div class="modal-backdrop in"></div>
    <div class="modal-dialog">
      <div class="modal-content">
      </div>
    </div>`


export function showDialog({relatedTarget = document.body, content}) {
    currentDialog && this.hide();
    relatedTarget.classList.add('modal-open');

    currentDialog = createElement({
        html: ModalTemplate,
        className: 'modal in'
    });
    let body = currentDialog.querySelector('.modal-content');
    if(content){
        if(content instanceof HTMLElement){
            body.appendChild(content);
        }else{
            body.innerHTML = content;
        }
    }

    currentDialog.onclick = function (evt) {
        if (evt.target !== evt.currentTarget) {
            return;
        }
        hide();
    }
    relatedTarget.appendChild(currentDialog);
    return body;
}