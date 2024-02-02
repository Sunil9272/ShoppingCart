package com.shoppingcart.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shoppingcart.dto.Admin;
import com.shoppingcart.dto.Customer;
import com.shoppingcart.dto.Merchant;

@WebServlet("/loginvalidation")
public class LoginValidation extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		
		String choice = req.getParameter("choice");
		
		if(choice.equals("Customer")) {
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("sunil");
			EntityManager em = emf.createEntityManager();

			Query query = em.createQuery("select a from Customer a where a.email = ?1 and a.password = ?2");
			query.setParameter(1, email);
			query.setParameter(2, password);
			
			List<Customer> customer = query.getResultList();
			
			if(customer.size()>0) {
				Customer c = customer.get(0);
				HttpSession hs = req.getSession();
				hs.setAttribute("customer", c);
				
				RequestDispatcher rd = req.getRequestDispatcher("customeroptions.html");
				rd.forward(req, resp);
			}else {
				PrintWriter pout = resp.getWriter();
				pout.print("Invalid Credentials");
				RequestDispatcher rd = req.getRequestDispatcher("Login.html");
				rd.include(req, resp);
				resp.setContentType("text/html");
			}
			
		}else if(choice.equals("Merchant")) {
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("sunil");
			EntityManager em = emf.createEntityManager();
			

			Query query = em.createQuery("select a from Merchant a where a.email = ?1 and a.password = ?2");
			query.setParameter(1, email);
			query.setParameter(2, password);
			
			List<Merchant> merchant = query.getResultList();
			
			if(merchant.size()>0) {
				
				Merchant a = merchant.get(0);
				if(a.getStatus().equals("active")) {
					Merchant m = merchant.get(0);
					HttpSession hs = req.getSession();
					hs.setAttribute("merchant", m);
					RequestDispatcher rd = req.getRequestDispatcher("merchantoptions.html");
					rd.forward(req, resp);	
				}else if(a.getStatus().equals("inactive")) {
					PrintWriter pout = resp.getWriter();
					pout.print("Your Account is InActive");
					RequestDispatcher rd = req.getRequestDispatcher("Login.html");
					rd.include(req, resp);
					resp.setContentType("text/html");
					
				}else if(a.getStatus().equals("block")) {
					PrintWriter pout = resp.getWriter();
					pout.print("Your Account is Blocked");
					RequestDispatcher rd = req.getRequestDispatcher("Login.html");
					rd.include(req, resp);
					resp.setContentType("text/html");
				}
				
				
			}else {
				PrintWriter pout = resp.getWriter();
				pout.print("Invalid Credentials");
				RequestDispatcher rd = req.getRequestDispatcher("Login.html");
				rd.include(req, resp);
				resp.setContentType("text/html");
			}
		}else if(choice.equals("Admin")) {
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("sunil");
			EntityManager em = emf.createEntityManager();

			Query query = em.createQuery("select a from Admin a where a.email = ?1 and a.password = ?2");
			query.setParameter(1, email);
			query.setParameter(2, password);
			
			List<Admin> admin = query.getResultList();
			
			if(admin.size()>0) {
				Admin a = admin.get(0);
				HttpSession hs = req.getSession();
				hs.setAttribute("admin", a);
				
				RequestDispatcher rd = req.getRequestDispatcher("adminoptions.html");
				rd.forward(req, resp);
			}else {
				PrintWriter pout = resp.getWriter();
				pout.print("Invalid Credentials");
				RequestDispatcher rd = req.getRequestDispatcher("Login.html");
				rd.include(req, resp);
				resp.setContentType("text/html");
			}
		}
	}
}
