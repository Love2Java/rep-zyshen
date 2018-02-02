var mask;
//var ipAddress = "http://127.0.0.1:8080";
var ipAddress = "http://139.196.23.43:8132";

String.prototype.replaceAll = function(s1,s2){ 
	return this.replace(new RegExp(s1,"gm"),s2); 
	}


Date.prototype.format = function(format) {
	var o = {
		"M+" : this.getMonth() + 1,
		// month
		"d+" : this.getDate(),
		// day
		"h+" : this.getHours(),
		// hour
		"m+" : this.getMinutes(),
		// minute
		"s+" : this.getSeconds(),
		// second
		"q+" : Math.floor((this.getMonth() + 3) / 3),
		// quarter
		"S" : this.getMilliseconds()
	// millisecond
	};
	if (/(y+)/.test(format) || /(Y+)/.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	}
	for ( var k in o) {
		if (new RegExp("(" + k + ")").test(format)) {
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
					: ("00" + o[k]).substr(("" + o[k]).length));
		}
	}
	return format;
};


var el;
function showLoading(msg){    		
	el=$.loading({content:msg})
}


function hideLoading(){    		
	el.hide();
}


function chkEmail(val){
	var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
	return reg.test(val);
}

function chkPhone(val){
	var reg = /^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(15[5-9]{1})(17[0-9]{1})||(18[0-9]{1}))+\d{8})$/;
	return reg.test(val);
}


function getMaxZindex(){
	 var maxZ = Math.max.apply(null, 
		    　　$.map($('body *'), function(e,n) {
		      　　if ($(e).css('position') != 'static')
		        　　return parseInt($(e).css('z-index')) || 1;
		    }));
		    return maxZ;
	
}

// 控制按钮的显示与隐藏
function showButton(buttonID, isShow) {
    if ($("#" + buttonID).length > 0) {
        if (isShow) {
            $("#" + buttonID).show();
        }
        else {
            $("#" + buttonID).hide();
        }
    }
}

function showMask() {
	//mask = top.layer.load(0);
}
function hideMask() {
	//top.layer.close(mask);
}

function chkBmgz(bm,bmgz,sjbm){
	var _sjbm=getSjbm(bm, bmgz);
	
	if(sjbm!=_sjbm) {
		if(_sjbm!=""){
		      showWarnMsg("编号【" + bm + "】不符合编码规则！");
		}
		return false;
	}
	return true;
	
}
// 根据编码规则获取上级编码
function getSjbm(bm, bmgz) {
  if (bmgz == "") {
      showWarnMsg("请联系管理员设置编码规则");
      return "";
  }
  var bmgz_ = bmgz.split("-");
  var len = 0;
  var gz = false;
  for (var i = 0; i < bmgz_.length; i++) {
      len += parseInt(bmgz_[i]);
      if (len == bm.length) {
          gz = true;
          len -= bmgz_[i];
          break;
      }
  }
  if (!gz) {
      showWarnMsg("编号【" + bm + "】不符合编码规则！");
      return "";
  }
  return bm.substr(0, len);
}

function currentPage() {
	var currentId = top.$('.page-tabs-content').find('.active').attr('data-id');
	var target = top.$('.LRADMS_iframe[data-id="' + currentId + '"]')[0].contentWindow;
	return target;
}

function getEditObj() {
	return currentPage().editObj;
}

function openIconDialog() {
	window.open("http://fontawesome.io/icons", "_blank");
}

$.fn.serializeObject = function()
{
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name] !== undefined) {
			if (!o[this.name].push) {
				o[this.name] = [o[this.name]];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};

function dgDateTime(value, row, index) {
	if(value)
	{
		var timestamp = (new Date(parseFloat(value))).format("yyyy-MM-dd hh:mm:ss");
		return timestamp;
	}
	return "";
}
function dgDate(value, row, index) {
	if(value)
	{
		var timestamp = (new Date(parseFloat(value))).format("yyyy-MM-dd");
		return timestamp;
	}
	return "";
}

function MergeCells(tableID, fldList) {
	var Arr = fldList.split(",");
	var dg = $('#' + tableID);
	var fldName;
	var RowCount = dg.datagrid("getRows").length;
	var span;
	var PerValue = "";
	var CurValue = "";
	var length = Arr.length - 1;
	for (i = length; i >= 0; i--) {
		fldName = Arr[i];
		PerValue = "";
		span = 1;
		for (row = 0; row <= RowCount; row++) {
			if (row == RowCount) {
				CurValue = "";
			} else {
				CurValue = dg.datagrid("getRows")[row][fldName];
			}
			if (PerValue == CurValue) {
				span += 1;
			} else {
				var index = row - span;
				dg.datagrid('mergeCells', {
					index : index,
					field : fldName,
					rowspan : span,
					colspan : null
				});
				span = 1;
				PerValue = CurValue;
			}
		}
	}
}

$.ajaxSetup({
	contentType : "application/x-www-form-urlencoded;charset=utf-8",
	beforeSend : function(a, b) {
		// alert(JSON.stringify(b));
		if (b.url.indexOf("getNavigation") < 0) {
			top.showMask();
		}
	},
	complete : function(XMLHttpRequest, textStatus) {
		top.hideMask();
		var sessionstatus = XMLHttpRequest.getResponseHeader("sessionstatus");
		if (sessionstatus == "TimeOut") {
			top.location = "/Account/TimeOut";
		} else if (sessionstatus == "OtherPlace") {
			top.location = "/Account/OtherPlace";
		}
	},
	success : function(data, textStatus) {
		top.hideMask();
	},
	error : function(xhr, status, e) {
		top.hideMask();
	}
});
// 消息框
function showCryMsg(msg) {
	top.layer.msg(msg, {
		icon : 5
	});
}
function showWarnMsg(msg) {
	top.layer.msg(msg, {
		icon : 0
	});
}
function showErrMsg(msg) {
	top.layer.msg(msg, {
		icon : 2
	});
}
function showMsg(msg) {
	top.layer.msg(msg);
}

function postJson(url,data,successCallBack,errorCallBack){
	$.ajax({
        type: "POST",
        url: url,
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(data),
        dataType: "json",
        success: function (data) {
        	successCallBack(data);
        },
        error: function (message) {
        	errorCallBack(message);
        }
    });
}


// 弹出确认提示框
function showConfirm(msg, trueCallback, falseCallback) {
	top.layer.confirm(msg, function(data) {
		top.layer.closeAll();
		trueCallback();
	});
}
function openDialog(title, url, dlgId, width, height, isRefresh) {
	top.layer.open({
		type : 2,
		title : title,
		shadeClose : true,
		shade : 0.2,
		area : [ width + 'px', height + 'px' ],
		content : [ url, 'yes' ],
		scrollbar : true
	});
}

function layerFrame(layero) {
	return layero.find('iframe')[0].contentWindow;
}
function layerBody(layerIndex) {
	return top.layer.getChildFrame('body', layerIndex);
}
function openEditDlg(title, url, width, height) {
	top.layer.open({
		type : 2,
		title : title,
		shade : 0.2,
		area : [ width + 'px', height + 'px' ],
		content : [ url, 'yes' ],
		btn : [ '保存', '关闭' ],
		yes : function(index, layero) {
			layerFrame(layero).save();
		}
	});
}
function closeEditDlg() {
	var index = parent.layer.getFrameIndex(window.name);
	top.layer.close(index);
}

// 获取URL参数
function getParam(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); // 构造一个含有目标参数的正则表达式对象
	var r = window.location.search.substr(1).match(reg); // 匹配目标参数
	if (r != null)
		return unescape(r[2]);
	return null; // 返回参数值
}