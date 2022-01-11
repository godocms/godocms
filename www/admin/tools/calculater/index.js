var points = 0;
var flag = true;

function $() {
	return document.getElementById("result");
}

function on() {
	if (flag) {
		$().value = "";
		flag = false;
	} else {
		$().value = "0";
		flag = true;
	}
}

function f(s) {
	if ($().value == "0") {
		if (s == '.' || s == '+' || s == '.-' || s == '%' || s == '×' || s == '÷') {
			$().value += s;
		} else {
			$().value = s;
		}
	} else {
		$().value += s;
	}
}

function num(value) {
	if (flag) {
		f(value);
	}
}

function num_p() {
	if (flag) {
		if (points == 0) {
			f(".");
			points++;
		}
	}
}

function cal(operator) {
	if (flag) {
		if (operator == '+') {
			f("+");
			points = 0;
		} else if (operator == '-') {
			f("-");
			points = 0;
		} else if (operator == '×') {
			f("×");
			points = 0;
		} else if (operator == '÷') {
			f("÷");
			points = 0;
		} else if (operator == '%') {
			f("%");
			points = 1;
		} else if (operator == 'C') {
			$().value = "0";
			points = 0;
		} else if (operator == '=') {
			try {
				var s = $().value;
				s = s.replace('×', '*')
				s = s.replace('÷', '/')
				$().value = eval(s);
			} catch (exception) {
				alert("你的输入不合法！");
			}
		}
	}
}
