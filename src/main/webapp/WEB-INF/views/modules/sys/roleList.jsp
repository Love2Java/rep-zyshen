<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/include.html"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

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
		</div>
		<div style="float: right" class="layui-anim layui-anim-up">
			<input type="text" class="easyui-searchbox" id="searchValue" style="width: 400px" prompt="请输入角色名称"/>
		</div>
	</div>
	<div region="center" border=false style="padding: 0 10px 10px 10px">
		<table id="grid">
			<thead>
				<tr>
					<th data-options="field:'name',width:100,halign:'center'">角色名称</th>
					<th data-options="field:'enname',width:100,align:'left',halign:'center'">英文名称</th>
					<th data-options="field:'office.name',width:150,align:'left',halign:'center',formatter:formatOffice">归属机构</th>
				</tr>
			</thead>
		</table>
	</div>
	<script>
		var url = "${ctx}/sys/role/";
		var cascadeCheck = true;
		$(function() {
			loadGrid();
		})

		function loadGrid() {
			$("#grid").datagrid({
				url:url+'datagrid',
				height : 'auto',
				striped : true,
				border : true,
				loadMsg : '',
				rownumbers : true,
				multiSort : true,
				fit : true,
				idField : 'id',
				singleSelect : true,
				pagination: true,
				pageSize: 50,
				pageList: [10,20,50,100],
				checkOnSelect : false,
				selectOnCheck : false,
				frozenColumns : [ [ {
					field : 'ck',
					checkbox : true
				} ] ]
			});
		}
		
		function formatOffice(value, row, index) {
			return row.office.name;
		}
		
		$('#searchValue').searchbox({
			searcher : function(value, name) {
				var params = {
					name : value
				};
				$('#grid').datagrid({
					queryParams : params
				});
			}
		});

		function add() {
			top.openEditDlg("角色编辑", url + "form", 560, 350);
		}

		function edit() {
			var selRow = $("#grid").datagrid("getChecked");
			if (selRow.length == 0) {
				showWarnMsg("请选择需要修改的记录");
				return;
			}
			if (selRow.length > 1) {
				showWarnMsg("只能选择一条记录进行编辑操作");
				return;
			}
			openEditDlg("角色编辑", url + "form?id="+selRow[0].id,560, 350);
		}

		function reload() {
			$("#grid").datagrid("reload");
			$("#grid").datagrid("clearChecked");
		}
		
		function stop() {
			var ids = getChecked();
			if (ids == "") {
				showWarnMsg("请选择需要操作的记录");
				return;
			}
			$.post(url + "stop", {
				ids : ids
			}, function(data) {
				if (data.success) {
					reload();
					showMsg(data.msg)
					$("#grid").datagrid("clearChecked");
				} else {
					showErrMsg(data.msg);
				}
			}, "json");

		}
		function start() {
			var ids = getChecked();
			if (ids == "") {
				showWarnMsg("请选择需要操作的记录");
				return;
			}
			$.post(url + "start", {
				ids : ids
			}, function(data) {
				if (data.success) {
					reload();
					showMsg(data.msg)
					$("#grid").datagrid("clearChecked");
				} else {
					showErrMsg(data.msg);
				}
			}, "json");

		}

		function getChecked() {
			var selRow = $("#grid").datagrid("getChecked");
			//alert(JSON.stringify(selRow));
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