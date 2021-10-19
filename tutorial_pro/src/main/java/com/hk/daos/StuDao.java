package com.hk.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.hk.config.SqlMapConfig;
import com.hk.datasource.DataBase;
import com.hk.dtos.StuDto;
import com.hk.dtos.TuDto;

public class StuDao extends SqlMapConfig{

	private static StuDao stuDao;
	private StuDao() {}
	public static StuDao getStuDao() {
		if(stuDao==null) {
			stuDao=new StuDao();
		}
		return stuDao;
	}
	
	//글목록 조회하기
	public List<StuDto> getAllList(String id){
		List<StuDto> list=new ArrayList<>();
		SqlSession sqlSession=null;
			
		try {
			sqlSession=getSqlSessionFactory().openSession(true);
			list=sqlSession.selectList("com.hk.stuboard.stuboardlist", id);
		} catch (Exception e) {
			System.out.println("JDBC실패:getAllList():"+getClass());
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return list;
	}
	//새글 추가하기
	public boolean insertBoard(StuDto dto) {
		int count=0;
		
		SqlSession sqlSession=null;
		
		try {
			sqlSession=getSqlSessionFactory().openSession(true);
			count=sqlSession.insert("com.hk.stuboard.insertboard", dto);
		} catch (Exception e) {
			System.out.println("JDBC실패:insertBoard():"+getClass());
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return count>0?true:false;
	}
	//글 상세보기
	public StuDto getStuBoard(int seq){
		StuDto dto = new StuDto();
		
		SqlSession sqlSession=null;
		
		try {
			sqlSession=getSqlSessionFactory().openSession(true);
//			dto=sqlSession.selectOne("com.hk.ansboard.getboard", seq);
			
			//다이나믹 쿼리를 사용하려면 파라미터를 Map에 담아서 전달해야 된다.
			Map<String, Integer>map=new HashMap<String, Integer>();
			map.put("sseq", seq);
			dto=sqlSession.selectOne("com.hk.stuboard.detailboardlist", map);
		} catch (Exception e) {
			System.out.println("JDBC실패:getStuBoard():"+getClass());
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return dto;
	}
	//글 수정하기
	public boolean updateBoard(StuDto dto) {
		int count=0;
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.update("com.hk.stuboard.updateboard", dto);
		} catch (Exception e) {
			System.out.println("JDBC실패:updateBoard():"+getClass());
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return count>0?true:false;
	}
	//글 삭제하기(update문 실행)
	public boolean deleteBoard(String[] seqs) {
		int count=0;
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			Map<String, String[]> map = new HashMap<String, String[]>();
			map.put("seqs", seqs);
			count = sqlSession.update("com.hk.stuboard.delboard", map);
		} catch (Exception e) {
			System.out.println("JDBC실패:deleteBoard():"+getClass());
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return count>0?true:false;
	}
	//글 조회수: update문실행 --> readcount의 값을 증가시킨다.--> 글을 조회할때마다 
	public boolean readCount(int seq) {
		int count=0;
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.update("com.hk.stuboard.readcount", seq);
		} catch (Exception e) {
			System.out.println("JDBC실패:readCount():"+getClass());
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return count>0?true:false;
	}
	//답글추가하기
	// 문제점: step이 꼬인다? --> 정렬을 위해서 글추가전에 step값을 수정해야 한다.
	//       update문 실행 후 insert문 실행---> 2개의 작업을 한번에 실행--> 트랜젝션 처리 필요
	public boolean replyBoard(StuDto dto) {
		int count=0;
		SqlSession sqlSession = null;
		
		try {
			//transaction 처리 : autocommit = false 설정
			sqlSession = getSqlSessionFactory().openSession(false); //transaction처리 
			sqlSession.update("com.hk.stuboard.replyupdate", dto);
			count = sqlSession.insert("com.hk.stuboard.replyinsert", dto);
			sqlSession.commit(); //정상실행 후 commit 실행 --> DB에 반영 //transaction ㅊ러ㅣ
		} catch (Exception e) { 
			sqlSession.rollback(); //transaction처리
			System.out.println("JDBC실패:replyBoard():"+getClass());
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return count>0?true:false;
	}
	

	//최신글 6개만 가져오기
	public List<StuDao> getRecentList(){
		List<StuDao> list=new ArrayList<>();
		SqlSession sqlSession=null;
			
		try {
			sqlSession=getSqlSessionFactory().openSession(true);
			list=sqlSession.selectList("com.hk.stuboard.recentlist");
		} catch (Exception e) {
			System.out.println("JDBC실패:getRecentList():"+getClass());
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return list;
	}
	
}






