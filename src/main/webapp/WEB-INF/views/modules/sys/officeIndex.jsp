<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/include.html"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script src="${ctxContent}/js/floatEditDiv.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body class="easyui-layout layui-anim layui-anim-scale" border=false>

			<div region="north" border=false style="padding: 10px; height: 50px;">

				<div style="float: left">

					<div class="layui-btn-group">
						<button id="btnReload" class="layui-btn layui-btn-primary  layui-btn-small" onclick="reload()">
							<li class="fa fa-refresh"></li>&nbsp;刷新
						</button>
						<button id="btnAdd" class="layui-btn layui-btn-primary  layui-btn-small" onclick="add()">
							<li class="fa fa-plus"></li>&nbsp;新增
						</button>
						<button id="btnEdit" class="layui-btn layui-btn-primary  layui-btn-small" onclick="edit()">
							<li class="fa fa-edit"></li>&nbsp;编辑
						</button>
						<button id="btnDelete" class="layui-btn layui-btn-primary  layui-btn-small" onclick="del()">
							<li class="fa fa-trash"></li>&nbsp;删除
						</button>
					</div>
					<div class="layui-btn-group">
						<button id="btnCascadeCheck" class="layui-btn layui-btn-small layui-btn-primary" onclick="openCascadeCheck()">
							<li class="fa fa-hand-pointer-o"></li>&nbsp;打开/关闭级联选择
						</button>
					</div>
				</div>
			</div>
			<div region="center" border=false style="padding: 0 10px 10px 10px">
				<table id="grid">
					<thead>
						<tr>
							<th data-options="field:'text',width:280,halign:'center'">机构名称</th>
							<th data-options="field:'areaName',width:120,align:'center',halign:'center',formatter:formatAreaName">归属区域</th>
							<th data-options="field:'code',width:100,align:'left',halign:'center',formatter:formatCode">机构编码</th>
							<th data-options="field:'typeName',width:100,align:'center',halign:'center',formatter:formatType">机构类型</th>
							<th data-options="field:'remarks',width:140,align:'left',halign:'center',formatter:formatRemarks">备注</th>
						</tr>
					</thead>
				</table>
			</div>

		<script type="text/javascript">
			var editObj = {
				bjzt : "",
				id : ""
			};
			var url = "${ctx}/sys/office/";
			var cascadeCheck = true;

			$(function() {
				getList();
			});
			function formatAreaName(value, row, index) {
				return row.attributes.area.name;
			}
			function formatCode(value, row, index) {
				return row.attributes.code;
			}
			function formatType(value, row, index) {
				return row.attributes.typeName;
			}
			function formatRemarks(value, row, index) {
				return row.attributes.remarks;
			}

			function add() {
				showFloatEditDiv(url + "form?id=");
			}
			function openCascadeCheck() {
				if (cascadeCheck) {
					cascadeCheck = false;
					showMsg("已关闭级联选择");
				} else {
					cascadeCheck = true;
					showMsg("已打开级联选择");
				}
				$("#grid").treegrid({
					cascadeCheck : cascadeCheck
				});
			}

			function edit() {

				var selRow = $("#grid").treegrid("getCheckedNodes");
				if (selRow.length == 0) {
					showWarnMsg("请选择需要修改的记录");
					return;
				}
				if (selRow.length > 1) {
					showWarnMsg("只能选择一条记录进行编辑操作");
					return;
				}
				showFloatEditDiv(url + "form?id="+selRow[0].id);
			}

			function reload() {
				$("#grid").treegrid("reload");
				$("#grid").treegrid("clearChecked");
			}

			function getList() {
				$("#grid").treegrid({
					url : "${ctx}/sys/office/getTree",
					idField : 'id',
					treeField : 'text',
					singleSelect : true,
					checkOnSelect : false,
					selectOnCheck : false,
					parentField : 'pid',
					animate : true,
					method : 'get',
					width : 'auto',
					height : 'auto',
					fit : true,
					checkbox : true,
					cascadeCheck : cascadeCheck
				});
			}

			function getChecked() {
				var selRow = $("#grid").treegrid("getCheckedNodes");
				var ids = "";
				for (var i = 0; i < selRow.length; i++) {
					ids += selRow[i].id + ","
				}
				if (ids != "")
					ids = ids.substr(0, ids.length - 1);
				return ids;
			}

			function del() {
				var ids = getChecked();
				if (ids == "") {
					showWarnMsg("请选择需要删除的记录");
					return;
				}
				showConfirm("确定要删除吗？", function() {
					$.post(url + "delete", {
						ids : ids
					}, function(data) {
						if (data.success) {
							reload();
							showMsg(data.msg)
							$("#grid").datagrid("clearChecked");
						} else {
							showErrMsg(data.msg);
						}
					}, "json")
				});
			}
			
		</script>
</body>
</html>