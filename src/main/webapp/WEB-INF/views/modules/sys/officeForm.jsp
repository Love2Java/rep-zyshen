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
input,select{
	width: 200px;
}

.tbEdit {
	margin: 20px;
	width: 100%
}

.tdLeft {
	width: 120px;
	text-align: right
}

.tdRight {
	width: 220px;
	text-align: left
}

.tbEdit td {
	padding: 10px;
	border-bottom: 1px dashed #cccccc
}
</style>
<body class=' easyui-layout  '  border=false>
	<div region="north"  border=false  style="margin:10px;">
	<div class="layui-btn-group">
		<button class="layui-btn layui-btn-primary layui-btn-small" onclick="close1()">
			<li class="fa fa-window-close"></li>&nbsp;关闭
		</button>
		<button class="layui-btn  layui-btn-primary layui-btn-small" onclick="save()">
			<li class="fa fa-save"></li>&nbsp;保存
		</button>
	</div>
	</div>
	<div region="center" fixed=true border=false>

	<form id="frmEdit" method="post">
	<input type="hidden" id="id" name="id" value="${office.id}" />
		<table class="tbEdit" cellpadding="0" cellspacing="2">
			<tr>
				<td class="tdLeft">上级机构:</td>
				<td class="tdRight"><input type="text" class="easyui-combotree" id="parentid" name="parent.id" value="${office.parent.id}" editable="false" required="true" /></td>
				<td class="tdLeft">归属区域:</td>
				<td class="tdRight"><input type="text" class="easyui-combotree" id="areaid" name="area.id" value="${office.area.id}" editable="false" required="true" /></td>
				<td></td>
			</tr>
			<tr>
				<td class="tdLeft">机构名称:</td>
				<td class="tdRight"><input type="text" class="easyui-textbox" id="name" name="name" value="${office.name}" required="true" /></td>
				<td class="tdLeft">机构编码:</td>
				<td class="tdRight"><input type="text" class="easyui-textbox" id="code" name="code" value="${office.code}" required="true" /></td>
				<td></td>
			</tr>
			<tr>
				<td class="tdLeft">机构类型:</td>
				<td class="tdRight">
				    <select class="easyui-combobox" name="type" editable=false id="type">
				        <c:forEach items="${fns:getDictList('sys_office_type')}" var="item">
				            <option <c:if test="${office.type eq item.value}"> selected </c:if> value="${item.value}">${item}</option>
				        </c:forEach>
			        </select>
				</td>
				<td class="tdLeft">机构级别:</td>
				<td class="tdRight">
				    <select class="easyui-combobox" name="grade" editable=false id="grade" >
				        <c:forEach items="${fns:getDictList('sys_office_grade')}"  var="item">
					        <option <c:if test="${office.grade eq item.value}"> selected </c:if> value="${item.value}">${item}</option>
				        </c:forEach>
			        </select>
			    </td>
				<td></td>
			</tr>
			<tr>
				<td class="tdLeft">是否可用:</td>
				<td class="tdRight">
				    <select class="easyui-combobox" name="useable"  editable=false id="useable" >
				        <c:forEach items="${fns:getDictList('yes_no')}"  var="item">
				            <option <c:if test="${office.useable eq item.value}"> selected </c:if> value="${item.value}">${item}</option>
				        </c:forEach>
			        </select>
			    </td>
				<td class="tdLeft"></td>
				<td class="tdRight"></td>
				<td></td>
			</tr>
			<tr>
				<td class="tdLeft">联系地址:</td>
				<td class="tdRight" colspan="3"><input type="text" class="easyui-textbox" id="address" name="address" value="${office.address}" style="width:580px;" /></td>
				<td></td>
			</tr>
			<tr>
				<td class="tdLeft">备注:</td>
				<td class="tdRight" colspan="3"><input type="text" multiline=true class="easyui-textbox" id="remarks" name="remarks" value="${office.remarks}" style="width:580px;height:100px" /></td>
				<td></td>
			</tr>
		</table>
	</form>
	</div>

	<script>
		var id = "";
		var bjzt = "save";
		var dataUrl = "${ctx}/sys/office/";

		$(function() {
			id = getParam("id");
			if(id!="") bjzt="update";
			
			$.post(dataUrl + 'getTree', function(data) {
				$("#parentid").combotree({
					method : 'get',
					parentField : 'pid',
					data : data
				});
			}, "json");
			
			$.post('${ctx}/sys/area/getTree', function(data) {
				$("#areaid").combotree({
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
						currentPage().hideFloatEditDiv();
					}
					showMsg(data.msg);
					currentPage().reload();
				} else {
					showCryMsg(data.msg);
				}
			}, "json");
		}
		function close1() {
			currentPage().hideFloatEditDiv();
		}
	</script>

</body>