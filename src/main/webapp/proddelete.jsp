<%@page import="com.shoppingcart.dto.Product"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="javax.persistence.EntityTransaction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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

Product p  = em.find(Product.class, id);
Merchant m = p.getMerchant() ;
List<Product> products = m.getProducts() ;

List<Product> newproducts = new ArrayList() ;
if(products != null){
for(Product p1 : products) {
	if(p1.getId()==p.getId()) {
		
	}
	else {
		newproducts.add(p1) ;
	}
}

m.setProducts(products);
et.begin();
em.merge(m) ;
em.remove(p);
et.commit();

RequestDispatcher rd = request.getRequestDispatcher("deleteproduct.jsp");
rd.include(request, response);
PrintWriter pout = response.getWriter();
pout.print("Product deleted.....");
}else{
	RequestDispatcher rd = request.getRequestDispatcher("deleteproduct.jsp");
	rd.include(request, response);
	PrintWriter pout = response.getWriter();
	pout.print("Product not found.....");
}
%>
</body>
</html>