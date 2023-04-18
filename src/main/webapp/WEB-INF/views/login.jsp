<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>로그인페이지</h1>
  <p>1. 로그인 폼 태그</p>
    <form action="/login" method="post">
      <input type="text" name="id"><br>
      <input type="password" name="pwd"><br>
      <input type="submit" value="로그인"><br>
    </form>
  <p>2. 회원가입/아이디찾기/비밀번호찾기 페이지로 이동하는 버튼</p>
    <a href="/join">회원가입</a>
    <a href="/search_id">아이디찾기</a>
    <a href="/search_pwd">비밀번호찾기</a>
</body>
</html>