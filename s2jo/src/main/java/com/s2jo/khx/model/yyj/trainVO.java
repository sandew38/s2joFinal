package com.s2jo.khx.model.yyj;

public class trainVO {
	
private int runinfoseq;
private int trainno;
private String departure;
private String departuretime;
private String arrival;
private String arrivaltime;
private int status;

public trainVO (){}

public trainVO(int runinfoseq, int trainno, String departure, String departuretime, String arrival,
		String arrivaltime,int status) {
	
	this.runinfoseq = runinfoseq;
	this.trainno = trainno;
	this.departure = departure;
	this.departuretime = departuretime;
	this.arrival = arrival;
	this.arrivaltime = arrivaltime;
	this.status = status;
}

public int getRuninfoseq() {
	return runinfoseq;
}

public void setRuninfoseq(int runinfoseq) {
	this.runinfoseq = runinfoseq;
}

public int getTrainno() {
	return trainno;
}

public void setTrainno(int trainno) {
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

public int getStatus() {
	return status;
}

public void setStatus(int status) {
	this.status = status;
}




	
}