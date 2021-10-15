package com.hk.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hk.daos.ADao;
import com.hk.daos.TeamDao;
import com.hk.dtos.TeamDto;

import net.sf.json.JSONObject;


@WebServlet("/TeamController.do")
public class TeamController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//���ϴ� ��Ű ���ϴ� �޼���
	public Cookie getCookie(String cookieName, HttpServletRequest request) {
		Cookie[] cookies=request.getCookies();
		Cookie cookie=null;
		for (int i = 0; i < cookies.length; i++) {
			if(cookies[i].getName().equals(cookieName)) {
				cookie=cookies[i];
			}
		}
		return cookie;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String command=request.getParameter("command");
		
		//�̱�������
		TeamDao dao=TeamDao.getTeamDao();
		//session��ü ����
		HttpSession session=request.getSession();
		
		if(command.equals("updateteamnum")) {
			String[] chks = new String[5];
			
			String[] chk=request.getParameterValues("chk");//���� �̸��� �� �������� ���� ��
			
			if(chk.length < 5) {
				for(int i=0;i<chk.length;i++) {
					chks[i]=chk[i];
				}
			}
			
			String tutor=chks[0];
			String tutee1=chks[1];
			String tutee2=chks[2];
			String tutee3=chks[3];
			String tutee4=chks[4];
			
			boolean isS=dao.insertBoard(new TeamDto(tutor,tutee1,tutee2,tutee3,tutee4));
			if(isS) {
				response.sendRedirect("updateteamnum.jsp");
			}else {
				response.sendRedirect("error.jsp?msg="+URLEncoder.encode("3","utf-8"));
			}
		}
			
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
