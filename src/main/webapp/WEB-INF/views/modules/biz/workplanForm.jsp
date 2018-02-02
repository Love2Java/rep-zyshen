<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/include.html"%>
<%@ include file="/WEB-INF/views/include/file.jsp"%>

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
<body class=' easyui-layout  ' border=false style="margin:10px;">
	<div region="north"  border=false>
	<div class="layui-btn-group">
		<button class="layui-btn layui-btn-primary  layui-btn-small" onclick="close1()">
			<li class="fa fa-window-close"></li>&nbsp;关闭
		</button>
		<button class="layui-btn layui-btn-primary  layui-btn-small" onclick="save()">
			<li class="fa fa-save"></li>&nbsp;保存
		</button>
		<button class="layui-btn layui-btn-primary  layui-btn-small" onclick="uploadFile()">
			<li class="fa fa-upload"></li>&nbsp;上传附件
		</button>
		</div>
	</div>
	<div region="center" fixed=true border=false>
		<form id="frmEdit" method="post">
			<input type="hidden" id="id" name="id" value="${workPlan.id}" />
			<table class="tbEdit" cellpadding="0" cellspacing="2">
				<tr>
					<td class="tdLeft">类别:</td>
					<td class="tdRight">
					    <input type="text" class="easyui-combobox" id="lb" name="lb" editable=false required=true value="${workPlan.lb}" />
					</td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
				    <td class="tdLeft">年度:</td>
					<td class="tdRight"><input type="text" class="easyui-numberbox" id="nd" name="nd" value="${workPlan.nd}" precision="0"  required="true" /></td>
					<td class="tdLeft">时间:</td>
					<td class="tdRight"><input class="easyui-combobox" name="sj" editable=false id="sj" required=true  value="${workPlan.sj}" /></td>
					<td></td>
				</tr>
				<tr>
					<td class="tdLeft">关键字:</td>
					<td class="tdRight" colspan="3"><input type="text" required=true style="width:580px" class="easyui-textbox" id="gjz" name="gjz" value="${workPlan.gjz}" /></td>
					<td></td>
				</tr><tr>
					<td class="tdLeft">工作内容:</td>
					<td class="tdRight" colspan="4">
					<input type="text" class="easyui-textbox" id="gznr" multiline=true name="gznr" style='width: 580px;height:100px' value="${workPlan.gznr}" />
					</td>
				</tr><tr>
					<td class="tdLeft">备注:</td>
					<td class="tdRight" colspan="3"><input type="text" class="easyui-textbox" id="remarks" multiline=true name="remarks" style='width: 580px;height:50px;' value="${workPlan.remarks}" /></td>
					<td></td>
				</tr>
				<tr>
					<td class="tdLeft">附件:</td>
					<td class="tdRight" colspan="4">
						<div class="divFileList">
					</div>
					</td>
				
				</tr>
			</table>
		</form>
	</div>

	<script>
		var id = "";
		var bjzt = "save";
		var dataUrl = "${ctx}/biz/workplan/";
		$(function() {
			id = getParam("id");
			
			var data = [{text:"个人计划"}, {text:"责任区计划"}];
			$("#lb").combobox({
				data: data,
				valueField: "text",
				textField: "text",
				onSelect:function(value){
					var data1=[];
					if(value.text=="个人计划"){
						data1=[{text:"上半年"},{text:"下半年"}];
					}	 
					else if(value.text=="责任区计划"){
						data1=[{text:"全年"}];
					}
					$("#sj").combobox({
						data:data1,
						valueField:"text",
						textField:"text"
					});
				}
			});
			if (id != "") {
				bjzt = "update";
				//获取附件列表
				getFileListById();
			}
		});

		function add() {
			$("#frmEdit").form("clear");
			$(".divFileList").empty();
		}
		function uploadFile() {
			top.openDialog("附件上传", "${ctx}/sys/multifile/", "MultiFile", 950, 550, false);
		}
		function reset() {
			$("#frmEdit").form("reset");
			$(".divFileList").empty();
		}
		
		function getFileListById(){
			$.get(dataUrl+"getFileListById",{id:id},function(data){
				//form加载主表数据
				$("#frmEdit").form("load",data);
				//fileList-文件列表
				$.each(data.fileList, function(index, file) {
					appendFile(file);
				});
				
			},"json");
		}

		function save() {
			if (!$("#frmEdit").form('validate')) {
				return;
			}

			var data=$("#frmEdit").serializeObject();
			data.fileList=getFileList();
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