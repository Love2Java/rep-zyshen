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
import com.thinkgem.jeesite.modules.base.dao.RspAreaDao;
import com.thinkgem.jeesite.modules.base.entity.RspArea;

/**
 * 责任区Service
 * @author ThinkGem
 * @version 2017-12-27
 */
@Service
@Transactional(readOnly = true)
public class RspAreaService extends CrudService<RspAreaDao, RspArea> {
	
	
	@Autowired
	private RspAreaDao rspAreaDao;

	public List<RspArea> findAll(){
		return null;
	}

	@Transactional(readOnly = false)
	public void save(RspArea rspArea) {
		super.save(rspArea);
	}
	
	@Transactional(readOnly = false)
	public void delete(RspArea rspArea) {
		super.delete(rspArea);
	}
	
	/**
	 * 分页查询所有责任区信息
	 * @return
	 */
	public List<RspArea> getRspAreaList(int pageNo, int pageSize, RspArea rspArea){
		return rspAreaDao.getRspAreaList(new RowBounds(pageSize*(pageNo-1), pageSize), rspArea);
	}
	/**
	 * 查询所有责任区信息count
	 * @return
	 */
	public int getRspAreaListCount(RspArea rspArea){
		return rspAreaDao.getRspAreaListCount(rspArea);
	}
	
	//根据用户ID获取责任区学校列表
	public List<RspArea> getSchoolsByUserId(String userId) {
		return rspAreaDao.getSchoolsByUserId(userId);
	}
	
}
