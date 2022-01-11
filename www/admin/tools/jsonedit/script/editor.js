var data;
var currentNode;
var currentNodeMaxIndex;
var currentNodePath;

var autoTypeConvert = true;

var fname;
var copiedNode;

var searchString = '';

const DELIMITER = String.fromCharCode(7);

function loadFile(type) {
	let fileSelector = document.createElement('input');
	fileSelector.type = 'file';
	if (type) {
		fileSelector.setAttribute('accept', type);
	}
	fileSelector.addEventListener('change', () => {
		let file = fileSelector.files[0];
		fname = file.name;
		var reader = new FileReader();
		reader.onload = function (e) {
			var contents = e.target.result;
			loadData(contents);
		};
		reader.readAsText(file);
	});
	fileSelector.click();
}

function loadData(string) {
	//TODO refresh not reload
	try {
		data = JSON.parse(string);
	} catch (err) {
		alert('Your JSON contains syntax errors!\n' + 'Fail to parse JSON: ' + err.message);
		return;
	}
	document.querySelector('#save-json-button').style.visibility = 'visible';
	document.querySelector('#browser').style.visibility = 'visible';
	if (fname !== undefined) {
		document.querySelector('title').innerText = ('JSONEdit: ' + fname);
	} else {
		fname = 'JSON.json';
	}
	document.querySelector('#tree').innerHTML = '';
	document.querySelector('#editor-content').innerHTML = '';
	assembleTreeDisplay(data, fname);
}

function assembleTreeDisplay(object, name) {
	let tree = getTreeNodeHTML(object, name);
	if (tree){
		document.querySelector('#tree').appendChild(tree);
	}
	document.querySelectorAll('.caret').forEach((element) => {
		element.addEventListener('click', (e) => {
			let item = e.target.parentElement;
			item.querySelector('.tree-node-list')?.classList.toggle('active-tree');
			if (item.querySelector('.caret').innerHTML === '+') {
				item.querySelector('.caret').innerHTML = '-';
			} else if (item.querySelector('.caret').innerHTML === '-') {
				item.querySelector('.caret').innerHTML = '+';
			}
		});
	});
	document.querySelectorAll('.tree-label').forEach((element) => {
		element.addEventListener('click', (e) => {
			e.stopPropagation();
			document.querySelectorAll('.tree-label-selected').forEach((e2) => e2.classList.toggle('tree-label-selected'));
			e.target.classList.toggle('tree-label-selected');
			loadDatum(e.target.dataset.name);
		});
	});
}

function refreshTree() {
	if (!!data) {
		loadData(JSON.stringify(data));
	}
}

