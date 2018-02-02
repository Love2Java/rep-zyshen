/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.entity;

import java.util.Date;
import java.util.List;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 问卷模板Entity
 * @author ThinkGem
 * @version 2017-12-28
 */
public class Models extends DataEntity<Models> {

	private static final long serialVersionUID = 1L;
	private String lx; 	  // 类型(家长或教师或学生代表)
	private int nd;       // 年度
	private String bbh;   // 版本号
	private String wjbt;  // 问卷标题
	private String wjjj;  // 问卷简介
	private String zt;    // 状态
	private String gbrId; // 关闭人ID
	private String gbrmc; // 关闭人名称
	private Date gbrq;    // 关闭日期
	
	private List<ModelDetail> detailList = Lists.newArrayList();//拥有的内容集合
	
	public Models(){
		super();
	}

	public Models(String id){
		super(id);
	}

	public String getLx() {
		return lx;
	}

	public void setLx(String lx) {
		this.lx = lx;
	}

	public int getNd() {
		return nd;
	}

	public void setNd(int nd) {
		this.nd = nd;
	}

	public String getBbh() {
		return bbh;
	}

	public void setBbh(String bbh) {
		this.bbh = bbh;
	}

	public String getWjbt() {
		return wjbt;
	}

	public void setWjbt(String wjbt) {
		this.wjbt = wjbt;
	}

	public String getWjjj() {
		return wjjj;
	}

	public void setWjjj(String wjjj) {
		this.wjjj = wjjj;
	}

	public String getZt() {
		return zt;
	}

	public void setZt(String zt) {
		this.zt = zt;
	}

	public String getGbrId() {
		return gbrId;
	}

	public void setGbrId(String gbrId) {
		this.gbrId = gbrId;
	}

	public String getGbrmc() {
		return gbrmc;
	}

	public void setGbrmc(String gbrmc) {
		this.gbrmc = gbrmc;
	}

	public Date getGbrq() {
		return gbrq;
	}

	public void setGbrq(Date gbrq) {
		this.gbrq = gbrq;
	}

	public List<ModelDetail> getDetailList() {
		return detailList;
	}

	public void setDetailList(List<ModelDetail> detailList) {
		this.detailList = detailList;
	}

}