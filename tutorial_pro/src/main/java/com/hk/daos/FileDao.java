package com.hk.daos;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.hk.config.SqlMapConfig;
import com.hk.dtos.FileDto;

public class FileDao extends SqlMapConfig{

	private String namespace="com.hk.file.";
	
	public boolean insertFileInfo(FileDto dto) {
		int count=0;
		SqlSession sqlSession=null;
		
		try {
			sqlSession=getSqlSessionFactory().openSession(true);
			count=sqlSession.insert(namespace+"insertFileInfo", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return count>0?true:false;
	}
	
	public List<FileDto> getFileList(){
		List<FileDto> list=null;
		SqlSession sqlSession=null;
		
		try {
			sqlSession=getSqlSessionFactory().openSession(true);
			list=sqlSession.selectList(namespace+"getFileList");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return list;
	}
	
	public FileDto getFileInfo(int seq){
		FileDto dto=null;
		SqlSession sqlSession=null;
		
		try {
			sqlSession=getSqlSessionFactory().openSession(true);
			Map<String, Integer> map=new HashMap<String, Integer>();
			map.put("aseq", seq);
			dto=sqlSession.selectOne(namespace+"getFileList",map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return dto;
	}
}





