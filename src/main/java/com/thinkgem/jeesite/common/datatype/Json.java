package com.thinkgem.jeesite.common.datatype;

public class Json {

	private String msg = "";
	private String msg2 = "";
	private Object obj = null;
	private boolean success = false;
	
	public Json() {
		
	}
	
	public Json(boolean success, String msg, String msg2, Object obj) {
		super();
		this.msg = msg;
		this.msg2 = msg2;
		this.obj = obj;
		this.success = success;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public String getMsg2() {
		return msg2;
	}

	public void setMsg2(String msg2) {
		this.msg2 = msg2;
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}
}
