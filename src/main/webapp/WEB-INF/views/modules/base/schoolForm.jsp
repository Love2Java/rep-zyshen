<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/include.html"%>
<html>
<head>
<title>学校信息</title>
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
		<input type="hidden" name="id" id="id" value="${school.id}" />
		<div class="frmDiv">
			<label class="textbox-label">学校类型:</label>
			<select class="easyui-combobox" name="xxlx" editable=false id="xxlx">
			    <option <c:if test="${school.xxlx eq ''}"> selected </c:if> value="">==请选择==</option>
				<c:forEach items="${fns:getDictList('base_school_xxlx')}" var="item">
					<option <c:if test="${school.xxlx eq item.value}"> selected </c:if> value="${item.value}">${item}</option>
			    </c:forEach>
			</select>
		</div>
		<div class="frmDiv">
			<label class="textbox-label">学校名称:</label>
			<input id="oldXxmc" name="oldXxmc" type="hidden" value="${school.xxmc}">
			<input class="easyui-textbox" id="xxmc" name="xxmc" value="${school.xxmc}" required=true>
		</div>
		<div class="frmDiv">
			<label class="textbox-label">单位代码:</label>
			<input type="text" class="easyui-textbox" name="dwdm" id="dwdm" value="${school.dwdm}" required=true>
		</div>
		<div class="frmDiv">
			<label class="textbox-label">注册地址:</label>
			<input type="text" class="easyui-textbox" name="zcdz" id="zcdz" value="${school.zcdz}" >
		</div>
		<div class="frmDiv">
			<label class="textbox-label">联系人:</label>
			<input type="text" class="easyui-textbox" name="lxr" id="lxr" value="${school.lxr}" >
		</div>
		<div class="frmDiv">
			<label class="textbox-label">联系电话:</label>
			<input type="text" class="easyui-textbox" name="lxdh" id="lxdh" validType="mobile" value="${school.lxdh}" >
		</div>
	</form>
	<script type="text/javascript">
		var bjzt="save";
		var dataUrl = "${ctx}/base/school/";

		$(function() {
			var id = getParam("id");
			if(id!="") bjzt="update";
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
					currentPage().reload();
				} else {
					showCryMsg(data.msg);
				}
			}, "json");
		}

	</script>
</body>
</html>