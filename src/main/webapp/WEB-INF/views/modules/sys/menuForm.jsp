<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/include.html"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
input {
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

.frmButton {
	text-align: right;
}

.frmButton a {
	margin: 10px 5px 5px 5px;
}
</style>

<body>

	<form id="frmEdit"  method="post" >
		<input type="hidden" name="id" id="id" value="${menu.id}" />
		<div class="frmDiv">
			<label class="textbox-label" for="parentId">父级菜单：</label>
			<input id="parentId" name="parent.id" value="${menu.parent.id}" required="true" class="easyui-combotree" />
			<a id="btn_ref" href="#" onclick="$('#parentId').combotree('reload');return false;" class="easyui-linkbutton" data-options="plain:true,iconCls:'fa fa-refresh'"></a>
			<a id="btn_ref" href="#" onclick="$('#parentId').combotree('setValue','');return false;" class="easyui-linkbutton" data-options="plain:true,iconCls:'fa fa-times-circle'"></a>
		</div>
		<div class="frmDiv">
			<label class="textbox-label" for="name">菜单名称：</label>
			<input class="easyui-textbox" required="true" value="${menu.name}" id="name" name="name" />
		</div>
		<div class="frmDiv">
			<label class="textbox-label" for="icon">图标：</label>
			<input class="easyui-searchbox" searcher="openIconDialog" value="${menu.icon}" id="icon" name="icon" />
		</div>
		<div class="frmDiv">
			<label class="textbox-label" for="href">URL：</label>
			<input class="easyui-textbox" id="href" name="href" value="${menu.href}" />
		</div>
		<div class="frmDiv">
			<label class="textbox-label" for="target">目标：</label>
			<select editable="false" class="easyui-combobox" value="${menu.target}" style="width: 150px;" id="target" name="target" required="true">
				<option value="iframe" <c:if test="${menu.target=='iframe'}"> selected </c:if>>iframe</option>
				<option value="window" <c:if test="${menu.target=='window'}"> selected </c:if>>window</option>
			</select>
		</div>
		<div class="frmDiv">
		    <label class="textbox-label" for="target">是否启用：</label>
			<select name="isShow" id="isShow" style="width: 100px" class="easyui-combobox" value="${menu.isShow}">
				<option value="1" <c:if test="${menu.isShow=='1'}"> selected </c:if> >是</option>
				<option value="0" <c:if test="${menu.isShow=='0'}"> selected </c:if> >否</option>
			</select>
		</div>
		<div class="frmDiv">
			<label class="textbox-label" for="sort">排序：</label>
			<input class="easyui-numberbox" required="true" value="${menu.sort}" id="sort" name="sort" data-options="min:0,precision:0" />
		</div>
		<div class="frmDiv">
			<label class="textbox-label" for="remarks">描述：</label>
			<input class="easyui-textbox" id="remarks" value="${menu.remarks}" name="remarks" />
		</div>
	</form>

	<script>
		var dataUrl = "${ctx}/sys/menu/";
		var bjzt="save";
		
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
						reset();
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