function getTreeNodeHTML(object, name) {
	let node = document.createElement('li');
	let list = [];
	if (Array.isArray(object)) {
		let length = 0;
		object.forEach((value, key) => {
			let child = getTreeNodeHTML(value, name + DELIMITER + key);
			if (child !== undefined) {
				list.push(child);
				length++;
			}
		});
		if (length > 0) {
			node.insertAdjacentHTML('beforeend', `<span class='caret'>${searchString.length>0?'-':'+'}</span><span class='tree-label' data-name='${name}'><i class='type-icon-array type-icon'> </i>${name.substr(name.lastIndexOf(DELIMITER) + 1)}</span>`);
		} else {
			node.insertAdjacentHTML('beforeend', `<span class='caret'>&nbsp;</span><span class='tree-label' data-name='${name}'><i class='type-icon-array type-icon'> </i>${name.substr(name.lastIndexOf(DELIMITER) + 1)}</span>`);
		}
	} else if (isObject(object)) {
		let entries = Object.entries(object);
		let length = 0;
		for (const [key, value] of entries) {
			let child = getTreeNodeHTML(value, name + DELIMITER + key);
			if (child !== undefined) {
				list.push(child);
				length++;
			}
		}
		if (length > 0) {
			node.insertAdjacentHTML('beforeend', `<span class='caret'>${searchString.length>0?'-':'+'}</span><span class='tree-label' data-name='${name}'><i class='type-icon-object type-icon'> </i>${name.substr(name.lastIndexOf(DELIMITER) + 1)}</span>`);
		} else {
			node.insertAdjacentHTML('beforeend', `<span class='caret'>&nbsp;</span><span class='tree-label' data-name='${name}'><i class='type-icon-object type-icon'> </i>${name.substr(name.lastIndexOf(DELIMITER) + 1)}</span>`);
		}
	} else if (isNumber(object)) {
		node.insertAdjacentHTML('beforeend', `<span class='caret'>&nbsp;</span><span class='tree-label' data-name='${name}'><i class='type-icon-number type-icon'> </i>${name.substr(name.lastIndexOf(DELIMITER) + 1)}</span>`);
	} else if (object === true || object === false) {
		node.insertAdjacentHTML('beforeend', `<span class='caret'>&nbsp;</span><span class='tree-label' data-name='${name}'><i class='type-icon-bool type-icon'> </i>${name.substr(name.lastIndexOf(DELIMITER) + 1)}</span>`);
	} else {
		node.insertAdjacentHTML('beforeend', `<span class='caret'>&nbsp;</span><span class='tree-label' data-name='${name}'><i class='type-icon-string type-icon'> </i>${name.substr(name.lastIndexOf(DELIMITER) + 1)}</span>`);
	}
	if (list.length > 0 || (searchString.length === 0 || name.toLowerCase().includes(searchString.toLowerCase()))) {
		let nodeList = document.createElement('ul');
		nodeList.classList.add('tree-node-list');
		if (searchString.length > 0 && name.split(DELIMITER).pop().toLowerCase().includes(searchString.toLowerCase())){
			nodeList.classList.add('active-tree')
		}
		for (let i = 0; i < list.length; i++) {
			nodeList.appendChild(list[i]);
		}
		node.appendChild(nodeList);
		return node;
	} else {
		return undefined;
	}
}

