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

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hk.daos.SFileDao;
import com.hk.daos.StuDao;
import com.hk.dtos.ADto;
import com.hk.dtos.LoginDto;
import com.hk.dtos.SFileDto;
import com.hk.dtos.StuDto;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.sf.json.JSONObject;


@WebServlet("/StuController.do")
public class StuController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//원하는 쿠키 구하는 메서드
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
		
		//싱글턴패턴
		StuDao dao=StuDao.getStuDao();
		SFileDao fdao=new SFileDao();
		//session객체 구함
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
	         if(multi.getParameter("command").equals("insertboard")) {     

	            String id=multi.getParameter("id");
	            String title=multi.getParameter("title");
	            String content=multi.getParameter("content");
	            
	            boolean isS=dao.insertBoard(new StuDto(id,title,content));
	            
	            String origin_fname=multi.getOriginalFileName("filename");//   ε  Ҷ         ϸ  ϱ 
	            
	            //String random32= UUID.randomUUID().toString().replaceAll("-", "");//"-"     ϰ  32 ڸ        
	            String stored_fname=origin_fname.substring(origin_fname.lastIndexOf("."));
	                                                      // "123.jpg".substring(3) --> ".jpg"
	            
	            int file_size=(int)multi.getFile("filename").length();// file.length()   ȯŸ   long
	            
	            boolean fisS=fdao.insertFileInfo(
	                  new SFileDto(origin_fname,file_size));
	            
	            File oldFile=new File(saveDirectory+"/"+multi.getFilesystemName("filename"));
	            File newFile=new File(saveDirectory+"/"+stored_fname);
	            oldFile.renameTo(newFile);//old--> new      ϸ   ٲ 
	               
	            if(isS) {
	               response.sendRedirect("StuController.do?command=boardlist");
	            }else {
	               response.sendRedirect("error.jsp?msg="+URLEncoder.encode("3","utf-8"));
	            }
	         }else if(multi.getParameter("command").equals("updateboard")) {
	             
	                int seq=Integer.parseInt(multi.getParameter("seq"));
	                String title=multi.getParameter("title");
	                String content=multi.getParameter("content");
	                
	                StuDto dto=dao.getStuBoard(seq);
	                request.setAttribute("dto", dto);
	                                                                  
	                if(multi.getOriginalFileName("filename")!=null) {
	                   String origin_fname=multi.getOriginalFileName("filename");//   ε  Ҷ         ϸ  ϱ 
	                
	                   //String random32= UUID.randomUUID().toString().replaceAll("-", "");//"-"     ϰ  32 ڸ        
	                   String stored_fname=origin_fname.substring(origin_fname.lastIndexOf("."));
	                    
	                   int file_size=(int)multi.getFile("filename").length();// file.length()   ȯŸ   long
	                   
	                   boolean fisS=fdao.updateFile(
	                            new SFileDto(origin_fname, file_size, seq));
	                      
	                      File oldFile=new File(saveDirectory+"/"+multi.getFilesystemName("filename"));
	                      File newFile=new File(saveDirectory+"/"+stored_fname);
	                      oldFile.renameTo(newFile);//old--> new                              // "123.jpg".substring(3) --> ".jpg"
	                }
	                
	                SFileDto fdto = fdao.getFileInfo(seq);
	                request.setAttribute("fdto", fdto);       
	                
	                boolean isS=dao.updateBoard(new StuDto(seq,title,content));           
	                      
	                if(isS) {
	                   //Adetailboard.jsp:응답할 페이지를 먼저 확인해본다
	                   //내가 수정한 글을 바로 조회해서 본다.
	                   response.sendRedirect("StuController.do?command=detailboard&seq="+seq);
	                }else {
	                   response.sendRedirect("error.jsp?msg="+URLEncoder.encode("수정실패","utf-8"));
	                }
	         
		}
	         }else if(command.equals("download")) {//      ٿ ε  ϱ 
	         // ٿ ε    û             DB             
	         int seq=Integer.parseInt(request.getParameter("sseq"));
	         SFileDto dto=fdao.getFileInfo(seq);
	         
	         //             
	         String saveDirectory="C:/Academy/eclipse-workspace/tutorial_test/src/main/webapp/upload";
	         
	         String filePath=saveDirectory+"/"+dto.getSorigin_fname();
	         
	         File file=new File(filePath);//File  ü     
	         
//	         int [] i=new int[3];//[0,0,0]
//	         int []ii={1,2,3,4,5};
	         //java    ѹ             ִ       ũ ⸸ŭ  迭       
	         byte[] b=new byte[(int)file.length()];
	         
	         //                           ʱ ȭ
	         response.reset();
	         
	         // ٿ ε  ϴ                 𸥴ٸ  octet-stream      Ѵ .
	         //  ) application/msword
	         response.setContentType("application/octet-stream");
	         
	         // ѱ    ڵ  :  ѱ    Ͽ       ̸                    
	         String encoding=new String(dto.getSorigin_fname().getBytes("utf-8"),"8859_1");
	         
	         //        ٿ ε    ư   Ŭ           ٿ ε      ȭ              ó  
	         //   ϸ           ϸ       ٲ  ִ   ڵ 
	         response.setHeader("Content-Disposition", "attachment; filename="+encoding);
	         
	         FileInputStream in =null;//        о   ̱         ü( Է )
	         ServletOutputStream out=null;//                ü(   )
	         
	         try {
	            //file    о   ̱                 غ  Ѵ .
	            in=new FileInputStream(file);
	            
	            //                     غ  Ѵ .
	            out=response.getOutputStream();
	            
	            // о   ̴                  
	            int numRead=0;
	            //read()              о    
	            while((numRead=in.read(b, 0, b.length))!=-1) {
	               //write()                 ϱ 
	               out.write(b, 0, numRead);
	            }
	         } catch (FileNotFoundException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	         }finally {
	            out.flush();//          Ͱ                 о           
	            out.close();//out  ü  ݱ 
	            in.close();//in  ü  ݱ 
	         }
	      } else if(command.equals("boardlist")) {
//------조회수 처리 코드 시작-------			
			//글목록을 요청하면 session 또는 cookie를 삭제하자
			//1.session삭제하기
//			session.removeAttribute("readcount");
			
			//2.cookie삭제하기
			Cookie cookie=getCookie("rseq", request);
			if(cookie!=null) {
				cookie.setMaxAge(0);//해당쿠키 삭제:유효기간을 0으로 설정
				response.addCookie(cookie);//클라이언트에 반영				
			}
			
//			Cookie[] cookies=request.getCookies();
//			for (int i = 0; i < cookies.length; i++) {
//				if(cookies[i].getName().equals("rseq")) {
//					cookies[i].setMaxAge(0);//유효기간을 0으로 설정
//					response.addCookie(cookies[i]);//클라이언트로 반영
//				}
//			}
//------------조회수관련 코드 종료---------
			LoginDto ldto = (LoginDto) session.getAttribute("ldto");
			
			List<StuDto> list=dao.getAllList(ldto.getId());
			request.setAttribute("list", list);
//			request.getRequestDispatcher("boardlist.jsp").forward(request, response);
			dispatch("stuboardlist.jsp", request, response);
		}else if(command.equals("muldel")) {
			//삭제할 chk의 값이 여러개 전달된다. chk=4 chk=5...    chk[4,5,6,8]
			String[] chks=request.getParameterValues("chk");//같은 이름의 값 여러개를 받을 때
			boolean isS=dao.deleteBoard(chks);
			if(isS) {
				jsForward("글을 삭제합니다", "StuController.do?command=boardlist", response);
			}else {
				//controller에 와서 작업하고 응답을 할때 동적페이지로 응답을 한다면 다시 컨트롤러를 요청
				// 동적페이지의 의미는 DB에 접속해서 결과 얻어와서 화면에 출력하는 작업이 필요한 페이지
				String msg=URLEncoder.encode("글삭제실패", "utf-8");
				response.sendRedirect("error.jsp?msg="+msg);
			}
		}else if(command.equals("insertform")) {
			//응답할 페이지 코드가 컨트롤러에 이미 구현되어 있거나
			//또한 응답할 페이지가 정적페이지라면 response.sendRedirect() 사용항자
			
			response.sendRedirect("stuinsertboard.jsp");
		}else if(command.equals("insertboard")) {
			String id=request.getParameter("id");
			String title=request.getParameter("title");
			String content=request.getParameter("content");
			
			boolean isS=dao.insertBoard(new StuDto(id,title,content));
			
			if(isS) {
				response.sendRedirect("StuController.do?command=boardlist");
			}else {
				response.sendRedirect("error.jsp?msg="+URLEncoder.encode("글추가실패","utf-8"));
			}
		}else if(command.equals("detailboard")) {//글 상세보기(조회수 포함)
			int seq=Integer.parseInt(request.getParameter("seq"));
			SFileDto fdto = fdao.getFileInfo(seq);
	        request.setAttribute("fdto", fdto);
	         
			StuDto dto=dao.getStuBoard(seq);
			//쿠키의 값들을 가져오기(반환타입:배열)
			Cookie[] cookies=request.getCookies();
			String s=null;
			for (int i = 0; i < cookies.length; i++) {
				if(cookies[i].getName().equals("rseq")) {
					s=cookies[i].getValue();
				}
			}
			
			//쿠키생성 작업의 전제조건 : "rseq"라는 이름의 쿠기값이 없을 때
			//현재 저장된 쿠키의 값과 조회한 seq의 값이 다른 경우
			if(s==null||!s.equals(seq+"")) {//seq는 int라 4+""="4"로 변환
				Cookie cookie =new Cookie("rseq",seq+"");//쿠키생성
				cookie.setMaxAge(10*60);//쿠키의 유효기간
				response.addCookie(cookie);//브라우저로 생성한 쿠키를 추가
				dao.readCount(seq);//조회수증가
			}
			//------조회수 올리기할때 확인 코드 종료---------//
			
			
			
			request.setAttribute("dto", dto);
			dispatch("studetailboard.jsp", request, response);
		}else if(command.equals("replyboard")) {
			int seq=Integer.parseInt(request.getParameter("seq"));
			String id=request.getParameter("id");
			String title=request.getParameter("title");
			String content=request.getParameter("content");
			
			boolean isS=dao.replyBoard(new StuDto(seq,id,title,content));
			if(isS) {
				response.sendRedirect("StuController.do?command=boardlist");
			}else {
				response.sendRedirect("error.jsp?msg="+(URLEncoder.encode("답글추가실패", "utf-8")));
			}
		}else if(command.equals("updateform")) {
			int seq=Integer.parseInt(request.getParameter("seq"));
			StuDto dto=dao.getStuBoard(seq);
			SFileDto fdto = fdao.getFileInfo(seq);
            request.setAttribute("fdto", fdto);   
			request.setAttribute("dto", dto);
			dispatch("stuupdateboard.jsp", request, response);
		}else if(command.equals("updateboard")) {
			int seq=Integer.parseInt(request.getParameter("seq"));
			String title=request.getParameter("title");
			String content=request.getParameter("content");
			
			boolean isS=dao.updateBoard(new StuDto(seq,title,content));
			if(isS) {
				//detailboard.jsp:응답할 페이지를 먼저 확인해본다.
				response.sendRedirect("StuController.do?command=detailboard&seq="+seq);
			}else {
				response.sendRedirect("error.jsp?msg="+URLEncoder.encode("수정실패", "utf-8"));
			}
		}else if(command.equals("contentAjax")) {
			int seq=Integer.parseInt(request.getParameter("sseq"));
			
			StuDto dto=dao.getStuBoard(seq);//seq에 대한 글상세내용 조회--> dto담음
			//date타입은 json으로 변환 안됨
//-----------간단한 값 하나 응답할때 text타입 예시		
//			//요청했던 페이지로 응답하는 코드
//			PrintWriter pw=response.getWriter();
////			pw.print("전달한 seq값:"+seq);
//			pw.print(dto.getContent());//글의 내용만 꺼내서 클라이언트로 보냄

//-----------여러값을 json으로 응답할때 코드 예시: map-->json
			Date regdate=dto.getSregdate();//date 값 가져오기
			SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
			String regdateStr=sf.format(regdate);//date타입-->String타입으로 변환
			
			
			
			
			
			
			//regdateStr을 어따스는거지?????????????????????????????????????????????????????????????????????????????/
//			dto.setRegdateStr(regdateStr);//dto에 String타입의 날짜를 저장
//			dto.setTregdate(null);//regdate만 값을 다시 정의
			
			
			
			
			
			
			
			Map<String, StuDto>map=new HashMap<>();
			map.put("dto", dto);
			
			//map구조: key:value  , json구조: key:value
			JSONObject obj=JSONObject.fromObject(map);//map-->json변환
			PrintWriter pw=response.getWriter();
			obj.write(pw);//obj는 프린터가 없어서 프린터기를 빌려줌(pw)
			
		}else if(command.equals("main")) { //로그인 전
			List<StuDao> list=dao.getRecentList();
			request.setAttribute("list", list);
//			request.getRequestDispatcher("boardlist.jsp").forward(request, response);
			dispatch("index2.jsp", request, response);
		}
		else if(command.equals("main2")) { //로그인 후
			List<StuDao> list=dao.getRecentList();
			request.setAttribute("list", list);
			dispatch("index3.jsp", request, response);
			
		}else if(command.equals("adminmain")) { //로그인 후
			List<StuDao> list=dao.getRecentList();
			request.setAttribute("list", list);
			dispatch("admin_main.jsp", request, response);
		}
	         
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	//js forward 메서드 구현하기: 알림창을 띄우면서 이동
	public void jsForward(String msg,String url,HttpServletResponse response) throws IOException {
		String s="<script type='text/javascript'>"
				+ "		alert('"+msg+"');"
				+ "		location.href='"+url+"';"
				+ "</script>";
		
		PrintWriter pw=response.getWriter();
		pw.print(s);
	}
	
	//forward 메서드 구현하기: 객체를 전달하면서 이동
	public void dispatch(String url, HttpServletRequest request,HttpServletResponse response) 
		throws ServletException, IOException {
		request.getRequestDispatcher(url).forward(request, response);
	}


}
