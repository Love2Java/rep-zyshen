/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.web;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;

/**
 * 文件上传Controller
 * 
 * @author ThinkGem
 * @version 2017-12-30
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/multifile")
public class FileUploadController {

	@RequestMapping(value = "")
	public String multifile(Model model) {
		return "modules/sys/multiFile";
	}

	@RequestMapping("upload")
	@ResponseBody
	public UploadFileInfo uploads(@RequestParam("file") MultipartFile[] files, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		//获取文件上传路径
		String uploadUrl = Global.getConfig("upload_url") + "\\";
		
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
		try {
			String[] fileNames = new String[files.length];
			int index = 0;
			for (MultipartFile file : files) {
				String suffix = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
				int length = ".rar,.zip,.doc,.xls,.docx,.xlsx,.pdf,.jpg,.jpeg,.png,.gif,.txt,.ppt,.pptx".indexOf(suffix.toLowerCase());
				if (length == -1) {
					throw new Exception("请上传允许格式的文件");
				}
				if (file.getSize() > 5 * 1024 * 1024) {
					throw new Exception("您上传的文件大小已经超出范围");
				}
				SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
				String destDir = "upload/" + sdf2.format(new Date());
				//String realPath = request.getSession().getServletContext().getRealPath("/");
				File destFile = new File(uploadUrl + sdf2.format(new Date()));
				if (!destFile.exists()) {
					destFile.mkdirs();
				}
				String fileNameNew = System.currentTimeMillis() + "." + suffix;//
				File f = new File(destFile.getAbsoluteFile() + "\\" + fileNameNew);
				file.transferTo(f);
				f.createNewFile();
				fileNames[index++] = basePath + destDir + fileNameNew;

				UploadFileInfo fileInfo = new UploadFileInfo();
				fileInfo.setAutoId(IdGen.uuid());
				fileInfo.setDjly("PC");//来源
				fileInfo.setTpmc(file.getOriginalFilename());
				fileInfo.setTplj("/"+destDir + "/" + fileNameNew);
				fileInfo.setFileSize(file.getSize());
				fileInfo.setLx(suffix);
				return fileInfo;
			}
		} catch (Exception e) {
			throw e;
		}

		return null;

	}
}