function loadDatum(path) {
	let pathComponents = path.split(DELIMITER);
	let index;
	let targetObj;
	let editor = document.querySelector('#editor-content');
	editor.innerHTML = '';
	index = 1;
	targetObj = data;
	for (let i = index; i < pathComponents.length; i++) {
		targetObj = targetObj[pathComponents[i]];
	}
	if (!isObject(targetObj) && !Array.isArray(targetObj)) {
		pathComponents.pop();
		return loadDatum(pathComponents.join(DELIMITER));
	}
	currentNode = targetObj;
	currentNodePath = path;
	//TODO reduce repeated code
	if (Array.isArray(currentNode)) {
		currentNodeMaxIndex = currentNode.length;
		currentNode.forEach((o, i) => {
			if (isObject(o)) {
				editor.insertAdjacentHTML('beforeend', `
														<div class="table-row">
															<input class="key-input" readonly value=${i}> : <textarea class="table-cell value-input" readonly value=${JSON.stringify(o)} id="id-input">${JSON.stringify(o)}</textarea>
															<button class='delete-row'><i class="material-icons" style="vertical-align: middle;">remove_circle</i>Delete</button>
														</div>`
				);
			} else {
				editor.insertAdjacentHTML('beforeend', `
														<div class="table-row">
															<input class="key-input" readonly value=${i}> : <textarea class="table-cell value-input" value=${o} id="id-input">${o}</textarea>
															<button class='delete-row'><i class="material-icons" style="vertical-align: middle;">remove_circle</i>Delete</button>
														</div>`
				);
			}
		});
	} else {
		for (let [i, o] of Object.entries(currentNode)) {
			if (isObject(o)) {
				editor.insertAdjacentHTML('beforeend', `
														<div class="table-row">
															<input class="key-input" value=${i}> : <textarea class="table-cell value-input" readonly value=${JSON.stringify(o)} id="id-input">${JSON.stringify(o)}</textarea>
															<button class='delete-row'><i class="material-icons" style="vertical-align: middle;">remove_circle</i>Delete</button>
														</div>`
				);
			} else {
				editor.insertAdjacentHTML('beforeend', `
														<div class="table-row">
															<input class="key-input" value=${i}> : <textarea class="table-cell value-input" value=${o} id="id-input">${o}</textarea>
															<button class='delete-row'><i class="material-icons" style="vertical-align: middle;">remove_circle</i>Delete</button>
														</div>`
				);
			}
		}
	}
	if (!document.querySelectorAll('.new').length) {
		//FIXME can this be fixed not generated every time?
		editor.insertAdjacentHTML('beforeend', `
			<div class='table-row' id='new-row'>
				<button class='new'>
					<i class='material-icons' style='vertical-align: middle;'>add_circle</i>
					New...
				</button>
				<ul class='menu' id='new-option'>
					<li class='menu-items' id='new-value-button'><a>Value</a></li>
					<li class='menu-items' id='new-array-button'><a>Array</a></li>
					<li class='menu-items' id='new-object-button'><a>Object</a></li>
				</ul>
			</div>
		`);
		document.querySelector('#new-value-button').addEventListener('click', () => {
			document.querySelector('#new-option').style.display = 'none';
			let newRow;
			if (Array.isArray(currentNode)) {
				newRow = `
					<div class='table-row'><input class='key-input' readonly value=''> :
						<textarea class='table-cell value-input' id='id-input'> </textarea>
						<button class='delete-row'>
							<i class='material-icons' style='vertical-align: middle;'>remove_circle</i>Delete
						</button>
					</div>
				`;
			} else {
				newRow = `
					<div class='table-row'><input class='key-input' value=''> :
						<textarea class='table-cell value-input' id='id-input'> </textarea>
						<button class='delete-row'>
							<i class='material-icons' style='vertical-align: middle;'>remove_circle</i>Delete
						</button>
					</div>
				`;
			}
			document.querySelector('#new-row').insertAdjacentHTML('beforebegin', newRow);
			reloadIndices();
		});
		document.querySelector('#new-array-button').addEventListener('click', () => {
			document.querySelector('#new-option').style.display = 'none';
			let newRow;
			if (Array.isArray(currentNode)) {
				newRow = `
					<div class='table-row'><input class='key-input' readonly value=''> :
						<textarea class='table-cell value-input' readonly id='id-input'>[]</textarea>
						<button class='delete-row'>
							<i class='material-icons' style='vertical-align: middle;'>remove_circle</i>Delete
						</button>
					</div>
				`;
			} else {
				newRow = `
					<div class='table-row'><input class='key-input' value=''> :
						<textarea class='table-cell value-input' readonly id='id-input'>[]</textarea>
						<button class='delete-row'>
							<i class='material-icons' style='vertical-align: middle;'>remove_circle</i>Delete
						</button>
					</div>
				`;
			}
			document.querySelector('#new-row').insertAdjacentHTML('beforebegin', newRow);
			reloadIndices();
		});
		document.querySelector('#new-object-button').addEventListener('click', () => {
			document.querySelector('#new-option').style.display = 'none';
			let newRow;
			if (Array.isArray(currentNode)) {
				newRow = `
					<div class='table-row'><input class='key-input' readonly value=''> :
						<textarea class='table-cell value-input' readonly id='id-input'>{}</textarea>
						<button class='delete-row'>
							<i class='material-icons' style='vertical-align: middle;'>remove_circle</i>Delete
						</button>
					</div>
				`;
			} else {
				newRow = `
					<div class='table-row'><input class='key-input' value=''> :
						<textarea class='table-cell value-input' readonly id='id-input'>{}</textarea>
						<button class='delete-row'>
							<i class='material-icons' style='vertical-align: middle;'>remove_circle</i>Delete
						</button>
					</div>
				`;
			}
			document.querySelector('#new-row').insertAdjacentHTML('beforebegin', newRow);
			reloadIndices();
		});
		document.querySelectorAll('.new').forEach(e => e.addEventListener('click', () => {
			document.querySelector('#new-option').style.display = 'block';
		}));

	}
	if (!!!document.querySelector('#save-btn')) {
		document.querySelector('#editor-content').insertAdjacentHTML('beforeend', '<button id="save-btn" class="save-btn raised-button">Save</button>');
		document.querySelector('#save-btn').addEventListener('click', () => {
			saveDatum();
		});
	}
	document.querySelectorAll('.key-input[readonly]').forEach(e => e.addEventListener('keydown', () =>
		alert('Array indices cannot be modified!')
	));
	document.querySelectorAll('.value-input[readonly]').forEach(e => e.addEventListener('keydown', () =>
		alert('Objects and arrays must be edited in their own node!')
	));
	document.querySelectorAll('.delete-row').forEach(e => e.addEventListener('click', (e) => {
		e.target.parentNode.remove();
		if (Array.isArray(currentNode)) {
			reloadIndices();
		}
	}));
	document.querySelector('#edit-button').style.visibility = 'visible';
}

