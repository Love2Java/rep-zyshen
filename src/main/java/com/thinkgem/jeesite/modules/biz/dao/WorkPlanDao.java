/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.biz.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.biz.entity.WorkPlan;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;

/**
 * 工作计划DAO接口
 * @author ThinkGem
 * @version 2017-12-28
 */
@MyBatisDao
public interface WorkPlanDao extends CrudDao<WorkPlan> {

	//分页获取工作计划（个人）
	public List<WorkPlan> getWorkPlanList(RowBounds bounds, WorkPlan workPlan);
	public int getWorkPlanListCount(WorkPlan workPlan);
	
	//文件列表操作
	public void deleteFileList(String id);
	public void insertFileList(WorkPlan workPlan);
	public List<UploadFileInfo> getFileListById(String id);
	
}
