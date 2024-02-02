<%@page import="java.io.PrintWriter"%>
<%@page import="com.shoppingcart.dto.Item"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.shoppingcart.dto.Cart"%>
<%@page import="com.shoppingcart.dto.Product"%>
<%@page import="com.shoppingcart.dto.Customer"%>
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
Customer customer = (Customer)session.getAttribute("customer");

int id = Integer.parseInt(request.getParameter("id")) ;
int quantity = Integer.parseInt(request.getParameter("quantity"));
EntityManagerFactory emf = Persistence.createEntityManagerFactory("sunil");
EntityManager em = emf.createEntityManager();
EntityTransaction et = em.getTransaction();

Product p = em.find(Product.class, id);
Cart cart = customer.getCart();

Item item = new Item();

item.setCategory(p.getCategory());
item.setName(p.getName());
item.setCart(cart);

if(quantity>0){
	item.setPrice(p.getPrice()*quantity);
	cart.setTotalprice(p.getPrice()*quantity+cart.getTotalprice());	
}else{
	item.setPrice(0);
	cart.setTotalprice(0+cart.getTotalprice());
}


item.setQuantity(quantity);



List<Item> items = new ArrayList();
items.add(item);

cart.setItems(items);

et.begin();
em.persist(item) ;
em.merge(cart);
et.commit();
PrintWriter pout = response.getWriter();
pout.print("Items Added into cart.....");

%>
</body>
</html>