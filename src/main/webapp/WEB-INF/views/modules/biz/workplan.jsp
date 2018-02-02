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
				</div>
			</div>
			<div region="center" border=false style="padding: 0 10px 10px 10px">
				<table id="grid">
					<thead>
						<tr>
							<th data-options="field:'nd',width:140,align:'left',halign:'center'">年度</th>
							<th data-options="field:'sj',width:140,align:'center',halign:'center'">时间</th>
							<th data-options="field:'lb',width:140,align:'center',halign:'center'">类别</th>
							<th data-options="field:'gjz',width:140,align:'center',halign:'center'">关键字</th>
							<th data-options="field:'rymc',width:100,align:'center',halign:'center'">记录人</th>
							<th data-options="field:'createDate',width:150,align:'center',halign:'center'">记录日期</th>
							<th data-options="field:'djly',width:100,align:'center',halign:'center'">来源</th>
						</tr>
					</thead>
				</table>
			</div>

		<script type="text/javascript">
		
			var url = "${ctx}/biz/workplan/";

			$(function() {
				getList();
			});
			
			function add() {
				showFloatEditDiv(url + "form?id=");
			}

			function edit() {
				var selRow = $("#grid").treegrid("getChecked");
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
				$("#grid").datagrid("reload");
				$("#grid").datagrid("clearChecked");
			}

			function getList() {
				$("#grid").datagrid({
					url : url+'datagrid',
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

			function appendFile(file){
				$('#ifrmFloatEditDiv')[0].contentWindow.appendFile(file);
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