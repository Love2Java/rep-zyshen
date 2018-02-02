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
<body class="easyui-layout " border=false>
			<div region="north" border=false style="padding: 10px; height: 50px;">

				<div style="float: left">

					<div class="layui-btn-group">
						<button id="btnReload" class="layui-btn layui-btn-primary  layui-btn-small" onclick="reload()">
							<li class="fa fa-refresh"></li>&nbsp;刷新
						</button>
						<button id="btnAdd" class="layui-btn layui-btn-primary  layui-btn-small" onclick="selUser()">
							<li class="fa fa-check"></li>&nbsp;选择
						</button>
					</div>
					
				</div>
			</div>
			<div region="center" border=false style="padding: 0 10px 10px 10px">
				<table id="grid">
					<thead>
						<tr>
						    <th data-options="field:'name',width:100,align:'center',halign:'center'">姓名</th>
							<th data-options="field:'office.name',width:100,align:'center',halign:'center',formatter:formatOffice">归属机构</th>
							<th data-options="field:'loginName',width:100,align:'left',halign:'center'">登录名</th>
							<th data-options="field:'xb',width:60,align:'center',halign:'center'">性别</th>
							<th data-options="field:'sfzhm',width:180,align:'center',halign:'center'">身份证号</th>
							<th data-options="field:'phone',width:120,align:'left',halign:'center'">电话</th>
							<th data-options="field:'mobile',width:120,align:'left',halign:'center'">手机</th>
						</tr>
					</thead>
				</table>
			</div>

		<script type="text/javascript">
		
			var url = "${ctx}/sys/user/";

			$(function() {
				getList();
			});
			
			function formatOffice(value, row, index) {
				return row.office.name;
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
					} ] ],
					onDblClickRow:function(idx,row){
						var rows=JSON.parse("["+JSON.stringify(row)+"]");
						 currentPage().setUser(rows);
					     closeEditDlg();
					}
				});

			}

		    function selUser() {
		        var selRow = $("#grid").datagrid("getChecked");
		        if (selRow.length == 0) {
		            showWarnMsg("请选择至少一条记录");
		            return;
		        }
		        currentPage().setUser(selRow);
		        closeEditDlg();
		        $("#grid").datagrid("clearChecked");
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

		</script>
</body>
</html>