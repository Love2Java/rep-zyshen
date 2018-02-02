/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.biz.entity;

import java.util.Date;
import java.util.List;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;

/**
 * 日常工作记录Entity
 * @author ThinkGem
 * @version 2018-01-02
 */
public class WorkRecord extends DataEntity<WorkRecord> {

	private static final long serialVersionUID = 1L;
	private String ryId; 	 // 人员Id
	private String rymc;     // 人员姓名
	private Date djrq; 	     // 单据日期
	private String djbh;     // 单据编号
	private String lb;       // 类别（随机、专项或综合）
	private String xxId;     // 学校ID
	private String xxmc;     // 学校名称
	private String ddzynr; 	 // 督导主要内容
	private String gzcj;     // 学校近期重点工作及成绩(管理、德育、教学、特色、文件等方面)
	private String bxqk;     // 学校规范办学情况（师德、落实课程建设、学生在校时间、阳光体育活动等）
	private String czwt;     // 存在问题、困难及处理情况
	private String yjjy;     // 对学校的意见及建议
	private String wtgjz;    // 问题关键字
	//private String wtgjzmc;  // 问题关键字全称
	private String urls;     // 路径
	private String bt;       // 标题
	private String djly;     // 单据来源
	
	private List<UploadFileInfo> fileList;
	
	public WorkRecord(){
		super();
	}

	public WorkRecord(String id){
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

	public Date getDjrq() {
		return djrq;
	}

	public void setDjrq(Date djrq) {
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

	public String getXxId() {
		return xxId;
	}

	public void setXxId(String xxId) {
		this.xxId = xxId;
	}

	public String getXxmc() {
		return xxmc;
	}

	public void setXxmc(String xxmc) {
		this.xxmc = xxmc;
	}

	public String getDdzynr() {
		return ddzynr;
	}

	public void setDdzynr(String ddzynr) {
		this.ddzynr = ddzynr;
	}

	public String getGzcj() {
		return gzcj;
	}

	public void setGzcj(String gzcj) {
		this.gzcj = gzcj;
	}

	public String getBxqk() {
		return bxqk;
	}

	public void setBxqk(String bxqk) {
		this.bxqk = bxqk;
	}

	public String getCzwt() {
		return czwt;
	}

	public void setCzwt(String czwt) {
		this.czwt = czwt;
	}

	public String getYjjy() {
		return yjjy;
	}

	public void setYjjy(String yjjy) {
		this.yjjy = yjjy;
	}

	public String getWtgjz() {
		return wtgjz;
	}

	public void setWtgjz(String wtgjz) {
		this.wtgjz = wtgjz;
	}

	public String getUrls() {
		return urls;
	}

	public void setUrls(String urls) {
		this.urls = urls;
	}

	public String getBt() {
		return bt;
	}

	public void setBt(String bt) {
		this.bt = bt;
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