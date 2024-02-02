<%@page import="java.io.PrintWriter"%>
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
Admin a = m.getAdmin() ;
List<Merchant> merchants = a.getMerchants() ;

List<Merchant> newmerchants = new ArrayList() ;
if(merchants != null){
for(Merchant m1 : merchants) {
	if(m1.getId()==m.getId()) {
		
	}
	else {
		newmerchants.add(m1) ;
	}
}

a.setMerchants(newmerchants) ;
et.begin();
em.merge(a) ;
em.remove(m);
et.commit();

RequestDispatcher rd = request.getRequestDispatcher("merchantdelete.jsp");
rd.include(request, response);
}else{
	RequestDispatcher rd = request.getRequestDispatcher("merchantdelete.jsp");
	rd.include(request, response);
	PrintWriter pout = response.getWriter();
	pout.print("Merchant not found.....");
}
%>
</body>
</html>