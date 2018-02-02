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
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.biz.entity.WorkRecord;
import com.thinkgem.jeesite.modules.biz.entity.WorkRectify;
import com.thinkgem.jeesite.modules.biz.service.WorkRecordService;
import com.thinkgem.jeesite.modules.biz.service.WorkRectifyService;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 日常工作记录Controller
 * @author ThinkGem
 * @version 2017-12-30
 */
@Controller
@RequestMapping(value = "${adminPath}/biz/workrecord")
public class WorkRecordController extends BaseController {

	
	@Autowired
	private WorkRecordService workRecordService;
	@Autowired
	private WorkRectifyService workRectifyService;
	
	//跳转至则日常工作记录页面
	@RequestMapping(value = {"list", ""})
	public String list( Model model) {
		
		return "modules/biz/workrecord";
	}
	
	//获取日常工作记录列表
	@ResponseBody
	@RequestMapping(value = "datagrid")
	public DataGrid datagrid(PageHelper pageHelper) {
		
		//del_flag=0，获取当前登录的用户Id
		WorkRecord workRecord = new WorkRecord();
		User user = UserUtils.getUser();
		if(null != user && !"".equals(user.getId())) {
			//判断是否是系统管理员
			if(user.isAdmin()) {
				//取所有
			}else {
				workRecord.setRyId(user.getId());//当前用户
			}
		}
		
		List<WorkRecord> list = workRecordService.getWorkRecordList(pageHelper.getPage(), pageHelper.getRows(), workRecord);
		//对工作计划中涉及的文件路径进行拼接
		
		
		int total = workRecordService.getWorkRecordListCount(workRecord);
		
		DataGrid dataGrid = new DataGrid();
		dataGrid.setRows(0 == total ? "" : list);//空的时候返回""
		dataGrid.setTotal(total);
		
		return dataGrid;
	}
	
	//跳转至日常工作记录表单
	@RequestMapping(value = "form")
	public String form(WorkRecord workRecord, Model model) {
		
	/*	WorkRecord wr = new WorkRecord();
		//判断新增还是编辑
		if(StringUtils.isNotBlank(workRecord.getId())) {
			wr = workRecordService.get(workRecord.getId());
			model.addAttribute("workRecord", wr);
		}*/
		
		return "modules/biz/workrecordForm";
	}
	
	//获取日常工作记录详情
	@ResponseBody
	@RequestMapping(value = "/getFileListById")
	public WorkRecord getFileListById(String id) {
		
		WorkRecord wr = workRecordService.get(id);
		
		if(null != wr) {
			//取文件列表的数据
			List<UploadFileInfo> fileList = workRecordService.getFileListById(wr.getId());
			if(null != fileList && fileList.size() > 0) {
				wr.setFileList(fileList);
			}
		}
		
		return wr;
	}
	
	//新增
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
		WorkRecord workRecord = (WorkRecord) JsonMapper.getInstance().fromJsonString(item, WorkRecord.class);
		
		//新增编辑之前先删除文件列表中的文件
		if(StringUtils.isNotBlank(workRecord.getId())) {
			workRecordService.deleteFileList(workRecord.getId());
			WorkRecord wr = workRecordService.get(workRecord.getId());
			workRecord.setDjbh(wr.getDjbh());//编辑时单据编号不做修改
		}else {
			//单据编号自动生成-年月日+3位流水号
			//取当前年月日
			String ymd = DateUtils.formatDate(new Date(), "yyyyMMdd");
			String djbh = ymd + "001";//编号从001开始
			WorkRecord wr = workRecordService.getMaxDjbh(ymd);
			if(null != wr && !"".equals(wr.getDjbh())) {
				//编号+1，取后三位操作
				String x = "1" + wr.getDjbh().substring(8);//前面+1便于进行加法
				String y = String.valueOf(Integer.parseInt(x) + 1);//+1转字符串
				djbh = ymd + y.substring(1);//去掉之前+的1
			}
			workRecord.setDjbh(djbh);
			//新增时加上来源PC，编辑的话不修改来源
			workRecord.setDjly("PC");
		}
		
		User user = UserUtils.getUser();
		if(null != user && !"".equals(user.getId())) {
			workRecord.setRyId(user.getId());
		}
		
		workRecordService.save(workRecord);//存工作记录表基础内容
		//执行新增文件存储操作
		if(null != workRecord.getFileList() && workRecord.getFileList().size() > 0) {
			workRecordService.insertFileList(workRecord);
		}
		
		addMessage(redirectAttributes, "保存日常工作记录成功");
		
		json.setSuccess(true);
		json.setMsg("保存日常工作记录成功");
		//将ID返回至前台
		json.setMsg2(workRecord.getId());
		
		return json;
	}
	
	//删除
	@ResponseBody
	@RequestMapping(value = "delete")
	public Json delete(WorkRecord workRecord, String ids, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		String recordIds[] = ids.split(",");
		for(String item : recordIds) {
			WorkRecord e = new WorkRecord(item);
			workRecordService.delete(e);
			//同时删除图片路径表中对应的数据
			workRecordService.deleteFileList(item);
		}
		
		json.setSuccess(true);
		json.setMsg("删除日常工作记录成功");
		
		return json;
	}
	
	
	//跳转至问题整改通知书
	@RequestMapping(value = "sendRectify")
	public String rectifyForm( Model model) {

		return "modules/biz/sendRectify";
	}
	/*@RequestMapping(value = "sendRectify/{zbId}")
	public String rectifyForm(@PathVariable("zbId") String zbId, Model model) {
		
		WorkRecord workRecord = workRecordService.get(zbId);
		workRecord.setBt("关于"+workRecord.getWtgjz()+"的问题");
		model.addAttribute("workRecord", workRecord);
		
		return "modules/biz/sendRectify";
	}*/
	
	//保存
	@ResponseBody
	@RequestMapping(value = "saveRectify")
	public Json saveRectify(WorkRectify workRectify, Model model, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		workRectify.setDqzt("0");//初始0：待处理；1：已计划；2：已回访；3：已汇报；4：已评价
		workRectify.setXdrq(new Date());
		workRectify.setDjly("PC");//来源
		workRectifyService.save(workRectify);
		
		addMessage(redirectAttributes, "保存整改通知书成功");
		
		json.setSuccess(true);
		json.setMsg("保存整改通知书成功");
		
		return json;
	}
	
}
