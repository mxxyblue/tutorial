package com.hk.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.hk.datasource.DataBase;
import com.hk.dtos.LoginDto;

public class LoginDao2 extends DataBase{

	//싱글톤 패턴
	private static LoginDao2 loginDao;
	private LoginDao2() {}
	public static LoginDao2 getLoginDao() {
		if(loginDao==null) {
			loginDao=new LoginDao2();
		}
		return loginDao;
	}

	//공통 기능: 로그인, 회원가입
	
	//로그인: DAO구현할 내용-> ID/PW를 입력했을때 DB에 ID와 PW가 일치하는 정보가 있는지 확인해서 
	//       jsp에서 처리할 내용->존재하면 해당 메인화면으로 이동하고, 아니면 로그인화면으로 다시 이동한다. 
	//쿼리: select문 사용 , 파라미터 id,pw  , 반환타입 LoginDto
	public LoginDto getLogin(String id, String password) {
		LoginDto dto=new LoginDto();
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		

		StringBuffer sb=new StringBuffer();
		sb.append(" SELECT ID, NAME, ADDRESS, EMAIL, PHONE, ENABLED, ROLE ");
		sb.append(" FROM MEMBER WHERE ID=? AND PASSWORD=? AND ENABLED='N' ");
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sb.toString());
			psmt.setString(1, id);
			psmt.setString(2, password);
			rs=psmt.executeQuery();
			while(rs.next()) {
				int i=1;
				dto.setId(rs.getString(i++));//id
				dto.setName(rs.getString(i++));
				dto.setAddress(rs.getString(i++));
				dto.setEmail(rs.getString(i++));
				dto.setPhone(rs.getString(i++));
				dto.setEnabled(rs.getString(i++));
				dto.setRole(rs.getString(i++));
				System.out.println("로그인정보:"+dto);
			}
		} catch (SQLException e) {
			System.out.println("JDBC실패:getLogin():"+getClass());
			e.printStackTrace();
		}finally {
			close(rs, psmt, conn);
		}
		return dto;
	}
	
	//회원가입: insert문 실행, 파리미터: Dto, 반환타입 boolean
	//  추가하는 정보중에 등급(role)의 초기값은 'USER', 사용중여부(enabled):'Y'
	public boolean insertUser(LoginDto dto) {
		int count=0;
		Connection conn=null;
		PreparedStatement psmt=null;
		
		StringBuffer sb=new StringBuffer();
		sb.append(" INSERT INTO MEMBER VALUES ");
		sb.append(" (?,?,?,?,?,?,'Y','TUTEE',SYSDATE) ");
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sb.toString());
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getPassword());
			psmt.setString(4, dto.getAddress());
			psmt.setString(5, dto.getPhone());
			psmt.setString(6, dto.getEmail());
			count=psmt.executeUpdate();//업데이트 된 행의 개수를 반환한다.
		} catch (SQLException e) {
			System.out.println("JDBC실패:insertUser():"+getClass());
			e.printStackTrace();
		}finally {
			close(null, psmt, conn);
		}
		return count>0?true:false;
	}
	
	//아이디 중복체크: 가입할 아이디가 기존 DB에 존재하는 여부 체크-select문실행, 파리미터 : 가입할 ID
	public String idChk(String id) {
		String resultId=null;
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		StringBuffer sb=new StringBuffer();
		sb.append(" SELECT ID");
		sb.append(" FROM MEMBER WHERE ID=? ");
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sb.toString());
			psmt.setString(1, id);
