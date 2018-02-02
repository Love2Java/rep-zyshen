<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/include.html"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body class="easyui-layout" border=false>
	<div region="north" border=false style="padding: 10px; height: 50px;">
		<div style="float: left">
			<div class="layui-btn-group">
				<button id="btnReload" class="layui-btn layui-btn-primary  layui-btn-small" onclick="reload()">
					<li class="fa fa-refresh"></li>&nbsp;刷新
				</button>
				<button id="btnSel" class="layui-btn layui-btn-primary  layui-btn-small" onclick="selSchool()">
					<li class="fa fa-plus"></li>&nbsp;选择
				</button>
			</div>
		</div>
	</div>
	<div region="center" border=false style="padding: 0 10px 10px 10px">
		<table id="grid">
			<thead>
				<tr>
					<th data-options="field:'xxmc',width:150,align:'left',halign:'center'">学校名称</th>
					<th data-options="field:'xxlxmc',width:100,align:'center',halign:'center'">学校类型</th>
					<th data-options="field:'dwdm',width:100,align:'center',halign:'center'">单位代码</th>
					<th data-options="field:'zcdz',width:300,align:'left',halign:'center'">注册地址</th>
					<th data-options="field:'lxr',width:100,align:'center',halign:'center'">联系人</th>
					<th data-options="field:'lxdh',width:150,align:'center',halign:'center'">联系电话</th>
				</tr>
			</thead>
		</table>
	</div>
	<script>
		var url = "${ctx}/base/school/";
		var cascadeCheck = true;
		$(function() {
			initGrid();
		})

		function initGrid() {
			var flag = '${flag}';
			$("#grid").datagrid({
				url : url+'datagrid?flag='+flag,
				height : 'auto',
				striped : true,
				border : true,
				loadMsg : '',
				rownumbers : true,
				multiSort : true,
				fit : true,
				idField : 'id',
				pagination: true,
				pageSize: 50,
				pageList: [10,20,50,100],
				singleSelect : true,
				checkOnSelect : false,
				selectOnCheck : false,
				frozenColumns : [ [ {
					field : 'ck',
					checkbox : true
				} ] ],
				onDblClickRow:function(idx,row){
					var rows=JSON.parse("["+JSON.stringify(row)+"]");
					 currentPage().setSchool(rows);
				     closeEditDlg();
				}
			});
		}

	    function selSchool() {
	        var selRow = $("#grid").datagrid("getChecked");
	        if (selRow.length == 0) {
	            showWarnMsg("请选择至少一条记录");
	            return;
	        }
	        currentPage().setSchool(selRow);
	        closeEditDlg();
	        $("#grid").datagrid("clearChecked");
	    }
		
		function reload() {
			$("#grid").datagrid("reload");
			$("#grid").datagrid("clearChecked");
		}

	</script>
</body>
</html>