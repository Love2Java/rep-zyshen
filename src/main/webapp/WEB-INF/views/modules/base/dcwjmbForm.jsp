<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/include.html"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
input, select {
	width: 200px;
}

.tbEdit {
	margin: 20px;
	width: 100%
}

.tdLeft {
	width: 120px;
	text-align: right
}

.tdRight {
	width: 220px;
	text-align: left
}

.tbEdit td {
	padding: 10px;
	border-bottom: 1px dashed #cccccc
}
</style>

<body class=' easyui-layout '  border=false style="margin:10px;">
	<div region="north"  border=false>
	<div class="layui-btn-group">
		<button class="layui-btn layui-btn-primary layui-btn-small" onclick="close1()">
			<li class="fa fa-window-close"></li>&nbsp;关闭
		</button>
		<button class="layui-btn layui-btn-primary layui-btn-small" onclick="save()">
			<li class="fa fa-save"></li>&nbsp;保存
		</button>
	</div>
	</div>

	<div region="center" fixed=true border=false>
		<form id="frmEdit" method="post">
			<input type="hidden" id="id" name="id" value="${models.id}" />
			<table class="tbEdit" cellpadding="0" cellspacing="2">
				<tr>
					<td class="tdLeft">类型:</td>
					<td class="tdRight"><input class="easyui-combobox" name="lx" editable=false id="lx" required="true" /></td>
					<td class="tdLeft">年度:</td>
					<td class="tdRight"><input type="text" id="nd" name="nd" class="easyui-numberbox" min=0  required="true"  precision=0></td>
					<td></td>
				</tr>
				<tr>
					<td class="tdLeft">版本号:</td>
					<td class="tdRight"><input type="text"  required="true"  class="easyui-textbox" id="bbh" name="bbh" /></td>
					<td class="tdLeft">模板状态:</td>
					<td class="tdRight"><input class="easyui-combobox" name="zt" editable=false id="zt" required="true" /></td>
					<td></td>
				</tr>
				<tr>
					<td class="tdLeft">问卷标题:</td>
					<td class="tdRight" colspan=3><input type="text" class="easyui-textbox" id="wjbt" name="wjbt" required="true" style="width: 580px" /></td>
					<td></td>
				</tr>
				<tr>
					<td class="tdLeft">问卷简介:</td>
					<td class="tdRight" colspan=3><input type="text" multiline="true" class="easyui-textbox" id="wjjj" name="wjjj" required="true" style="width: 580px; height: 100px;" /></td>
					<td></td>
				</tr>
			</table>
		</form>
		<div style="width: 820px; height: 500px;">
			<div id="btnGrid">
				<div class="layui-btn-group">
					<button class="layui-btn layui-btn-small" onclick="appendRow()">
						<li class="fa fa-plus"></li>&nbsp;增行
					</button>
					<button class="layui-btn layui-btn-small" onclick="removeRow()">
						<li class="fa fa-trash"></li>&nbsp;删行
					</button>
				</div>
			</div>
			<table id="grid">
				<thead>
					<tr>
						<th data-options="field:'wjnr',width:750,align:'left',halign:'center',editor:'text'">评测要点</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>

	<script>
	//alert("主子表传参问题已解决，见文件最下方");
		var id = "";
		var bjzt = "save";
		var dataUrl = "${ctx}/base/qnaire/model/";

		$(function() {
			//该页面不可用jstl方式取数  因为有张明细表   需获取单据json格式数据   
			//获取数据方法见getRecord();
			id = getParam("id");
			initGrid();
			$("#lx").combobox({
				data:[{text:"教师"},{text:"家长"},{text:"学生代表"}],
				valueField:"text",
				textField:"text"
			});
			$("#zt").combobox({
				data:[{text:"打开"},{text:"关闭"}],
				valueField:"text",
				textField:"text"
			});
			if (id != "") {
				bjzt = "update";
				getRecord();
			}
			else{
				//默认添加10个空行
				for(var i=0;i<10;i++){
					appendRow();
				}
			}

		});
		var lstGridIdx=-1;
		function initGrid() {
			$("#grid").datagrid({
				toolbar : "#btnGrid",
				height : 'auto',
				striped : true,
				border : true,
				loadMsg : '',
				rownumbers : true,
				fit : true,
				idField : 'id',
				singleSelect : true,
				checkOnSelect : false,
				selectOnCheck : false,
				onClickRow:function(idx,data){
					endEdit();
					lstGridIdx=idx;
					beginEdit();
				}
			});
		}
		function getRecord(){
			$.get(dataUrl+"getRecord",{id:id},function(data){
				//form加载主表数据
				//datagrid加载明细表数据
				$("#frmEdit").form("load",data);
				$("#grid").datagrid({
					data:data.detailList
				})
			},"json");
		}
		function endEdit(){
			if(lstGridIdx!=-1){
				$('#grid').datagrid('endEdit',lstGridIdx);
			}
		}
		function beginEdit(){
				$('#grid').datagrid('beginEdit',lstGridIdx);
		}
		function removeRow(){			
			if(lstGridIdx!=-1){
				$('#grid').datagrid('deleteRow',lstGridIdx);
			}
		}
		function appendRow(){
			$('#grid').datagrid('appendRow',{
				zbid: '',
				id: '',
				wjnr: ''
			});
		}
		function add() {
			$("#frmEdit").form("clear");
			$("#grid").datagrid({
				data:[]
			});
		}
		function reset() {
			$("#frmEdit").form("reset");
			$("#grid").datagrid({
				data:[]
			});
		}

		function save() {
			endEdit();
			if (!$("#frmEdit").form('validate')) {
				return;
			}
			var rows=$("#grid").datagrid("getRows");

			var data=$("#frmEdit").serializeObject();
			data.detailList=[];
			$.each(rows,function(i,row){
				if(row.wjnr!="") {
					data.detailList.push({id:row.id,zbid:row.zbid,wjnr:row.wjnr});
				}
			});
			if(data.detailList.length==0){
				showWarnMsg("请设置评测要点");
				return;
			}
			postJson(dataUrl + "save",data,function(data){
				if (data.success) {
					if (bjzt == "save") {
						add();
					} else {
						currentPage().hideFloatEditDiv();
					}
					showMsg(data.msg);
					currentPage().reload();
				} else {
					showCryMsg(data.msg);
				}
			});
			
		}
		function close1() {
			currentPage().hideFloatEditDiv();
		}
	</script>
</body>