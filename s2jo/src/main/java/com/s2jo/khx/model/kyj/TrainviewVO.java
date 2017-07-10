package com.s2jo.khx.model.kyj;

public class TrainviewVO {

	private String trainno; 
	private String traintype;
	private String departure;
	private String departuretime;
	private String arrival;
	private String arrivaltime; 
	private String turnaroundtime;
	private String perminuterate;
	private String rate;
	
	public TrainviewVO()
	{	// 기본생성자
		
	}
	
	public TrainviewVO(String trainno, String traintype, String departure, String departuretime, String arrival,
			String arrivaltime, String turnaroundtime, String perminuterate, String rate) {
		this.trainno = trainno;
		this.traintype = traintype;
		this.departure = departure;
		this.departuretime = departuretime;
		this.arrival = arrival;
		this.arrivaltime = arrivaltime;
		this.turnaroundtime = turnaroundtime;
		this.perminuterate = perminuterate;
		this.rate = rate;
	}

	public String getTrainno() {
		return trainno;
	}

	public void setTrainno(String trainno) {
		this.trainno = trainno;
	}

	public String getTraintype() {
		return traintype;
	}

	public void setTraintype(String traintype) {
		this.traintype = traintype;
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

	public String getTurnaroundtime() {
		return turnaroundtime;
	}

	public void setTurnaroundtime(String turnaroundtime) {
		this.turnaroundtime = turnaroundtime;
	}

	public String getPerminuterate() {
		return perminuterate;
	}

	public void setPerminuterate(String perminuterate) {
		this.perminuterate = perminuterate;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}
	
	
	
	
	
}
