<%@page import="com.shoppingcart.dto.Item"%>
<%@page import="com.shoppingcart.dto.Cart"%>
<%@page import="com.shoppingcart.dto.Customer"%>
<%@page import="com.shoppingcart.dto.Merchant"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="javax.persistence.Query"%>
<%@page import="com.shoppingcart.dto.Product"%>
<%@page import="java.util.List"%>
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
<body>
<%
EntityManagerFactory emf = Persistence.createEntityManagerFactory("sunil");
EntityManager em = emf.createEntityManager();

Customer customer = (Customer)session.getAttribute("customer");
Cart cart = customer.getCart();
int cart_id = cart.getId();

//Query query = em.createQuery("SELECT i FROM Item i JOIN FETCH Cart c WHERE c.id = id");


Query query = em.createQuery("SELECT i FROM Item i WHERE cart_id = :id");
query.setParameter("id",cart_id);


List <Item> items = query.getResultList();



if(items.size() != 0){

%>
<table border=1 align="center">
<tr>
<th>Id</th>
<th>Category</th>
<th>Name</th>
<th>Price</th>
<th>Quantity</th>
<th>Cart_Id</th>
<th>Remove from Cart</th>
</tr>

<%for(Item i : items){%>
<tr>

<td><%=i.getId() %>
<td><%=i.getCategory() %></td>
<td><%=i.getName() %></td>
<td><%=i.getPrice() %></td>
<td><%=i.getQuantity()%></td>
<td><%=cart.getId()%></td>
<td><a href="removefromcart.jsp?id=<%=i.getId()%>">Remove</a>
 
</tr>
<%}%>
</table>
<%}else{
	PrintWriter pout = response.getWriter();
	pout.print("Cart is Empty...");
	RequestDispatcher rd=request.getRequestDispatcher("customeroptions.html");
	rd.include(request, response);
}%>

</body>
</html>