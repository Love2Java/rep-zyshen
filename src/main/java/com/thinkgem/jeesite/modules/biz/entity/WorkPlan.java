/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.biz.entity;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;

/**
 * 工作计划Entity
 * @author ThinkGem
 * @version 2017-12-28
 */
public class WorkPlan extends DataEntity<WorkPlan> {

	private static final long serialVersionUID = 1L;
	private String ryId; 	// 人员Id
	private String rymc;    // 人员姓名
	private String nd;      // 年度
	private String sj;      // 时间：个人计划（上半年、下半年）、责任区计划（全年）
	private String lb; 	    // 类别：个人计划、责任区计划
	private String gjz;     // 关键字
	private String gznr;    // 工作内容
	private String urls;    // 路径
	private String djly;    // 单据来源
	
	private List<UploadFileInfo> fileList;
	
	public WorkPlan(){
		super();
	}

	public WorkPlan(String id){
		super(id);
	}

	public String getRyId() {
		return ryId;
	}

	public void setRyId(String ryId) {
		this.ryId = ryId;
	}

	public String getRymc() {
		return rymc;
	}

	public void setRymc(String rymc) {
		this.rymc = rymc;
	}

	public String getNd() {
		return nd;
	}

	public void setNd(String nd) {
		this.nd = nd;
	}

	public String getSj() {
		return sj;
	}

	public void setSj(String sj) {
		this.sj = sj;
	}

	public String getLb() {
		return lb;
	}

	public void setLb(String lb) {
		this.lb = lb;
	}

	public String getGjz() {
		return gjz;
	}

	public void setGjz(String gjz) {
		this.gjz = gjz;
	}

	public String getGznr() {
		return gznr;
	}

	public void setGznr(String gznr) {
		this.gznr = gznr;
	}

	public String getUrls() {
		return urls;
	}

	public void setUrls(String urls) {
		this.urls = urls;
	}

	public String getDjly() {
		return djly;
	}

	public void setDjly(String djly) {
		this.djly = djly;
	}

	public List<UploadFileInfo> getFileList() {
		return fileList;
	}

	public void setFileList(List<UploadFileInfo> fileList) {
		this.fileList = fileList;
	}
}