function reloadIndices() {
	if (Array.isArray(currentNode)) {
		var keys = document.querySelectorAll('.key-input');
		keys.forEach((o, i) => o.value = i);
	} else {
		//no need to reload.
	}
}

function copyDatum() {
	copiedNode = JSON.stringify(currentNode);
	alert('Current element copied.');
}

function pasteDatum() {
	if (!!copiedNode) {
		let newRow;
		if (Array.isArray(currentNode)) {
			newRow = `
			<div class='table-row'>
				<input class='key-input' readonly value=''> : 
				<textarea class='table-cell value-input' readonly id='id-input'>
					${copiedNode}
				</textarea>
				<button class='delete-row'><i class='material-icons'style='vertical-align: middle;'>remove_circle</i>Delete</button>
			</div>`;
		} else {
			newRow = `
			<div class='table-row'>
				<input class='key-input'> : 
				<textarea class='table-cell value-input' readonly id='id-input'>
					${copiedNode}
				</textarea>
				<button class='delete-row'><i class='material-icons'style='vertical-align: middle;'>remove_circle</i>Delete</button>
			</div>`;
		}
		document.querySelector('#new-row').insertAdjacentHTML('beforebegin', newRow);
		reloadIndices();
	}

}

function clearNode(node){
	if (Array.isArray(node)) {
		let length = 0;
		node.forEach((value, key) => {
			if (isObject(value)|| Array.isArray(value)){
				clearNode(node[key])
			} else if (isNumber(node[key])) {
				node[key] = 0;
			} else if (node[key] === true || node[key] === false) {
				node[key] = false;
			} else {
				node[key] = "";
			}
		});
	} else if (isObject(node)) {
		let entries = Object.entries(node);
		for (const [key, value] of entries) {
			if (isObject(value)|| Array.isArray(value)){
				clearNode(node[key])
			} else if (isNumber(node[key])) {
				node[key] = 0;
			} else if (node[key] === true || node[key] === false) {
				node[key] = false;
			} else {
				node[key] = "";
			}
		}
	}
}

function saveDatum() {
	let currentNodeOld = JSON.parse(JSON.stringify(currentNode));//deep cloning (JSON compatible only)
	let oldKeys = Object.keys(currentNodeOld);
	let keys = document.querySelectorAll('.key-input');
	let newKeys = [];
	let values = document.querySelectorAll('.value-input');
	keys.forEach((o, i) => {
		newKeys.push(o.value);
		if (values[i].readOnly) {
			if (oldKeys.includes(o.value)) {
				//do nothing -- editing prohibited
			} else {
				//okay, that's new
				currentNode[o.value] = JSON.parse(values[i].value);
			}
		} else {
			if (autoTypeConvert) {
				if (isNumber(values[i].value)) {
					currentNode[o.value] = Number(values[i].value);
				} else if (values[i].value === 'true') {
					currentNode[o.value] = true;
				} else if (values[i].value === 'false') {
					currentNode[o.value] = false;
				} else {
					currentNode[o.value] = values[i].value;
				}
			} else {
				currentNode[o.value] = values[i].value;
			}
		}
	});
	//remove unwanted properties
	oldKeys.forEach((o) => {
		if (!newKeys.includes(o)) {
			delete currentNode[o];
		}
	});
	//refresh tree
	loadData(JSON.stringify(data));
	alert('Content saved.');

}

