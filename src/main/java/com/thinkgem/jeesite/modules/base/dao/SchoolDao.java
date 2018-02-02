/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.base.entity.School;

/**
 * 学校DAO接口
 * @author ThinkGem
 * @version 2017-12-22
 */
@MyBatisDao
public interface SchoolDao extends CrudDao<School> {

	/**
	 * 根据学校名称查询学校信息
	 * @param xxmc
	 * @return
	 */
	public School getSchoolByXxmc(School school);
	
	
	//分页获取学校信息
	public List<School> getSchoolList(RowBounds bounds, School school);
	public int getSchoolListCount(School school);
	
	public List<School> getSchoolByUser(RowBounds bounds, HashMap<String, Object> map);
	public int getSchoolCountByUser(HashMap<String, Object> map);
	
}
