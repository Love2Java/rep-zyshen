/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.base.dao.ModelDao;
import com.thinkgem.jeesite.modules.base.entity.ModelDetail;
import com.thinkgem.jeesite.modules.base.entity.Models;

/**
 * 问卷模板Service
 * @author ThinkGem
 * @version 2017-12-28
 */
@Service
@Transactional(readOnly = true)
public class ModelService extends CrudService<ModelDao, Models> {
	
	
	@Autowired
	private ModelDao modelDao;

	public List<Models> findAll(){
		return null;
	}

	@Transactional(readOnly = false)
	public void save(Models model) {
		super.save(model);
	}
	
	@Transactional(readOnly = false)
	public void delete(Models model) {
		super.delete(model);
	}
	
	/**
	 * 分页查询所有模板信息
	 * @return
	 */
	public List<Models> getModelList(int pageNo, int pageSize, Models model){
		return modelDao.getModelList(new RowBounds(pageSize*(pageNo-1), pageSize), model);
	}
	/**
	 * 查询所有模板count
	 * @return
	 */
	public int getModelListCount(Models model){
		return modelDao.getModelListCount(model);
	}
	
	//明细表操作
	public void insertModelDetails(Models model){
	    modelDao.insertModelDetails(model);
	}
	public void deleteModelDetails(String zbId){
		modelDao.deleteModelDetails(zbId);
	}
	public List<ModelDetail> getModelDetailsById(String zbId){
		return modelDao.getModelDetailsById(zbId);
	}
	
}
