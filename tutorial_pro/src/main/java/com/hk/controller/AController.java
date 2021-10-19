package com.hk.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hk.daos.ADao;
import com.hk.daos.FileDao;
import com.hk.dtos.ADto;
import com.hk.dtos.FileDto;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.sf.json.JSONObject;

@WebServlet("/AController.do")
public class AController extends HttpServlet {
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
		String command=request.getParameter("command");
		
		//�̱�������
		ADao dao=ADao.getADao();
		FileDao fdao=new FileDao();
		//session��ü ����
		HttpSession session=request.getSession();
		if(command==null) {
			MultipartRequest multi=null;			

			String saveDirectory="C:/Academy/eclipse-workspace/tutorial_test/src/main/webapp/upload";
			
			//1024byte --> 1kbyte --> 1024kb --> 1MB
			int maxPostSize=1024*1024*10;
			
			try {
				multi=new MultipartRequest(request, saveDirectory, maxPostSize, "utf-8",
						                    new DefaultFileRenamePolicy());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			String id=multi.getParameter("id");
			String title=multi.getParameter("title");
			String content=multi.getParameter("content");
			
			boolean isS=dao.insertBoard(new ADto(id,title,content));
			
			String origin_fname=multi.getOriginalFileName("filename");//���ε��Ҷ� �������ϸ��ϱ�
			
			//String random32= UUID.randomUUID().toString().replaceAll("-", "");//"-"�����ϰ� 32�ڸ� ������
			String stored_fname=origin_fname.substring(origin_fname.lastIndexOf("."));
			                                          // "123.jpg".substring(3) --> ".jpg"
			
			int file_size=(int)multi.getFile("filename").length();// file.length() ��ȯŸ�� long
			
			boolean fisS=fdao.insertFileInfo(
					new FileDto(origin_fname,file_size));
			
			File oldFile=new File(saveDirectory+"/"+multi.getFilesystemName("filename"));
			File newFile=new File(saveDirectory+"/"+stored_fname);
			oldFile.renameTo(newFile);//old--> new�� ���ϸ� �ٲ�
			

			if(isS) {
				response.sendRedirect("AController.do?command=boardlist");
			}else {
				response.sendRedirect("error.jsp?msg="+URLEncoder.encode("3","utf-8"));
			}
		}
		else if(command.equals("boardlist")) {
//------��ȸ�� ó�� �ڵ� ����-------			
			//�۸���� ��û�ϸ� session �Ǵ� cookie�� ��������
			//1.session�����ϱ�
//			session.removeAttribute("readcount");
			
			//2.cookie�����ϱ�
			Cookie cookie=getCookie("rseq", request);
			if(cookie!=null) {
				cookie.setMaxAge(0);//�ش���Ű ����:��ȿ�Ⱓ�� 0���� ����
				response.addCookie(cookie);//Ŭ���̾�Ʈ�� �ݿ�				
			}
			
//			Cookie[] cookies=request.getCookies();
//			for (int i = 0; i < cookies.length; i++) {
//				if(cookies[i].getName().equals("rseq")) {
//					cookies[i].setMaxAge(0);//��ȿ�Ⱓ�� 0���� ����
//					response.addCookie(cookies[i]);//Ŭ���̾�Ʈ�� �ݿ�
//				}
//			}
//------------��ȸ������ �ڵ� ����---------
			
			List<ADto> list=dao.getAllList();
			request.setAttribute("list", list);
//			request.getRequestDispatcher("Aboardlist.jsp").forward(request, response);
			dispatch("Aboardlist.jsp", request, response);
		}else if(command.equals("muldel")) {
			//������ chk�� ���� ������ ���޵ȴ�. chk=4 chk=5...    chk[4,5,6,8]
			String[] chks=request.getParameterValues("chk");//���� �̸��� �� �������� ���� ��
			boolean isS=dao.deleteBoard(chks);
			if(isS) {
				jsForward("1", "AController.do?command=boardlist", response);
			}else {
				//controller�� �ͼ� �۾��ϰ� ������ �Ҷ� ������������ ������ �Ѵٸ� �ٽ� ��Ʈ�ѷ��� ��û
				// ������������ �ǹ̴� DB�� �����ؼ� ��� ���ͼ� ȭ�鿡 ����ϴ� �۾��� �ʿ��� ������
				String msg=URLEncoder.encode("2", "utf-8");
				response.sendRedirect("error.jsp?msg="+msg);
			}
		}else if(command.equals("insertform")) {
			response.sendRedirect("Ainsertboard.jsp");
		}else if(command.equals("detailboard")) {//�� �󼼺���(��ȸ�� ����)
			int seq=Integer.parseInt(request.getParameter("seq"));
			ADto dto=dao.getABoard(seq);
			
	//------��ȸ�� �ø����Ҷ� Ȯ�� �ڵ� ����---------//
			//session �̿��ϱ�: ���� ������ ��ȸ�� ���¸� Ȯ��
//			if(session.getAttribute("readcount")==null) {//readcount���� ���ٸ�
//				session.setAttribute("readcount", "readcount");
//				dao.readCount(seq);//��ȸ�� �ø���
//			}
			
			FileDto fdto = fdao.getFileInfo(seq);
			request.setAttribute("fdto", fdto);
			
			//��Ű�� ������ ��������(��ȯŸ��:�迭)
			Cookie[] cookies=request.getCookies();
			String s=null;
			for (int i = 0; i < cookies.length; i++) {
				if(cookies[i].getName().equals("rseq")) {
					s=cookies[i].getValue();
				}
			}
			
			//��Ű���� �۾��� �������� : "rseq"��� �̸��� ��Ⱚ�� ���� ��
			//���� ����� ��Ű�� ���� ��ȸ�� seq�� ���� �ٸ� ���
			if(s==null||!s.equals(seq+"")) {//seq�� int�� 4+""="4"�� ��ȯ
				Cookie cookie =new Cookie("rseq",seq+"");//��Ű����
				cookie.setMaxAge(10*60);//��Ű�� ��ȿ�Ⱓ
				response.addCookie(cookie);//�������� ������ ��Ű�� �߰�
				dao.readCount(seq);//��ȸ������
			}
			//------��ȸ�� �ø����Ҷ� Ȯ�� �ڵ� ����---------//

			
//			List<FileDto> list=fdao.getFileList();//file ��� ����
//			request.setAttribute("list", list);
//			request.getRequestDispatcher("Adetailboard.jsp").forward(request, response);
			
			request.setAttribute("dto", dto);
			dispatch("Adetailboard.jsp", request, response);
		}else if(command.equals("download")) {//���� �ٿ�ε��ϱ�
			//�ٿ�ε� ��û ���� ������ DB���� ��������
			int seq=Integer.parseInt(request.getParameter("aseq"));
			FileDto dto=fdao.getFileInfo(seq);
			
			//���� ���� ���
			String saveDirectory="C:/Academy/eclipse-workspace/tutorial_test/src/main/webapp/upload";
			
			String filePath=saveDirectory+"/"+dto.getAorigin_fname();
			
			File file=new File(filePath);//File��ü ����
			
//			int [] i=new int[3];//[0,0,0]
//			int []ii={1,2,3,4,5};
			//java�� �ѹ��� ���� �� �ִ� ���� ũ�⸸ŭ �迭�� ����
			byte[] b=new byte[(int)file.length()];
			
			//�������� ������ �� ������ �ʱ�ȭ
			response.reset();
			
			//�ٿ�ε��ϴ� ������ ������ �𸥴ٸ� octet-stream �����Ѵ�.
			//��) application/msword
			response.setContentType("application/octet-stream");
			
			//�ѱ����ڵ� : �ѱ����Ͽ� ��� �̸��� ������ ���� ����
			String encoding=new String(dto.getAorigin_fname().getBytes("utf-8"),"8859_1");
			
			//������ �ٿ�ε� ��ư�� Ŭ������ �� �ٿ�ε� ����ȭ���� �������� ó��
			//���ϸ��� �������ϸ����� �ٲ��ִ� �ڵ�
			response.setHeader("Content-Disposition", "attachment; filename="+encoding);
			
			FileInputStream in =null;//������ �о���̱� ���� ��ü(�Է�)
			ServletOutputStream out=null;//�������� ���� ��ü(���)
			
			try {
				//file�� �о���̱� ���� �������� �غ��Ѵ�.
				in=new FileInputStream(file);
				
				//����� ���� �������� �غ��Ѵ�.
				out=response.getOutputStream();
				
				//�о���̴� ���� ������ ����
				int numRead=0;
				//read()�� ���� ���� �о����
				while((numRead=in.read(b, 0, b.length))!=-1) {
					//write()�� ���� ���� ����ϱ�
					out.write(b, 0, numRead);
				}
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				out.flush();//���� �����Ͱ� ������ ��� �� �о�� ��������
				out.close();//out��ü �ݱ�
				in.close();//in��ü �ݱ�
			}
		}else if(command.equals("replyboard")) {
			int seq=Integer.parseInt(request.getParameter("seq"));
			String id=request.getParameter("id");
			String title=request.getParameter("title");
			String content=request.getParameter("content");
			
			boolean isS=dao.replyBoard(new ADto(seq,id,title,content));
			if(isS) {
				response.sendRedirect("AController.do?command=boardlist");
			}else {
				response.sendRedirect("error.jsp?msg="+(URLEncoder.encode("답글추가실패", "utf-8")));
			}
		}else if(command.equals("updateform")) {
			int seq=Integer.parseInt(request.getParameter("seq"));
			ADto dto = dao.getABoard(seq);
			request.setAttribute("dto", dto);
			dispatch("Aupdateboard.jsp",request,response);
		}else if(command.equals("updateboard")) {
			int seq=Integer.parseInt(request.getParameter("seq"));
			String title=request.getParameter("title");
			String content=request.getParameter("content");
			
			boolean isS=dao.updateBoard(new ADto(seq,title,content));
			
			if(isS) {
				//Adetailboard.jsp:응답할 페이지를 먼저 확인해본다
				//내가 수정한 글을 바로 조회해서 본다.
				response.sendRedirect("AController.do?command=detailboard&seq="+seq);
			}else {
				response.sendRedirect("error.jsp?msg="+URLEncoder.encode("수정실패","utf-8"));
			}
		}else if(command.equals("contentAjax")) {
			int seq=Integer.parseInt(request.getParameter("seq"));
			
			ADto dto = dao.getABoard(seq);	//seq에 대한 글상세 내용 조회 --> dto 담음
			//date타입은 json으로 변환 안됨
//			dto.setRegdate(null);//regdate만 값을 다시 정의
			Date regdate = dto.getAregdate();
			SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
			String regdateStr=sf.format(regdate);//date타입-->String으로 변환
			dto.setAregdateStr(regdateStr);
			dto.setAregdateStr(regdateStr);
			dto.setAregdate(null);
//-----------간단한 값 하나 응답할 때 text 타입 예시
			//요청한 페이지 응답하는 코드
			PrintWriter pw=response.getWriter();
			pw.print("������ seq��:"+seq);
			pw.print(dto.getAcontent());	//글의 내용만 꺼내서 클라이언트로 보냄
			
//-----------여러값을 json으로 응답할 때 코드 예시 : map-->json
			Map<String, ADto>map = new HashMap<>();
			map.put("dto", dto);
			
			//map구조 : key:value, json구조: key:value

			JSONObject obj=JSONObject.fromObject(map);	//map-->json 변환
			//PrintWriter pw = response.getWriter();
			obj.write(pw);//obj는 프린터가 업어서 프린터기를 빌려줌(pw)
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	//js forward �޼��� �����ϱ�: �˸�â�� ���鼭 �̵�
	public void jsForward(String msg,String url,HttpServletResponse response) throws IOException {
		String s="<script type='text/javascript'>"
				+ "		alert('"+msg+"');"
				+ "		location.href='"+url+"';"
				+ "</script>";
		
		PrintWriter pw=response.getWriter();
		pw.print(s);
	}
	
	//forward �޼��� �����ϱ�: ��ü�� �����ϸ鼭 �̵�
	public void dispatch(String url, HttpServletRequest request,HttpServletResponse response) 
		throws ServletException, IOException {
		request.getRequestDispatcher(url).forward(request, response);
	}

}
