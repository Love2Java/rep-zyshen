<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/include.html"%>
<html>
<head>
<title>角色管理</title>
</head>
<style>
input, select {
	width: 285px;
}

.textbox-label {
	background: #ffffff;
	border: 0;
	height: 25px;
	line-height: 25px;
	width: 80px;
	text-align: right;
}
</style>

<body>

	<form id="frmEdit" runat="server">
		<input type="hidden" name="id" id="id" value="${dict.id}" />
		<div class="frmDiv">
			<label class="textbox-label">键值:</label>
			<input class="easyui-textbox" id="value" name="value" value="${dict.value}" required=true>
		</div>
		<div class="frmDiv">
			<label class="textbox-label">标签:</label>
			<input type="text" class="easyui-textbox" name="label" id="label" value="${dict.label}" required=true>
		</div>
		<div class="frmDiv">
			<label class="textbox-label">类型:</label>
			<input type="text" class="easyui-textbox" name="type" id="type" value="${dict.type}" required=true>
		</div>
		<div class="frmDiv">
			<label class="textbox-label">描述:</label>
			<input type="text" class="easyui-textbox" name="description" id="description" value="${dict.description}" required=true>
		</div>
		<div class="frmDiv">
			<label class="textbox-label">排序:</label>
			<input type="text" class="easyui-numberbox" name="sort" id="sort" value="${dict.sort}" required=true>
		</div>
		<div class="frmDiv">
			<label class="textbox-label">备注:</label>
			<input type="text" class="easyui-textbox" multiline=true style="height: 100px;" name="remarks" id="remarks" value="${dict.remarks}">
		</div>
	</form>
	<script type="text/javascript">
	    var bjzt="save";
		var dataUrl = "${ctx}/sys/dict/";

		$(function() {
			var id=getParam("id");
			if(id!="")  bjzt="update";
		});
		
		function add() {
			$("#frmEdit").form("clear");
		}

		function reset() {
			$("#frmEdit").form("reset");
		}
		function save() {
			if (!$("#frmEdit").form('validate')) {
				return;
			}
			$.post(dataUrl + "save", $("#frmEdit").serialize(), function(data) {
				if (data.success) {
					if (bjzt == "save") {
						add();
					} else {
						closeEditDlg();
					}
					showMsg(data.msg);
					currentPage().reload();
				} else {
					showCryMsg(data.msg);
				}
			}, "json");
		}
	</script>
</body>
</html>