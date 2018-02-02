/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.biz.entity;

import java.util.Date;
import java.util.List;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;

/**
 * 问题整改通知书Entity
 * @author ThinkGem
 * @version 2018-01-02
 */
public class WorkRectify extends DataEntity<WorkRectify> {

	private static final long serialVersionUID = 1L;
	private String zbId; 	 // 日常工作记录主键ID
	private String djbh;     // 单据编号
	private String xxId;     // 学校ID
	private String xxmc;     // 学校名称
	private String rymc;     // 人员名称
	private String gznr; 	 // 工作内容
	private String wtgjz;    // 问题关键字
	private String zgnr;     // 整改内容
	private Date xdrq;       // 下达日期
	private String dqzt;     // 当前状态（0：待处理；1：已计划；2：已回访；3：已汇报；4：已评价）
	private int xqsj;        // 限期时间(天)
	private String xxzgjh;   // 学校整改计划
	private String hfjl;     // 回访记录
	private String zgbg;     // 学校整改情况汇报
	private String pjjl;     // 评价记录
	
	private String urls;     // 路径
	private String bt;       // 标题
	private String djly;     // 单据来源
	
	private List<UploadFileInfo> fileList;
	
	public WorkRectify(){
		super();
	}

	public WorkRectify(String id){
		super(id);
	}

	public String getZbId() {
		return zbId;
	}

	public void setZbId(String zbId) {
		this.zbId = zbId;
	}

	public String getDjbh() {
		return djbh;
	}

	public void setDjbh(String djbh) {
		this.djbh = djbh;
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

	public String getRymc() {
		return rymc;
	}

	public void setRymc(String rymc) {
		this.rymc = rymc;
	}

	public String getGznr() {
		return gznr;
	}

	public void setGznr(String gznr) {
		this.gznr = gznr;
	}

	public String getWtgjz() {
		return wtgjz;
	}

	public void setWtgjz(String wtgjz) {
		this.wtgjz = wtgjz;
	}

	public String getZgnr() {
		return zgnr;
	}

	public void setZgnr(String zgnr) {
		this.zgnr = zgnr;
	}

	public Date getXdrq() {
		return xdrq;
	}

	public void setXdrq(Date xdrq) {
		this.xdrq = xdrq;
	}

	public String getDqzt() {
		return dqzt;
	}

	public void setDqzt(String dqzt) {
		this.dqzt = dqzt;
	}

	public int getXqsj() {
		return xqsj;
	}

	public void setXqsj(int xqsj) {
		this.xqsj = xqsj;
	}

	public String getXxzgjh() {
		return xxzgjh;
	}

	public void setXxzgjh(String xxzgjh) {
		this.xxzgjh = xxzgjh;
	}

	public String getHfjl() {
		return hfjl;
	}

	public void setHfjl(String hfjl) {
		this.hfjl = hfjl;
	}

	public String getZgbg() {
		return zgbg;
	}

	public void setZgbg(String zgbg) {
		this.zgbg = zgbg;
	}

	public String getPjjl() {
		return pjjl;
	}

	public void setPjjl(String pjjl) {
		this.pjjl = pjjl;
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