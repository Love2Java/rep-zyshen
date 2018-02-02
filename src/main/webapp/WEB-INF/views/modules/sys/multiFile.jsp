<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/webUploader.html"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script>
 var GUID = WebUploader.Base.guid();//一个GUID
        var files = [];
        $(function () {
            initUpload();
        })
        //初始化上传控件
        function initUpload() {
            var $ = jQuery;
            var $list = $('#thelist');
            var uploader = WebUploader.create({

                // 选完文件后，是否自动上传。
                auto: false,
                // swf文件路径
                swf: '${ctxContent}/tools/webUploader/Uploader.swf',

                // 文件接收服务端。
                server: '${ctx}/sys/multifile/upload',

                // 选择文件的按钮。可选。
                // 内部根据当前运行是创建，可能是input元素，也可能是flash.
                pick: '#picker',
                fileNumLimit: 200,
                chunked: false,//开始分片上传
                chunkSize: 2048000,//每一片的大小
                fileSingleSizeLimit: 5 * 1024 * 1024,   //设定单个文件大小
                formData: {
                    guid: GUID //自定义参数，待会儿解释
                },

                resize: false,
                accept: {
                    title: 'intoTypes',
                    extensions: 'rar,zip,doc,xls,docx,xlsx,pdf,jpg,jpeg,png,gif,txt,ppt,pptx',
                    mimeTypes: '.rar,.zip,.doc,.xls,.docx,.xlsx,.pdf,.jpg,.jpeg,.png,.gif,.txt,.ppt,.pptx'
                }

            });
            // 当有文件被添加进队列的时候
            uploader.on('fileQueued', function (file) {
                $list.append('<li id="' + file.id + '" class="list-group-item">' +
                    '<span class="fileName" dataValue="">' + file.name + '</span>' +
                    '<span class="state"  style=\" margin-left: 10px;\">等待上传</span>' +
                    '<span class="filepath" dataValue="0" style=\" margin-left: 10px;display: none;\"></span>' +
                    '<span class="download" style="margin-left:20px;"></span>' +
                    '<span class="webuploadDelbtn"style=\"float: right; \">删除<span>' +
                '</li>');
            });
            // 文件上传过程中创建进度条实时显示。
            uploader.on('uploadProgress', function (file, percentage) {
                var $li = $('#' + file.id),
            $percent = $li.find('.progress .progress-bar');

                // 避免重复创建
                if (!$percent.length) {
                    $percent = $('<div class="progress progress-striped active">' +
                      '<div class="progress-bar" role="progressbar" style="width: 0%">' +
                      '</div>' +
                    '</div>').appendTo($li).find('.progress-bar');
                }

                $li.find('span.state').text('上传中');

                $percent.css('width', percentage * 100 + '%');

            });

            // 文件上传成功，给item添加成功class, 用样式标记上传成功。
            uploader.on('uploadSuccess', function (file, response) {
                $( '#'+file.id ).addClass('upload-state-done');  
                $( '#'+file.id ).find('span.state').html("上传成功");
				currentPage().appendFile(response);
            });

            // 文件上传失败，显示上传出错。
            uploader.on('uploadError', function (file, reason) {
                $('#' + file.id).find('p.state').text(reason);
            });

            // 完成上传完了，成功或者失败，先删除进度条。
            uploader.on('uploadComplete', function (file) {
                $('#' + file.id).find('.progress').fadeOut();
            });

            //所有文件上传完毕
            uploader.on("uploadFinished", function (data) {
            	//
				closeEditDlg();
            });
            //开始上传
            $("#ctlBtn").click(function () {
                uploader.upload();

            });
            //删除
            $list.on("click", ".webuploadDelbtn", function () {
                debugger
                var $ele = $(this);
                var id = $ele.parent().attr("id");
                var file = uploader.getFile(id);

                uploader.removeFile(file);
                $ele.parent().remove();
                //移除数组
                var destFile = findFile(file.name)
                var index = files.indexOf(destFile);
                if (index > -1) {
                    files.splice(index, 1);
                }
            });
        }
        //查找目标文件
        function findFile(fileName) {
            if (files.length == 0) return;
            for (var i = 0; i < files.length; i++) {
                if (files[i].filename == fileName) {
                    return files[i];
                }
            }
        }
    </script>
</head>

<body style="padding:10px">

                    
<div id="uploader" class="wu-example">
        <!--用来存放文件信息-->
        <div class="btns">
            <div id="picker" style="float: left;">选择文件（不允许超过5M）</div>
            <input id="ctlBtn" type="button" value="开始上传" class="btn btn-default" style="width: 86px; height: 40px; margin-left: 10px;" />
        </div>
        <br />
        <ul id="thelist" class="list-group" style="max-height: 350px; overflow: auto"></ul>
        <div class="uploader-list"></div>
    </div>
</body>
</html>