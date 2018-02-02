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
import com.thinkgem.jeesite.modules.biz.entity.WorkSum;
import com.thinkgem.jeesite.modules.biz.service.WorkSumService;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 工作总结Controller
 * @author ThinkGem
 * @version 2017-12-30
 */
@Controller
@RequestMapping(value = "${adminPath}/biz/worksum")
public class WorkSumController extends BaseController {

	@Autowired
	private WorkSumService workSumService;
	
	@ModelAttribute("workplan")
	public WorkSum get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return workSumService.get(id);
		}else{
			return new WorkSum();
		}
	}
	
	//跳转至则工作总结页面
	@RequestMapping(value = {"list", ""})
	public String list(WorkSum workSum, Model model) {
		
		User user = UserUtils.getUser();
		model.addAttribute("user", user);
		
		return "modules/biz/workSummary";
	}
	
	//获取工作总结列表
	@ResponseBody
	@RequestMapping(value = "datagrid")
	public DataGrid datagrid(PageHelper pageHelper) {
		
		//del_flag=0，获取当前登录的用户Id
		WorkSum workSum = new WorkSum();
		User user = UserUtils.getUser();
		if(null != user && !"".equals(user.getId())) {
			//判断是否是系统管理员
			if(user.isAdmin()) {
				//取所有
			}else {
				workSum.setRyId(user.getId());//当前用户
			}
		}
		
		List<WorkSum> list = workSumService.getWorkSumList(pageHelper.getPage(), pageHelper.getRows(), workSum);
		//对工作总结中涉及的文件路径进行拼接
		
		
		int total = workSumService.getWorkSumListCount(workSum);
		
		DataGrid dataGrid = new DataGrid();
		dataGrid.setRows(0 == total ? "" : list);//空的时候返回""
		dataGrid.setTotal(total);
		
		return dataGrid;
	}
	
	//跳转至工作总结表单
	@RequestMapping(value = "form")
	public String form(WorkSum workSum, Model model) {
		
		WorkSum ws = new WorkSum();
		//判断新增还是编辑
		if(StringUtils.isNotBlank(workSum.getId())) {
			ws = workSumService.get(workSum.getId());
			model.addAttribute("workSum", ws);
		}
		
		return "modules/biz/workSummaryForm";
	}
	
	//获取工作总结详情
	@ResponseBody
	@RequestMapping(value = "/getFileListById")
	public WorkSum getFileListById(String id) {
		
		WorkSum ws = workSumService.get(id);
		
		if(null != ws) {
			//取文件列表的数据
			List<UploadFileInfo> fileList = workSumService.getFileListById(ws.getId());
			if(null != fileList && fileList.size() > 0) {
				ws.setFileList(fileList);
			}
		}
		
		return ws;
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
		WorkSum workSum = (WorkSum) JsonMapper.getInstance().fromJsonString(item, WorkSum.class);
		
		//新增编辑之前先删除文件列表中的文件
		if(StringUtils.isNotBlank(workSum.getId())) {
			workSumService.deleteFileList(workSum.getId());
		}else {
			//新增时加上来源PC，编辑的话不修改来源
			workSum.setDjly("PC");
		}
		
		User user = UserUtils.getUser();
		if(null != user && !"".equals(user.getId())) {
			workSum.setRyId(user.getId());
		}
		
		workSumService.save(workSum);
		//执行新增文件存储操作
		if(null != workSum.getFileList() && workSum.getFileList().size() > 0) {
			workSumService.insertFileList(workSum);
		}
		
		addMessage(redirectAttributes, "保存工作总结成功");
		
		json.setSuccess(true);
		json.setMsg("保存工作总结成功");
		
		return json;
	}
	
	//删除
	@ResponseBody
	@RequestMapping(value = "delete")
	public Json delete(WorkSum workSum, String ids, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		String sumIds[] = ids.split(",");
		for(String item : sumIds) {
			WorkSum e = new WorkSum(item);
			workSumService.delete(e);
			//同时删除图片路径表中对应的数据
			workSumService.deleteFileList(item);
		}
		
		json.setSuccess(true);
		json.setMsg("删除工作总结成功");
		
		return json;
	}
	
}
