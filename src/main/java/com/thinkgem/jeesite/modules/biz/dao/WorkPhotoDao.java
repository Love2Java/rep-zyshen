/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.biz.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.biz.entity.WorkPhoto;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;

/**
 * 工作掠影DAO接口
 * @author ThinkGem
 * @version 2017-12-30
 */
@MyBatisDao
public interface WorkPhotoDao extends CrudDao<WorkPhoto> {

	//分页获取工作掠影（个人）
	public List<WorkPhoto> getWorkPhotoList(RowBounds bounds, WorkPhoto workPhoto);
	public int getWorkPhotoListCount(WorkPhoto workPhoto);
	public List<WorkPhoto> getFileInfoList(RowBounds bounds, WorkPhoto workPhoto);
	public int getFileInfoListCount(WorkPhoto workPhoto);
	public List<WorkPhoto> getFileInfoListByType(RowBounds bounds, WorkPhoto workPhoto);
	public int getFileInfoListCountByType(WorkPhoto workPhoto);
	
	//文件列表操作
	public void deleteFileList(String id);
	public void insertFileList(WorkPhoto workPhoto);
	public List<UploadFileInfo> getFileListById(String id);
	
	//审核弃核
	public void updateStates(WorkPhoto workPhoto);
	
}
