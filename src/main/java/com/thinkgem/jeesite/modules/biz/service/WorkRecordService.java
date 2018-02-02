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
import com.thinkgem.jeesite.modules.biz.dao.WorkRecordDao;
import com.thinkgem.jeesite.modules.biz.entity.WorkRecord;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;

/**
 * 日常工作记录Service
 * @author ThinkGem
 * @version 2018-01-02
 */
@Service
@Transactional(readOnly = true)
public class WorkRecordService extends CrudService<WorkRecordDao, WorkRecord> {
	
	@Autowired
	private WorkRecordDao workRecordDao;

	public List<WorkRecord> findAll(){
		return null;
	}

	@Transactional(readOnly = false)
	public void save(WorkRecord workRecord) {
		super.save(workRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(WorkRecord workRecord) {
		super.delete(workRecord);
	}
	
	/**
	 * 分页查询日常工作记录（个人）
	 * @return
	 */
	public List<WorkRecord> getWorkRecordList(int pageNo, int pageSize, WorkRecord workRecord){
		return workRecordDao.getWorkRecordList(new RowBounds(pageSize*(pageNo-1), pageSize), workRecord);
	}
	/**
	 * 查询日常工作记录count（个人）
	 * @return
	 */
	public int getWorkRecordListCount(WorkRecord workRecord){
		return workRecordDao.getWorkRecordListCount(workRecord);
	}
	
	//文件列表操作
	public void insertFileList(WorkRecord workRecord){
		workRecordDao.insertFileList(workRecord);
	}
	public void deleteFileList(String id){
		workRecordDao.deleteFileList(id);
	}
	public List<UploadFileInfo> getFileListById(String id){
		return workRecordDao.getFileListById(id);
	}
	
	//根据年月日获取单据编号
	public WorkRecord getMaxDjbh(String ymd){
		return workRecordDao.getMaxDjbh(ymd);
	}
	
	
	
}
