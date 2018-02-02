<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/include.html"%>
<html>
<head>
<title>个人信息</title>
<style>
body {
	background: #ffffff;
	padding: 20px;
}

input {
	width: 300px;
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
</head>
<body>

	<form id="inputForm" action="${ctx}/sys/user/info" method="post">
	<input type="hidden" name="id" id="id" value="${user.id}" />
		<div class="frmDiv">
			<label class="textbox-label">归属机构:</label>
			<label class="lbl">${user.office.name}</label>
		</div>
		<div class="frmDiv">
			<label class="textbox-label">姓名:</label>
			<input name="name" id="name" class="easyui-textbox" value="${user.name}" editable=false />
		</div>
		<div class="frmDiv">
			<label class="textbox-label">邮箱:</label>
			<input name="email" id="email" class="easyui-textbox" validType="email" value="${user.email}" />
		</div>
		<div class="frmDiv">
			<label class="textbox-label">电话:</label>
			<input name="phone" id="phone" class="easyui-textbox" value="${user.phone}" />
		</div>
		<div class="frmDiv">
			<label class="textbox-label">手机:</label>
			<input name="mobile" id="mobile" class="easyui-textbox" validType="mobile" value="${user.mobile}" />
		</div>
		<div class="frmDiv">
			<label class="textbox-label">备注:</label>
			<input name="remarks" id="remarks" class="easyui-textbox" multiline=true style="height: 100px;" value="${user.remarks}" />
		</div>
		<div class="frmDiv">
			<label class="textbox-label">用户类型:</label>
			<label class="lbl">${fns:getDictLabel(user.userType, 'sys_user_type', '无')}</label>
		</div>
		<div class="frmDiv">
			<label class="textbox-label">用户角色:</label>
			<label class="lbl">${user.roleNames}</label>
		</div>
		<div class="frmDiv">
			<label class="textbox-label">上次登录:</label>
			<label class="lbl">IP:${user.oldLoginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.oldLoginDate}" type="both" dateStyle="full" /></label>
		</div>
		<div class="frmDiv">
			<div style="margin-left: 200px;" id="btnSave" class="layui-btn layui-btn-small" onclick="save()">
				<li class="fa fa-save"></li>&nbsp;保存
			</div>
		</div>
	</form>
	<script type="text/javascript">
		function save() {
			if (!$("#inputForm").form('validate')) {
				return;
			} else {
				$("#inputForm").submit();
			}
		}
	</script>
</body>
</html>