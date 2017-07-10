package com.s2jo.khx.model.kyj;

public class TraininfoVO {
	
	private String traintype;			// 기차종류 (1: ktx, 2: 3: )
	private String trainno;				// 열차번호
	private String perminuterate;		// 분당운임 
	
	RuninfoVO RuninfoVO;
	
	public TraininfoVO()
	{	// 기본 생성자
		
	}
	
	public TraininfoVO(String traintype, String trainno, String perminuterate) {
		super();
		this.traintype = traintype;
		this.trainno = trainno;
		this.perminuterate = perminuterate;
	}

	public String getTraintype() {
		return traintype;
	}

	public void setTraintype(String traintype) {
		this.traintype = traintype;
	}

	public String getTrainno() {
		return trainno;
	}

	public void setTrainno(String trainno) {
		this.trainno = trainno;
	}

	public String getPerminuterate() {
		return perminuterate;
	}

	public void setPerminuterate(String perminuterate) {
		this.perminuterate = perminuterate;
	}
	
	
	
	
}
