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

.divDdzynr ul,.divGzcj ul,.divBxqk ul,.divCzwt ul,.divYjjy ul{
	clear:both;
	height: 32px;
	line-height: 32px;
	border: 1px solid #ccc;
	margin: 3px 0 0 0;
	width: 580px;
	padding-left: 5px;
}


.divDdzynr ul,.divBxqk ul,.divYjjy ul{
	background: #f0f0f0
}


.divDdzynr ul .layui-btn,.divBxqk ul .layui-btn,.divYjjy ul .layui-btn{
	background: #f0f0f0
}
.divDdzynr li,.divGzcj li,.divBxqk li,.divCzwt li,.divYjjy li{
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
		<button class="layui-btn layui-btn-primary layui-btn-small" onclick="sendTzs()">
			<li class="fa fa-send-o"></li>&nbsp;下发整改通知书
		</button>
	</div>
	</div>
	<div region="center" fixed=true border=false>
		<form id="frmEdit" method="post">
			<input type="hidden" id="id" name="id" />
			<input type="hidden" id="djbh" name="djbh"  />
			<table class="tbEdit" cellpadding="0" cellspacing="2">
				<tr>
					<td class="tdLeft">日期:</td>
					<td class="tdRight"><input type="text" class="easyui-datebox"
						id="djrq" name="djrq"  required="true"
						editable=false /></td>
					<td class="tdLeft">类别:</td>
					<td class="tdRight"><input type="text" class="easyui-combobox"
						id="lb" name="lb"  required="true"
						editable=false /></td>
					<td></td>
				</tr>

				<tr>
					<td class="tdLeft">学校名称:</td>
					<td class="tdRight" colspan=3><input type="text"
						class="easyui-searchbox" searcher="showSchool"
						style="width: 580px" editable=false required=true id="xxmc"
						name="xxmc"  /> <input type="hidden"
						id="xxId" name="xxId"></td>

					<td></td>
				</tr>

				<tr style="background: #f0f0f0">
					<td class="tdLeft">督导主要内容:</td>

					<td class="tdRight" colspan=3><input type="text"
						class="easyui-textbox" id="ddzynr" multiline=true name="ddzynr"
						style='width: 580px; height: 100px'  />

						<div class="layui-btn layui-btn-primary layui-btn-small" onclick="uploadFile1('divDdzynr')"
							style='margin-top: 5px'>
							<li class="fa fa-upload"></li>&nbsp;上传附件
						</div>
						<div class="divDdzynr"></div>
						</td>
					<td></td>
				</tr>
				<tr >
					<td class="tdLeft">学校近期:<br />重点工作及成绩&nbsp;</td>

					<td class="tdRight" colspan=3><input type="text"
						class="easyui-textbox" id="gzcj" multiline=true name="gzcj"
						style='width: 580px; height: 100px' />
						<div class="layui-btn layui-btn-primary layui-btn-small" onclick="uploadFile1('divGzcj')"
							style='margin-top: 5px'>
							<li class="fa fa-upload"></li>&nbsp;上传附件
						</div>
						<div class="divGzcj"></div>
						</td>
					<td></td>
				</tr>
				<tr style="background: #f0f0f0">
					<td class="tdLeft">学校规范办学情况:</td>

					<td class="tdRight" colspan=3><input type="text"
						class="easyui-textbox" id="bxqk" multiline=true name="bxqk"
						style='width: 580px; height: 100px'  />

						<div class="layui-btn layui-btn-primary layui-btn-small" onclick="uploadFile1('divBxqk')"
							style='margin-top: 5px'>
							<li class="fa fa-upload"></li>&nbsp;上传附件
						</div>						
						<div class="divBxqk"></div>
						</td>
					<td></td>
				</tr>
				<tr >
					<td class="tdLeft">存在问题、困难及:<br />处理情况&nbsp;</td>
					<td class="tdRight" colspan=3>
					问题关键字:<input type="text" class="easyui-searchbox"
						id="wtgjz" name="wtgjz"  searcher=showGjz  
						editable=false style="width:506px" />
					<div style="height:5px">&nbsp;</div>
					<input type="text" 
						class="easyui-textbox" id="czwt" multiline=true name="czwt"
						style='width: 580px; height: 100px;margin-top: 10px'  />

						<div class="layui-btn layui-btn-primary layui-btn-small" onclick="uploadFile1('divCzwt')"
							style='margin-top: 5px'>
							<li class="fa fa-upload"></li>&nbsp;上传附件
						</div>						
						<div class="divCzwt"></div> 
						</td>
					<td></td>
				</tr>
				<tr style="background: #f0f0f0">
					<td class="tdLeft" >对学校的意见:<br />及建议&nbsp;</td>

					<td class="tdRight" colspan=3><input type="text"
						class="easyui-textbox" id="yjjy" multiline=true name="yjjy"
						style='width: 580px; height: 100px'  />

						<div class="layui-btn layui-btn-primary layui-btn-small" onclick="uploadFile1('divYjjy')"
							style='margin-top: 5px'>
							<li class="fa fa-upload"></li>&nbsp;上传附件
						</div>						
						<div class="divYjjy"></div>
						</td>
					<td></td>
				</tr>
			</table>
		</form>
	</div>

	<script>
		var id = "";
		var bjzt = "save";
		var dataUrl = "${ctx}/biz/workrecord/";

		$(function() {
			id = getParam("id");

			$("#lb").combobox({
				data : [ {
					text : "随机"
				}, {
					text : "专项"
				}, {
					text : "综合"
				} ],
				valueField : "text",
				textField : "text"
			});

			if (id != "") {
				bjzt = "update";
				//获取附件列表
				getFileListById();
			}
			
		});
		
		function showGjz(){
			top.openDialog("选择工作内容", "${ctx}/base/job/dialog", "JobDialog", 	950, 550, false);
		}
		function setJobContent(rows){
			var gjz="";
			$.each(rows,function(idx,row){
				gjz+=row.gjz+",";
			});
			if(gjz!="") gjz=gjz.substring(0,gjz.length-1);
			$("#wtgjz").searchbox("setValue",gjz);
		}
		function getFileListById(){
			$.get(dataUrl+"getFileListById",{id:id},function(data){

				//return;
				data.djrq=dgDate(data.djrq,"","");
				$("#frmEdit").form("load",data);
				if(!data.fileList) data.fileList=[];
 				 $.each(data.fileList, function(index, file) {
 					if("ddzynr" == file.nrlx) {
						className="divDdzynr";
						appendFile(file);
					}
				 	if("gzcj" == file.nrlx) {
						className="divGzcj";
						appendFile(file);
					}
					if("bxqk" == file.nrlx) {
						className="divBxqk";
						appendFile(file);
					}
					if("czwt" == file.nrlx) {
						className="divCzwt";
						appendFile(file);
					}
					if("yjjy" == file.nrlx) {
						className="divYjjy";
						appendFile(file);
					} 
				}); 
				
			},"json");
		}
		
		function sendTzs(){
			//下发通知书必须填写问题关键字
			if("" == $("#wtgjz").val()) {
				showMsg("请选择问题关键字再进行整改通知书下发操作！");
			}else {
				save(function(zdId){
					top.openEditDlg("问题整改通知书", "${ctx}/biz/workrecord/sendRectify?id="+zdId, 950, 550);
				});
			}
		}
		function uploadFile1(name){
			className=name;
			uploadFile();
		}
		function showSchool() {
			top.openDialog("选择学校", "${ctx}/base/school/dialog?flag=1", "ShoolDialog", 	950, 550, false);
		}
		function setSchool(rows) {
			$("#xxId").val(rows[0].id);
			$("#xxmc").searchbox("setValue", rows[0].xxmc);
		}
		function add() {
			$("#frmEdit").form("clear");
			$(".divDdzynr").empty();
			$(".divGzcj").empty();
			$(".divBxqk").empty();
			$(".divCzwt").empty();
			$(".divYjjy").empty();
		}

		function reset() {
			$("#frmEdit").form("reset");
			$(".divDdzynr").empty();
			$(".divGzcj").empty();
			$(".divBxqk").empty();
			$(".divCzwt").empty();
			$(".divYjjy").empty();
		}
		function save(cb) {
			if (!$("#frmEdit").form('validate')) {
				return;
			}
			
			var data = $("#frmEdit").serializeObject();
			
			var fileList=[];
			var f=getFileList1('divDdzynr','ddzynr');
			$.each(f,function(idx,data){
				fileList.push(data);
			});

			f=getFileList1('divGzcj','gzcj');
			$.each(f,function(idx,data){
				fileList.push(data);
			});
			
			f=getFileList1('divBxqk','bxqk');
			$.each(f,function(idx,data){
				fileList.push(data);
			});
			
			f=getFileList1('divCzwt','czwt');
			$.each(f,function(idx,data){
				fileList.push(data);
			});
			
			f=getFileList1('divYjjy','yjjy');
			$.each(f,function(idx,data){
				fileList.push(data);
			});
			data.fileList=fileList;
			
			postJson(dataUrl + "save", data, function(data) {
				if (data.success) {
				 	if(cb){
				 		//保存返回zbId，传递至整改通知书页面
				 		$("#id").val(data.msg2);//id赋值，下次操作-保存而不是新增
						cb(data.msg2);
					} 
				 	else{
						if (bjzt == "save") {
							add();
						} else {
							currentPage().hideFloatEditDiv();
						}
						showMsg(data.msg);
						currentPage().reload();
				 	}
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