//			psmt.setString(2, password);
			rs=psmt.executeQuery();
			while(rs.next()) {
				resultId=rs.getString(1);//id
			}
		} catch (SQLException e) {
			System.out.println("JDBC실패:idChk():"+getClass());
			e.printStackTrace();
		}finally {
			close(rs, psmt, conn);
		}
		return resultId;
	}
	
	//전체회원조회(상태조회) : select문 where절이 없다.
	//반환 타입 : 결과가 여러행 반환 --> List
	public List<LoginDto> getAllUserStatus(){
		List<LoginDto> list=new ArrayList<>();
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		StringBuffer sb=new StringBuffer();
		sb.append(" SELECT ID,NAME,ADDRESS,PHONE,EMAIL,ENABLED,ROLE,REGDATE ");
		sb.append(" FROM MEMBER ORDER BY NAME ");
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sb.toString());
			rs=psmt.executeQuery();
			while(rs.next()) {
				int i=1;
				LoginDto dto=new LoginDto();//하나의 행의 데이터를 담을 객체
				//rs에 있는 varchar2타입의 id를 java 타입인  String타입으로 변환해서 가져온다.
				dto.setId(rs.getString(i++));
				dto.setName(rs.getString(i++));
				dto.setAddress(rs.getString(i++));
				dto.setPhone(rs.getString(i++));
				dto.setEmail(rs.getString(i++));
				dto.setEnabled(rs.getString(i++));
				dto.setRole(rs.getString(i++));
				dto.setRegdate(rs.getDate(i++));
				list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("JDBC실패:getAllUserStatus():"+getClass());
			e.printStackTrace();
		}finally {
			close(rs, psmt, conn);
		}
		
		return list;
	}
	
	//사용중인 회원정보 목록 조회: select문 실행 where 추가 --> enabled='Y'
	public List<LoginDto> getAllUser(){
		List<LoginDto> list=new ArrayList<>();
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		StringBuffer sb=new StringBuffer();
		sb.append(" SELECT ID,NAME,ADDRESS,PHONE,EMAIL,ENABLED,ROLE,REGDATE ");
		sb.append(" FROM MEMBER WHERE ENABLED='Y' ORDER BY NAME ");
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sb.toString());
			rs=psmt.executeQuery();
			while(rs.next()) {
				int i=1;
				LoginDto dto=new LoginDto();//하나의 행의 데이터를 담을 객체
				//rs에 있는 varchar2타입의 id를 java 타입인  String타입으로 변환해서 가져온다.
				dto.setId(rs.getString(i++));
				dto.setName(rs.getString(i++));
				dto.setAddress(rs.getString(i++));
				dto.setPhone(rs.getString(i++));
				dto.setEmail(rs.getString(i++));
				dto.setEnabled(rs.getString(i++));
				dto.setRole(rs.getString(i++));
				dto.setRegdate(rs.getDate(i++));
				list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("JDBC실패:getAllUser():"+getClass());
			e.printStackTrace();
		}finally {
			close(rs, psmt, conn);
		}
		
		return list;
	}
	//사용중인 회원정보 목록 조회: select문 실행 where 추가 --> enabled='Y'
	public List<LoginDto> getAllUserTeam(){
		List<LoginDto> list=new ArrayList<>();
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		StringBuffer sb=new StringBuffer();
		sb.append(" SELECT ID,NAME,ADDRESS,PHONE,EMAIL,ENABLED,ROLE,REGDATE ");
		sb.append(" FROM MEMBER WHERE ENABLED='Y' ORDER BY ROLE DESC");
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sb.toString());
			rs=psmt.executeQuery();
			while(rs.next()) {
				int i=1;
				LoginDto dto=new LoginDto();//하나의 행의 데이터를 담을 객체
				//rs에 있는 varchar2타입의 id를 java 타입인  String타입으로 변환해서 가져온다.
				dto.setId(rs.getString(i++));
				dto.setName(rs.getString(i++));
				dto.setAddress(rs.getString(i++));
				dto.setPhone(rs.getString(i++));
				dto.setEmail(rs.getString(i++));
				dto.setEnabled(rs.getString(i++));
				dto.setRole(rs.getString(i++));
				dto.setRegdate(rs.getDate(i++));
				list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("JDBC실패:getAllUser():"+getClass());
			e.printStackTrace();
		}finally {
			close(rs, psmt, conn);
		}
		
		return list;
	}
	//회원 한명에 대한 상세 조회 : select 문 where id
	//반환타입: LoginDto 하나의 행이 반환
	public LoginDto getUser(String id){
		LoginDto dto=new LoginDto();
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		StringBuffer sb=new StringBuffer();
		sb.append(" SELECT ID,NAME,ADDRESS,PHONE,EMAIL,ENABLED,ROLE,REGDATE ");
		sb.append(" FROM MEMBER WHERE ENABLED='Y' AND ID=? ");
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sb.toString());
			psmt.setString(1, id);
			rs=psmt.executeQuery();
			while(rs.next()) {
				int i=1;
				
				//rs에 있는 varchar2타입의 id를 java 타입인  String타입으로 변환해서 가져온다.
				dto.setId(rs.getString(i++));
				dto.setName(rs.getString(i++));
				dto.setAddress(rs.getString(i++));
				dto.setPhone(rs.getString(i++));
				dto.setEmail(rs.getString(i++));
				dto.setEnabled(rs.getString(i++));
				dto.setRole(rs.getString(i++));
				dto.setRegdate(rs.getDate(i++));
				
			}
		} catch (SQLException e) {
			System.out.println("JDBC실패:getUser():"+getClass());
			e.printStackTrace();
		}finally {
			close(rs, psmt, conn);
		}
		
		return dto;
	}
	
	//회원의 등급 변경: update문 where id , role 변경 --> 파라미터 id,role
	//반환타입: 없음 --> true/false
	public boolean updateRoleUser(String id, String role) {
		int count=0;
		Connection conn=null;
		PreparedStatement psmt=null;
		
		StringBuffer sb=new StringBuffer();
		sb.append(" UPDATE MEMBER SET ROLE=? WHERE ID=? ");
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sb.toString());
			psmt.setString(1, role);
			psmt.setString(2, id);
			count=psmt.executeUpdate();//업데이트 된 행의 개수를 반환한다.
		} catch (SQLException e) {
			System.out.println("JDBC실패:updateRoleUser():"+getClass());
			e.printStackTrace();
		}finally {
			close(null, psmt, conn);
		}
		return count>0?true:false;
	}
	
	//회원 탈퇴하기: update문 실행 enabled='N' 변경
	// 결과 없음 : true/false  파라미터 id
	public boolean deleteUser(String id) {
		int count=0;
		Connection conn=null;
		PreparedStatement psmt=null;
		
		StringBuffer sb=new StringBuffer();
		sb.append(" UPDATE MEMBER SET ENABLED='N' WHERE ID=? ");
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sb.toString());
			psmt.setString(1, id);
			count=psmt.executeUpdate();//업데이트 된 행의 개수를 반환한다.
		} catch (SQLException e) {
			System.out.println("JDBC실패:deleteUser():"+getClass());
			e.printStackTrace();
		}finally {
			close(null, psmt, conn);
		}
		return count>0?true:false;
	}
	
	//나의 정보 수정하기: update문 실행 , 수정할 내용: 주소, 전화번호, 이메일
	//결과 없음 : true/false , 파라미터: ID, 수정할 addr, phone, email
	public boolean updateUser(LoginDto dto) {
		int count=0;
		Connection conn=null;
		PreparedStatement psmt=null;
		
		StringBuffer sb=new StringBuffer();
		sb.append(" UPDATE MEMBER SET ADDRESS=?,PHONE=?,EMAIL=? WHERE ID=? ");
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sb.toString());
			psmt.setString(1, dto.getAddress());
			psmt.setString(2, dto.getPhone());
			psmt.setString(3, dto.getEmail());
			psmt.setString(4, dto.getId());
			count=psmt.executeUpdate();//업데이트 된 행의 개수를 반환한다.
		} catch (SQLException e) {
			System.out.println("JDBC실패:updateUser():"+getClass());
			e.printStackTrace();
		}finally {
			close(null, psmt, conn);
		}
		return count>0?true:false;
	}
}

















