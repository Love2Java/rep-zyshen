/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.base.entity.Score;

/**
 * 问卷分值DAO接口
 * @author ThinkGem
 * @version 2017-12-28
 */
@MyBatisDao
public interface ScoreDao extends CrudDao<Score> {
	
	//分页获取问卷分值信息
	public List<Score> getScoreList(RowBounds bounds, Score score);
	public int getScoreListCount(Score score);
	
	//新增或编辑重复验证
	public Score getScoreBySave(Score score);
}
