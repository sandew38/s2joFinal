package com.s2jo.khx.model.yyj;

public class AdminMemberVO {

	
	

	
   private String userid;
   private String name;
   private String pwd;
   private String email;
   private String hp;
   private String post;
   private String addr1;
   private String addr2;
   private String joindate;
   private int status;
   private String birthday;
   private int gender;
   
    public AdminMemberVO (){};  
    
   
public AdminMemberVO(String userid, String name, String pwd, String email, String hp, String post, String addr1,
		String addr2, String joindate, int status, String birthday, int gender) {
	
	this.userid = userid;
	this.name = name;
	this.pwd = pwd;
	this.email = email;
	this.hp = hp;
	this.post = post;
	this.addr1 = addr1;
	this.addr2 = addr2;
	this.joindate = joindate;
	this.status = status;
	this.birthday = birthday;
	this.gender = gender;
}


public String getUserid() {
	return userid;
}


public void setUserid(String userid) {
	this.userid = userid;
}


public String getName() {
	return name;
}


public void setName(String name) {
	this.name = name;
}


public String getPwd() {
	return pwd;
}


public void setPwd(String pwd) {
	this.pwd = pwd;
}


public String getEmail() {
	return email;
}


public void setEmail(String email) {
	this.email = email;
}


public String getHp() {
	return hp;
}


public void setHp(String hp) {
	this.hp = hp;
}


public String getPost() {
	return post;
}


public void setPost(String post) {
	this.post = post;
}


public String getAddr1() {
	return addr1;
}


public void setAddr1(String addr1) {
	this.addr1 = addr1;
}


public String getAddr2() {
	return addr2;
}


public void setAddr2(String addr2) {
	this.addr2 = addr2;
}


public String getJoindate() {
	return joindate;
}


public void setJoindate(String joindate) {
	this.joindate = joindate;
}

public int getStatus() {
	return status;
}


public void setStatus(int status) {
	this.status = status;
}


public String getBirthday() {
	return birthday;
}


public void setBirthday(String birthday) {
	this.birthday = birthday;
}


public int getGender() {
	return gender;
}


public void setGender(int gender) {
	this.gender = gender;
}



	
	
   
   
	
}

