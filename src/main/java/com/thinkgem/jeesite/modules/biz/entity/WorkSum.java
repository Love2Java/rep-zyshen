/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.biz.entity;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;

/**
 * 工作总结Entity
 * @author ThinkGem
 * @version 2017-12-30
 */
public class WorkSum extends DataEntity<WorkSum> {

	private static final long serialVersionUID = 1L;
	
	private String ryId; 	// 人员Id
	private String rymc;    // 人员姓名
	private String djrq; 	// 单据日期
	private String djbh;    // 单据编号
	private String lb; 	    // 类别（月度总结或半年度总结）
	private String nd;      // 年度
	private String sj;      // 时间：（一至十二月、上半年、下半年）
	private String zjbt;    // 总结标题
	private String zjnr;    // 总结内容
	private String urls;    // 路径
	private String djly;    // 单据来源
	
	private List<UploadFileInfo> fileList;
	
	public WorkSum(){
		super();
	}

	public WorkSum(String id){
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

	public String getDjrq() {
		return djrq;
	}

	public void setDjrq(String djrq) {
		this.djrq = djrq;
	}

	public String getDjbh() {
		return djbh;
	}

	public void setDjbh(String djbh) {
		this.djbh = djbh;
	}

	public String getLb() {
		return lb;
	}

	public void setLb(String lb) {
		this.lb = lb;
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

	public String getZjbt() {
		return zjbt;
	}

	public void setZjbt(String zjbt) {
		this.zjbt = zjbt;
	}

	public String getZjnr() {
		return zjnr;
	}

	public void setZjnr(String zjnr) {
		this.zjnr = zjnr;
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