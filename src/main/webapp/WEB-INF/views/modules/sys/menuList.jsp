<%@ page contentType="text/html;charset=UTF-8" %>
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
			<div class="layui-btn-group">
				<button id="btnStart" class="layui-btn layui-btn-small layui-btn-primary" onclick="start()">
					<li class="fa fa-play"></li>&nbsp;启用
				</button>
				<button id="btnStop" class="layui-btn layui-btn-small layui-btn-primary" onclick="stop()">
					<li class="fa fa-stop"></li>&nbsp;停用
				</button>
			</div>
			<div class="layui-btn-group">
				<button id="btnCascadeCheck" class="layui-btn layui-btn-small layui-btn-primary" onclick="openCascadeCheck()">
					<li class="fa fa-hand-pointer-o"></li>&nbsp;打开/关闭级联选择
				</button>
			</div>
		</div>
<!-- 		<div style="float: right" class="  layui-anim layui-anim-up">
			<input type="text" class="easyui-searchbox" id="filterTxt" style="width: 400px" prompt="请输入名称" />
		</div> -->
	</div>
	<div region="center" border=false style="padding: 0 10px 10px 10px">
		<table id="grid">
			<thead>
				<tr>
					<th data-options="field:'text',width:300,halign:'center'">资源名称</th>
					<th data-options="field:'icon',width:30,align:'center',halign:'center',formatter:formatICon">图标</th>
					<th data-options="field:'href',width:240,align:'left',halign:'center',formatter:formatURL">URL</th>
					<th data-options="field:'isShow',width:60,align:'center',halign:'center',formatter:formatEnabled">是否有效</th>
					<th data-options="field:'target',width:80,align:'left',halign:'center',formatter:formatTarget">目标</th>
					<th data-options="field:'remarks',width:150,align:'left',halign:'center',formatter:formatRemarks">描述</th>
					<th data-options="field:'sort',width:80,align:'right',halign:'center',formatter:formatSortCode">排序</th>
				</tr>
			</thead>
		</table>
	</div>
	<script>
		var url = "${ctx}/sys/menu/";
		var cascadeCheck = true;
		$(function() {
			getList();

		})
		function formatRemarks(value, row, index) {
			return row.attributes.remarks;
		}
		function formatTarget(value, row, index) {
			return row.attributes.target;
		}
		function formatEnabled(value, row, index) {
			if (row.attributes.isShow == 1) {
				return "<img src='${ctxContent}/img/chk.gif'   />";
			} else {
				return "<img  src='${ctxContent}/img/unchk.gif'    />";
			}
		}
		function formatURL(value, row, index) {
			return row.attributes.href;
		}
		function formatSortCode(value, row, index) {
			return row.attributes.sort;
		}
		function formatICon(value, row, index) {
			return "<span style='font-size:14px;' class='" + row.attributes.icon + "'></span>";
		}
		function add() {
			top.openEditDlg("菜单新增", url + "form?id=", 550, 550);
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
			openEditDlg("按钮", url + "form?id="+selRow[0].id, 550, 550);
		}

		function reload() {
			$("#grid").treegrid("reload");
			$("#grid").treegrid("clearChecked");
		}
		function getList() {
			$("#grid").treegrid({
				url : url + "getTree",
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
/* 
		$('#filterTxt').searchbox({
			searcher : function(value, name) {
				var params = {
					name : value,
				};
				$('#grid').treegrid({
					queryParams : params
				});
			}
		}); */

		function stop() {
			var ids = getChecked();
			if (ids == "") {
				showWarnMsg("请选择需要操作的记录");
				return;
			}
			$.post(url + "start", {
				ids : ids, state : '0'
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
				ids : ids, state : '1'
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