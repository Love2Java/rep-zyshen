package com.thinkgem.jeesite.common.datatype;

public class PageHelper implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private String order;// asc/desc
	private int page;// 当前页
	private int rows;// 每页显示记录数
	private String sort;// 排序字段

	public String getOrder() {
		return order;
	}

	public int getPage() {
		return page;
	}

	public int getRows() {
		return rows;
	}

	public String getSort() {
		return sort;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

}
