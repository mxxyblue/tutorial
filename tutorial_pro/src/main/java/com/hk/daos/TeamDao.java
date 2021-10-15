package com.hk.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.hk.datasource.DataBase;
import com.hk.dtos.TeamDto;

public class TeamDao extends DataBase{
	private static TeamDao teamDao;
	private TeamDao() {}
	public static TeamDao getTeamDao() {
		if(teamDao==null) {
			teamDao=new TeamDao();
		}
		return teamDao;
	}
	
	//�۸�� ��ȸ�ϱ�
	public List<TeamDto> getAllList(){
		List<TeamDto> list=new ArrayList<>();
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		//ATITLE,
		String sql=" SELECT TEAMNUM,TUTOR,TUTEE1,TUTEE2,TUTEE3,TUTEE4 "
				  +" FROM TEAM " 
				  +" ORDER BY TEAMNUM ";
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sql);
			rs=psmt.executeQuery();
			while(rs.next()) {
				int i=1;
				TeamDto dto=new TeamDto();
				dto.setTeam(rs.getInt(i++));
				dto.setTutor(rs.getString(i++));
				dto.setTutee1(rs.getString(i++));
				dto.setTutee2(rs.getString(i++));
				dto.setTutee3(rs.getString(i++));
				dto.setTutee4(rs.getString(i++));
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
	public boolean insertBoard(TeamDto dto) {
		int count=0;
		Connection conn=null;
		PreparedStatement psmt=null;
//		ResultSet rs=null;
		
		String sql=" INSERT INTO TEAM " 
				+" VALUES (TEAM_SEQ.NEXTVAL,?,?,?,?,?) ";
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, dto.getTutor());
			psmt.setString(2, dto.getTutee1());
			psmt.setString(3, dto.getTutee2());
			psmt.setString(4, dto.getTutee3());
			psmt.setString(5, dto.getTutee4());
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
	public TeamDto getTeamBoard(int seq){
		TeamDto dto=new TeamDto();
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		String sql=" SELECT TEAMNUM, TUTOR, TUTEE1, TUTEE2, TUTEE3, TUTEE4 "
				  +" FROM TEAM " 
				  +" WHERE TEAMNUM=? ";
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			rs=psmt.executeQuery();
			while(rs.next()) {
				int i=1;
				dto.setTeam(rs.getInt(i++));
				dto.setTutor(rs.getString(i++));
				dto.setTutee1(rs.getString(i++));
				dto.setTutee2(rs.getString(i++));
				dto.setTutee3(rs.getString(i++));
				dto.setTutee4(rs.getString(i++));
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
	public boolean updateBoard(TeamDto dto) {
		int count=0;
		Connection conn=null;
		PreparedStatement psmt=null;
//		ResultSet rs=null;
		
		String sql=" UPDATE TEAM "
				 + " SET TUTEE2=?, TUTEE3=?, TUTEE4=? "
				 + " WHERE TEAMNUM=? ";
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, dto.getTutee2());
			psmt.setString(2, dto.getTutee3());
			psmt.setString(3, dto.getTutee4());
			psmt.setInt(4, dto.getTeam());
			count=psmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("JDBC����:updateBoard():"+getClass());
			e.printStackTrace();
		}finally {
			close(null, psmt, conn);
		}
		return count>0?true:false;
	}
//	//�� �����ϱ�(update�� ����)
//	public boolean deleteBoard(String[] seqs) {
//		int count=0;
//		Connection conn=null;
//		PreparedStatement psmt=null;
////		ResultSet rs=null;
//		
//		String sql=" UPDATE ABOARD "
//				 + " SET ADELFLAG = 'Y' "
//				 + " WHERE ASEQ IN ("+String.join(",", seqs)+") ";
//		                                 // seqs[1,2,3,4]  ---> "WHERE SEQ IN (1,2,3,4)"
//		try {
//			conn=getConnection();
//			psmt=conn.prepareStatement(sql);
//			count=psmt.executeUpdate();
//		} catch (SQLException e) {
//			System.out.println("JDBC����:deleteBoard():"+getClass());
//			e.printStackTrace();
//		}finally {
//			close(null, psmt, conn);
//		}
//		return count>0?true:false;
//	}
}
