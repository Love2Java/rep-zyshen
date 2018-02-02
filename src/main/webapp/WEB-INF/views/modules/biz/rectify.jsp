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
						<button id="btnEdit" class="layui-btn layui-btn-primary  layui-btn-small" onclick="edit()">
							<li class="fa fa-edit"></li>&nbsp;修改通知书
						</button>
						<button id="btnEdit" class="layui-btn layui-btn-primary  layui-btn-small" onclick="doRectify()">
							<li class="fa fa-wrench "></li>&nbsp;整改
						</button>
						<button id="btnEdit" class="layui-btn layui-btn-primary  layui-btn-small" onclick="pjRectify()">
							<li class="fa fa-file-text-o  "></li>&nbsp;评价
						</button>
						<button id="btnDelete" class="layui-btn layui-btn-primary  layui-btn-small" onclick="del()">
							<li class="fa fa-trash"></li>&nbsp;删除
						</button>
					</div>
				</div>
				<div style="float: right" class="layui-anim layui-anim-up">
			        <select prompt="选择状态" class="easyui-combobox" style="width: 180px" id="type" name="type" editable=false>
				        <option value="">==选择状态==</option>
						<option value="0">待处理</option>
						<option value="1">已计划</option>
						<option value="2">已回访</option>
						<option value="3">已汇报</option>
						<option value="4">已评价</option>
			        </select>
			        <input type="text" prompt="输入问题关键字描述" class="easyui-searchbox" id="description" style="width: 200px" />
		        </div>
			</div>
			<div region="center" border=false style="padding: 0 10px 10px 10px">
				<table id="grid">
					<thead>
						<tr>
							<th data-options="field:'wtgjz',width:200,align:'left',halign:'center',formatter:formatBt">问题整改列表标题</th>
							<th data-options="field:'xxmc',width:140,align:'center',halign:'center'">学校名称</th>
							<th data-options="field:'xdrq',width:140,align:'center',halign:'center',formatter:dgDate">下达日期</th>
							<th data-options="field:'xqsj',width:100,align:'right',halign:'center'">限期时间（天）</th>
							<th data-options="field:'dqzt',width:100,align:'center',halign:'center',formatter:formatZt">整改状态</th>
							<th data-options="field:'rymc',width:100,align:'center',halign:'center'">记录人</th>
							<th data-options="field:'createDate',width:150,align:'center',halign:'center'">记录日期</th>
							<th data-options="field:'djly',width:100,align:'center',halign:'center'">来源</th>
						</tr>
					</thead>
				</table>
			</div>

		<script type="text/javascript">
		
			var url = "${ctx}/biz/rectify/";

			$(function() {
				getList();
			});
			
			$('#description').searchbox({
				searcher : function(value, name) {
					var params = {
						description : value,
						type: $("#type").combobox("getValue")
					};
					$('#grid').datagrid({
						queryParams : params
					});
				}
			});
			
			function formatBt(value,row,idx){
				if(value && value!=""){
					return "关于"+value+"的问题";
				}
			}
			
			function formatZt(value,row,index){
				if(value=="0"){
					return "待处理";
				}
				else if(value=="1"){
					return "已计划 ";
				}
				else if(value=="2"){
					return "已回访";
				}
				else if(value=="3"){
					return "已汇报";
				}
				else if(value=="4"){
					return "已评价";
				}
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
				if(selRow[0].dqzt == "0") {
					showFloatEditDiv(url+"form?id="+selRow[0].id);
				}else {
					showErrMsg("该问题整改通知书已在处理中，无法编辑！");
				}
				
			}

			function doRectify(){
				var selRow = $("#grid").treegrid("getChecked");
				if (selRow.length == 0) {
					showWarnMsg("请选择需要整改的记录");
					return;
				}
				if (selRow.length > 1) {
					showWarnMsg("只能选择一条记录进行整改操作");
					return;
				}
				if(selRow[0].dqzt != "4") {
					showFloatEditDiv(url+"doRectify?id="+selRow[0].id);
				}else {
					showErrMsg("该问题整改通知书已经处理完毕，无法整改！");
				}
				
			}
			function pjRectify(){
				var selRow = $("#grid").treegrid("getChecked");
				if (selRow.length == 0) {
					showWarnMsg("请选择需要评价的记录");
					return;
				}
				if (selRow.length > 1) {
					showWarnMsg("只能选择一条记录进行评价");
					return;
				}
				if(selRow[0].dqzt == "3") {
					showFloatEditDiv(url+"pjRectify?id="+selRow[0].id);
				}else {
					showErrMsg("该问题整改通知书未处理完毕，无法评价！");
				}
				
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
			function setSchool(rows){
				$('#ifrmFloatEditDiv')[0].contentWindow.setSchool(rows);
			}
			function appendFile(file){
				$('#ifrmFloatEditDiv')[0].contentWindow.appendFile(file);
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