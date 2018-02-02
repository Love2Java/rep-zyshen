/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.biz.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.biz.entity.WorkSum;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;

/**
 * 工作总结DAO接口
 * @author ThinkGem
 * @version 2017-12-30
 */
@MyBatisDao
public interface WorkSumDao extends CrudDao<WorkSum> {

	//分页获取工作总结（个人）
	public List<WorkSum> getWorkSumList(RowBounds bounds, WorkSum workSum);
	public int getWorkSumListCount(WorkSum workSum);
	
	//文件列表操作
	public void deleteFileList(String id);
	public void insertFileList(WorkSum workSum);
	public List<UploadFileInfo> getFileListById(String id);
}
