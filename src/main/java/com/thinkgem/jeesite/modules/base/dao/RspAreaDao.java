/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.base.entity.RspArea;

/**
 * 学校DAO接口
 * @author ThinkGem
 * @version 2017-12-22
 */
@MyBatisDao
public interface RspAreaDao extends CrudDao<RspArea> {

	//分页获取责任区信息
	public List<RspArea> getRspAreaList(RowBounds bounds, RspArea rspArea);
	public int getRspAreaListCount(RspArea rspArea);
	
	//根据用户ID获取责任区学校列表
	public List<RspArea> getSchoolsByUserId(String userId);
	
}
