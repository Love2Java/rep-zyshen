/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 工作内容Entity
 * @author ThinkGem
 * @version 2017-12-27
 */
public class JobContent extends DataEntity<JobContent> {

	private static final long serialVersionUID = 1L;
	private String mc; 	   // 工作内容名称
	private String gjz;    // 关键字，逗号拼接
	
	private String oldMc; //原学校名称
	
	public JobContent(){
		super();
	}

	public JobContent(String id){
		super(id);
	}

	public String getMc() {
		return mc;
	}

	public void setMc(String mc) {
		this.mc = mc;
	}

	public String getGjz() {
		return gjz;
	}

	public void setGjz(String gjz) {
		this.gjz = gjz;
	}

	public String getOldMc() {
		return oldMc;
	}

	public void setOldMc(String oldMc) {
		this.oldMc = oldMc;
	}

}