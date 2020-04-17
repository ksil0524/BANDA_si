<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<a href = "naver_callback.do?request=${request}"> callback보기 </a>

	<%
		
		System.out.println(request);
	
	
	%>
</body>
</html>