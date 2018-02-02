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
import com.thinkgem.jeesite.modules.base.dao.ScoreDao;
import com.thinkgem.jeesite.modules.base.entity.Score;

/**
 * 问卷分值Service
 * @author ThinkGem
 * @version 2017-12-28
 */
@Service
@Transactional(readOnly = true)
public class ScoreService extends CrudService<ScoreDao, Score> {
	
	
	@Autowired
	private ScoreDao scoreDao;

	public List<Score> findAll(){
		return null;
	}

	@Transactional(readOnly = false)
	public void save(Score score) {
		super.save(score);
	}
	
	@Transactional(readOnly = false)
	public void delete(Score score) {
		super.delete(score);
	}
	
	/**
	 * 分页查询所有分值信息
	 * @return
	 */
	public List<Score> getScoreList(int pageNo, int pageSize, Score score){
		return scoreDao.getScoreList(new RowBounds(pageSize*(pageNo-1), pageSize), score);
	}
	/**
	 * 查询所有分值count
	 * @return
	 */
	public int getScoreListCount(Score score){
		return scoreDao.getScoreListCount(score);
	}
	
	//新增或编辑验证
    public Score getScoreBySave(Score score) {
		
    	Score xx = scoreDao.getScoreBySave(score);
		
		if(null == xx) {
			return null;
		}
		
		return xx;
	}
	
}
