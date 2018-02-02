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
import com.thinkgem.jeesite.modules.biz.dao.WorkSumDao;
import com.thinkgem.jeesite.modules.biz.entity.WorkSum;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;

/**
 * 工作总结Service
 * @author ThinkGem
 * @version 2017-12-30
 */
@Service
@Transactional(readOnly = true)
public class WorkSumService extends CrudService<WorkSumDao, WorkSum> {
	
	@Autowired
	private WorkSumDao workSumDao;

	public List<WorkSum> findAll(){
		return null;
	}

	@Transactional(readOnly = false)
	public void save(WorkSum workSum) {
		super.save(workSum);
	}
	
	@Transactional(readOnly = false)
	public void delete(WorkSum workSum) {
		super.delete(workSum);
	}
	
	/**
	 * 分页查询工作总结（个人）
	 * @return
	 */
	public List<WorkSum> getWorkSumList(int pageNo, int pageSize, WorkSum workSum){
		return workSumDao.getWorkSumList(new RowBounds(pageSize*(pageNo-1), pageSize), workSum);
	}
	/**
	 * 查询工作总结count（个人）
	 * @return
	 */
	public int getWorkSumListCount(WorkSum workSum){
		return workSumDao.getWorkSumListCount(workSum);
	}
	
	//文件列表操作
	public void insertFileList(WorkSum workSum){
		workSumDao.insertFileList(workSum);
	}
	public void deleteFileList(String id){
		workSumDao.deleteFileList(id);
	}
	public List<UploadFileInfo> getFileListById(String id){
		return workSumDao.getFileListById(id);
	}
	
}
