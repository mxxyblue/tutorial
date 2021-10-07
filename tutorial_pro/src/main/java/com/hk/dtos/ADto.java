package com.hk.dtos;

import java.util.Date;

public class ADto {
	private int aseq;
	private String aid;
	private String atitle;
	private String acontent;
	private Date aregdate;
	private int arefer;
	private int astep;
	private int adepth;
	private int areadcount;
	private String adelflag;
	private String aregdateStr;
	public ADto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ADto(int aseq, String aid, String atitle, String acontent, Date aregdate, int arefer, int astep, int adepth,
			int areadcount, String adelflag) {
		super();
		this.aseq = aseq;
		this.aid = aid;
		this.atitle = atitle;
		this.acontent = acontent;
		this.aregdate = aregdate;
		this.arefer = arefer;
		this.astep = astep;
		this.adepth = adepth;
		this.areadcount = areadcount;
		this.adelflag = adelflag;
	}
	public ADto(String aid, String atitle, String acontent) {
		super();
		this.aid = aid;
		this.atitle = atitle;
		this.acontent = acontent;
	}
	
	public ADto(int aseq, String aid, String atitle, String acontent) {
		super();
		this.aseq = aseq;
		this.aid = aid;
		this.atitle = atitle;
		this.acontent = acontent;
	}
	
	public ADto(int aseq, String atitle, String acontent) {
		super();
		this.aseq = aseq;
		this.atitle = atitle;
		this.acontent = acontent;
	}
	public int getAseq() {
		return aseq;
	}
	public void setAseq(int aseq) {
		this.aseq = aseq;
	}
	public String getAid() {
		return aid;
	}
	public void setAid(String aid) {
		this.aid = aid;
	}
	public String getAtitle() {
		return atitle;
	}
	public void setAtitle(String atitle) {
		this.atitle = atitle;
	}
	public String getAcontent() {
		return acontent;
	}
	public void setAcontent(String acontent) {
		this.acontent = acontent;
	}
	public Date getAregdate() {
		return aregdate;
	}
	public void setAregdate(Date aregdate) {
		this.aregdate = aregdate;
	}
	public int getArefer() {
		return arefer;
	}
	public void setArefer(int arefer) {
		this.arefer = arefer;
	}
	public int getAstep() {
		return astep;
	}
	public void setAstep(int astep) {
		this.astep = astep;
	}
	public int getAdepth() {
		return adepth;
	}
	public void setAdepth(int adepth) {
		this.adepth = adepth;
	}
	public int getAreadcount() {
		return areadcount;
	}
	public void setAreadcount(int areadcount) {
		this.areadcount = areadcount;
	}
	public String getAdelflag() {
		return adelflag;
	}
	public void setAdelflag(String adelflag) {
		this.adelflag = adelflag;
	}
	public void setAregdateStr(String aregdateStr) {
		this.aregdateStr = aregdateStr;
	}
	@Override
	public String toString() {
		return "ADto [aseq=" + aseq + ", aid=" + aid + ", atitle=" + atitle + ", acontent=" + acontent + ", aregdate="
				+ aregdate + ", arefer=" + arefer + ", astep=" + astep + ", adepth=" + adepth + ", areadcount="
				+ areadcount + ", adelflag=" + adelflag + "]";
	}
}
