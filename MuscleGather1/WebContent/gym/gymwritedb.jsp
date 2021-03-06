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
String gym_name = null;
String gym_content = null;
/* String gym_addr = null; */
String gym_salary = null;
String gym_secret = null;
String gym_images = null;
byte[] pfile = null;

ServletFileUpload sfu = new ServletFileUpload(new DiskFileItemFactory());
// 추출 값들을 객체 형태로 저장할 준비

List items = sfu.parseRequest(request);
// 입력된 값들을 추출하여 객체에 저장

Iterator iter = items.iterator();
// 순차적으로 접근하기 위해 객체 생성
while(iter.hasNext()) {  // 요소가 있으면 계속 반복 없으면 종료
    FileItem item = (FileItem) iter.next();  //요소를 하나씩 추출
    String name = item.getFieldName();       //요소의 이름 추출
    
    if(item.isFormField()) { // 이름과 값으로 즉 맵 형태 쌍으로 구성이 되어 있는지 확인
        String value = item.getString("utf-8");	// 한글 처리 중요
        if (name.equals("gym_name")) gym_name = value;
        else if (name.equals("gym_content")) gym_content = value;
  /*       else if (name.equals("gym_addr")) gym_addr = value; */
        else if (name.equals("gym_salary")) gym_salary = value;
        else if (name.equals("gym_secret")) gym_secret = value;
        else if (name.equals("gym_images")) gym_images = value;
    }
    else {
        if (name.equals("images")) {
        	gym_images = item.getName();
            pfile = item.get();
            //서버에 사진 저장
            String root = application.getRealPath(java.io.File.separator);
            FileUtil.saveImage(root, gym_images, pfile);
            
	}
}
}
/* //디비에 게시물 모든 정보 전달
GymDAO dao = new GymDAO();
if (dao.insert(gym_name, gym_content, gym_salary, gym_secret, gym_images)) {
	response.sendRedirect("gymwrite.jsp");
} */
%>
