/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 学校Entity
 * @author ThinkGem
 * @version 2017-12-22
 */
public class School extends DataEntity<School> {

	private static final long serialVersionUID = 1L;
	private String xxmc; 	// 学校名称
	private String xxlx;    // 学校类型
	private String xxlxmc;  // 学校类型名称
	private String dwdm; 	// 单位代码
	private String zcdz;    // 注册地址
	private String lxdh;    // 联系电话
	private String lxr;     // 联系人
	
	private String oldXxmc; //原学校名称
	
	public School(){
		super();
	}

	public School(String id){
		super(id);
	}

	public String getXxmc() {
		return xxmc;
	}

	public void setXxmc(String xxmc) {
		this.xxmc = xxmc;
	}

	public String getXxlx() {
		return xxlx;
	}

	public void setXxlx(String xxlx) {
		this.xxlx = xxlx;
	}

	public String getXxlxmc() {
		return xxlxmc;
	}

	public void setXxlxmc(String xxlxmc) {
		this.xxlxmc = xxlxmc;
	}

	public String getDwdm() {
		return dwdm;
	}

	public void setDwdm(String dwdm) {
		this.dwdm = dwdm;
	}

	public String getZcdz() {
		return zcdz;
	}

	public void setZcdz(String zcdz) {
		this.zcdz = zcdz;
	}

	public String getLxdh() {
		return lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}

	public String getLxr() {
		return lxr;
	}

	public void setLxr(String lxr) {
		this.lxr = lxr;
	}

	public String getOldXxmc() {
		return oldXxmc;
	}

	public void setOldXxmc(String oldXxmc) {
		this.oldXxmc = oldXxmc;
	}

}