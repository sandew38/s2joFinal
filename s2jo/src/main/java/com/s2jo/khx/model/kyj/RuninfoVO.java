package com.s2jo.khx.model.kyj;

public class RuninfoVO {

	private String runinfoseq; 		// 운행정보 시퀀스
	private String trainno;			// 열차번호
	private String departure;		// 출발지
	private String departuretime;	// 출발시각
	private String arrival;			// 도착지
	private String arrivaltime;		//
	
	private String traintype;			// 기차종류 (1: ktx, 2: 3: )
	private String perminuterate;		// 분당운임 
		
	public RuninfoVO()
	{	// 기본 생성자
		
	}
	
	public RuninfoVO(String runinfoseq, String trainno, String departure, String departuretime, String arrival,
			String arrivaltime, String traintype, String perminuterate) {
		this.runinfoseq = runinfoseq;
		this.trainno = trainno;
		this.departure = departure;
		this.departuretime = departuretime;
		this.arrival = arrival;
		this.arrivaltime = arrivaltime;
		this.traintype = traintype;
		this.perminuterate = perminuterate;
	}





	public String getRuninfoseq() {
		return runinfoseq;
	}

	public void setRuninfoseq(String runinfoseq) {
		this.runinfoseq = runinfoseq;
	}

	public String getTrainno() {
		return trainno;
	}

	public void setTrainno(String trainno) {
		this.trainno = trainno;
	}

	public String getDeparture() {
		return departure;
	}

	public void setDeparture(String departure) {
		this.departure = departure;
	}

	public String getDeparturetime() {
		return departuretime;
	}

	public void setDeparturetime(String departuretime) {
		this.departuretime = departuretime;
	}

	public String getArrival() {
		return arrival;
	}

	public void setArrival(String arrival) {
		this.arrival = arrival;
	}

	public String getArrivaltime() {
		return arrivaltime;
	}

	public void setArrivaltime(String arrivaltime) {
		this.arrivaltime = arrivaltime;
	}

	public String getTraintype() {
		return traintype;
	}

	public void setTraintype(String traintype) {
		this.traintype = traintype;
	}

	public String getPerminuterate() {
		return perminuterate;
	}

	public void setPerminuterate(String perminuterate) {
		this.perminuterate = perminuterate;
	}

	
	
	
}
