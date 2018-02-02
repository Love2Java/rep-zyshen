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
import com.thinkgem.jeesite.modules.biz.dao.WorkPhotoDao;
import com.thinkgem.jeesite.modules.biz.entity.WorkPhoto;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;

/**
 * 工作掠影Service
 * @author ThinkGem
 * @version 2017-12-30
 */
@Service
@Transactional(readOnly = true)
public class WorkPhotoService extends CrudService<WorkPhotoDao, WorkPhoto> {
	
	@Autowired
	private WorkPhotoDao workPhotoDao;

	public List<WorkPhoto> findAll(){
		return null;
	}

	@Transactional(readOnly = false)
	public void save(WorkPhoto workPhoto) {
		super.save(workPhoto);
	}
	
	@Transactional(readOnly = false)
	public void delete(WorkPhoto workPhoto) {
		super.delete(workPhoto);
	}
	
	/**
	 * 分页查询工作掠影（个人）
	 * @return
	 */
	public List<WorkPhoto> getWorkPhotoList(int pageNo, int pageSize, WorkPhoto workPhoto){
		return workPhotoDao.getWorkPhotoList(new RowBounds(pageSize*(pageNo-1), pageSize), workPhoto);
	}
	public List<WorkPhoto> getFileInfoList(int pageNo, int pageSize, WorkPhoto workPhoto){
		return workPhotoDao.getFileInfoList(new RowBounds(pageSize*(pageNo-1), pageSize), workPhoto);
	}
	public List<WorkPhoto> getFileInfoListByType(int pageNo, int pageSize, WorkPhoto workPhoto){
		return workPhotoDao.getFileInfoListByType(new RowBounds(pageSize*(pageNo-1), pageSize), workPhoto);
	}
	/**
	 * 查询工作掠影count（个人）
	 * @return
	 */
	public int getWorkPhotoListCount(WorkPhoto workPhoto){
		return workPhotoDao.getWorkPhotoListCount(workPhoto);
	}
	public int getFileInfoListCount(WorkPhoto workPhoto){
		return workPhotoDao.getFileInfoListCount(workPhoto);
	}
	public int getFileInfoListCountByType(WorkPhoto workPhoto){
		return workPhotoDao.getFileInfoListCountByType(workPhoto);
	}
	
	//文件列表操作
	public void insertFileList(WorkPhoto workPhoto){
		workPhotoDao.insertFileList(workPhoto);
	}
	public void deleteFileList(String id){
		workPhotoDao.deleteFileList(id);
	}
	public List<UploadFileInfo> getFileListById(String id){
		return workPhotoDao.getFileListById(id);
	}
	
	//审核弃坑
	public void updateStates(WorkPhoto workPhoto){
		workPhotoDao.updateStates(workPhoto);
	}
	
}
