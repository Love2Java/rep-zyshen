<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/include.html"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色授权</title>
</head>
<body class="easyui-layout layui-anim layui-anim-scale" border=false>
	<div region="west" style="width: 350px; padding: 1px" split="true"
		title="角色列表"
		data-options="tools: [{ iconCls:'icon-mini_refresh',  handler:function(){$('#gridRole').datagrid('reload')}}]"
		collapsible="false">
		<table id="gridRole">
			<thead>
				<tr>
					<th data-options="field:'name',width:150,halign:'center'">角色名称</th>
					<th
						data-options="field:'officename',width:150,align:'left',halign:'center',formatter:formatOffice">归属机构</th>
				</tr>
			</thead>
		</table>
	</div>
	<div region="center" title="角色授权">
		<div class="easyui-layout" fit=true>
			<div region="center" border=false>
				<div id="tt" class="easyui-tabs" border="false" fit="true"
					style="overflow: hidden">
					<div title="角色成员"  border="false" >
						<div id="toolRoleUser">
							<div class="layui-btn-group">
								<button id="btnReload"
									class="layui-btn layui-btn-primary  layui-btn-small"
									onclick="reloadUser()">
									<li class="fa fa-refresh"></li>&nbsp;刷新
								</button>
								<button id="btnAdd"
									class="layui-btn layui-btn-primary  layui-btn-small"
									onclick="addUser()">
									<li class="fa fa-plus"></li>&nbsp;添加用户
								</button>
								<button id="btnRemove"
									class="layui-btn layui-btn-primary  layui-btn-small"
									onclick="removeUser()">
									<li class="fa fa-remove"></li>&nbsp;删除用户
								</button>
							</div>
						</div>

						<table id="gridUser">
							<thead>
								<tr>
									<th
										data-options="field:'loginName',width:100,align:'left',halign:'center',sortable:'true'">登录名</th>
									<th
										data-options="field:'name',width:100,align:'left',halign:'center',sortable:'true'">姓名</th>
									<th
										data-options="field:'office.name',width:150,align:'left',halign:'center',sortable:'true',formatter:formatOffice">归属机构</th>
								</tr>
							</thead>
						</table>
					</div>
					<div title="模块权限" style="padding: 1px;" border="false">
						<div id="toolRoleMenu" >
							<div class="layui-btn-group">
								<button id="btnReload"
									class="layui-btn layui-btn-primary  layui-btn-small"
									onclick="reloadMenu()">
									<li class="fa fa-refresh"></li>&nbsp;刷新
								</button>
								<button id="btnAdd"
									class="layui-btn layui-btn-primary  layui-btn-small"
									onclick="roleMenuGrant()">
									<li class="fa fa-grant"></li>&nbsp;授权
								</button>
							</div>
						</div>
						<table id="gridMenu">
							<thead>
								<tr>
									<th data-options="field:'text',width:400,halign:'center'">功能模块</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		var selRoleId = "";
		var roleMenu;
		$(function() {
			loadRole();
			loadUser();
		})

		function addUser(){
			top.openDialog("选择用户", "${ctx}/sys/role/usertorole", "UserToRole", 950, 550, false); 		
		}
		
		function formatOffice(value, row, index) {
			return row.office.name;
		}
		$('#tt').tabs({
			onSelect : function(data, idx) {
				if (idx == 1) {
					loadRoleMenu();
				}
			}
		});
		
		function setUser(rows){
			var ids="";
			if(selRoleId==""){
				showWarnMsg("请选择角色");
				return;
			}
			$.each(rows,function(i,row){
	            ids += row.id + ",";
			});
			if(ids=="") return;
			if(ids!="") ids=ids.substring(0,ids.length-1);
			$.post("${ctx}/sys/role/addUserToRole",{ids:ids,roleId:selRoleId},function(data){
				if(data.success){
					$("#gridUser").datagrid("reload");
					showMsg(data.msg);
				}
				else{
					showCryMsg(data.msg);
				}				
			},"json");
		}
		
		function removeUser(){
			 var selRow = $("#gridUser").datagrid("getChecked");
		        if (selRow.length == 0) {
		            showWarnMsg("请选择需要删除的记录");
		            return;
		        }
		        showConfirm("确定要删除吗？", function () {
		            var ids = "";
		            for (var i = 0; i < selRow.length; i++) {
		                ids += selRow[i].id + ","
		            }
		            ids = ids.substr(0, ids.length - 1);
		            $.post("${ctx}/sys/role/deleteUserRole", { roleId: selRoleId, ids: ids }, function (data) {
		                if (data.success) {
		                	reloadUser();
		                    showMsg(data.msg)
		                    $("#gridUser").datagrid("clearChecked");
		                }
		                else {
		                    showErrMsg(data.msg);
		                }
		            }, "json")
		        });
		}
		
		function reloadUser() {
			$("#gridUser").datagrid("reload");
		}
		function formatOffice(value, row, index) {
			return row.office.name;
		}

		function loadUser() {
			$("#gridUser").datagrid({
				url : '${ctx}/sys/role/getUsersByRoleId',
				height : 'auto',
				queryParams : {
					roleId : currentPage().selRoleId,
				},
				striped : true,
				toolbar : "#toolRoleUser",
				border : false,
				loadMsg : '',
				rownumbers : true,
				multiSort : true,
				fit : true,
				pagination : true,
				pageSize : 50,
				idField : 'id',
				pageList : [ 50, 100, 200 ],
				singleSelect : true,
				checkOnSelect : false,
				selectOnCheck : false,
				frozenColumns : [ [ {
					field : 'ck',
					checkbox : true
				} ] ]
			})
		}

		function loadRoleMenu() {
			var url = '${ctx}/sys/menu/getTreeByRoleId';
			$.post(url, {
				roleId : selRoleId
			}, function(data) {
				roleMenu = data;
				loadMenuGrid();
			}, "json");
		}
		function reloadMenu() {
			$("#gridMenu").treegrid("reload");
		}
		function roleMenuGrant() {

			if ("" == selRoleId) {
				return;
			}

			var url = '${ctx}/sys/menu/roleMenuGrant';
			var data = $("#gridMenu").treegrid("getCheckedNodes");
			var ids = "";
			for (var i = 0; i < data.length; i++) {
				ids += data[i].id + ",";
			}
			if ("" != ids) {
				ids = ids.substr(0, ids.length - 1);
			}
			$.post(url, {
				ids : ids,
				roleId : selRoleId
			}, function(data) {

				if (data.success) {
					showMsg(data.msg);
				} else {
					showCryMsg(data.msg);
				}

			}, "json");
		}
		function loadRole() {
			$("#gridRole").datagrid({
				url : '${ctx}/sys/role/getRoles',
				height : 'auto',
				striped : true,
				border : false,
				loadMsg : '',
				rownumbers : true,
				multiSort : true,
				fit : true,
				idField : 'id',
				singleSelect : true,
				checkOnSelect : false,
				selectOnCheck : false,
				onClickRow : function(idx, row) {
					selRoleId = row.id;
					loadRoleMenu();
					loadUser();
				},
				onLoadSuccess : function(data) {
					
					var rows = $('#gridRole').datagrid("getRows");
					if(rows.length > 0) {
						$('#gridRole').datagrid('selectRow',0);
						var row = $('#gridRole').datagrid("getSelections");
						selRoleId = row[0].id;
						loadRoleMenu();
						loadUser();
					}
				}
			});
		}
		function loadMenuGrid() {
			$("#gridMenu").treegrid({
				toolbar : "#toolRoleMenu",
				url : "${ctx}/sys/menu/getTree",
				idField : 'id',
				treeField : 'text',
				border:false,
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
				onLoadSuccess : function(data) {
					var roots = $(this).treegrid("getRoots");
					for (var i = 0; i < roots.length; i++) {
						$(this).treegrid("uncheckNode", roots[i].id);
					}
					for (var i = 0; i < roleMenu.length; i++) {
						$(this).treegrid("checkNode", roleMenu[i].id);
					}
				}
			});
		}
	</script>
</body>
</html>