function isObject(obj) {
	return obj === Object(obj);
}

function isNumber(n) {
	return typeof n === "number";
}

function saveFile() {
	var odata = JSON.stringify(data);
	var link = document.createElement('a');
	link.setAttribute('download', fname);
	link.href = window.URL.createObjectURL(new Blob([odata], {type: 'application/json'}));
	document.body.appendChild(link);
	window.requestAnimationFrame(() => {
		link.click();
		document.body.removeChild(link);
	});
}

document.querySelector('#save-file-button').addEventListener('click', () => {
	saveFile();
});

document.querySelector('#load-file-button').addEventListener('click', () => {
	loadFile('.json');
});

document.querySelector('#new-json-button').addEventListener('click', () => {
	if (data !== undefined) {
		if (!confirm('Creating a new JSON will discard the JSON you are currently editing.\nAre you sure you want to continue?')) {
			return;
		}
	}
	document.querySelector('#modal-new-json-bg').style.display = 'block';
	window.onclick = function (event) {
		if (event.target == document.querySelector('#modal-new-json-bg')) {
			document.querySelector('#modal-new-json-bg').style.display = 'none';
		}
	};
	document.querySelector('#new-json').addEventListener('click', () => {
		if (document.querySelector('#option-ary').checked === true) {
			loadData('[]');
			document.querySelector('#modal-new-json-bg').style.display = 'none';
		} else if (document.querySelector('#option-obj').checked === true) {
			loadData('{}');
			document.querySelector('#modal-new-json-bg').style.display = 'none';
		}
	});
});

document.querySelector('#setting-button').addEventListener('click', () => {
	document.querySelector('#modal-setting-bg').style.display = 'block';
	window.onclick = function (event) {
		if (event.target === document.querySelector('#modal-setting-bg')) {
			document.querySelector('#modal-setting-bg').style.display = 'none';
		}
	};
	document.querySelector('#save-setting').addEventListener('click', () => {
		autoTypeConvert = document.querySelector('#option-type-convert').checked;
		document.querySelector('#modal-setting-bg').style.display = 'none';
	});
});

document.querySelector('#save-string-button').addEventListener('click', () => {
	let modalBg = document.querySelector('#modal-string-out-bg');
	modalBg.style.display = 'block';
	modalBg.addEventListener('click', function (e) {
		e.target.style.display = 'none';
	});
	modalBg.childNodes.forEach(node => node.addEventListener('click', (e) => {
		e.stopPropagation();
	}));
	let output = document.querySelector('#string-output');
	output.value = JSON.stringify(data);
	output.focus();
	output.select();
	document.querySelector('#copy-string').addEventListener('click', () => {
		let output = document.querySelector('#string-output');
		output.focus();
		output.select();
		document.execCommand('copy');
		alert('Output JSON copied to your clipboard.');
	});
});

document.querySelector('#load-string-button').addEventListener('click', () => {
	let modalBg = document.querySelector('#modal-string-bg');
	modalBg.style.display = 'block';
	modalBg.addEventListener('click', function (e) {
		e.target.style.display = 'none';
	});
	modalBg.childNodes.forEach(node => node.addEventListener('click', (e) => {
		e.stopPropagation();
	}));
	document.querySelector('#load-string').addEventListener('click', () => {
		loadData(document.querySelector('#string-input').value);
		document.querySelector('#modal-string-bg').style.display = 'none';
	});
});

document.querySelector('#copy-button').addEventListener('click', () => {
	copyDatum();
});

document.querySelector('#paste-button').addEventListener('click', () => {
	pasteDatum();
});

document.querySelector('#clear-button').addEventListener('click', () => {
	if (confirm("Are you sure you want to clear all JSON values?\nAll values in the current editing JSON will be removed.")){
		clearNode(currentNode);
		loadData(JSON.stringify(data));
	}
});

document.querySelector('#searchbox').addEventListener('keyup', (e) => {
	searchString = e.target.value;
	refreshTree();
});

document.querySelector('#back-button').addEventListener('click', (e) => {
	window.history.back();
});

