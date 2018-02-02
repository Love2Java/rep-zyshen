/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.biz.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.biz.entity.WorkRectify;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;

/**
 * 问题整改通知书DAO接口
 * @author ThinkGem
 * @version 2018-01-03
 */
@MyBatisDao
public interface WorkRectifyDao extends CrudDao<WorkRectify> {

	//分页获取问题整改通知书（个人）
	public List<WorkRectify> getWorkRectifyList(RowBounds bounds, WorkRectify workRectify);
	public int getWorkRectifyListCount(WorkRectify workRectify);
	
	//获取整改通知书记录
	public List<WorkRectify> getAllRectify(RowBounds bounds, WorkRectify workRectify);
	public int getAllRectifyCount(WorkRectify workRectify);
	public List<WorkRectify> getRectifyBySchool(RowBounds bounds, HashMap<String, Object> map);
	public int getRectifyCountBySchool(HashMap<String, Object> map);
	
	//文件操作
	public void deleteFileList(String id);
	public void insertFileList(WorkRectify workRectify);
	public List<UploadFileInfo> getFileListById(String id);
}
