/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.datatype.DataGrid;
import com.thinkgem.jeesite.common.datatype.Json;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.base.entity.JobContent;
import com.thinkgem.jeesite.modules.base.service.JobService;

/**
 * 工作内容Controller
 * @author ThinkGem
 * @version 2017-12-27
 */
@Controller
@RequestMapping(value = "${adminPath}/base/job")
public class JobController extends BaseController {

	@Autowired
	private JobService jobService;
	
	@ModelAttribute("job")
	public JobContent get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return jobService.get(id);
		}else{
			return new JobContent();
		}
	}
	
	//跳转至工作内容页面
	@RequestMapping(value = {"list", ""})
	public String list(JobContent jobContent, Model model) {
		//model.addAttribute("list", schoolService.findAll());
		return "modules/base/jobContent";
	}	
	//打开工作内容参照
	@RequestMapping(value = "dialog")
	public String dialog(JobContent jobContent, Model model) {
		//model.addAttribute("list", schoolService.findAll());
		return "modules/base/jobContentDialog";
	}
	
	//获取工作内容信息列表
	@ResponseBody
	@RequestMapping(value = "datagrid")
	public DataGrid datagrid() {
		
		//del_flag=0
		JobContent jobContent = new JobContent();
		
		List<JobContent> list = jobService.getJobContentList(jobContent);
		
		DataGrid dataGrid = new DataGrid();
		dataGrid.setRows(0 == list.size() ? "" : list);//空的时候返回""
		
		return dataGrid;
	}
	
	//新增或编辑
	@ResponseBody
	@RequestMapping(value = "save")
	public Json save(JobContent jobContent, Model model, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		//页面oldMc字段来做名称重复判断
		if (!"true".equals(checkJobContentName(jobContent.getOldMc(), jobContent.getMc()))){
			addMessage(model, "保存工作内容'" + jobContent.getMc() + "'失败，名称已存在");
			json.setSuccess(false);
			json.setMsg("保存工作内容'" + jobContent.getMc() + "'失败，名称已存在");
			return json;
		}
		
		jobService.save(jobContent);
		addMessage(redirectAttributes, "保存工作内容'" + jobContent.getMc() + "'成功");
		
		json.setSuccess(true);
		json.setMsg("保存工作内容'" + jobContent.getMc() + "'成功");
		
		return json;
	}
	
	//删除
	@ResponseBody
	@RequestMapping(value = "delete")
	public Json delete(JobContent jobContent, String ids, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		String jobIds[] = ids.split(",");
		for(String item : jobIds) {
			JobContent e = new JobContent(item);
			jobService.delete(e);
		}
		
		json.setSuccess(true);
		json.setMsg("删除工作内容成功");
		
		return json;
	}
	
	//判断工作内容名称重复
	@ResponseBody
	@RequestMapping(value = "checkJobContentName")
	public String checkJobContentName(String oldMc, String mc) {
		if (mc !=null && mc.equals(oldMc)) {
			return "true";
		} else if (mc !=null && jobService.getJobContentByMc(mc) == null) {
			return "true";
		}
		return "false";
	}

}
