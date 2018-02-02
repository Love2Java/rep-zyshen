/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 问卷分值Entity
 * @author ThinkGem
 * @version 2017-12-28
 */
public class Score extends DataEntity<Score> {

	private static final long serialVersionUID = 1L;
	private String da; 	   // 选项ABC
	private int fz;        // 分值
	private String bbh;    // 版本号
	
	public Score(){
		super();
	}

	public Score(String id){
		super(id);
	}

	public String getDa() {
		return da;
	}

	public void setDa(String da) {
		this.da = da;
	}

	public int getFz() {
		return fz;
	}

	public void setFz(int fz) {
		this.fz = fz;
	}

	public String getBbh() {
		return bbh;
	}

	public void setBbh(String bbh) {
		this.bbh = bbh;
	}

}