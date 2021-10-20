package com.hk.dtos;

import java.util.Date;

public class SFileDto {

	private int fseq;
	private String sorigin_fname;
	private int sfile_size;
	private Date sf_regdate;
	private int sseq;
	
	public SFileDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SFileDto(int fseq, String sorigin_fname, int sfile_size, Date sf_regdate, int sseq) {
		super();
		this.fseq = fseq;
		this.sorigin_fname = sorigin_fname;
		this.sfile_size = sfile_size;
		this.sf_regdate = sf_regdate;
		this.sseq = sseq;
	}
	

	public SFileDto(String sorigin_fname, int sfile_size, int sseq) {
		super();
		this.sorigin_fname = sorigin_fname;
		this.sfile_size = sfile_size;
		this.sseq = sseq;
	}

	public SFileDto(String sorigin_fname, int sfile_size) {
		super();
		this.sorigin_fname = sorigin_fname;
		this.sfile_size = sfile_size;
	}

	public int getFseq() {
		return fseq;
	}

	public void setFseq(int fseq) {
		this.fseq = fseq;
	}

	public String getSorigin_fname() {
		return sorigin_fname;
	}

	public void setSorigin_fname(String sorigin_fname) {
		this.sorigin_fname = sorigin_fname;
	}

	public int getSfile_size() {
		return sfile_size;
	}

	public void setSfile_size(int sfile_size) {
		this.sfile_size = sfile_size;
	}

	public Date getSf_regdate() {
		return sf_regdate;
	}

	public void setSf_regdate(Date sf_regdate) {
		this.sf_regdate = sf_regdate;
	}

	public int getSseq() {
		return sseq;
	}

	public void setSseq(int sseq) {
		this.sseq = sseq;
	}

	@Override
	public String toString() {
		return "SFileDto [fseq=" + fseq + ", sorigin_fname=" + sorigin_fname + ", sfile_size=" + sfile_size
				+ ", sf_regdate=" + sf_regdate + ", sseq=" + sseq + "]";
	}

	
	
}
