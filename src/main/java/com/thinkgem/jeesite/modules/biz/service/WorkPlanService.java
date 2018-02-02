/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.biz.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.biz.dao.WorkPlanDao;
import com.thinkgem.jeesite.modules.biz.entity.WorkPlan;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;

/**
 * 工作计划Service
 * @author ThinkGem
 * @version 2017-12-28
 */
@Service
@Transactional(readOnly = true)
public class WorkPlanService extends CrudService<WorkPlanDao, WorkPlan> {
	
	@Autowired
	private WorkPlanDao workPlanDao;

	public List<WorkPlan> findAll(){
		return null;
	}

	@Transactional(readOnly = false)
	public void save(WorkPlan workPlan) {
		super.save(workPlan);
	}
	
	@Transactional(readOnly = false)
	public void delete(WorkPlan workPlan) {
		super.delete(workPlan);
	}
	
	/**
	 * 分页查询工作计划（个人）
	 * @return
	 */
	public List<WorkPlan> getWorkPlanList(int pageNo, int pageSize, WorkPlan workPlan){
		return workPlanDao.getWorkPlanList(new RowBounds(pageSize*(pageNo-1), pageSize), workPlan);
	}
	/**
	 * 查询工作计划count（个人）
	 * @return
	 */
	public int getWorkPlanListCount(WorkPlan workPlan){
		return workPlanDao.getWorkPlanListCount(workPlan);
	}
	
	//文件列表操作
	public void insertFileList(WorkPlan workPlan){
		workPlanDao.insertFileList(workPlan);
	}
	public void deleteFileList(String id){
		workPlanDao.deleteFileList(id);
	}
	public List<UploadFileInfo> getFileListById(String id){
		return workPlanDao.getFileListById(id);
	}
	
}
