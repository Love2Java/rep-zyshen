<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/include.html"%>
 <%@ include file="/WEB-INF/views/include/ueditor.html"%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
input, select {
	width: 140px;
}

.textbox-label {
	background: #ffffff;
	border: 0;
	height: 25px;
	line-height: 25px;
	width: 80px;
	text-align: right;
}

.tdLeft {
	width: 100px;
	text-align: right;
}

.tdRight {
	width: 140px;
	text-align: left;
}
.tbEdit {
width:100%
}
.tbEdit td {
	padding: 10px;
	border-bottom: 1px dashed #cccccc
}
</style>

<body class=' easyui-layout  '  border=false>
	<div region="north"  border=false  style="margin:10px;">
	<div class="layui-btn-group">
		<button class="layui-btn layui-btn-primary layui-btn-small"
			onclick="close1()">
			<li class="fa fa-window-close"></li>&nbsp;关闭
		</button>
		<button class="layui-btn layui-btn-primary layui-btn-small" onclick="save()">
			<li class="fa fa-save"></li>&nbsp;保存
		</button>
	</div>
	</div>
	<div region="center" fixed=true border=false>
	<form id="frmEdit" method="post">
		<input type="hidden" id="id" name="id" value="${workRectify.id}" />
		<table class="tbEdit" cellpadding="0" cellspacing="2">
			<tr>
				<td class="tdLeft">编号:</td>
				<td class="tdRight"><input class="easyui-textbox" name="djbh"
					editable=false id="djbh"  value="${workRectify.djbh}"   /></td>
				<td class="tdLeft">整改期限(天):
				</td>
				<td class="tdRight"><input type="text" id="xqsj" name="xqsj"
					class="easyui-numberbox" min=0 required="true" precision=0  value="${workRectify.xqsj}"></td>
				<td></td>
			</tr>
			<tr>
				<td class="tdLeft">学校名称:</td>
				<td class="tdRight" colspan="3"><input style="width:500px"   value="${workRectify.xxmc}" name="xxmc" class="easyui-textbox" 
					editable=false id="xxmc" /></td>
				
				<td></td>
			</tr>
			<tr>
				<td class="tdLeft">标题:</td>
				<td class="tdRight" colspan="3"><input style="width:500px"   value="${workRectify.bt}"  class="easyui-textbox" name="bt"
					editable=false id="bt"  /></td>
				
				<td></td>
			</tr>
			<tr>
				<td class="tdLeft">问题描述:</td>
				<td class="tdRight" colspan="4">
					<script id="zgnr" name="zgnr" style="width: 99%; height: 200px;"  >
					${workRectify.zgnr}
			
					</script>
				</td>
			</tr>
		</table>
	</form>
	</div>
	<script type="text/javascript">
		var dataUrl = "${ctx}/biz/rectify/";
		//ueditor 建议按如下方式使用 99、101、102行   ，ueditor初始化方式为异步
		var editor;		 
	        $(function(){ 
	        	editor = UE.getEditor('zgnr');
	        	editor.addListener('ready', function (e) {
	            	var html=editor.getContent();
	            	html=html.replaceAll("&gt;",">");
	            	html=html.replaceAll("&lt;","<");
	            	html=html.replaceAll("&quot;/","");
	            	html=html.replaceAll("&quot;","");
	            	editor.setContent(html);
	        	});
	        })
		function save() {
			if (!$("#frmEdit").form('validate')) {
				return;
			}
			$.post(dataUrl + "save", $("#frmEdit").serialize(), function(data) {
				if (data.success) {
					currentPage().hideFloatEditDiv();
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