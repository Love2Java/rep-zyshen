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
	width: 140px;
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

.divPjjl ul{
	clear:both;
	height: 32px;
	line-height: 32px;
	border: 1px solid #ccc;
	margin: 3px 0 0 0;
	width: 580px;
	padding-left: 5px;
}


.divPjjl li{
	margin-left: 5px;
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
		<input type="hidden" id="dqzt" name="dqzt" value="${workRectify.dqzt}" />
		<input type="hidden" id="xqsj" name="xqsj" value="${workRectify.xqsj}" />
		<table class="tbEdit" cellpadding="0" cellspacing="2">
			<tr>
				<td class="tdLeft">日期:</td>
				<td class="tdRight" id="tdRq"><fmt:formatDate value="${workRectify.xdrq}" pattern="yyyy-MM-dd"/></td>
				<td class="tdLeft">学校:
				</td>
				<td class="tdRight"  id="tdXx">${workRectify.xxmc}</td>
				<td></td>
			</tr>
			<tr style="background: #f0f0f0">
				<td class="tdLeft">问题描述:</td>
				<td class="tdRight" colspan="4" id="zgnr" >${workRectify.zgnr}
				</td>
			</tr>
			<tr >
					<td class="tdLeft">学校整改计划:</td>

					<td class="tdRight" colspan=3>${workRectify.xxzgjh}
						<div class="divXxzgjh"></div>
						</td>
					<td></td>
				</tr>
				<tr style="background: #f0f0f0">
					<td class="tdLeft">回访记录:</td>

					<td class="tdRight" colspan=3>${workRectify.hfjl}			
						<div class="divHfjl"></div>
						</td>
					<td></td>
				</tr>
				<tr >
					<td class="tdLeft">学校整改情况汇报:<br >（整改报告、过程性材料）</td>
					<td class="tdRight" colspan=3>${workRectify.zgbg}
						<div class="divZgbg"></div> 
						</td>
					<td></td>
				</tr><tr >
					<td class="tdLeft">评价：</td>
					<td class="tdRight" colspan=3>
					<input type="text" 
						class="easyui-textbox" id="pjjl" multiline=true name="pjjl"
						style='width: 580px; height: 100px;margin-top: 10px'  />

						<div class="layui-btn layui-btn-primary layui-btn-small" onclick="uploadFile1('divPjjl')"
							style='margin-top: 5px'>
							<li class="fa fa-upload"></li>&nbsp;上传附件
						</div>						
						<div class="divPjjl"></div> 
						</td>
					<td></td>
					</tr>
			
		</table>
	</form>
	</div>
	<script type="text/javascript">
		var dataUrl = "${ctx}/biz/rectify/";
		$(function(){
			//下述代码仅做演示,ajax取数成功后可能会用到
			var html=$("#zgnr").html();
			html=html.replaceAll("&gt;",">");
        	html=html.replaceAll("&lt;","<");
        	html=html.replaceAll("&quot;/","");
        	html=html.replaceAll("&quot;","");
        	$("#zgnr").html(html);
        	//此处需要加载已经提交过的整改记录（三大项）
        	getFileListById();
		});
		
		function getFileListById(){
			$.get(dataUrl+"getFileListById",{id:'${workRectify.id}'},function(data){

				if(!data.fileList) data.fileList=[];
 				 $.each(data.fileList, function(index, file) {
 					if("xxzgjh" == file.nrlx) {
						className="divXxzgjh";
						appendFileNoDel(file);
					}
				 	if("hfjl" == file.nrlx) {
						className="divHfjl";
						appendFileNoDel(file);
					}
					if("zgbg" == file.nrlx) {
						className="divZgbg";
						appendFileNoDel(file);
					}
				}); 
				
			},"json");
		}
		
		function uploadFile1(name){
			className=name;
			uploadFile();
		}
		
		function save() {
			if (!$("#frmEdit").form('validate')) {
				return;
			}
			//此处判断状态，传入后台
			$("#dqzt").val("4");
			var data = $("#frmEdit").serializeObject();
			
			var fileList=[];
			var f=getFileList1('divPjjl','pjjl');
			$.each(f,function(idx,data){
				fileList.push(data);
			});
			
			data.fileList=fileList;
			//alert(JSON.stringify(data));
			postJson(dataUrl + "pjRectifySave", data, function(data) {
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