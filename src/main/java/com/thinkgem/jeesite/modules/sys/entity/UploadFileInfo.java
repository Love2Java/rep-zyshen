package com.thinkgem.jeesite.modules.sys.entity;

public class UploadFileInfo {
    
    private String id;      //外键ID
    private String autoId;  //主键
    private String tplj;    //文件路径
    private String tpmc;    //文件名称
    private String lx;      //文件类型
    private String nrlx;    //督学内容中类型ID
    private long fileSize;  //文件大小
    private String djly;    //单据来源
    
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAutoId() {
		return autoId;
	}
	public void setAutoId(String autoId) {
		this.autoId = autoId;
	}
	public String getTplj() {
		return tplj;
	}
	public void setTplj(String tplj) {
		this.tplj = tplj;
	}
	public String getTpmc() {
		return tpmc;
	}
	public void setTpmc(String tpmc) {
		this.tpmc = tpmc;
	}
	public String getLx() {
		return lx;
	}
	public void setLx(String lx) {
		this.lx = lx;
	}
	public String getNrlx() {
		return nrlx;
	}
	public void setNrlx(String nrlx) {
		this.nrlx = nrlx;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	public String getDjly() {
		return djly;
	}
	public void setDjly(String djly) {
		this.djly = djly;
	}
}
