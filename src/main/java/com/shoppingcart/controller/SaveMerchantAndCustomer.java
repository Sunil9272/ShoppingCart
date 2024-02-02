package com.shoppingcart.controller;

import java.io.IOException;

import java.io.PrintWriter;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoppingcart.dto.Cart;
import com.shoppingcart.dto.Customer;
import com.shoppingcart.dto.Merchant;
 
@WebServlet("/savedata")
public class SaveMerchantAndCustomer extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String password = req.getParameter("pass");
		Long mobilenumber = Long.parseLong(req.getParameter("mbnum"));
		
		String choice = req.getParameter("choice");
		
		if(choice.equals("Create Account as Merchant")) {
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("sunil");
			EntityManager em = emf.createEntityManager();
			EntityTransaction et = em.getTransaction();
			
			Merchant merchant = new Merchant();
			
			merchant.setName(name);
			merchant.setEmail(email);
			merchant.setPassword(password);
			merchant.setMobilenumber(mobilenumber);
			merchant.setStatus("inactive");
			
			et.begin();
			em.persist(merchant);
			et.commit();
			
			PrintWriter pout = resp.getWriter();
			pout.print("Merchant Account Created Successfully.....");
			RequestDispatcher rd = req.getRequestDispatcher("Login.html");
			rd.include(req, resp);
			resp.setContentType("text/html");
		}else {
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("sunil");
			EntityManager em = emf.createEntityManager();
			EntityTransaction et = em.getTransaction();
			
			Cart cart = new Cart();
			cart.setItems(null);
			cart.setTotalprice(0);
			cart.setCustomer(null);
			
			et.begin();
			em.persist(cart);
			et.commit();
			
			Customer customer = new Customer();
			
			customer.setName(name);
			customer.setEmail(email);
			customer.setPassword(password);
			customer.setMobilenumber(mobilenumber);
			customer.setStatus("active");
			customer.setCart(cart);
			
			cart.setCustomer(customer);
			
			et.begin();
			em.persist(cart);
			em.persist(customer);
			et.commit();
			
			PrintWriter pout = resp.getWriter();
			pout.print("Customer Account Created Successfully.....");
			RequestDispatcher rd = req.getRequestDispatcher("Login.html");
			rd.include(req, resp);
			resp.setContentType("text/html");
		}
		
	}

}
