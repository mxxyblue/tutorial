package com.hk.dtos;

public class TeamDto {
	private int team;
	private String tutor;
	private String tutee1;
	private String tutee2;
	private String tutee3;
	private String tutee4;
	public TeamDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TeamDto(int team, String tutor, String tutee1, String tutee2, String tutee3, String tutee4) {
		super();
		this.team = team;
		this.tutor = tutor;
		this.tutee1 = tutee1;
		this.tutee2 = tutee2;
		this.tutee3 = tutee3;
		this.tutee4 = tutee4;
	}
	public int getTeam() {
		return team;
	}
	public void setTeam(int team) {
		this.team = team;
	}
	public String getTutor() {
		return tutor;
	}
	public void setTutor(String tutor) {
		this.tutor = tutor;
	}
	public String getTutee1() {
		return tutee1;
	}
	public void setTutee1(String tutee1) {
		this.tutee1 = tutee1;
	}
	public String getTutee2() {
		return tutee2;
	}
	public void setTutee2(String tutee2) {
		this.tutee2 = tutee2;
	}
	public String getTutee3() {
		return tutee3;
	}
	public void setTutee3(String tutee3) {
		this.tutee3 = tutee3;
	}
	public String getTutee4() {
		return tutee4;
	}
	public void setTutee4(String tutee4) {
		this.tutee4 = tutee4;
	}
	@Override
	public String toString() {
		return "TeamDto [team=" + team + ", tutor=" + tutor + ", tutee1=" + tutee1 + ", tutee2=" + tutee2 + ", tutee3="
				+ tutee3 + ", tutee4=" + tutee4 + "]";
	}
	
	
}
