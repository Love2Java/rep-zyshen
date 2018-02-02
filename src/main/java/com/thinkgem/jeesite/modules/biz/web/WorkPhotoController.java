/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.biz.web;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
 * 工作掠影Controller
 * @author ThinkGem
 * @version 2017-12-30
 */
@Controller
@RequestMapping(value = "${adminPath}/biz/workphoto")
public class WorkPhotoController extends BaseController {

	@Autowired
	private WorkPhotoService workPhotoService;
	
	@ModelAttribute("workphoto")
	public WorkPhoto get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return workPhotoService.get(id);
		}else{
			return new WorkPhoto();
		}
	}
	
	//跳转至则工作掠影页面
	@RequestMapping(value = {"list", ""})
	public String list(WorkPhoto workPhoto, Model model) {
		
		User user = UserUtils.getUser();
		model.addAttribute("user", user);
		
		return "modules/biz/workphoto";
	}
	
	//获取工作掠影列表
	@ResponseBody
	@RequestMapping(value = "datagrid")
	public DataGrid datagrid(HttpServletRequest request, PageHelper pageHelper) {
		
		//del_flag=0
		WorkPhoto workPhoto = new WorkPhoto();
		//判断审核状态
		String shzt = request.getParameter("shzt");
		if(null != shzt && !"".equals(shzt)) {
			//0:未审核，1：已审核
			workPhoto.setStates(shzt);
		}
		//获取当前登录的用户Id
		User user = UserUtils.getUser();
		if(null != user && !"".equals(user.getId())) {
			//判断是否是系统管理员
			if(user.isAdmin()) {
				//取所有
			}else {
				workPhoto.setPublisher(user.getId());//当前用户
			}
		}
		//取工作掠影classId
		String classId = DictUtils.getDictValue("工作掠影", "base_file_type", "4");//默认4
		workPhoto.setClassId(classId);
		
		List<WorkPhoto> list = workPhotoService.getWorkPhotoList(pageHelper.getPage(), pageHelper.getRows(), workPhoto);
		
		int total = workPhotoService.getWorkPhotoListCount(workPhoto);
		
		DataGrid dataGrid = new DataGrid();
		dataGrid.setRows(0 == total ? "" : list);//空的时候返回""
		dataGrid.setTotal(total);
		
		return dataGrid;
	}
	
	//跳转至工作掠影表单
	@RequestMapping(value = "form")
	public String form(WorkPhoto workPhoto, Model model) {
		
		WorkPhoto wp = new WorkPhoto();
		//判断新增还是编辑
		if(StringUtils.isNotBlank(workPhoto.getId())) {
			wp = workPhotoService.get(workPhoto.getId());
			model.addAttribute("workPhoto", wp);
		}
		
		return "modules/biz/workphotoForm";
	}
	
	//获取工作掠影详情
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
			//获取工作掠影classId
			String classId = DictUtils.getDictValue("工作掠影", "base_file_type", "4");//默认4
			workPhoto.setClassId(classId);
			//新增时加上来源PC，编辑的话不修改来源
			workPhoto.setDjly("PC");
		}
		workPhoto.setCheckId(null == user ? "" : user.getId());
		workPhoto.setCheckDate(new Date());
		workPhoto.setStates("1");//PC端直接审核通过
		
		workPhotoService.save(workPhoto);
		//执行新增文件存储操作
		if(null != workPhoto.getFileList() && workPhoto.getFileList().size() > 0) {
			workPhotoService.insertFileList(workPhoto);
		}
		
		addMessage(redirectAttributes, "保存工作掠影成功");
		
		json.setSuccess(true);
		json.setMsg("保存工作掠影成功");
		
		return json;
	}
	
	//审核
	@ResponseBody
	@RequestMapping(value = "check")
	public Json check(String ids, String states, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		User user = UserUtils.getUser();
		String userId = "";
		if(null != user && !"".equals(user.getId())) {
			userId = user.getId();
		}
		
		String photoIds[] = ids.split(",");
		if("1".equals(states)) {
			//审核操作
			for(String item : photoIds) {
				WorkPhoto e = workPhotoService.get(item);
				if(null == e || "1".equals(e.getStates())) {
					
				}else {
					e.setCheckId(userId);
					e.setCheckDate(new Date());
					e.setStates(states);
					workPhotoService.updateStates(e);
				}
			}
			json.setSuccess(true);
			json.setMsg("审核成功");
		}else {
			//弃核操作
			for(String item : photoIds) {
				WorkPhoto e = new WorkPhoto(item);
				e.setCheckId("");
				e.setCheckDate(null);
				e.setStates(states);
				workPhotoService.updateStates(e);
			}
			json.setSuccess(true);
			json.setMsg("弃核成功");
		}
		
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
			if(null == e || "1".equals(e.getStates())) {
				json.setSuccess(false);
				json.setMsg("已审核的记录无法删除，请先弃核！");
			}else {
				workPhotoService.delete(e);
				//同时删除图片路径表中对应的数据
				workPhotoService.deleteFileList(item);
				json.setSuccess(true);
				json.setMsg("删除工作掠影成功");
			}
		}
		
		return json;
	}
	
}
