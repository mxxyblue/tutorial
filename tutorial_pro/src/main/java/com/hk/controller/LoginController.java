package com.hk.controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.hk.daos.LoginDao;
import com.hk.dtos.LoginDto;

@WebServlet("/LoginController.do")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger=Logger.getLogger(CalController.class);
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command=request.getParameter("command");
		
		LoginDao dao=new LoginDao(); 
		
		if(command.equals("login")) {
			String id=request.getParameter("id");
			String password=request.getParameter("pw");
			
			LoginDto ldto=dao.getLogin(id, password);
			
			if(ldto==null||ldto.getId()==null) {
				String msg="회원정보를 확인하세요";
				response.sendRedirect("error.jsp?msg="+URLEncoder.encode(msg,"utf-8"));
			}else {
				logger.info("로그인 ID: "+ldto.getId());
				//session 스코프에 로그인 정보 담기
				request.getSession().setAttribute("ldto", ldto);
				request.getSession().setMaxInactiveInterval(10*60);
				
				if(ldto.getRole().toUpperCase().equals("ADMIN")) {
					response.sendRedirect("TuController.do?command=adminmain");
				}else if(ldto.getRole().toUpperCase().equals("TUTOR")) {
					response.sendRedirect("TuController.do?command=main2");
				}else if(ldto.getRole().toUpperCase().equals("TUTEE")) {
					response.sendRedirect("TuController.do?command=main2");
				}
			}
		}else if(command.equals("logout")) {
			request.getSession().invalidate();
			response.sendRedirect("index.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
