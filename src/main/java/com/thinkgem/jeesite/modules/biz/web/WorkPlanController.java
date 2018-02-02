/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.biz.web;

import java.util.List;

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
import com.thinkgem.jeesite.modules.biz.entity.WorkPlan;
import com.thinkgem.jeesite.modules.biz.service.WorkPlanService;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 工作计划Controller
 * @author ThinkGem
 * @version 2017-12-28
 */
@Controller
@RequestMapping(value = "${adminPath}/biz/workplan")
public class WorkPlanController extends BaseController {

	@Autowired
	private WorkPlanService workPlanService;
	
	@ModelAttribute("workplan")
	public WorkPlan get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return workPlanService.get(id);
		}else{
			return new WorkPlan();
		}
	}
	
	//跳转至则工作计划页面
	@RequestMapping(value = {"list", ""})
	public String list(WorkPlan workPlan, Model model) {
		
		User user = UserUtils.getUser();
		model.addAttribute("user", user);
		
		return "modules/biz/workplan";
	}
	
	//获取工作计划列表
	@ResponseBody
	@RequestMapping(value = "datagrid")
	public DataGrid datagrid(PageHelper pageHelper) {
		
		//del_flag=0，获取当前登录的用户Id
		WorkPlan workPlan = new WorkPlan();
		User user = UserUtils.getUser();
		if(null != user && !"".equals(user.getId())) {
			//判断是否是系统管理员
			if(user.isAdmin()) {
				//取所有
			}else {
				workPlan.setRyId(user.getId());//当前用户
			}
		}
		
		List<WorkPlan> list = workPlanService.getWorkPlanList(pageHelper.getPage(), pageHelper.getRows(), workPlan);
		//对工作计划中涉及的文件路径进行拼接
		
		
		int total = workPlanService.getWorkPlanListCount(workPlan);
		
		DataGrid dataGrid = new DataGrid();
		dataGrid.setRows(0 == total ? "" : list);//空的时候返回""
		dataGrid.setTotal(total);
		
		return dataGrid;
	}
	
	//跳转至工作计划表单
	@RequestMapping(value = "form")
	public String form(WorkPlan workPlan, Model model) {
		
		WorkPlan wp = new WorkPlan();
		//判断新增还是编辑
		if(StringUtils.isNotBlank(workPlan.getId())) {
			wp = workPlanService.get(workPlan.getId());
			model.addAttribute("workPlan", wp);
		}
		
		return "modules/biz/workplanForm";
	}
	
	//获取工作计划详情
	@ResponseBody
	@RequestMapping(value = "/getFileListById")
	public WorkPlan getFileListById(String id) {
		
		WorkPlan wps = workPlanService.get(id);
		
		if(null != wps) {
			//取文件列表的数据
			List<UploadFileInfo> fileList = workPlanService.getFileListById(wps.getId());
			if(null != fileList && fileList.size() > 0) {
				wps.setFileList(fileList);
			}
		}
		
		return wps;
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
		WorkPlan workPlan = (WorkPlan) JsonMapper.getInstance().fromJsonString(item, WorkPlan.class);
		
		//新增编辑之前先删除文件列表中的文件
		if(StringUtils.isNotBlank(workPlan.getId())) {
			workPlanService.deleteFileList(workPlan.getId());
		}else {
			//新增时加上来源PC，编辑的话不修改来源
			workPlan.setDjly("PC");
		}
		
		User user = UserUtils.getUser();
		if(null != user && !"".equals(user.getId())) {
			workPlan.setRyId(user.getId());
		}
		
		workPlanService.save(workPlan);//存工作计划表基础内容
		//执行新增文件存储操作
		if(null != workPlan.getFileList() && workPlan.getFileList().size() > 0) {
			workPlanService.insertFileList(workPlan);
		}
		
		addMessage(redirectAttributes, "保存工作计划成功");
		
		json.setSuccess(true);
		json.setMsg("保存工作计划成功");
		
		return json;
	}
	
	//删除
	@ResponseBody
	@RequestMapping(value = "delete")
	public Json delete(WorkPlan workPlan, String ids, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		String planIds[] = ids.split(",");
		for(String item : planIds) {
			WorkPlan e = new WorkPlan(item);
			workPlanService.delete(e);
			//同时删除图片路径表中对应的数据
			workPlanService.deleteFileList(item);
		}
		
		json.setSuccess(true);
		json.setMsg("删除工作计划成功");
		
		return json;
	}
	
}
