<%@page import="javax.persistence.EntityTransaction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.shoppingcart.dto.Admin"%>
<%@page import="com.shoppingcart.dto.Merchant"%>
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
int id = Integer.parseInt(request.getParameter("id")) ;
EntityManagerFactory emf = Persistence.createEntityManagerFactory("sunil");
EntityManager em = emf.createEntityManager();
EntityTransaction et = em.getTransaction();

Merchant m = em.find(Merchant.class, id);
m.setStatus("active");

Admin a = (Admin)session.getAttribute("admin");
m.setAdmin(a);
List<Merchant> merchant = new ArrayList() ;
merchant.add(m);
a.setMerchants(merchant);

et.begin();
em.merge(a);
em.merge(m);
et.commit();

RequestDispatcher rd = request.getRequestDispatcher("approvemerchant.jsp");
rd.include(request, response);
%>
</body>
</html>