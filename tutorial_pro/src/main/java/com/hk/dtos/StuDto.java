package com.hk.dtos;

import java.util.Date;

public class StuDto {

	private int sseq;
	private String sid;
	private String stitle;
	private String scontent;
	private Date sregdate;
	private int srefer;
	private int sstep;
	private int sdepth;
	private int sreadcount;
	private String sdelflag;
	private int teamnum;
	public StuDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public StuDto(int sseq, String sid, String stitle, String scontent, Date sregdate, int srefer, int sstep,
			int sdepth, int sreadcount, String sdelflag, int teamnum) {
		super();
		this.sseq = sseq;
		this.sid = sid;
		this.stitle = stitle;
		this.scontent = scontent;
		this.sregdate = sregdate;
		this.srefer = srefer;
		this.sstep = sstep;
		this.sdepth = sdepth;
		this.sreadcount = sreadcount;
		this.sdelflag = sdelflag;
		this.teamnum = teamnum;
	}
	public int getSseq() {
		return sseq;
	}
	public void setSseq(int sseq) {
		this.sseq = sseq;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getStitle() {
		return stitle;
	}
	public void setStitle(String stitle) {
		this.stitle = stitle;
	}
	public String getScontent() {
		return scontent;
	}
	public void setScontent(String scontent) {
		this.scontent = scontent;
	}
	public Date getSregdate() {
		return sregdate;
	}
	public void setSregdate(Date sregdate) {
		this.sregdate = sregdate;
	}
	public int getSrefer() {
		return srefer;
	}
	public void setSrefer(int srefer) {
		this.srefer = srefer;
	}
	public int getSstep() {
		return sstep;
	}
	public void setSstep(int sstep) {
		this.sstep = sstep;
	}
	public int getSdepth() {
		return sdepth;
	}
	public void setSdepth(int sdepth) {
		this.sdepth = sdepth;
	}
	public int getSreadcount() {
		return sreadcount;
	}
	public void setSreadcount(int sreadcount) {
		this.sreadcount = sreadcount;
	}
	public String getSdelflag() {
		return sdelflag;
	}
	public void setSdelflag(String sdelflag) {
		this.sdelflag = sdelflag;
	}
	public int getTeamnum() {
		return teamnum;
	}
	public void setTeamnum(int teamnum) {
		this.teamnum = teamnum;
	}
	@Override
	public String toString() {
		return "StuDto [sseq=" + sseq + ", sid=" + sid + ", stitle=" + stitle + ", scontent=" + scontent + ", sregdate="
				+ sregdate + ", srefer=" + srefer + ", sstep=" + sstep + ", sdepth=" + sdepth + ", sreadcount="
				+ sreadcount + ", sdelflag=" + sdelflag + ", teamnum=" + teamnum + "]";
	}

	
	
	
}
