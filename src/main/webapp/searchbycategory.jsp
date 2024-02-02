<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.protocol.Resultset"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.shoppingcart.dto.Merchant"%>
<%@page import="com.shoppingcart.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.Query"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body align = "center">
<%

  String category = request.getParameter("category");

  EntityManagerFactory emf = Persistence.createEntityManagerFactory("sunil");
  EntityManager em = emf.createEntityManager();
  
  Query query = em.createQuery("SELECT p FROM Product p WHERE p.category = category");
  
  List<Product> products = query.getResultList();

  %>
  <table border=1 align="center">
  <tr>
  <th>Category</th>
  <th>Name</th>
  <th>Price</th>
  <th>Stock</th>
  <th>Merchent_id</th>
  <th>Product_id</th>
  <th>Quantity</th>
  <th>Add to Cart</th>
  </tr>
  
  <%if(!products.isEmpty()){
	  for(Product p : products){
	  %>
  <tr>
  
  <td><%=p.getCategory() %></td>
  <td><%=p.getName() %></td>
  <td><%=p.getPrice() %></td>
  <td><%=p.getStock()%></td>
  <%Merchant m = p.getMerchant();%>
  <td><%=m.getId() %></td>
  <form action = "addcart.jsp?id=<%=p.getId()%>">
  <td><input type ="number" name="id"value="<%=p.getId()%>" readonly>
  <td><input type="number" name = "quantity" min="0" max="<%=p.getStock() %>"></td>
  <td><input type = "submit" value = "Add to Cart">
  </form>
 
  </tr>
  <%} %>
  </table>
  <%}else{
  	PrintWriter pout = response.getWriter();
  	pout.print("No Product Found.....");
  	RequestDispatcher rd=request.getRequestDispatcher("customeroptions.html");
  	rd.include(request, response);
  }%>

</body>
</html>