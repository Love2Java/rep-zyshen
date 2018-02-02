/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.base.entity.ModelDetail;
import com.thinkgem.jeesite.modules.base.entity.Models;

/**
 * 问卷模板DAO接口
 * @author ThinkGem
 * @version 2017-12-28
 */
@MyBatisDao
public interface ModelDao extends CrudDao<Models> {
	
	//分页获取问卷模板
	public List<Models> getModelList(RowBounds bounds, Models model);
	public int getModelListCount(Models model);
	
	//新增问卷模板下的内容列
	public int insertListToModel(Models model);
	
	//明细表操作
	public void deleteModelDetails(String zdId);
	public void insertModelDetails(Models model);
	public List<ModelDetail> getModelDetailsById(String zbId);
}
