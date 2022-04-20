<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 유효성 검사는 사용자가 입력한 데이터 값이 서버로 전송되기 전에 규칙에 맞는지 검사하여 검증하는 것
사용자가 실수로 유효하지 않은 데이터 값을 입력하게 되면 부적합하다고 판단하여 다시 입력하도록 알려준다.

아이디 검사, 패스워드 검사, 빈칸 여부... -->
<script type="text/javascript">
function CheckForm() {
/* 	alert("아이디 : " + document.loginForm.id.value + "\n"
			+ "비번 : " + document.loginForm.pw.value); */
			
	if(document.loginForm.id.value.length < 3 || document.loginForm.id.value.length > 20) {
		alert("아이디 값이 너무 작거나 큽니다. 다시 입력해주세요.");
		form.id.focus();
		return false;
	} 
	
	if (document.loginForm.pw.length < 2) {
		alert("비번은 두글자 이상으로 입력하세요.")
		form.pw.focus();
		return false;
	}
	
	form.submit();
}

</script>

<form name="loginForm">
아이디 : <input type="text" name="id">
비번 : <input type="password" name="pw">
<input type="submit" onclick="CheckForm()">

</form>

</body>
</html>