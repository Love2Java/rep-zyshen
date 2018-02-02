/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.biz.web;

import java.util.HashMap;
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
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.base.entity.RspArea;
import com.thinkgem.jeesite.modules.base.service.RspAreaService;
import com.thinkgem.jeesite.modules.biz.entity.WorkRectify;
import com.thinkgem.jeesite.modules.biz.service.WorkRecordService;
import com.thinkgem.jeesite.modules.biz.service.WorkRectifyService;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 问题整改Controller
 * @author ThinkGem
 * @version 2017-12-30
 */
@Controller
@RequestMapping(value = "${adminPath}/biz/rectify")
public class RectifyController extends BaseController {

	@Autowired
	private WorkRecordService workRecordService;
	@Autowired
	private WorkRectifyService workRectifyService;
	@Autowired
	private RspAreaService rspAreaService;
	
	//跳转至则整改通知页面
	@RequestMapping(value = {"list", ""})
	public String list( Model model) {
		
		
		return "modules/biz/rectify";
	}
	
	//获取整改通知记录列表
	@ResponseBody
	@RequestMapping(value = "datagrid")
	public DataGrid datagrid(String type, String description, PageHelper pageHelper) {
		
		DataGrid dataGrid = new DataGrid();
		
		WorkRectify workRectify = new WorkRectify();
		
		User user = UserUtils.getUser();
		if(null != user && !"".equals(user.getId())) {
			//判断是否是系统管理员
			if(user.isAdmin()) {
				//取所有
				workRectify.setDqzt(type);
				workRectify.setWtgjz(description);
				List<WorkRectify> lists = workRectifyService.getAllRectify(pageHelper.getPage(), pageHelper.getRows(), workRectify);
				int total = workRectifyService.getAllRectifyCount(workRectify);
				
				dataGrid.setRows(0 == total ? "" : lists);//空的时候返回""
				dataGrid.setTotal(total);
			}else {
				//取归属学校的记录（联络人、组长、责任督学人员）
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
					map.put("dqzt", type);
					map.put("wtgjz", description);
					List<WorkRectify> lists = workRectifyService.getRectifyBySchool(pageHelper.getPage(), pageHelper.getRows(), map);
					int total = workRectifyService.getRectifyCountBySchool(map);
					
					dataGrid.setRows(0 == total ? "" : lists);//空的时候返回""
					dataGrid.setTotal(total);
				}
			}
		}
		
		return dataGrid;
	}
	
	//跳转至整改通知书表单
	@RequestMapping(value = "form")
	public String form(WorkRectify workRectify, Model model) {
		
		WorkRectify wr = workRectifyService.get(workRectify.getId());
		
		wr.setBt("关于"+wr.getWtgjz()+"的问题");
		
		model.addAttribute("workRectify", wr);
		
		return "modules/biz/rectifyForm";
	}
	
	//新增或编辑
	@ResponseBody
	@RequestMapping(value = "save")
	public Json save(WorkRectify workRectify, Model model, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		//只能编辑待处理（dqzt=0）的记录
		workRectify.setDqzt("0");
		workRectifyService.save(workRectify);
		
		addMessage(redirectAttributes, "保存问题整改通知书成功");
		
		json.setSuccess(true);
		json.setMsg("保存问题整改通知书成功");
		
		return json;
	}
	
	//跳转至整改页面
	@RequestMapping(value = "doRectify")
	public String doRectify(WorkRectify workRectify, Model model) {
		
		WorkRectify wr = workRectifyService.get(workRectify.getId());
		
		wr.setBt("关于"+wr.getWtgjz()+"的问题");
		
		model.addAttribute("workRectify", wr);
		
		return "modules/biz/doRectify";
	}
	
	//获取文件列表
	@ResponseBody
	@RequestMapping(value = "/getFileListById")
	public WorkRectify getFileListById(String id) {
		
		WorkRectify wr = workRectifyService.get(id);
		
		if(null != wr) {
			//取文件列表的数据
			List<UploadFileInfo> fileList = workRectifyService.getFileListById(wr.getId());
			if(null != fileList && fileList.size() > 0) {
				wr.setFileList(fileList);
			}
		}
		
		return wr;
	}
	
	//整改确认
	@ResponseBody
	@RequestMapping(value = "doRectifySave")
	public Json doRectifySave(@RequestBody String item, Model model, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		@SuppressWarnings("static-access")
		WorkRectify workRectify = (WorkRectify) JsonMapper.getInstance().fromJsonString(item, WorkRectify.class);
		
		//编辑之前先删除文件列表中的文件
		workRectifyService.deleteFileList(workRectify.getId());
		//状态从前台获取
		WorkRectify wr = workRectifyService.get(workRectify.getId());
		workRectify.setZgnr(wr.getZgnr());
		System.out.println(workRectify.getZgnr());
		workRectifyService.save(workRectify);
		//执行新增文件存储操作
		if(null != workRectify.getFileList() && workRectify.getFileList().size() > 0) {
			workRectifyService.insertFileList(workRectify);
		}
		
		addMessage(redirectAttributes, "问题整改成功");
		
		json.setSuccess(true);
		json.setMsg("问题整改成功");
		
		return json;
	}
	
	
	//跳转至整改评价页面
	@RequestMapping(value = "pjRectify")
	public String pjRectify(WorkRectify workRectify, Model model) {
		
		WorkRectify wr = workRectifyService.get(workRectify.getId());
		
		wr.setBt("关于"+wr.getWtgjz()+"的问题");
		
		model.addAttribute("workRectify", wr);
		
		return "modules/biz/pjRectify";
	}
	
	//评价确认
	@ResponseBody
	@RequestMapping(value = "pjRectifySave")
	public Json pjRectifySave(@RequestBody String item, Model model, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		@SuppressWarnings("static-access")
		WorkRectify workRectify = (WorkRectify) JsonMapper.getInstance().fromJsonString(item, WorkRectify.class);
		
		//状态从前台获取
		WorkRectify wr = workRectifyService.get(workRectify.getId());
		workRectify.setZgnr(wr.getZgnr());
		System.out.println(workRectify.getZgnr());
		
		workRectifyService.save(workRectify);
		//执行新增文件存储操作
		if(null != workRectify.getFileList() && workRectify.getFileList().size() > 0) {
			workRectifyService.insertFileList(workRectify);
		}
		
		addMessage(redirectAttributes, "评价成功");
		
		json.setSuccess(true);
		json.setMsg("评价成功");
		
		return json;
	}
	
	//删除
	@ResponseBody
	@RequestMapping(value = "delete")
	public Json delete(WorkRectify workRectify, String ids, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		String rectifyIds[] = ids.split(",");
		for(String item : rectifyIds) {
			WorkRectify e = workRectifyService.get(item);
			if(null == e || !"0".equals(e.getDqzt())) {
				json.setSuccess(false);
				json.setMsg("整改处理中的记录无法删除");
			}else {
				workRectifyService.delete(e);
				//同时删除图片路径表中对应的数据
				workRectifyService.deleteFileList(item);
				json.setSuccess(true);
				json.setMsg("删除问题整改通知书成功");
			}
		}
		
		return json;
	}
	
}
