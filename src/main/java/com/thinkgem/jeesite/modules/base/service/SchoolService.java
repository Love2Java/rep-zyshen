/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.base.dao.SchoolDao;
import com.thinkgem.jeesite.modules.base.entity.School;

/**
 * 学校Service
 * @author ThinkGem
 * @version 2017-12-22
 */
@Service
@Transactional(readOnly = true)
public class SchoolService extends CrudService<SchoolDao, School> {
	
	
	@Autowired
	private SchoolDao schoolDao;

	public List<School> findAll(){
		return null;
	}

	@Transactional(readOnly = false)
	public void save(School school) {
		super.save(school);
	}
	
	@Transactional(readOnly = false)
	public void delete(School school) {
		super.delete(school);
	}
	
	/**
	 * 分页查询所有学校信息
	 * @return
	 */
	public List<School> getSchoolList(int pageNo, int pageSize, School school){
		return schoolDao.getSchoolList(new RowBounds(pageSize*(pageNo-1), pageSize), school);
	}
	/**
	 * 查询所有学校信息count
	 * @return
	 */
	public int getSchoolListCount(School school){
		return schoolDao.getSchoolListCount(school);
	}
	
	public List<School> getSchoolByUser(int pageNo, int pageSize, HashMap<String, Object> map) {
		return schoolDao.getSchoolByUser(new RowBounds(pageSize*(pageNo-1), pageSize), map);
	}
	public int getSchoolCountByUser(HashMap<String, Object> map) {
		return schoolDao.getSchoolCountByUser(map);
	}
	
	
	/**
	 * 根据学校名称获取学校
	 * @param xxmc
	 * @return
	 */
	public School getSchoolByXxmc(String xxmc) {
		
		School school = new School();
		school.setXxmc(xxmc);
		School xx = schoolDao.getSchoolByXxmc(school);
		
		if(null == xx) {
			return null;
		}
		
		return xx;
	}
	
}
