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
<body class=' easyui-layout' border=false
	style="margin: 10px;">
	<div region="north" border=false>
	
	<div class="layui-btn-group">
		<button class="layui-btn layui-btn-primary layui-btn-small"
			onclick="close1()">
			<li class="fa fa-window-close"></li>&nbsp;关闭
		</button>
		<button class="layui-btn layui-btn-primary layui-btn-small" onclick="save()">
			<li class="fa fa-save"></li>&nbsp;保存
		</button>
		<button class="layui-btn layui-btn-primary layui-btn-small" onclick="uploadFile()">
			<li class="fa fa-upload"></li>&nbsp;上传附件
		</button>
		</div>
	</div>
	<div region="center" fixed=true border=false>
		<form id="frmEdit" method="post">
			<input type="hidden" id="id" name="id" value="${workSum.id}" />
			<table class="tbEdit" cellpadding="0" cellspacing="2">
				<tr>
					<td class="tdLeft">类别:</td>
					<td class="tdRight"><input type="text" class="easyui-combobox"
						id="lb" name="lb" value="${workSum.lb}" required="true"
						editable=false /></td>
					<td></td><td></td><td></td>
				</tr>

				<tr>
					<td class="tdLeft">年度:</td>
					<td class="tdRight"><input type="text"
						class="easyui-numberbox" id="nd" name="nd"
						value="${workSum.nd}" precision="0" required="true" /></td>

					<td class="tdLeft">时间:</td>
					<td class="tdRight"><input class="easyui-combobox" name="sj"
						editable=false id="sj" value="${workSum.sj}" required="true" /></td>
					<td></td>
				</tr>
				<tr>
					<td class="tdLeft">总结标题:</td>
					<td class="tdRight" colspan="3"><input type="text"
						style="width: 580px" class="easyui-textbox" id="zjbt"
						required="true" name="zjbt" value="${workSum.zjbt}" /></td>
					<td></td>
				</tr>
				<tr>
					<td class="tdLeft">总结内容:</td>
					<td class="tdRight" colspan="4"><input type="text"
						class="easyui-textbox" id="zjnr" multiline=true name="zjnr"
						style='width: 580px; height: 100px;' value="${workSum.zjnr}" />
					</td>
				</tr>
				<tr>
					<td class="tdLeft">备注:</td>
					<td class="tdRight" colspan="3"><input type="text"
						class="easyui-textbox" id="remarks" multiline=true name="remarks"
						style='width: 580px; height: 50px;' value="${workSum.remarks}" /></td>
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
		var dataUrl = "${ctx}/biz/worksum/";
		var editor;
		$(function() {
			id = getParam("id");
			//editor = UE.getEditor('zjnr');
			var data = [{text : "月度总结"}, {text : "半年度总结"}];
			$("#lb").combobox({
				data : data,
				valueField : "text",
				textField : "text",
				onSelect:function(data){
					var sjData = [];
					if(data.text=="月度总结"){
						sjData = [ {
							text : "一月份"
						}, {
							text : "二月份"
						}, {
							text : "三月份"
						}, {
							text : "四月份"
						}, {
							text : "五月份"
						}, {
							text : "六月份"
						}, {
							text : "七月份"
						}, {
							text : "八月份"
						}, {
							text : "九月份"
						}, {
							text : "十月份"
						}, {
							text : "十一月份"
						}, {
							text : "十二月份"
						} ];
					}
					else{
						sjData = [{
							text : "上半年"
						}, {
							text : "下半年"
						} ];
					}
					$("#sj").combobox({
						data : sjData,
						valueField : "text",
						textField : "text"
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