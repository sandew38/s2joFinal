
package com.s2jo.khx.model.psc;

public class khxpscMemberVO {

	private String userid; 			/* 회원ID */
	private String name;			/* 회원명 */
	private String pwd;				/* 비밀번호 */
	private String email; 			/* 이메일주소 */
	private String hp;				/* 핸드폰번호 */
	private String post;			/* 우편번호 */
	private String addr1;			/* 집주소 */
	private String addr2;			/* 상세집주소 */
	private String joindate;		/* 가입날짜 */
	private int status;			/* 가입상태 default 1 : 회원가입, 0 : 탈퇴 */
	private String birthday;		/* 생년월일 가나다*/
	private int gender;				/* 성별 default 1 :남자, 2 :여자*/

	private String str_gender;
	
	public khxpscMemberVO() { }


	public khxpscMemberVO(String userid, String name, String pwd, String email, String hp, String post, String addr1,
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


	public String getStr_gender() {
		

		if (gender == 1)
		{
			str_gender = "남자";
		}
		
		if(gender == 2)
		{
			str_gender = "여자";
		}
		return str_gender;
	}
	

public void setStr_gender(String str_gender) {
	this.str_gender = str_gender;
}


}//end of public class khxpscNonMemberVO {
