package com.thinkgem.jeesite.modules.base.entity;

import java.io.Serializable;

public class ModelDetail implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String id;       //ID
	private String zbId;     //模板ID
	private String wjnr;     //问卷内容
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getZbId() {
		return zbId;
	}
	public void setZbId(String zbId) {
		this.zbId = zbId;
	}
	public String getWjnr() {
		return wjnr;
	}
	public void setWjnr(String wjnr) {
		this.wjnr = wjnr;
	}
}
