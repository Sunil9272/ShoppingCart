<%@page import="com.shoppingcart.dto.Product"%>
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

Query query = em.createQuery("SELECT p FROM Product p ");
List<Product> products = query.getResultList();
if(products.size()>0){
	%>	
	
	<table border=1 align="center">
<tr>
<th>id</th>
<th>Name</th>
<th>Stock</th>
<th>Category</th>
<th>Price</th>
<th>Merchant</th>
<th>Delete</th>
</tr>
	<%for(Product p : products){ %>
	<tr>
	<td><%=p.getId() %></td>
	<td><%=p.getName() %></td>
	<td><%=p.getStock() %></td>
	<td><%=p.getCategory() %>
	<td><%=p.getPrice() %></td>
	<%Merchant m = (Merchant)p.getMerchant(); %>
	<td><%= m.getId() %></td>
	<td><a href ="proddelete.jsp?id=<%=p.getId()%>">Delete</a></td>
	</tr>
	<%} %>
	</table>
	
<%}else{
	PrintWriter pout = response.getWriter();
	pout.println("Products not found");
	RequestDispatcher rd=request.getRequestDispatcher("adminoptions.html");
	rd.include(request, response);
}
%>

</body>
</html>