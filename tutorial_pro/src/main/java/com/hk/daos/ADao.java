package com.hk.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.hk.datasource.DataBase;
import com.hk.dtos.ADto;
import com.hk.dtos.LoginDto;

public class ADao extends DataBase{

	private static ADao aDao;
	private ADao() {}
	public static ADao getADao() {
		if(aDao==null) {
			aDao=new ADao();
		}
		return aDao;
	}
	
	//�۸�� ��ȸ�ϱ�
	public List<ADto> getAllList(){
		List<ADto> list=new ArrayList<>();
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		//ATITLE,
		String sql=" SELECT ASEQ,AID,ATITLE,ACONTENT,AREGDATE,AREFER "
				  +" ,ASTEP,ADEPTH,AREADCOUNT,ADELFLAG " 
				  +" FROM ABOARD " 
				  +" ORDER BY AREFER,ASTEP ";
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sql);
			rs=psmt.executeQuery();
			while(rs.next()) {
				int i=1;
				ADto dto=new ADto();
				dto.setAseq(rs.getInt(i++));
				dto.setAid(rs.getString(i++));
				dto.setAtitle(rs.getString(i++));
				dto.setAcontent(rs.getString(i++));
				dto.setAregdate(rs.getDate(i++));
				dto.setArefer(rs.getInt(i++));
				dto.setAstep(rs.getInt(i++));
				dto.setAdepth(rs.getInt(i++));
				dto.setAreadcount(rs.getInt(i++));
				dto.setAdelflag(rs.getString(i++));
				list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("JDBC����:getAllList():"+getClass());
			e.printStackTrace();
		}finally {
			close(rs, psmt, conn);
		}
		return list;
	}
	//���� �߰��ϱ�
	public boolean insertBoard(ADto dto) {
		int count=0;
		Connection conn=null;
		PreparedStatement psmt=null;
//		ResultSet rs=null;
		
		String sql=" INSERT INTO ABOARD " 
				+" VALUES (ABOARD_SEQ.NEXTVAL,?,?,?,SYSDATE "
				+" ,(SELECT NVL(MAX(arefer),0)+1 FROM ABOARD) , 0, 0, 0, 'N') ";
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, dto.getAid());
			psmt.setString(2, dto.getAtitle());
			psmt.setString(3, dto.getAcontent());
			count=psmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("JDBC����:insertBoard():"+getClass());
			e.printStackTrace();
		}finally {
			close(null, psmt, conn);
		}
		return count>0?true:false;
	}
	//�� �󼼺���
	public ADto getABoard(int seq){
		ADto dto=new ADto();
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		String sql=" SELECT ASEQ,AID,ATITLE,ACONTENT,AREGDATE,AREFER "
				  +" ,ASTEP,ADEPTH,AREADCOUNT,ADELFLAG " 
				  +" FROM ABOARD " 
				  +" WHERE ASEQ=? ";
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			rs=psmt.executeQuery();
			while(rs.next()) {
				int i=1;
				dto.setAseq(rs.getInt(i++));
				dto.setAid(rs.getString(i++));
				dto.setAtitle(rs.getString(i++));
				dto.setAcontent(rs.getString(i++));
				dto.setAregdate(rs.getDate(i++));
				dto.setArefer(rs.getInt(i++));
				dto.setAstep(rs.getInt(i++));
				dto.setAdepth(rs.getInt(i++));
				dto.setAreadcount(rs.getInt(i++));
				dto.setAdelflag(rs.getString(i++));
			}
		} catch (SQLException e) {
			System.out.println("JDBC����:getAnsBoard():"+getClass());
			e.printStackTrace();
		}finally {
			close(rs, psmt, conn);
		}
		return dto;
	}
	//�� �����ϱ�
	public boolean updateBoard(ADto dto) {
		int count=0;
		Connection conn=null;
		PreparedStatement psmt=null;
//		ResultSet rs=null;
		
		String sql=" UPDATE ABOARD "
				 + " SET ATITLE=?, ACONTENT=?,AREGDATE=SYSDATE "
				 + " WHERE ASEQ=? ";
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, dto.getAtitle());
			psmt.setString(2, dto.getAcontent());
			psmt.setInt(3, dto.getAseq());
			count=psmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("JDBC����:updateBoard():"+getClass());
			e.printStackTrace();
		}finally {
			close(null, psmt, conn);
		}
		return count>0?true:false;
	}
	//�� �����ϱ�(update�� ����)
	public boolean deleteBoard(String[] seqs) {
		int count=0;
		Connection conn=null;
		PreparedStatement psmt=null;
//		ResultSet rs=null;
		
		String sql=" UPDATE ABOARD "
				 + " SET ADELFLAG = 'Y' "
				 + " WHERE ASEQ IN ("+String.join(",", seqs)+") ";
		                                 // seqs[1,2,3,4]  ---> "WHERE SEQ IN (1,2,3,4)"
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sql);
			count=psmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("JDBC����:deleteBoard():"+getClass());
			e.printStackTrace();
		}finally {
			close(null, psmt, conn);
		}
		return count>0?true:false;
	}
	//�� ��ȸ��: update������ --> readcount�� ���� ������Ų��.--> ���� ��ȸ�Ҷ����� 
	public boolean readCount(int seq) {
		int count=0;
		Connection conn=null;
		PreparedStatement psmt=null;
//		ResultSet rs=null;
		
		String sql=" UPDATE ABOARD "
				 + " SET AREADCOUNT=AREADCOUNT+1 "
				 + " WHERE ASEQ=? ";
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			count=psmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("JDBC����:readCount():"+getClass());
			e.printStackTrace();
		}finally {
			close(null, psmt, conn);
		}
		return count>0?true:false;
	}
	//����߰��ϱ�
	// ������: step�� ���δ�? --> ������ ���ؼ� ���߰����� step���� �����ؾ� �Ѵ�.
	//       update�� ���� �� insert�� ����---> 2���� �۾��� �ѹ��� ����--> Ʈ������ ó�� �ʿ�
	public boolean replyBoard(ADto dto) {
		int count=0;
		Connection conn=null;
		PreparedStatement psmt=null;
		
		//���� �׷쿡�� �θ��� step���� ū �۵��� ���ؼ� step+1�� ����!!
		//update�ۼ� : �����������
		String sql1=" UPDATE ABOARD "
				+ " SET ASTEP=ASTEP+1 "
				+ " WHERE AREFER=(SELECT AREFER FROM ABOARD WHERE ASEQ = ?) "
				+ " AND ASTEP > (SELECT ASTEP FROM ABOARD WHERE ASEQ = ?) ";
		
		//����߰�: �θ��� refer, �θ��� step+1, �θ��� depth+1
		String sql2=" INSERT INTO ABOARD "
				+ "   VALUES(ABOARD_SEQ.NEXTVAL,?,?,?,SYSDATE "
				+ "        ,(SELECT AREFER FROM ABOARD WHERE ASEQ=?) "
				+ "        ,(SELECT ASTEP FROM ABOARD WHERE ASEQ=?)+1 "
				+ "        ,(SELECT ADEPTH FROM ABOARD WHERE ASEQ=?)+1, 0, 'N')";
		
		try {
			conn=getConnection();
			//transactionó��
			conn.setAutoCommit(false);//commit�� ����� �ڿ��� rollback�� �� �� ����
			psmt=conn.prepareStatement(sql1);//update�� �غ�
			psmt.setInt(1, dto.getAseq());
			psmt.setInt(2, dto.getAseq());
			psmt.executeUpdate();//update�� ����
			
			psmt=conn.prepareStatement(sql2);//insert�� �غ�
			psmt.setString(1, dto.getAid());
			psmt.setString(2, dto.getAtitle());
			psmt.setString(3, dto.getAcontent());
			psmt.setInt(4, dto.getAseq());
			psmt.setInt(5, dto.getAseq());
			psmt.setInt(6, dto.getAseq());
			count=psmt.executeUpdate();//insert������
			conn.commit();//commit����
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			System.out.println("JDBC����:replyBoard():"+getClass());
			e.printStackTrace();
		}finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			close(null, psmt, conn);
		}
		
		return count>0?true:false;
	}
	
	
}














