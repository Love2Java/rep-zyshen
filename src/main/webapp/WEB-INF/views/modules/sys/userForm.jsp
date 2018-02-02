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
<body class=' easyui-layout '  border=false style="margin:10px;">
	<div region="north"  border=false>
	<div class="layui-btn-group">
		<button class="layui-btn layui-btn-primary layui-btn-small" onclick="close1()">
			<li class="fa fa-window-close"></li>&nbsp;关闭
		</button>
		<button class="layui-btn layui-btn-primary  layui-btn-small" onclick="save()">
			<li class="fa fa-save"></li>&nbsp;保存
		</button>
		</div>
	</div>
	<div region="center" fixed=true border=false>
		<form id="frmEdit" method="post">
			<input type="hidden" id="id" name="id" value="${user.id}" />
			<table class="tbEdit" cellpadding="0" cellspacing="2">
				<tr>
					<%-- <td class="tdLeft">归属单位:</td>
					<td class="tdRight"><input type="text"
						class="easyui-combotree" id="company" name="company.id"
						value="${user.company.id}" editable="false" required="true" /></td> --%>
					<td class="tdLeft">归属机构:</td>
					<td class="tdRight"><input type="text" class="easyui-combotree" id="office" name="office.id" value="${user.office.id}" editable="false" required="true" /></td>
					<td class="tdLeft">姓名:</td>
					<td class="tdRight"><input type="text" class="easyui-textbox" id="name" name="name" validType="name" value="${user.name}" required="true" /></td>
					<td></td>
				</tr>
		<%-- 		<tr>
					<td class="tdLeft">工号:</td>
					<td class="tdRight"><input type="text" class="easyui-textbox"
						id="no" name="no" value="${user.no}" required="true" /></td>
					<td></td>
				</tr> --%>
				<tr>
					<td class="tdLeft">登录名:</td>
					<td class="tdRight">
					    <input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
					    <input type="text" class="easyui-textbox" id="loginName" name="loginName" value="${user.loginName}" />
					</td>
					<td class="tdLeft">邮箱:</td>
					<td class="tdRight"><input type="text" class="easyui-textbox" id="email" name="email" validType="email" value="${user.email}" /></td>
					<td></td>
				</tr>
				<tr>
					<td class="tdLeft">性别:</td>
					<td class="tdRight">
					    <select class="easyui-combobox" name="xb" editable=false id="xb">
							<option <c:if test="${user.xb eq ''}"> selected </c:if> value="">=请选择==</option>
							<option <c:if test="${user.xb eq '男'}"> selected </c:if> value="男">男</option>
							<option <c:if test="${user.xb eq '女'}"> selected </c:if> value="女">女</option>
					    </select>
					</td>
					<td class="tdLeft">身份证号:</td>
					<td class="tdRight"><input type="text" class="easyui-textbox" id="sfzhm" name="sfzhm" validType="idCardNo" value="${user.sfzhm}" /></td>
					<td></td>
				</tr>
				<tr>
					<td class="tdLeft">电话:</td>
					<td class="tdRight"><input type="text" class="easyui-textbox" id="phone" name="phone" value="${user.phone}" /></td>
					<td class="tdLeft">手机:</td>
					<td class="tdRight"><input type="text" class="easyui-textbox" id="mobile" name="mobile" validType="mobile" value="${user.mobile}" /></td>
					<td></td>
				</tr>
				<tr>
					<td class="tdLeft">籍贯:</td>
					<td class="tdRight"><input type="text" class="easyui-textbox" id="jg" name="jg" value="${user.jg}" /></td>
					<td class="tdLeft">出生日期:</td>
					<td class="tdRight"><input type="text" class="easyui-datebox" id="csrq" name="csrq" value="${user.csrq}" /></td>
					<td></td>
				</tr>
				<tr>
					<td class="tdLeft">户籍详址:</td>
					<td class="tdRight" colspan="3"><input type="text" class="easyui-textbox" id="hjxz" name="hjxz" style='width: 580px' value="${user.hjxz}" /></td>
					<td></td>
				</tr>
				<tr>
					<td class="tdLeft">现居住地址:</td>
					<td class="tdRight" colspan="3"><input type="text" class="easyui-textbox" id="xjzdz" name="xjzdz" style='width: 580px' value="${user.xjzdz}" /></td>
					<td></td>
				</tr>
				<tr>
					<td class="tdLeft">QQ:</td>
					<td class="tdRight"><input type="text" class="easyui-textbox" id="qq" name="qq" validType="qq" value="${user.qq}" /></td>
					<td class="tdLeft">微信号:</td>
					<td class="tdRight"><input type="text" class="easyui-textbox" id="wxh" name="wxh" value="${user.wxh}" /></td>
					<td></td>
				</tr>
				<tr>
					<td class="tdLeft">临时身份证号:</td>
					<td class="tdRight"><input type="text" class="easyui-textbox" id="lssfzh" name="lssfzh" value="${user.lssfzh}" /></td>
					<td class="tdLeft">学历:</td>
					<td class="tdRight">
					    <select class="easyui-combobox" name="xl" editable=false id="xl">
					        <option <c:if test="${user.xl eq ''}"> selected </c:if> value="">==请选择==</option>
						    <c:forEach items="${fns:getDictList('sys_user_xl')}" var="item">
						        <option <c:if test="${user.xl eq item.value}"> selected </c:if> value="${item.value}">${item}</option>
						    </c:forEach>
					    </select>
					</td>
					<td></td>
				</tr>
				<tr>
					<td class="tdLeft">民族:</td>
					<td class="tdRight">
					    <select class="easyui-combobox" name="mz" editable=false id="mz">
							<option <c:if test="${user.mz eq ''}"> selected </c:if> value="">==请选择==</option>
							<c:forEach items="${fns:getDictList('sys_user_mz')}" var="item">
								<option <c:if test="${user.mz eq item.value}"> selected </c:if> value="${item.value}">${item}</option>
							</c:forEach>
					    </select>
					</td>
					<td class="tdLeft">血型:</td>
					<td class="tdRight">
					    <select class="easyui-combobox" name="xx" editable=false id="xx">
							<option <c:if test="${user.xx eq ''}"> selected </c:if> value="">==请选择==</option>
							<c:forEach items="${fns:getDictList('sys_user_xx')}" var="item">
								<option <c:if test="${user.xx eq item.value}"> selected </c:if> value="${item.value}">${item}</option>
							</c:forEach>
					    </select>
					</td>
					<td></td>
				</tr>
				<tr>
					<td class="tdLeft">婚姻状况:</td>
					<td class="tdRight">
					    <select class="easyui-combobox" name="hy" editable=false id="hy">
							<option <c:if test="${user.hy eq ''}"> selected </c:if> value="">==请选择==</option>
							<c:forEach items="${fns:getDictList('sys_user_hy')}" var="item">
								<option <c:if test="${user.hy eq item.value}"> selected </c:if> value="${item.value}">${item}</option>
							</c:forEach>
					    </select>
					</td>
					<td class="tdLeft">从业类别:</td>
					<td class="tdRight">
					    <select class="easyui-combobox" name="cylb" editable=false id="cylb">
							<option <c:if test="${user.cylb eq ''}"> selected </c:if> value="">==请选择==</option>
							<c:forEach items="${fns:getDictList('sys_user_cylb')}" var="item">
								<option <c:if test="${user.cylb eq item.value}"> selected </c:if> value="${item.value}">${item}</option>
							</c:forEach>
					    </select>
					</td>
					<td></td>
				</tr>
				<tr>
					<td class="tdLeft">从业日期:</td>
					<td class="tdRight"><input type="text" class="easyui-datebox" id="cyrq" name="cyrq" value="${user.cyrq}" /></td>
					<td class="tdLeft">职务:</td>
					<td class="tdRight">
					    <select class="easyui-combobox" name="zw" editable=false id="zw">
							<option <c:if test="${user.zw eq ''}"> selected </c:if> value="">==请选择==</option>
							<c:forEach items="${fns:getDictList('sys_user_zw')}" var="item">
								<option <c:if test="${user.zw eq item.value}"> selected </c:if> value="${item.value}">${item}</option>
							</c:forEach>
					    </select>
					</td>
					<td></td>
				</tr>
				<tr>
					<td class="tdLeft">是否允许登录</td>
					<td class="tdRight">
					    <select class="easyui-combobox" name="loginFlag" editable=false id="loginFlag">
							<option <c:if test="${user.loginFlag eq ''}"> selected </c:if> value="">==请选择==</option>
							<c:forEach items="${fns:getDictList('yes_no')}" var="item">
								<option <c:if test="${office.loginFlag eq item.value}"> selected </c:if> value="${item.value}">${item}</option>
							</c:forEach>
					    </select>
					</td>
					<td class="tdLeft">用户类型:</td>
					<td class="tdRight">
					    <select class="easyui-combobox" name="userType" editable=false id="userType">
							<option <c:if test="${user.userType eq ''}"> selected </c:if> value="">==请选择==</option>
							<c:forEach items="${fns:getDictList('sys_user_type')}" var="item">
								<option <c:if test="${office.userType eq item.value}"> selected </c:if> value="${item.value}">${item}</option>
							</c:forEach>
					    </select>
					</td>
					<td></td>
				</tr><tr>
					<td class="tdLeft">备注:</td>
					<td class="tdRight" colspan="3"><input type="text" class="easyui-textbox" id="remarks" multiline=true name="remarks" style='width: 580px;height:50px;' value="${user.xjzdz}" /></td>
					<td></td>
				</tr>
			</table>
		</form>
	</div>

	<script>
		var id = "";
		var bjzt = "save";
		var dataUrl = "${ctx}/sys/user/";

		$(function() {
			id = getParam("id");
			if (id != "")
				bjzt = "update";

			$.post('${ctx}/sys/office/getTree', function(data) {
				$("#company").combotree({
					method : 'get',
					parentField : 'pid',
					data : data
				});
				$("#office").combotree({
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