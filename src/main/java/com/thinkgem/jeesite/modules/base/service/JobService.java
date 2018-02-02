/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.base.dao.JobDao;
import com.thinkgem.jeesite.modules.base.entity.JobContent;

/**
 * 工作内容Service
 * @author ThinkGem
 * @version 2017-12-27
 */
@Service
@Transactional(readOnly = true)
public class JobService extends CrudService<JobDao, JobContent> {
	
	
	@Autowired
	private JobDao jobDao;

	public List<JobContent> findAll(){
		return null;
	}

	@Transactional(readOnly = false)
	public void save(JobContent jobContent) {
		super.save(jobContent);
	}
	
	@Transactional(readOnly = false)
	public void delete(JobContent jobContent) {
		super.delete(jobContent);
	}
	
	/**
	 * 查询工作内容
	 * @return
	 */
	public List<JobContent> getJobContentList(JobContent jobContent){
		return jobDao.getJobContentList(jobContent);
	}
	
	
	/**
	 * 根据名称获取工作内容
	 * @param mc
	 * @return
	 */
	public JobContent getJobContentByMc(String mc) {
		
		JobContent jobContent = new JobContent();
		jobContent.setMc(mc);
		JobContent xx = jobDao.getJobContentByMc(jobContent);
		
		if(null == xx) {
			return null;
		}
		
		return xx;
	}
	
}
