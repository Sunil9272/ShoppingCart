<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.shoppingcart.dto.Merchant"%>
<%@page import="com.shoppingcart.dto.Product"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="javax.persistence.EntityTransaction"%>
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
String clname= request.getParameter("updatevalue");
String value = request.getParameter("value");
PrintWriter pouts = response.getWriter();
EntityManagerFactory emf = Persistence.createEntityManagerFactory("sunil");
EntityManager em = emf.createEntityManager();
EntityTransaction et = em.getTransaction();

Product p = em.find(Product.class, id);
if(p!=null){
if(clname.equals("name")){
	p.setName(value);
}else if(clname.equals("price")){
	double price = Double.parseDouble(value);
	p.setPrice(price);
}else if(clname.equals("stock")){
	int stock = Integer.parseInt(value);
	p.setStock(stock);
}else if(clname.equals("category")){
	p.setCategory(value);
}

et.begin();
em.merge(p);
et.commit();

RequestDispatcher rd = request.getRequestDispatcher("productupdate.jsp");
rd.include(request, response);
PrintWriter pout = response.getWriter();
pout.print("Product Updated.....");
}else{
	RequestDispatcher rd = request.getRequestDispatcher("productupdate.jsp");
	rd.include(request, response);
	PrintWriter pout = response.getWriter();
	pout.print("Product not found.....");
}
%>
</body>
</html>