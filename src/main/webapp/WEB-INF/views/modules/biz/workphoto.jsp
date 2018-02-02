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
				<button id="btnReload"
					class="layui-btn layui-btn-primary  layui-btn-small"
					onclick="reload()">
					<li class="fa fa-refresh"></li>&nbsp;刷新
				</button>
				<button id="btnAdd"
					class="layui-btn layui-btn-primary  layui-btn-small"
					onclick="add()">
					<li class="fa fa-plus"></li>&nbsp;新增
				</button>
				<button id="btnEdit"
					class="layui-btn layui-btn-primary  layui-btn-small"
					onclick="edit()">
					<li class="fa fa-edit"></li>&nbsp;编辑
				</button>
				<button id="btnDelete"
					class="layui-btn layui-btn-primary  layui-btn-small"
					onclick="del()">
					<li class="fa fa-trash"></li>&nbsp;删除
				</button>

				<button id="btnCheck"
					class="layui-btn layui-btn-primary  layui-btn-small"
					onclick="check('1')">
					<li class="fa fa-check"></li>&nbsp;审核
				</button>
				<button id="btnUnCheck"
					class="layui-btn layui-btn-primary  layui-btn-small"
					onclick="check('0')">
					<li class="fa fa-reply"></li>&nbsp;弃核
				</button>
			</div>
		</div>
	</div>
	<div region="center" border=false style="padding: 0 5px 5px 10px">
		<div id="tt" class="easyui-tabs" fit=true>
			<div title="所有记录" style="padding: 2px">
				<table id="gridAll">
					<thead>
						<tr>
							<th
								data-options="field:'xxmc',width:200,align:'left',halign:'center'">学校名称</th>
							<th
								data-options="field:'title',width:240,align:'left',halign:'center'">标题</th>
							<th
								data-options="field:'publishermc',width:140,align:'left',halign:'center'">发布人</th>
							<th
								data-options="field:'releaseDate',width:160,align:'center',halign:'center',formatter:dgDateTime">发布时间</th>
							<th
								data-options="field:'checkmc',width:140,align:'left',halign:'center'">审核人</th>
							<th
								data-options="field:'states',width:70,align:'center',halign:'center',formatter:formatStates">审核状态</th>
							<th
								data-options="field:'checkDate',width:160,align:'center',halign:'center',formatter:dgDateTime">审核时间</th>
							<th data-options="field:'djly',width:100,align:'center',halign:'center'">来源</th>
						</tr>
					</thead>
				</table>
			</div>
			<div title="未审核" style="padding: 2px">
				<table id="gridWsh">
					<thead>
						<tr>
							<th
								data-options="field:'xxmc',width:200,align:'left',halign:'center'">学校名称</th>
							<th
								data-options="field:'title',width:240,align:'left',halign:'center'">标题</th>
							<th
								data-options="field:'publishermc',width:140,align:'left',halign:'center'">发布人</th>
							<th
								data-options="field:'releaseDate',width:160,align:'center',halign:'center',formatter:dgDateTime">发布时间</th>
							<th data-options="field:'djly',width:100,align:'center',halign:'center'">来源</th>
						</tr>
					</thead>
				</table>
			</div>
			<div title="已审核" style="padding: 2px">
				<table id="gridYsh">
					<thead>
						<tr>
							<th
								data-options="field:'xxmc',width:200,align:'left',halign:'center'">学校名称</th>
							<th
								data-options="field:'title',width:240,align:'left',halign:'center'">标题</th>
							<th
								data-options="field:'publishermc',width:140,align:'left',halign:'center'">发布人</th>
							<th
								data-options="field:'releaseDate',width:160,align:'center',halign:'center',formatter:dgDateTime">发布时间</th>
							<th
								data-options="field:'checkmc',width:140,align:'left',halign:'center'">审核人</th>
							<th
								data-options="field:'states',width:70,align:'center',halign:'center',formatter:formatStates">审核状态</th>
							<th
								data-options="field:'checkDate',width:160,align:'center',halign:'center',formatter:dgDateTime">审核时间</th>
							<th data-options="field:'djly',width:100,align:'center',halign:'center'">来源</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>

	</div>

	<script type="text/javascript">
		var url = "${ctx}/biz/workphoto/";
		var gridID = "gridAll";
		$(function() {
			$("#btnCheck").show();
			$("#btnUnCheck").show();
			$("#btnEdit").show();
			$("#btnDelete").show();
			$('#tt').tabs({
				onSelect : function(data, idx) {
					if (idx == 0) {
						$("#btnCheck").show();
						$("#btnUnCheck").show();
						$("#btnEdit").show();
						$("#btnDelete").show();
						gridID = "gridAll";
					} else if (idx == 1) {
						$("#btnCheck").show();
						$("#btnUnCheck").hide();
						$("#btnEdit").show();
						$("#btnDelete").show();
						gridID = "gridWsh";
					} else if (idx == 2) {
						$("#btnCheck").hide();
						$("#btnUnCheck").show();
						$("#btnEdit").hide();
						$("#btnDelete").hide();
						gridID = "gridYsh";
					}
					reload();
				}
			});
			
			getAllList();
			getWshList();
			getYshList();
		});

		function formatStates(value, row, index) {
			if (value == "1") {
				return "<img src='${ctxContent}/img/chk.gif'   />";
			} else {
				return "<img  src='${ctxContent}/img/unchk.gif'    />";
			}
		}
		function formatDate(value, row, index) {
			return "";
		}
		function appendFile(file){
			$('#ifrmFloatEditDiv')[0].contentWindow.appendFile(file);
		}
		
		function add() {
			showFloatEditDiv("${ctx}/biz/workphoto/form?id=");
		}
		
		function setSchool(rows){
			$('#ifrmFloatEditDiv')[0].contentWindow.setSchool(rows);
		}
		
		function edit() {
			var selRow = $("#" + gridID).treegrid("getChecked");
			if (selRow.length == 0) {
				showWarnMsg("请选择需要修改的记录");
				return;
			}
			if (selRow.length > 1) {
				showWarnMsg("只能选择一条记录进行编辑操作");
				return;
			}
			showFloatEditDiv(url + "form?id=" + selRow[0].id);
		}

		function reload() {
			$("#gridAll").datagrid("reload");
			$("#gridAll").datagrid("clearChecked");
			$("#gridWsh").datagrid("reload");
			$("#gridWsh").datagrid("clearChecked");
			$("#gridYsh").datagrid("reload");
			$("#gridYsh").datagrid("clearChecked");
		}
		function getAllList() {
			getList("#gridAll", "");
		}
		function getWshList() {
			getList("#gridWsh", "0");
		}
		function getYshList() {
			getList("#gridYsh", "1");
		}
		function getList(grid_id, shzt) {
			$(grid_id).datagrid({
				url : url + 'datagrid?shzt=' + shzt,
				height : 'auto',
				striped : true,
				border : true,
				loadMsg : '',
				rownumbers : true,
				multiSort : true,
				fit : true,
				idField : 'id',
				singleSelect : true,
				pagination : true,
				pageSize : 50,
				pageList : [ 10, 20, 50, 100 ],
				checkOnSelect : false,
				selectOnCheck : false,
				frozenColumns : [ [ {
					field : 'ck',
					checkbox : true
				} ] ]
			});
		}

		function getChecked() {
			var selRow = $("#" + gridID).datagrid("getChecked");
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
					} else {
						showErrMsg(data.msg);
					}
				}, "json")
			});
		}

		function check(state) {
			var ids = getChecked();
			if (ids == "") {
				showWarnMsg("请选择需要审核的记录");
				return;
			}
			$.post(url + "check", {
				ids : ids,
				states : state
			}, function(data) {
				if (data.success) {
					reload();
					showMsg(data.msg)
				} else {
					showErrMsg(data.msg);
				}
			}, "json");
		}
	</script>
</body>
</html>