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
					<!-- <div class="layui-btn-group">
						<button id="btnReload"
							class="layui-btn layui-btn-primary  layui-btn-small"
							onclick="import()">
							<li class="fa fa-share"></li>&nbsp;导入
						</button>
						<button id="btnAdd"
							class="layui-btn layui-btn-primary  layui-btn-small"
							onclick="export()">
							<li class="fa fa-reply"></li>&nbsp;导出
						</button>
						
					</div> -->
					
				</div>
			</div>
			<div region="center" border=false style="padding: 0 10px 10px 10px">
				<table id="grid">
					<thead>
						<tr>
							<th data-options="field:'office.name',width:100,align:'center',halign:'center',formatter:formatOffice">归属机构</th>
							<th data-options="field:'loginName',width:100,align:'center',halign:'center'">登录名</th>
							<th data-options="field:'name',width:100,align:'center',halign:'center'">姓名</th>
							<th data-options="field:'xb',width:60,align:'center',halign:'center'">性别</th>
							<th data-options="field:'sfzhm',width:180,align:'center',halign:'center'">身份证号</th>
							<th data-options="field:'jg',width:100,align:'center',halign:'center'">籍贯</th>
							<th data-options="field:'lssfzh',width:180,align:'center',halign:'center'">临时身份证号</th>
							<th data-options="field:'phone',width:150,align:'center',halign:'center'">电话</th>
							<th data-options="field:'mobile',width:150,align:'center',halign:'center'">手机</th>
							<th data-options="field:'qq',width:150,align:'center',halign:'center'">QQ</th>
							<th data-options="field:'wxh',width:150,align:'center',halign:'center'">微信号</th>
							<th data-options="field:'xlmc',width:150,align:'center',halign:'center'">学历</th>
							<th data-options="field:'mzmc',width:150,align:'center',halign:'center'">民族</th>
							<th data-options="field:'xxmc',width:150,align:'center',halign:'center'">血型</th>
							<th data-options="field:'hymc',width:150,align:'center',halign:'center'">婚姻状况</th>
							<th data-options="field:'cylbmc',width:150,align:'center',halign:'center'">从业类别</th>
							<th data-options="field:'cyrq',width:140,align:'center',halign:'center'">从业日期</th>
							<th data-options="field:'zwmc',width:150,align:'center',halign:'center'">职务</th>
							<th data-options="field:'csrq',width:140,align:'center',halign:'center'">出生日期</th>
							<th data-options="field:'hjxz',width:150,align:'center',halign:'center'">户籍详址</th>
							<th data-options="field:'xjzdz',width:150,align:'center',halign:'center'">现居住地址</th>
						</tr>
					</thead>
				</table>
			</div>

		<script type="text/javascript">
			var editObj = {
				bjzt : "",
				id : ""
			};
			var url = "${ctx}/sys/user/";
			var cascadeCheck = true;

			$(function() {
				getList();
			});
			
			function formatOffice(value, row, index) {
				return row.office.name;
			}

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