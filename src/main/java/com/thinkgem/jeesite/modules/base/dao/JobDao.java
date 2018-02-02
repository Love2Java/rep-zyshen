/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.base.entity.JobContent;

/**
 * 工作内容DAO接口
 * @author ThinkGem
 * @version 2017-12-27
 */
@MyBatisDao
public interface JobDao extends CrudDao<JobContent> {

	/**
	 * 根据名称查询工作内容
	 * @param xxmc
	 * @return
	 */
	public JobContent getJobContentByMc(JobContent jobContent);
	
	//获取工作内容信息
	public List<JobContent> getJobContentList(JobContent jobContent);
	
}
