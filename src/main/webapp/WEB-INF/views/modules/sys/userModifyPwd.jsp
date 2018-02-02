<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/include.html"%>
<html>
<head>
<title>修改密码</title>
<style>
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
	<form id="inputForm" action="${ctx}/sys/user/modifyPwd" method="post">

		<input type="hidden" name="id" value="${user.id}" id="id" />
		<div class="frmDiv">
			<label class="textbox-label">旧密码<font color="red">*</font> :
			</label> <input id="oldPassword" name="oldPassword" type="password" value=""
				required="true" class="easyui-textbox" />

		</div>
		<div class="frmDiv">
			<label class="textbox-label">新密码<font color="red">*</font>:
			</label> <input id="newPassword" name="newPassword" type="password" value=""
				required="true" class="easyui-textbox" />

		</div>
		<div class="frmDiv">
			<label class="textbox-label">确认新密码<font color="red">*</font>:
			</label> <input id="confirmNewPassword" name="confirmNewPassword"
				type="password" value="" required="true" class="easyui-textbox">
		</div>

	</form>
	<script type="text/javascript">
		$(function() {
			var msg = "${message}";
			if (msg == "修改密码成功") {
				showMsg(msg);
				closeEditDlg();
			} else if(msg!="") {
				showCryMsg(msg);
			}
		});
		function save() {
			if (!$("#inputForm").form('validate')) {
				return;
			}
			if ($("#newPassword").textbox("getValue") != $(
					"#confirmNewPassword").textbox("getValue")) {
				showWarnMsg("新密码不一致");
				return;
			}
			$("#inputForm").submit();

		}
	</script>
</body>
</html>