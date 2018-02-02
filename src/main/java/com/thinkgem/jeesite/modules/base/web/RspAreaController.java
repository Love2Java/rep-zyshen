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

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.datatype.DataGrid;
import com.thinkgem.jeesite.common.datatype.Json;
import com.thinkgem.jeesite.common.datatype.PageHelper;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.base.entity.RspArea;
import com.thinkgem.jeesite.modules.base.service.RspAreaService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;

/**
 * 责任区设置Controller
 * @author ThinkGem
 * @version 2017-12-27
 */
@Controller
@RequestMapping(value = "${adminPath}/base/rspArea")
public class RspAreaController extends BaseController {

	@Autowired
	private RspAreaService rspAreaService;
	@Autowired
	private SystemService systemService;
	
	@ModelAttribute("rspArea")
	public RspArea get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return rspAreaService.get(id);
		}else{
			return new RspArea();
		}
	}
	
	//跳转至则责任区绑定页面
	@RequestMapping(value = {"list", ""})
	public String list(RspArea rspArea, Model model) {
		//model.addAttribute("list", schoolService.findAll());
		return "modules/base/zrdxbd";
	}
	
	//获取责任区信息列表
	@ResponseBody
	@RequestMapping(value = "datagrid")
	public DataGrid datagrid(PageHelper pageHelper) {
		
		//del_flag=0
		RspArea rspArea = new RspArea();
		
		List<RspArea> list = rspAreaService.getRspAreaList(pageHelper.getPage(), pageHelper.getRows(), rspArea);
		//对责任督学人员名称进行拼接
		List<RspArea> zrqlist = Lists.newArrayList();
		if(null != list && list.size() > 0) {
			for(RspArea entity : list) {
				StringBuilder zrdxrymc = new StringBuilder();
				String ids = entity.getZrdxryId();
				if(null != ids && !"".equals(ids)) {
					String userIds[] = ids.split(",");
					for(String item : userIds) {
						//遍历每个userId，从用户表中取出名称进行拼接
						User user = systemService.getUser(item);
						if(null != user && !"".equals(user.getName())) {
							zrdxrymc.append(user.getName() + ",");
						}
					}
				}
				if(zrdxrymc.length() > 0) {
					zrdxrymc.deleteCharAt(zrdxrymc.length()-1);
				}
				entity.setZrdxrymc(zrdxrymc.toString());
				zrqlist.add(entity);
			}
		}
		int total = rspAreaService.getRspAreaListCount(rspArea);
		
		DataGrid dataGrid = new DataGrid();
		dataGrid.setRows(0 == total ? "" : zrqlist);//空的时候返回""
		dataGrid.setTotal(total);
		
		return dataGrid;
	}
	
	//跳转至责任区表单
	@RequestMapping(value = "form")
	public String form(RspArea rspArea, Model model) {
		
		//判断新增还是编辑
		if(StringUtils.isNotBlank(rspArea.getId())) {
			//拼接责任督学人员
			String ids = rspArea.getZrdxryId();
			StringBuilder zrdxrymc = new StringBuilder();
			String userIds[] = ids.split(",");
			for(String item : userIds) {
				//遍历每个userId，从用户表中取出名称进行拼接
				User user = systemService.getUser(item);
				if(null != user && !"".equals(user.getName())) {
					zrdxrymc.append(user.getName() + ",");
				}
			}
			if(zrdxrymc.length() > 0) {
				zrdxrymc.deleteCharAt(zrdxrymc.length()-1);
			}
			rspArea.setZrdxrymc(zrdxrymc.toString());
		}
		
		model.addAttribute("rspArea", rspArea);
		return "modules/base/zrdxbdForm";
	}
	
	//新增或编辑
	@ResponseBody
	@RequestMapping(value = "save")
	public Json save(RspArea rspArea, Model model, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		//学校ids
		String xxIds[] = rspArea.getXxId().split(",");
		//判断新增还是编辑
		if(StringUtils.isNotBlank(rspArea.getId())) {
			//先删除该id下的责任区信息
			rspAreaService.delete(rspArea);
		}
		
		for(String item : xxIds) {
			RspArea ra = new RspArea();
			ra.setXxId(item);
			ra.setZrqId(rspArea.getZrqId());
			ra.setZrzId(rspArea.getZrzId());
			ra.setZrdxryId(rspArea.getZrdxryId());
			ra.setZzryId(rspArea.getZzryId());
			ra.setLlryId(rspArea.getLlryId());
			ra.setBbh(rspArea.getBbh());
			ra.setBbrq(rspArea.getBbrq());
			rspAreaService.save(ra);
		}
		
		addMessage(redirectAttributes, "保存责任区内容成功");
		
		json.setSuccess(true);
		json.setMsg("保存责任区内容成功");
		
		return json;
	}
	
	//删除
	@ResponseBody
	@RequestMapping(value = "delete")
	public Json delete(RspArea rspArea, String ids, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		String zrqIds[] = ids.split(",");
		for(String item : zrqIds) {
			RspArea e = new RspArea(item);
			rspAreaService.delete(e);
		}
		
		json.setSuccess(true);
		json.setMsg("删除责任区内容成功");
		
		return json;
	}
	
}
