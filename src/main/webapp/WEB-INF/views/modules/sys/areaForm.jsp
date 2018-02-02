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
		<input type="hidden" name="id" id="id" value="${area.id}" />
		<div class="frmDiv">
			<label class="textbox-label">上级区域:</label> 
			<input class="easyui-combotree" id="parentId" value="${area.parent.id}" name="parent.id" required=true>
		</div>
		<div class="frmDiv">
			<label class="textbox-label">区域名称:</label>
			<input type="text" class="easyui-textbox" name="name" id="name" value="${area.name}" required=true>
		</div>
		<div class="frmDiv">
			<label class="textbox-label">区域编码:</label>
			<input type="text" class="easyui-textbox" name="code" id="code" value="${area.code}" required=true>
		</div>
		<div class="frmDiv">
			<label class="textbox-label">区域类型:</label>
			<select class="easyui-combobox" name="type" value="${area.type}" id="type" editable=false>
				<c:forEach items="${fns:getDictList('sys_area_type')}"  var="item">
					<option <c:if test="${area.type eq item.value}"> selected </c:if> value="${item.value}">${item}</option>
				</c:forEach>
			</select>
		</div>
		<div class="frmDiv">
			<label class="textbox-label">备注:</label>
			<input value="${area.remarks}" type="text" class="easyui-textbox" multiline=true style="height: 100px;" name="remarks" id="remarks">
		</div>
	</form>
	<script type="text/javascript">
	    var bjzt="save";
		var dataUrl = "${ctx}/sys/area/";

		$(function() {
			var id=getParam("id");
			if(id!="")  bjzt="update";
			
			$.post(dataUrl + 'getTree', function(data) {
				$("#parentId").combotree({
					method : 'get',
					parentField : 'pid',
					data : data
				});
			}, "json");
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