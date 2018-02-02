package com.thinkgem.jeesite.common.datatype;

public class DataGrid {
	private int page=1;
	private Object rows;
	private int total;

	public Object getRows() {
		return rows;
	}

	public void setRows(Object rows) {
		this.rows = rows;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}
	

	public DataGrid(){
	}


	public DataGrid(int pageIndex,int recordCount,Object data){
		setPage(pageIndex);
		setTotal(recordCount);
		setRows(data);		
	}

	

}
