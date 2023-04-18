<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>회원가입페이지</h1>
    <form action="/join" method="post" required>
      <input type="text" name="mem_id" required><br>
      <input type="password" name="mem_pwd" required><br>
      <input type="password" name="mem_pwd_confirm" required><br>
      <input type="text" name="mem_name" required><br>
      <input type="text" name="mem_phone" required><br>
      <input type="text" name="mem_birth" required><br>
      <input type="text" name="mem_email" required><br>
      <input type="submit" value="회원가입"><br>
    </form>
</body>
</html>