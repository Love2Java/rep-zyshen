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
input, select {
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
		<button class="layui-btn layui-btn-primary  layui-btn-small" onclick="close1()">
			<li class="fa fa-window-close"></li>&nbsp;关闭
		</button>
		<button class="layui-btn layui-btn-primary  layui-btn-small" onclick="save()">
			<li class="fa fa-save"></li>&nbsp;保存
		</button>
	</div>
	</div>
	<div region="center" fixed=true border=false>
	<form id="frmEdit" method="post">
		<input type="hidden" id="id" name="id" value="${rspArea.id}" />
		<table class="tbEdit" cellpadding="0" cellspacing="2">
			<tr>
				<td class="tdLeft">责任区:</td>
				<td class="tdRight">
				    <select class="easyui-combobox" name="zrqId" editable=false id="zrqId">
						<option <c:if test="${rspArea.zrqId eq ''}"> selected </c:if> value="">==请选择==</option>
						<c:forEach items="${fns:getDictList('base_zrq')}" var="item">
							<option <c:if test="${rspArea.zrqId eq item.value}"> selected </c:if> value="${item.value}">${item}</option>
						</c:forEach>
				    </select>
				</td>
				<td class="tdLeft">责任组:</td>
				<td class="tdRight">
				    <select class="easyui-combobox" name="zrzId" editable=false id="zrzId">
						<option <c:if test="${rspArea.zrzId eq ''}"> selected </c:if> value="">==请选择==</option>
						<c:forEach items="${fns:getDictList('base_zrz')}" var="item">
							<option <c:if test="${rspArea.zrzId eq item.value}"> selected </c:if> value="${item.value}">${item}</option>
						</c:forEach>
				    </select>
				</td>
				<td></td>
			</tr>
			<tr>
				<td class="tdLeft">版本号:</td>
				<td class="tdRight"><input type="text" class="easyui-textbox" id="bbh" name="bbh" value="${rspArea.bbh}" /></td>
				<td class="tdLeft">版本日期:</td>
				<td class="tdRight"><input type="text" class="easyui-datebox" name="bbrq" id="bbrq" value="${rspArea.bbrq}" editable=false /></td>
				<td></td>
			</tr>
			<tr>
				<td class="tdLeft">学校名称:</td>
				<td class="tdRight" colspan=3>
				    <input type="text" class="easyui-searchbox" id="xxmc" editable=false searcher="showSchool" name="xxmc" value="${rspArea.xxmc}" required="true" style="width: 580px" />
					<input type="hidden" name="xxId" id="xxId" value="${rspArea.xxId}" /> 
				</td>
				<td></td>
			</tr>
			<tr>
				<td class="tdLeft">责任督学人员:</td>
				<td class="tdRight" colspan=3>
				    <input type="text" class="easyui-searchbox" searcher="selZrdxry" id="zrdxrymc" name="zrdxrymc" value="${rspArea.zrdxrymc}" style="width: 580px" editable=false required="true" />
				    <input type="hidden" name="zrdxryId" id="zrdxryId" value="${rspArea.zrdxryId}" />
				</td>
				<td></td>
			</tr>
			<tr>
				<td class="tdLeft">组长:</td>
				<td class="tdRight">
				    <input type="text" class="easyui-searchbox" id="zzrymc" name="zzrymc" value="${rspArea.zzrymc}" searcher="selZzry" editable=false required="true" />
				    <input type="hidden" name="zzryId" id="zzryId" value="${rspArea.zzryId}" />
				</td>
				<td class="tdLeft">联络人:</td>
				<td class="tdRight" colspan=3>
				    <input type="text" class="easyui-searchbox" id="llrymc" searcher="selLlry" required="true" name="llrymc" editable=false value="${rspArea.llrymc}" />
				    <input type="hidden" name="llryId" id="llryId" value="${rspArea.llryId}" />
				</td>
				<td></td>
			</tr>
		</table>
	</form>
</div>
	<script>
		var id = "";
		var bjzt = "save";
		var dataUrl = "${ctx}/base/rspArea/";

		$(function() {
			id = getParam("id");
			if (id != "")
				bjzt = "update";

		});
		
		function showSchool(){
			top.openDialog("选择学校", "${ctx}/base/school/dialog", "ShoolDialog", 950, 550, false);
		}
		function setSchool(rows){
			var ids="";
			var names="";
			$.each(rows,function(idx,row){
				ids+=row.id+",";
				names+=row.xxmc+",";
			});
			ids=ids.substring(0,ids.length-1);
			names=names.substring(0,names.length-1);
			$("#xxId").val(ids);
			$("#xxmc").searchbox("setValue",names);
		}
		var userType = "";
		function selZrdxry() {
			userType = "zrdxry";
			selUser();
		}
		function selZzry() {
			userType = "zzry";
			selUser();
		}
		function selLlry() {
			userType = "llry";
			selUser();
		}
		
		function setUser(rows){
			if(userType=="zrdxry"){
				var ids="";
				var names="";
				$.each(rows,function(idx,row){
					ids+=row.id+",";
					names+=row.name+",";
				});
				ids=ids.substring(0,ids.length-1);
				names=names.substring(0,names.length-1);
				$("#zrdxrymc").searchbox("setValue",names);
				$("#zrdxryId").val(ids);
			}
			else if(userType=="zzry"){
				$("#zzrymc").searchbox("setValue",rows[0].name);
				$("#zzryId").val(rows[0].id);
			}
			else if(userType=="llry"){
				$("#llrymc").searchbox("setValue",rows[0].name)
				$("#llryId").val(rows[0].id);
			}
		}
		
		//此处参照窗口 先借用角色分配的用户参照
		function selUser() {
			top.openDialog("选择用户", "${ctx}/sys/role/usertorole", "UserToRole", 950, 550, false);
		}
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