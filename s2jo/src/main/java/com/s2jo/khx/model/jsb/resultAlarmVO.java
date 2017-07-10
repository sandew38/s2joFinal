package com.s2jo.khx.model.jsb;

public class resultAlarmVO {

	
	private String userid;//     varchar2(20)      not null
	private String resultCount;//      number default 0  not null 
	//alarm 도합 카운트
	
	
	public resultAlarmVO(){}
	
	public resultAlarmVO(String userid, String resultCount) {
		
	
		this.userid = userid;
		this.resultCount = resultCount;
	}
	

	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getResultCount() {
		return resultCount;
	}
	public void setResultCount(String resultCount) {
		this.resultCount = resultCount;
	}
	
	
}
