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

	<form id="frmEdit">
		<input type="hidden" name="id" id="id" value="${role.id}"/>
		<input type="hidden" name="oldName" id="oldName"  value="${role.name}"/>
		<input type="hidden" name="oldEnname" id="oldEnname"  value="${role.enname}"/>
		<div class="frmDiv">
			<label class="textbox-label">归属机构:</label>
			<input class="easyui-combotreegrid" id="officeid" name="office.id" value="${role.office.id}" required=true>
		</div>
		<div class="frmDiv">
			<label class="textbox-label">角色名称:</label>
			<input type="text" class="easyui-textbox" name="name" id="name" value="${role.name}" required=true>
		</div>
		<div class="frmDiv">
			<label class="textbox-label">英文名称:</label>
			<input type="text" class="easyui-textbox" name="enname" id="enname" value="${role.enname}" required=true>
		</div>
<%-- 		<div class="frmDiv">
			<label class="textbox-label">角色类型:</label>
			<select class="easyui-combobox" name="roleType" id="roleType" value="${role.roleType}" editable=false required=true>
				<option value="assignment">任务分配</option>
				<option value="security-role">管理角色</option>
				<option value="user">普通角色</option>
			</select>
		</div> --%>
		<div class="frmDiv">
			<label class="textbox-label">是否系统数据:</label>
			<select class="easyui-combobox" name="sysData" id="sysData" editable=false>
				<c:forEach items="${fns:getDictList('yes_no')}" var="item">
					<option  <c:if test="${role.sysData eq item.value}"> selected </c:if> value="${item.value}">${item}</option>
				</c:forEach>
			</select>
		</div>
		<div class="frmDiv">
			<label class="textbox-label">是否可用:</label>
			<select class="easyui-combobox" name="useable" id="useable"  editable=false >
				<c:forEach items="${fns:getDictList('yes_no')}" var="item">
					<option  <c:if test="${role.useable eq item.value}"> selected </c:if>  value="${item.value}">${item}</option>
				</c:forEach>
			</select>
		</div>
<%-- 		<div class="frmDiv">
			<label class="textbox-label">数据范围:</label>
			<select class="easyui-combobox" name="dataScope" value="${role.dataScope}" id="dataScope" editable=false >
				<c:forEach items="${fns:getDictList('sys_data_scope')}" var="item">
					<option value="${item}">${item}</option>
				</c:forEach>
			</select>
		</div> --%>
	</form>
	<script type="text/javascript">
		var bjzt="save";
		var dataUrl = "${ctx}/sys/role/";

		$(function() {
			var id=getParam("id");
			if(id!="")  bjzt="update";
			$("#officeid").combotreegrid(
							{
								panelWidth : 380,
								panelHeight : 230,
								idField : 'id',
								url:'${ctx}/sys/office/treeData',
								parentField : 'pId',
								treeField : 'name',
								columns : [ [ {
									field : 'name',
									title : '机构名称',
									width : 350
								} ] ]
							});
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