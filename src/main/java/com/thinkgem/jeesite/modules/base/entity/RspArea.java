/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.base.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 责任区Entity
 * @author ThinkGem
 * @version 2017-12-27
 */
public class RspArea extends DataEntity<RspArea> {

	private static final long serialVersionUID = 1L;
	private String zrqId; 	 // 责任区编号
	private String zrqmc; 	 // 责任区名称（字典取）
	private String zrzId;    // 责任组编号
	private String zrzmc;    // 责任组名称（字典取）
	private String xxId;     // 学校编号
	private String xxmc;     // 学校名称
	private String zrdxryId; // 责任督学人员ID(人员ID，通过逗号隔开)
	private String zrdxrymc; // 责任督学人员名称(人员名称，通过逗号隔开)
	private String zzryId;   // 组长人员ID
	private String zzrymc;   // 组长人员名称
	private String llryId;   // 联络人员ID
	private String llrymc;   // 联络人员名称
	private String bbh;      // 版本号
	private String bbrq;     // 版本日期
	
	public RspArea(){
		super();
	}

	public RspArea(String id){
		super(id);
	}

	public String getZrqId() {
		return zrqId;
	}

	public void setZrqId(String zrqId) {
		this.zrqId = zrqId;
	}

	public String getZrqmc() {
		return zrqmc;
	}

	public void setZrqmc(String zrqmc) {
		this.zrqmc = zrqmc;
	}

	public String getZrzId() {
		return zrzId;
	}

	public void setZrzId(String zrzId) {
		this.zrzId = zrzId;
	}

	public String getZrzmc() {
		return zrzmc;
	}

	public void setZrzmc(String zrzmc) {
		this.zrzmc = zrzmc;
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

	public String getZrdxryId() {
		return zrdxryId;
	}

	public void setZrdxryId(String zrdxryId) {
		this.zrdxryId = zrdxryId;
	}

	public String getZrdxrymc() {
		return zrdxrymc;
	}

	public void setZrdxrymc(String zrdxrymc) {
		this.zrdxrymc = zrdxrymc;
	}

	public String getZzryId() {
		return zzryId;
	}

	public void setZzryId(String zzryId) {
		this.zzryId = zzryId;
	}

	public String getZzrymc() {
		return zzrymc;
	}

	public void setZzrymc(String zzrymc) {
		this.zzrymc = zzrymc;
	}

	public String getLlryId() {
		return llryId;
	}

	public void setLlryId(String llryId) {
		this.llryId = llryId;
	}

	public String getLlrymc() {
		return llrymc;
	}

	public void setLlrymc(String llrymc) {
		this.llrymc = llrymc;
	}

	public String getBbh() {
		return bbh;
	}

	public void setBbh(String bbh) {
		this.bbh = bbh;
	}

	public String getBbrq() {
		return bbrq;
	}

	public void setBbrq(String bbrq) {
		this.bbrq = bbrq;
	}

}