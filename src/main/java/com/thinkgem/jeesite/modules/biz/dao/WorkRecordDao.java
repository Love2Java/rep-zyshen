/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.biz.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.biz.entity.WorkRecord;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;

/**
 * 日常工作记录DAO接口
 * @author ThinkGem
 * @version 2018-01-02
 */
@MyBatisDao
public interface WorkRecordDao extends CrudDao<WorkRecord> {

	//分页获取日常工作记录（个人）
	public List<WorkRecord> getWorkRecordList(RowBounds bounds, WorkRecord workRecord);
	public int getWorkRecordListCount(WorkRecord workRecord);
	
	//文件列表操作
	public void deleteFileList(String id);
	public void insertFileList(WorkRecord workRecord);
	public List<UploadFileInfo> getFileListById(String id);
	
	//根据年月日获取单据编号
	public WorkRecord getMaxDjbh(String ymd);
	
}
