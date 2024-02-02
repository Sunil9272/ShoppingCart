<%@page import="java.io.PrintWriter"%>
<%@page import="javax.persistence.EntityTransaction"%>
<%@page import="com.shoppingcart.dto.Item"%>
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

int id = Integer.parseInt(request.getParameter("id"));

EntityManagerFactory emf = Persistence.createEntityManagerFactory("sunil");
EntityManager em = emf.createEntityManager();
EntityTransaction et = em.getTransaction();

Item item = em.find(Item.class, id);

item.setCart(null);

et.begin();
em.merge(item);
em.remove(item);
et.commit();


	PrintWriter pout = response.getWriter();
	pout.print("Item removed from cart...");
	RequestDispatcher rd=request.getRequestDispatcher("customeroptions.html");
	rd.include(request, response);


%>

</body>
</html>