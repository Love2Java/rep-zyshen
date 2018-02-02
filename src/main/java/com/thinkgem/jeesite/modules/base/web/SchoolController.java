/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.web;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import com.thinkgem.jeesite.common.datatype.PageHelper;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.base.entity.RspArea;
import com.thinkgem.jeesite.modules.base.entity.School;
import com.thinkgem.jeesite.modules.base.service.RspAreaService;
import com.thinkgem.jeesite.modules.base.service.SchoolService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 学校Controller
 * @author ThinkGem
 * @version 2017-12-22
 */
@Controller
@RequestMapping(value = "${adminPath}/base/school")
public class SchoolController extends BaseController {

	@Autowired
	private SchoolService schoolService;
	@Autowired
	private RspAreaService rspAreaService;
	
	@ModelAttribute("school")
	public School get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return schoolService.get(id);
		}else{
			return new School();
		}
	}
	
	//跳转至学校信息页面
	@RequestMapping(value = {"list", ""})
	public String list(School school, Model model) {
		//model.addAttribute("list", schoolService.findAll());
		return "modules/base/schoolList";
	}
	
	//获取学校信息列表-pageHelper分页
	@ResponseBody
	@RequestMapping(value = "datagrid")
	public DataGrid datagrid(HttpServletRequest request, PageHelper pageHelper) {
		
		//del_flag=0
		School school = new School();
		DataGrid dataGrid = new DataGrid();
		String flag = request.getParameter("flag");
		User user = UserUtils.getUser();
		if(null != user && !"".equals(user.getId())) {
			//判断是否是系统管理员
			if(user.isAdmin() || !"1".equals(flag)) {
				//取所有
				List<School> list = schoolService.getSchoolList(pageHelper.getPage(), pageHelper.getRows(), school);
				int total = schoolService.getSchoolListCount(school);
				
				dataGrid.setRows(0 == total ? "" : list);//空的时候返回""
				dataGrid.setTotal(total);
			}else{
				//flag=1，取归属学校的记录（联络人、组长、责任督学人员）
				List<RspArea> schools = rspAreaService.getSchoolsByUserId(user.getId());
				if(null != schools && schools.size() > 0) {
					String xxIds[] = new String[schools.size()];
					int i = 0;
					for(RspArea entity : schools) {
						xxIds[i] = entity.getXxId();
						i++;
					}
					HashMap<String, Object> map = new HashMap<String, Object>();
					map.put("xxIds", xxIds);
					List<School> lists = schoolService.getSchoolByUser(pageHelper.getPage(), pageHelper.getRows(), map);
					int total = schoolService.getSchoolCountByUser(map);
					
					dataGrid.setRows(0 == total ? "" : lists);//空的时候返回""
					dataGrid.setTotal(total);
				}
			}
		}
		
		return dataGrid;
	}
	
	//跳转至学校信息新增或编辑页面
	@RequestMapping(value = "form")
	public String form(School school, Model model) {
		return "modules/base/schoolForm";
	}
	
	//新增或编辑
	@ResponseBody
	@RequestMapping(value = "save")
	public Json save(School school, Model model, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		//页面oldXxmc字段来做名称重复判断
		if (!"true".equals(checkSchoolName(school.getOldXxmc(), school.getXxmc()))){
			addMessage(model, "保存学校'" + school.getXxmc() + "'失败，名称已存在");
			json.setSuccess(false);
			json.setMsg("保存学校'" + school.getOldXxmc() + "'失败，名称已存在");
			return json;
		}
		
		schoolService.save(school);
		addMessage(redirectAttributes, "保存学校'" + school.getXxmc() + "'成功");
		
		json.setSuccess(true);
		json.setMsg("保存学校'" + school.getXxmc() + "'成功");
		
		return json;
	}
	
	//删除
	@ResponseBody
	@RequestMapping(value = "delete")
	public Json delete(School school, String ids, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		String schoolIds[] = ids.split(",");
		for(String item : schoolIds) {
			School e = new School(item);
			schoolService.delete(e);
		}
		
		json.setSuccess(true);
		json.setMsg("删除学校信息成功");
		
		return json;
	}
	
	//判断学校名称重复
	@ResponseBody
	@RequestMapping(value = "checkSchoolName")
	public String checkSchoolName(String oldXxmc, String xxmc) {
		if (xxmc !=null && xxmc.equals(oldXxmc)) {
			return "true";
		} else if (xxmc !=null && schoolService.getSchoolByXxmc(xxmc) == null) {
			return "true";
		}
		return "false";
	}
	
	//学校选择
	@RequestMapping(value = "dialog")
	public String dialog(HttpServletRequest request, School school, Model model) {
		
		model.addAttribute("flag", request.getParameter("flag"));
		return "modules/base/schoolDialog";
	}
	
	
	
}
