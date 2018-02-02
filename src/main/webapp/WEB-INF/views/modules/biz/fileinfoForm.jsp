<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/file.jsp"%>
 <%@ include file="/WEB-INF/views/include/ueditor.html"%> 
<script>
var ctxContent="${ctxContent}";
</script>
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
	border-bottom: 1px dashed #cccccc;
	
}
#imgViewer{
	height:300px;
	width:99%;
}
</style>
<body class=' easyui-layout  '  border=false>
	<div region="north"  border=false  style="margin:10px;">
	<div class="layui-btn-group">
	
		<button class="layui-btn layui-btn-primary layui-btn-small" onclick="close1()">
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
			<input type="hidden" id="id" name="id" value="${workPhoto.id}" />

		<table class="tbEdit" cellpadding="0" cellspacing="2">
				<tr>
					<td class="tdLeft">类型:</td>
					<td class="tdRight" colspan="3">
					    <select class="easyui-combobox" name="classId" editable=false id="classId" required=true>
					        <option <c:if test="${workPhoto.classId eq ''}"> selected </c:if> value="">==请选择==</option>
						    <c:forEach items="${fns:getDictList('base_file_type')}" var="item">
						        <c:if test="${'4' != item.value}">
						            <option <c:if test="${workPhoto.classId eq item.value}"> selected </c:if> value="${item.value}">${item}</option>
						        </c:if>
						    </c:forEach>
					    </select>
					</td>
					<td></td>
				</tr>	
				<tr>
					<td class="tdLeft">标题:</td>
					<td class="tdRight" colspan="3"><input type="text" required=true style="width:580px" class="easyui-textbox" id="title" name="title"  value="${workPhoto.title}" /></td>
					<td></td>
				</tr>		
				<tr>
					<td class="tdLeft">内容:</td>
					<td class="tdRight" colspan="4">
					    <script id="newsContent" name="newsContent" style="width: 99%; height: 200px;">
				
					    </script>	
					</td>
				</tr>
				<tr>
					<td class="tdLeft">附件:</td>
					<td class="tdRight" colspan="4">
						<div class="divFileList"></div>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<script>
		var id = "";
		var bjzt = "save";
		var dataUrl = "${ctx}/biz/fileinfo/";
		var editor = UE.getEditor('newsContent');
		$(function() {
        	editor.addListener('ready', function (e) {
				id = getParam("id");
				if (id != "") {
					bjzt = "update";
					//获取附件列表
					getFileListById();
				}	
			});
		});
		
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

		function uploadFile() {
			top.openDialog("附件上传", "${ctx}/sys/multifile/", "MultiFile", 950, 550, false);
		}
		
		function add() {
			$("#frmEdit").form("clear");
			$(".divFileList").empty();
			editor.setContent("");
		}
		function reset() {
			$("#frmEdit").form("reset");
			$(".divFileList").empty();
			editor.setContent("");
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