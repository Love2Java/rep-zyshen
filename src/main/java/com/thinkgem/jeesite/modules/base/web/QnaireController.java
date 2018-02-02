/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.web;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
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
import com.thinkgem.jeesite.modules.base.entity.ModelDetail;
import com.thinkgem.jeesite.modules.base.entity.Models;
import com.thinkgem.jeesite.modules.base.entity.Score;
import com.thinkgem.jeesite.modules.base.service.ModelService;
import com.thinkgem.jeesite.modules.base.service.ScoreService;

/**
 * 问卷调查Controller
 * @author ThinkGem
 * @version 2017-12-28
 */
@Controller
@RequestMapping(value = "${adminPath}/base/qnaire")
public class QnaireController extends BaseController {

	@Autowired
	private ScoreService scoreService;
	@Autowired
	private ModelService modelService;
	
	
	//跳转至问卷分值表页面
	@RequestMapping(value = "/score")
	public String score() {
		return "modules/base/score";
	}
	
	//获取问卷分值列表
	@ResponseBody
	@RequestMapping(value = "/score/datagrid")
	public DataGrid datagridScore(String bbh, PageHelper pageHelper) {
		
		//del_flag=0
		Score score = new Score();
		score.setBbh(bbh);
		
		List<Score> list = scoreService.getScoreList(pageHelper.getPage(), pageHelper.getRows(), score);
		int total = scoreService.getScoreListCount(score);
		
		DataGrid dataGrid = new DataGrid();
		dataGrid.setRows(0 == total ? "" : list);//空的时候返回""
		dataGrid.setTotal(total);
		
		return dataGrid;
	}
	
	//新增或编辑
	@ResponseBody
	@RequestMapping(value = "/score/save")
	public Json saveScore(Score score, Model model, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		//根据版本号和答案判断是否已经存在，存在不进行新增；编辑同样进行验证
		if(scoreService.getScoreBySave(score) != null) {
			addMessage(model, "保存分值'" + score.getDa() + "'失败，内容已存在");
			json.setSuccess(false);
			json.setMsg("保存分值'" + score.getDa() + "'失败，内容已存在");
			return json;
		}else {
			//可以进行新增或编辑
			scoreService.save(score);
			addMessage(redirectAttributes, "保存分值'" + score.getDa() + "'成功");
			
			json.setSuccess(true);
			json.setMsg("保存分值'" + score.getDa() + "'成功");
		}
		
		return json;
	}
	
	//删除
	@ResponseBody
	@RequestMapping(value = "/score/delete")
	public Json deleteScore(Score score, String ids, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		String scoreIds[] = ids.split(",");
		for(String item : scoreIds) {
			Score e = new Score(item);
			scoreService.delete(e);
		}
		
		json.setSuccess(true);
		json.setMsg("删除分值成功");
		
		return json;
	}
	
	
	//跳转至问卷调查模板页面
	@RequestMapping(value = "/model")
	public String model() {
		return "modules/base/dcwjmb";
	}
	
	//获取问卷模板列表
	@ResponseBody
	@RequestMapping(value = "/model/datagrid")
	public DataGrid datagridModel(PageHelper pageHelper) {
		
		//del_flag=0
		Models models = new Models();
		
		List<Models> list = modelService.getModelList(pageHelper.getPage(), pageHelper.getRows(), models);
		int total = modelService.getModelListCount(models);
		
		DataGrid dataGrid = new DataGrid();
		dataGrid.setRows(0 == total ? "" : list);//空的时候返回""
		dataGrid.setTotal(total);
		
		return dataGrid;
	}
	
	//跳转至问卷调查表单页面
	@RequestMapping(value = "/model/form")
	public String modelForm(Models models) {
		
		return "modules/base/dcwjmbForm";
	}
	
	//新增或编辑
	@ResponseBody
	@RequestMapping(value = "/model/save")
	public Json saveModel(@RequestBody String item, Model model, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		@SuppressWarnings("static-access")
		Models models = (Models) JsonMapper.getInstance().fromJsonString(item, Models.class);
		
		//新增编辑之前先删除明细表中的内容
		if(StringUtils.isNotBlank(models.getId())) {
			modelService.deleteModelDetails(models.getId());
		}
		
		//执行新增或编辑操作
		modelService.save(models);
		//执行新增明细表操作
		if(null != models.getDetailList() && models.getDetailList().size() > 0) {
			
			modelService.insertModelDetails(models);
		}
		
		addMessage(redirectAttributes, "保存问卷模板'" + models.getWjbt() + "'成功");
		
		json.setSuccess(true);
		json.setMsg("保存问卷模板'" + models.getWjbt() + "'成功");
		
		return json;
	}
	
	//编辑时获取详情列
	@ResponseBody
	@RequestMapping(value = "/model/getRecord")
	public Models getRecord(String id) {
		
		Models models = modelService.get(id);
		
		if(null != models) {
			//取明细表的数据
			List<ModelDetail> details = modelService.getModelDetailsById(models.getId());
			if(null != details && details.size() > 0) {
				models.setDetailList(details);
			}
		}
		
		return models;
	}
	
	//删除
	@ResponseBody
	@RequestMapping(value = "/model/delete")
	public Json deleteModel(Models models, String ids, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		String modelsIds[] = ids.split(",");
		for(String item : modelsIds) {
			Models e = new Models(item);
			//删除主表
			modelService.delete(e);
			//删除详情表
			modelService.deleteModelDetails(item);
		}
		
		json.setSuccess(true);
		json.setMsg("删除问卷调查模板成功");
		
		return json;
	}

}
