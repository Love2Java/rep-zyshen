/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.biz.entity;

import java.util.Date;
import java.util.List;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.UploadFileInfo;

/**
 * 工作掠影Entity
 * @author ThinkGem
 * @version 2017-12-30
 */
public class WorkPhoto extends DataEntity<WorkPhoto> {

	private static final long serialVersionUID = 1L;
	private String title; 	      // 标题
	private String publisher;     // 发布人
	private String publishermc;   // 发布人名称
	private Date releaseDate;     // 发布日期
	private String newsContent;   // 掠影内容
	private String classId;       // 类别：此处字典中取掠影
	private String classmc;       // 类别名称
	private String imgPath;       // 不用
	private String xxId; 	      // 学校ID
	private String xxmc; 	      // 学校名称
	private String checkId;       // 审核人ID
	private String checkmc;       // 审核人名称
	private Date checkDate;       // 审核日期
	private String states;        // 审核状态：0-未审核；1-审核
	private String djly;          // 单据来源：PC/APP
	
	private List<UploadFileInfo> fileList;
	
	public WorkPhoto(){
		super();
	}

	public WorkPhoto(String id){
		super(id);
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getPublishermc() {
		return publishermc;
	}

	public void setPublishermc(String publishermc) {
		this.publishermc = publishermc;
	}

	public Date getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(Date releaseDate) {
		this.releaseDate = releaseDate;
	}

	public String getNewsContent() {
		return newsContent;
	}

	public void setNewsContent(String newsContent) {
		this.newsContent = newsContent;
	}

	public String getClassId() {
		return classId;
	}

	public void setClassId(String classId) {
		this.classId = classId;
	}

	public String getClassmc() {
		return classmc;
	}

	public void setClassmc(String classmc) {
		this.classmc = classmc;
	}

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
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

	public String getCheckId() {
		return checkId;
	}

	public void setCheckId(String checkId) {
		this.checkId = checkId;
	}

	public String getCheckmc() {
		return checkmc;
	}

	public void setCheckmc(String checkmc) {
		this.checkmc = checkmc;
	}

	public Date getCheckDate() {
		return checkDate;
	}

	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
	}

	public String getStates() {
		return states;
	}

	public void setStates(String states) {
		this.states = states;
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