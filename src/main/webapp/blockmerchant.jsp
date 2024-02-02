<%@page import="java.io.PrintWriter"%>
<%@page import="com.shoppingcart.dto.Merchant"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.Query"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
EntityManagerFactory emf = Persistence.createEntityManagerFactory("sunil");
EntityManager em = emf.createEntityManager();

Query query = em.createQuery("SELECT m FROM Merchant m WHERE m.Status = 'active'");
List<Merchant> merchants = query.getResultList();
if(merchants.size()>0){
	%>	
	
	<table border=1 align="center">
<tr>
<th>id</th>
<th>Name</th>
<th>Email</th>
<th>Password</th>
<th>Mobile Number</th>
<th>Status</th>
<th>Block</th>
</tr>
	<%for(Merchant m : merchants){ %>
	<tr>
	<td><%=m.getId() %></td>
	<td><%=m.getName() %></td>
	<td><%=m.getEmail() %></td>
	<td><%=m.getPassword() %>
	<td><%=m.getMobilenumber() %></td>
	<td><%=m.getStatus() %></td>
	<td><a href ="merchantstatusblock.jsp?id=<%=m.getId()%>">Block</a></td>
	</tr>
	<%} %>
	</table>
<%}else{
	PrintWriter pout = response.getWriter();
	pout.print("No Merchant for approve");
	RequestDispatcher rd=request.getRequestDispatcher("adminoptions.html");
	rd.include(request, response);
}%>
</body>
</html>