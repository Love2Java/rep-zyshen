/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.biz.web;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.datatype.DataGrid;
import com.thinkgem.jeesite.common.datatype.Json;
import com.thinkgem.jeesite.common.datatype.PageHelper;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.biz.entity.WorkPhoto;
import com.thinkgem.jeesite.modules.biz.service.WorkPhotoService;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 文件通知Controller
 * @author ThinkGem
 * @version 2018-01-04
 */
@Controller
@RequestMapping(value = "${adminPath}/biz/fileinfo")
public class FileInfoController extends BaseController {
	
	@Autowired
	private WorkPhotoService workPhotoService;
	
	//跳转至文件通知页面
	@RequestMapping(value = {"list", ""})
	public String list(Model model) {
		
		return "modules/biz/fileinfo";
	}
	
	//跳转至文件通知表单
	@RequestMapping(value = "form")
	public String form(WorkPhoto workPhoto, Model model) {

		WorkPhoto wp = new WorkPhoto();
		//判断新增还是编辑
		if(StringUtils.isNotBlank(workPhoto.getId())) {
			wp = workPhotoService.get(workPhoto.getId());
			model.addAttribute("workPhoto", wp);
		}
		
		return "modules/biz/fileinfoForm";
	}
	//获取文件通知记录列表
	@ResponseBody
	@RequestMapping(value = "datagrid")
	public DataGrid datagrid(String type, String description, PageHelper pageHelper) {
		
		WorkPhoto workPhoto = new WorkPhoto();
		
		DataGrid dataGrid = new DataGrid();
		
		//获取当前登录的用户Id
		User user = UserUtils.getUser();
		if(null != user && !"".equals(user.getId())) {
			//判断是否是系统管理员
			if(user.isAdmin()) {
				//取所有
			}else {
				workPhoto.setPublisher(user.getId());
			}
		}
		//取工作掠影classId（取工作掠影以外的所有类型）
		String classId = DictUtils.getDictValue("工作掠影", "base_file_type", "4");//默认4
		//判断查询条件
		if(null == type || "".equals(type)) {
			//取所有记录，过滤工作掠影
			workPhoto.setClassId(classId);
			workPhoto.setTitle(description);//标题描述
			
			List<WorkPhoto> list = workPhotoService.getFileInfoList(pageHelper.getPage(), pageHelper.getRows(), workPhoto);
			int total = workPhotoService.getFileInfoListCount(workPhoto);
			
			dataGrid.setRows(0 == total ? "" : list);//空的时候返回""
			dataGrid.setTotal(total);
		}else {
			workPhoto.setClassId(type);//取这个类型的记录
			workPhoto.setTitle(description);//标题描述
			
			List<WorkPhoto> list = workPhotoService.getFileInfoListByType(pageHelper.getPage(), pageHelper.getRows(), workPhoto);
			int total = workPhotoService.getFileInfoListCountByType(workPhoto);
			
			dataGrid.setRows(0 == total ? "" : list);//空的时候返回""
			dataGrid.setTotal(total);
		}
		
		return dataGrid;
	}
	
	//获取文件通知详情
	@ResponseBody
	@RequestMapping(value = "/getFileListById")
	public WorkPhoto getFileListById(String id) {
		
		WorkPhoto wp = workPhotoService.get(id);
		
		if(null != wp) {
			//取文件列表的数据
			List<UploadFileInfo> fileList = workPhotoService.getFileListById(wp.getId());
			if(null != fileList && fileList.size() > 0) {
				wp.setFileList(fileList);
			}
		}
		
		return wp;
	}
	
	//新增或编辑
	@ResponseBody
	@RequestMapping(value = "save")
	public Json save(@RequestBody String item, Model model, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		@SuppressWarnings("static-access")
		WorkPhoto workPhoto = (WorkPhoto) JsonMapper.getInstance().fromJsonString(item, WorkPhoto.class);
		
		User user = UserUtils.getUser();
		//新增编辑之前先删除文件列表中的文件
		if(StringUtils.isNotBlank(workPhoto.getId())) {
			
			workPhotoService.deleteFileList(workPhoto.getId());
		}else {
			//新增
			if(null != user && !"".equals(user.getId())) {
				workPhoto.setPublisher(user.getId());
			}
			workPhoto.setReleaseDate(new Date());
			workPhoto.setDjly("PC");
		}
		
		workPhotoService.save(workPhoto);
		//执行新增文件存储操作
		if(null != workPhoto.getFileList() && workPhoto.getFileList().size() > 0) {
			workPhotoService.insertFileList(workPhoto);
		}
		
		addMessage(redirectAttributes, "保存文件通知成功");
		
		json.setSuccess(true);
		json.setMsg("保存文件通知成功");
		
		return json;
	}
	
	//删除
	@ResponseBody
	@RequestMapping(value = "delete")
	public Json delete(WorkPhoto workPhoto, String ids, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		String photoIds[] = ids.split(",");
		for(String item : photoIds) {
			WorkPhoto e = workPhotoService.get(item);
			workPhotoService.delete(e);
			//同时删除图片路径表中对应的数据
			workPhotoService.deleteFileList(item);
			json.setSuccess(true);
			json.setMsg("删除文件通知成功");
		}
		
		return json;
	}
}
