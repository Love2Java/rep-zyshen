/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.biz.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.biz.dao.WorkRectifyDao;
import com.thinkgem.jeesite.modules.biz.entity.WorkRectify;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;

/**
 * 问题整改通知书Service
 * @author ThinkGem
 * @version 2018-01-03
 */
@Service
@Transactional(readOnly = true)
public class WorkRectifyService extends CrudService<WorkRectifyDao, WorkRectify> {
	
	@Autowired
	private WorkRectifyDao workRectifyDao;

	public List<WorkRectify> findAll(){
		return null;
	}

	@Transactional(readOnly = false)
	public void save(WorkRectify workRectify) {
		super.save(workRectify);
	}
	
	@Transactional(readOnly = false)
	public void delete(WorkRectify workRectify) {
		super.delete(workRectify);
	}
	
	/**
	 * 分页查询问题整改通知书（个人）
	 * @return
	 */
	public List<WorkRectify> getWorkRectifyList(int pageNo, int pageSize, WorkRectify workRectify) {
		return workRectifyDao.getWorkRectifyList(new RowBounds(pageSize*(pageNo-1), pageSize), workRectify);
	}
	/**
	 * 查询问题整改通知书count（个人）
	 * @return
	 */
	public int getWorkRectifyListCount(WorkRectify workRectify) {
		return workRectifyDao.getWorkRectifyListCount(workRectify);
	}
	
	//获取整改通知书记录操作
	public List<WorkRectify> getAllRectify(int pageNo, int pageSize, WorkRectify workRectify) {
		return workRectifyDao.getAllRectify(new RowBounds(pageSize*(pageNo-1), pageSize), workRectify);
	}
	public int getAllRectifyCount(WorkRectify workRectify) {
		return workRectifyDao.getAllRectifyCount(workRectify);
	}
    public List<WorkRectify> getRectifyBySchool(int pageNo, int pageSize, HashMap<String, Object> map) {
		return workRectifyDao.getRectifyBySchool(new RowBounds(pageSize*(pageNo-1), pageSize), map);
	}
	public int getRectifyCountBySchool(HashMap<String, Object> map) {
		return workRectifyDao.getRectifyCountBySchool(map);
	}
	
	//文件操作
	public void insertFileList(WorkRectify workRectify){
		workRectifyDao.insertFileList(workRectify);
	}
	public void deleteFileList(String id){
		workRectifyDao.deleteFileList(id);
	}
	public List<UploadFileInfo> getFileListById(String id){
		return workRectifyDao.getFileListById(id);
	}
	
}
