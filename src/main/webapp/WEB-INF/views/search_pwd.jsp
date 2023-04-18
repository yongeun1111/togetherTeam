<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>비밀번호찾기페이지</h1>
  <form action="/search_pwd" method="post">
    <input type="text" name="mem_id"><br>
    <input type="text" name="mem_name"><br>
    <input type="text" name="mem_email"><br>
    <input type="submit" value="아이디 찾기"><br>
  </form>
</body>
</html>