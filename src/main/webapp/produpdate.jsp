<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
Select value to Update:<br><br>
<form action="updateproduct.jsp" >
<input type="radio" name="updatevalue" value="name">Name<br>
<input type="radio" name="updatevalue" value="price">Price<br>
<input type="radio" name="updatevalue" value="stock">Stock<br>
<input type="radio" name="updatevalue" value="category">Category<br><br>
Id:<input type ="text" name="id" value=<%=request.getParameter("id")%> ><br><br>
value:<input type="text" name="value">
<input type = "submit">
</form>
</div>
</body>
</html>