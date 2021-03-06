<%@page import="jdbc.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "util.FileUtil"%>

<%
request.setCharacterEncoding("utf-8");
// images 로 전체 데이터가 넘어옴

int chk = 1;	// 사진없는경우

byte[] pfile = null;

ArrayList<String> arr = new ArrayList<>();
//이미지를 여러개 추가하면 이름을 여러개 저장하기 위해 ArrayList사용

ServletFileUpload sfu = new ServletFileUpload(new DiskFileItemFactory());
// 추출 값들을 객체 형태로 저장할 준비
List items = sfu.parseRequest(request);
// 입력된 값들을 추출하여 객체에 저장
Iterator iter = items.iterator();
// 순차적으로 접근하기 위해 객체 생성

while(iter.hasNext()) {  // 요소가 있으면 계속 반복 없으면 종료
/* 	System.out.println("중간---------------");
	System.out.println(gym_name);
	System.out.println(gym_content);
	System.out.println(gym_addr);
	System.out.println(gym_salary);
	System.out.println(gym_images); */
    FileItem item = (FileItem) iter.next();  //요소를 하나씩 추출
    String name = item.getFieldName();       //요소의 이름 추출
    
    if(item.isFormField()) { // 이름과 값으로 즉 맵 형태 쌍으로 구성이 되어 있는지 확인
        String value = item.getString("utf-8");	// 한글 처리 중요
        if (name.equals("gym_name")) gym_name = value;
        else if (name.equals("gym_content")) gym_content = value;
        else if (name.equals("gym_salary")) gym_salary = value;
        else if (name.equals("gym_addr")) gym_addr = value;
    }
    else {
    	
    	try{
    	
	        if (name.equals("images")) {
	        	
	        	gym_images = item.getName();
	        	System.out.println("----------> " + gym_images);
	        	
	            arr.add(gym_images);
	        	pfile = item.get();
	        	System.out.println(arr.toString());
	            //서버에 사진 저장
	            String root = application.getRealPath(java.io.File.separator);
	      /*       System.out.println("루트 ------------------\n " + root); */
	            FileUtil.saveImage(root, gym_images, pfile);
	        }
	        
    	} catch (Exception e) {
    		chk = 0;
    		break;
    	}
            
	}
}


//디비에 게시물 모든 정보 전달
GymDAO dao = new GymDAO();
boolean b = true;

if(chk == 1){ 
	b = dao.insert(user_no, gym_name, gym_content, gym_addr, gym_salary, arr);
} else {
	b = dao.insert(user_no, gym_name, gym_content, gym_addr, gym_salary);
}
	
if(b){
	response.sendRedirect("gymlist.jsp");
}
%>


