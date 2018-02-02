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
	<div region="north" border=false style="padding: 10px; height: 90px;overflow: hidden">
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
				<button id="btnSave" class="layui-btn layui-btn-primary  layui-btn-small" onclick="save()">
					<li class="fa fa-save"></li>&nbsp;保存
				</button>
				<button id="btnCancel" class="layui-btn layui-btn-primary  layui-btn-small" onclick="cancel()">
					<li class="fa fa-history"></li>&nbsp;取消
				</button>
				<button id="btnDelete" class="layui-btn layui-btn-primary  layui-btn-small" onclick="del()">
					<li class="fa fa-trash"></li>&nbsp;删除
				</button>
			</div>
		</div>
<!-- 		<div style="float: right" class="  layui-anim layui-anim-up">
			<input type="text" class="easyui-searchbox" id="filterTxt" menu="#mm" style="width: 400px" />

			<div id="mm" style="width: 120px">
				<div data-options="name:'mc'">工作内容</div>
				<div data-options="name:'gjz'">关键字</div>
			</div>
		</div> -->
		<div style="clear: both; maigin-left: 20px;">
			<form id="frmEdit" runat="server">
				<input type="hidden" id="id" name="id" />
				<div class="frmDiv">
				    &nbsp;&nbsp;工作内容：<input class="easyui-textbox" required="true" style="width: 150px" id="mc" name="mc" />
					&nbsp;&nbsp;关键字：<input class="easyui-textbox" required="true" style="width: 200px" id="gjz" name="gjz" />
					<input id="oldMc" name="oldMc" type="hidden" >
				</div>
			</form>
		</div>
	</div>
	<div region="center" border=false style="padding: 0 10px 10px 10px">
		<table id="grid">
			<thead>
				<tr>
					<th data-options="field:'mc',width:300,align:'left',halign:'center',sortable:'true'" rowspan="1">工作内容</th>
					<th data-options="field:'gjz',width:200,align:'left',halign:'center',sortable:'true'" rowspan="1">关键字</th>
				</tr>
			</thead>
		</table>
	</div>
	<script>
		var url = "${ctx}/base/job/";
		var bjzt = "";
		$(function() {
			initToolbar();
			getList();
			$("form input").prop("readonly", true);
		})

		function add() {
			bjzt = "save";
			addClick();
			$("form input").prop("readonly", false);
			$("#frmEdit").form("clear");
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
			bjzt = "update";
			editClick();
			$("form input").prop("readonly", false);
			$("#frmEdit").form("load", selRow[0]);
			$("#oldMc").val(selRow[0].mc);
		}

		function cancel() {
			$("form input").prop("readonly", true);
			cancelClick();
			$("#frmEdit").form("clear");
		}
		function reload() {
			$("#grid").datagrid("reload");
			$("#grid").datagrid("clearChecked");
		}
		function getList() {
			$("#grid").datagrid({
				url : url + 'datagrid',
				height : 'auto',
				striped : true,
				border : true,
				loadMsg : '',
				rownumbers : true,
				multiSort : true,
				fit : true,
				idField : 'id',
				singleSelect : true,
				checkOnSelect : false,
				selectOnCheck : false,
				frozenColumns : [ [ {
					field : 'ck',
					checkbox : true
				} ] ]

			});
		}

/* 		$('#filterTxt').searchbox({
			searcher : function(value, name) {
				var params = {
					mc : "",
					gjz : "",
				};
				if (name == "mc") {
					params.mc = value;
				} else if (name == "gjz") {
					params.gjz = value;
				} 
				$('#grid').treegrid({
					queryParams : params
				});

			}
		}); */

		function getChecked() {
			var selRow = $("#grid").datagrid("getChecked");
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

		function save() {
			if (!$("#frmEdit").form('validate')) {
				return;
			}
			$.post(url + "save", $("#frmEdit").serialize(), function(data) {
				if (data.success) {
					$("form input").prop("readonly", true);
					if (bjzt == "save") {
						add();
					} else {
						saveClick();
						$("#frmEdit").form("clear");
					}
					reload();
				} else {
					showCryMsg(data.msg);
				}
			}, "json");
		}
	</script>
</body>
</html>