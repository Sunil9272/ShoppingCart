<%@page import="java.io.PrintWriter"%>
<%@page import="com.shoppingcart.dto.Product"%>
<%@page import="com.shoppingcart.dto.Merchant"%>
<%@page import="javax.persistence.EntityTransaction"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
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
String name = request.getParameter("name");
double price = Double.parseDouble(request.getParameter("price"));
int stock = Integer.parseInt(request.getParameter("stock"));
String category =request.getParameter("catagory");

EntityManagerFactory emf = Persistence.createEntityManagerFactory("sunil");
EntityManager em = emf.createEntityManager();
EntityTransaction et = em.getTransaction();

Merchant merchant = (Merchant)session.getAttribute("merchant");
Product product = new Product();

product.setName(name);
product.setPrice(price);
product.setStock(stock);
product.setCategory(category);
product.setMerchant(merchant);

et.begin();
em.persist(product);
et.commit();

PrintWriter pout = response.getWriter();
pout.print("Product is successfully stored.....");
RequestDispatcher rd = request.getRequestDispatcher("Login.html");
rd.include(request, response);
response.setContentType("text/html");
%>
</body>
</html>