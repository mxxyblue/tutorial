package com.hk.dtos;

import java.util.Date;

public class FileDto {

	private int fseq;
	private String aorigin_fname;
	private int afile_size;
	private Date af_regdate;
	private int aseq;
	
	public FileDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public FileDto(int fseq, String aorigin_fname, int afile_size, Date af_regdate, int aseq) {
		super();
		this.fseq = fseq;
		this.aorigin_fname = aorigin_fname;
		this.afile_size = afile_size;
		this.af_regdate = af_regdate;
		this.aseq = aseq;
	}

	public FileDto(String aorigin_fname, int afile_size) {
		super();
		this.aorigin_fname = aorigin_fname;
		this.afile_size = afile_size;
	}
	public FileDto(String aorigin_fname, int afile_size, int aseq) {
		super();
		this.aorigin_fname = aorigin_fname;
		this.afile_size = afile_size;
		this.aseq=aseq;
	}
	public int getFseq() {
		return fseq;
	}

	public void setFseq(int fseq) {
		this.fseq = fseq;
	}

	public String getAorigin_fname() {
		return aorigin_fname;
	}

	public void setAorigin_fname(String aorigin_fname) {
		this.aorigin_fname = aorigin_fname;
	}

	public int getAfile_size() {
		return afile_size;
	}

	public void setAfile_size(int afile_size) {
		this.afile_size = afile_size;
	}

	public Date getAf_regdate() {
		return af_regdate;
	}

	public void setAf_regdate(Date af_regdate) {
		this.af_regdate = af_regdate;
	}

	public int getAseq() {
		return aseq;
	}

	public void setAseq(int aseq) {
		this.aseq = aseq;
	}

	@Override
	public String toString() {
		return "FileDto [fseq=" + fseq + ", aorigin_fname=" + aorigin_fname + ", afile_size=" + afile_size
				+ ", af_regdate=" + af_regdate + ", aseq=" + aseq + "]";
	}
	
	
}
