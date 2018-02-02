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

<body border=false>
	<form id="frmEdit" method="post">
		<input type="hidden" id="id" name="id" value="" />
		<input type="hidden" id="zbId" name="zbId" />
		<input type="hidden" id="xxId" name="xxId"  />
		<input type="hidden" id="wtgjz" name="wtgjz"  />
		<table class="tbEdit" cellpadding="0" cellspacing="2">
			<tr>
				<td class="tdLeft">编号:</td>
				<td class="tdRight"><input class="easyui-textbox" name="djbh" editable=false id="djbh" /></td>
				<td class="tdLeft">整改期限(天):
				</td>
				<td class="tdRight"><input type="text" id="xqsj" name="xqsj" class="easyui-numberbox" min=0 required="true" precision=0></td>
				<td></td>
			</tr>
			<tr>
				<td class="tdLeft">学校名称:</td>
				<td class="tdRight" colspan="3"><input style="width:500px" class="easyui-textbox" name="xxmc" editable=false id="xxmc" /></td>
				<td></td>
			</tr>
			<tr>
				<td class="tdLeft">标题:</td>
				<td class="tdRight" colspan="3"><input style="width:500px" class="easyui-textbox" name="bt" editable=false id="bt"  /></td>
				<td></td>
			</tr>
			<tr>
				<td class="tdLeft">问题描述:</td>
				<td class="tdRight" colspan="4">
					<script id="zgnr" name="zgnr" style="width: 99%; height: 200px;">
				
					</script>	
				</td>
			</tr>
		</table>
	</form>
	<script type="text/javascript">
	    var dataUrl = "${ctx}/biz/workrecord/";

		var editor;
		var id=getParam("id");
		$(function(){
			editor = UE.getEditor('zgnr');
        	editor.addListener('ready', function (e) {
				getWorkRecord();
        	});
		})
		function getWorkRecord(){
			$.get("${ctx}/biz/workrecord/getFileListById",{id:id},function(data){
				//alert(JSON.stringify(data));
				$("#zbId").val(data.id);
				$("#xxId").val(data.xxId);
				$("#wtgjz").val(data.wtgjz);
				$("#djbh").textbox("setValue",data.djbh);
				$("#xxmc").textbox("setValue",data.xxmc);
				$("#bt").textbox("setValue","关于"+data.wtgjz+"的问题");
				var czwtImgs="";
				var czwt="";
				var czwtFiles="";
				
				var yjjyImgs="";
				var yjjy="";
				var yjjyFiles="";
				editor.setHeight(170);
				
				//拼接整改内容
				$.each(data.fileList,function(index,row){
					if(row.nrlx=="czwt"){
						if(("jpg,gif,png,jpeg").indexOf(row.lx)>=0){
							czwtImgs+="<p><img src="+ipAddress+"/downloadFile"+row.tplj+" style='max-width:400px' /></p>";
						}
						else{
							czwtFiles+="<p><a href="+ipAddress+"/downloadFile"+row.tplj+" target='_blank'>"+row.tpmc+"</a></p>";
						}
					}	
					else if(row.nrlx=="yjjy"){
						if(("jpg,gif,png,jpeg").indexOf(row.lx)>=0){
							yjjyImgs+="<p><img src="+ipAddress+"/downloadFile"+row.tplj+" style='max-width:400px' /></p>";
						}
						else{
							yjjyFiles+="<p><a href="+ipAddress+"/downloadFile"+row.tplj+" target='_blank'>"+row.tpmc+"</a></p>";
						}
					}
				});
				//判断是否存在附件
				if("" != czwtFiles) {
					czwtFiles = "附件："+czwtFiles;
				}
				if("" != yjjyFiles) {
					yjjyFiles = "附件："+yjjyFiles;
				}
				editor.setContent("");
				//判断内容是否为空
				if(typeof(data.czwt) != "undefined") {
					czwt="<p>存在问题:<br />"+czwtImgs+"</p><p>"+data.czwt.replaceAll("\r\n","<br>")+"</p><p>"+czwtFiles+"</p>";
				}else {
					czwt="<p>存在问题:<br />"+czwtImgs+"</p>";
				}
				if(typeof(data.yjjy) != "undefined") {
					yjjy="<hr><hr>意见建议:<br /><p>"+yjjyImgs+"</p><p>"+data.yjjy.replaceAll("\r\n","<br>")+"</p><p>"+yjjyFiles+"</p>";
				}else {
					yjjy="<hr><hr>意见建议:<br /><p>"+yjjyImgs+"</p>";
				}
				editor.setContent(czwt+yjjy);
			},"json");
		}
			
		function save() {
			if (!$("#frmEdit").form('validate')) {
				return;
			}
			$.post(dataUrl + "saveRectify", $("#frmEdit").serialize(), function(data) {
				if (data.success) {
					showMsg(data.msg);
					currentPage().reload();//刷新
					closeEditDlg();
				} else {
					showCryMsg(data.msg);
				}
			});
		}
	</script>

</body>