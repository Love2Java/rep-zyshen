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
	<div region="north" border=false style="padding: 10px; overflow: hidden">
		<div style="float: left">
			<div class="layui-btn-group">
				<button id="btnReload" class="layui-btn layui-btn-primary  layui-btn-small" onclick="reload()">
					<li class="fa fa-refresh"></li>&nbsp;刷新
				</button>
				<button id="btnAdd" class="layui-btn layui-btn-primary  layui-btn-small" onclick="selJobContent()">
					<li class="fa fa-ok"></li>&nbsp;选择
				</button>
			</div>
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
			getList();
		})

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
				} ] ],
				onDblClickRow:function(idx,row){
					var rows=JSON.parse("["+JSON.stringify(row)+"]");
					 currentPage().setJobContent(rows);
				     closeEditDlg();
				}

			});
		}
	    function selJobContent() {
	        var selRow = $("#grid").datagrid("getChecked");
	        if (selRow.length == 0) {
	            showWarnMsg("请选择至少一条记录");
	            return;
	        }
	        currentPage().setJobContent(selRow);
	        closeEditDlg();
	        $("#grid").datagrid("clearChecked");
	    }
	</script>
</body>
</html>