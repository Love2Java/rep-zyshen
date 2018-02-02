<%@ page contentType="text/html;charset=UTF-8"%>

<style>
.divFileList ul {
	height: 32px;
	line-height: 32px;
	border: 1px solid #ccc;
	margin: 3px 0 0 0;
	width: 580px;
	padding-left: 5px;
}

.divFileList li {
	margin-left: 5px;
}

.fileDel {
	float: right
}

.fileType, .fileName {
	float: left
}
</style>
<script>
var className="divFileList";

function uploadFile() {
	top.openDialog("附件上传", "${ctx}/sys/multifile/", "MultiFile", 950, 550, false);
}

	function appendFile(file) {
		var delButton = "<button class=\"layui-btn layui-btn-primary layui-btn-small\" style='border:0;margin:1px' onclick=\"removeFile(this)\">";
		delButton += "<li class=\"fa fa-trash-o\" ></li>&nbsp;删除</button>";
		var html = "<ul>";
		html += "<li class=\"fileType\">" + getFileIcon(file.lx)
				+ "</li>";
		html += "<li class=\"filePath\" style=\"display:none\">"
				+ file.tplj + "</li>";
		html += "<li class=\"fileType1\" style=\"display:none\" >"
				+ file.lx + "</li>";
		html += "<li class=\"fileId\" style=\"display:none\" >"
				+ file.autoId + "</li>";
		html += "<li class=\"fileLY\" style=\"display:none\" >"
				+ file.djly + "</li>";
		html += "<li class=\"fileName\"><a href=\"/downloadFile"+file.tplj+"\" target='_blank'>"
				+ file.tpmc + "</a></li>";
		html += "<li class=\"fileDel\">" + delButton + "</li>";
		html += "</ul>";

		$("."+className).append(html);	
	}
	function appendFileNoDel(file) {
		var delButton = "<button class=\"layui-btn layui-btn-primary layui-btn-small\" style='border:0;margin:1px' onclick=\"removeFile(this)\">";
		delButton += "<li class=\"fa fa-trash-o\" ></li>&nbsp;删除</button>";
		var html = "<ul>";
		html += "<li class=\"fileType\">" + getFileIcon(file.lx)
				+ "</li>";
		html += "<li class=\"filePath\" style=\"display:none\">"
				+ file.tplj + "</li>";
		html += "<li class=\"fileType1\" style=\"display:none\" >"
				+ file.lx + "</li>";
		html += "<li class=\"fileId\" style=\"display:none\" >"
				+ file.autoId + "</li>";
		html += "<li class=\"fileLY\" style=\"display:none\" >"
				+ file.djly + "</li>";
		html += "<li class=\"fileName\"><a href=\"/downloadFile"+file.tplj+"\" target='_blank'>"
				+ file.tpmc + "</a></li>";
		html += "</ul>";

		$("."+className).append(html);	
	}
	function removeFile(obj) {
		var o = $(obj).parent().parent();
		o.remove();
	}
	function getFileList() {
		var fileList = [];
		$(".divFileList").find("ul").each(function() {
			var path = $(this).find(".filePath").text();
			var type = $(this).find(".fileType1").text();
			var name = $(this).find(".fileName").text();
			var autoId = $(this).find(".fileId").text();
			var djly = $(this).find(".fileLY").text();
			fileList.push({
				tpmc : name,
				tplj : path,
				lx : type,
				autoId: autoId,
				djly: djly
			});
		});
		return fileList;
	}
	function getFileList1(divClass,nrlx) {
		var fileList = [];
		$("."+divClass).find("ul").each(function() {
			var path = $(this).find(".filePath").text();
			var type = $(this).find(".fileType1").text();
			var name = $(this).find(".fileName").text();
			var autoId = $(this).find(".fileId").text();
			var djly = $(this).find(".fileLY").text();
			fileList.push({
				tpmc : name,
				tplj : path,
				lx : type,
				autoId: autoId,
				djly: djly,
				nrlx: nrlx
			});
		});
		return fileList;
	}
	function getFileIcon(type) {
		if (type == "txt") {
			return "<span class=\"fa fa-file-text-o\"></span>";
		} else if (type == "doc" || type == "docx") {
			return "<span class=\"fa fa-file-word-o\"></span>";
		} else if (type == "xls" || type == "xlsx") {
			return "<span class=\"fa fa-file-excel-o\"></span>";
		} else if (type == "zip" || type == "rar") {
			return "<span class=\"fa fa-file-zip-o\"></span>";
		} else if (type == "ppt" || type == "pptx") {
			return "<span class=\"fa fa-file-powerpoint-o\"></span>";
		} else if (type == "pdf") {
			return "<span class=\"fa fa-file-pdf-o\"></span>";
		} else {
			return "<span class=\"fa fa-file-image-o\"></span>";
		}
	}
</script>