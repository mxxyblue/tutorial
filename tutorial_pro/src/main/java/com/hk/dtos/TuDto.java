package com.hk.dtos;

import java.util.Date;

public class TuDto {

	private String regdateStr;
	private int tseq;
	private String tid;
	private String ttitle;
	private String tcontent;
	private Date tregdate;
	private int trefer;
	private int tstep;
	private int tdepth;
	private int treadcount;
	private String tdelflag;
	public TuDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TuDto(String regdateStr, int tseq, String tid, String ttitle, String tcontent, Date tregdate, int trefer,
			int tstep, int tdepth, int treadcount, String tdelflag) {
		super();
		this.regdateStr = regdateStr;
		this.tseq = tseq;
		this.tid = tid;
		this.ttitle = ttitle;
		this.tcontent = tcontent;
		this.tregdate = tregdate;
		this.trefer = trefer;
		this.tstep = tstep;
		this.tdepth = tdepth;
		this.treadcount = treadcount;
		this.tdelflag = tdelflag;
	}

	
	
	
	
	
	public TuDto(int tseq, String ttitle, String tcontent) {
		super();
		this.tseq = tseq;
		this.ttitle = ttitle;
		this.tcontent = tcontent;
	}
	public TuDto(int tseq, String tid, String ttitle, String tcontent) {
		super();
		this.tseq = tseq;
		this.tid = tid;
		this.ttitle = ttitle;
		this.tcontent = tcontent;
	}
	public TuDto(String tid, String ttitle, String tcontent) {
		super();
		this.tid = tid;
		this.ttitle = ttitle;
		this.tcontent = tcontent;
	}
	public String getRegdateStr() {
		return regdateStr;
	}
	public void setRegdateStr(String regdateStr) {
		this.regdateStr = regdateStr;
	}
	public int getTseq() {
		return tseq;
	}
	public void setTseq(int tseq) {
		this.tseq = tseq;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getTtitle() {
		return ttitle;
	}
	public void setTtitle(String ttitle) {
		this.ttitle = ttitle;
	}
	public String getTcontent() {
		return tcontent;
	}
	public void setTcontent(String tcontent) {
		this.tcontent = tcontent;
	}
	public Date getTregdate() {
		return tregdate;
	}
	public void setTregdate(Date tregdate) {
		this.tregdate = tregdate;
	}
	public int getTrefer() {
		return trefer;
	}
	public void setTrefer(int trefer) {
		this.trefer = trefer;
	}
	public int getTstep() {
		return tstep;
	}
	public void setTstep(int tstep) {
		this.tstep = tstep;
	}
	public int getTdepth() {
		return tdepth;
	}
	public void setTdepth(int tdepth) {
		this.tdepth = tdepth;
	}
	public int getTreadcount() {
		return treadcount;
	}
	public void setTreadcount(int treadcount) {
		this.treadcount = treadcount;
	}
	public String getTdelflag() {
		return tdelflag;
	}
	public void setTdelflag(String tdelflag) {
		this.tdelflag = tdelflag;
	}
	@Override
	public String toString() {
		return "TuDto [regdateStr=" + regdateStr + ", tseq=" + tseq + ", tid=" + tid + ", ttitle=" + ttitle
				+ ", tcontent=" + tcontent + ", tregdate=" + tregdate + ", trefer=" + trefer + ", tstep=" + tstep
				+ ", tdepth=" + tdepth + ", treadcount=" + treadcount + ", tdelflag=" + tdelflag + "]";
	}

	
}
