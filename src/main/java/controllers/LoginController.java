package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import services.UserService;

import java.io.IOException;

import entities.User;

/**
 * Servlet implementation class LoginController
 */

public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private UserService us = new UserService();   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
   
    public void service(HttpServletRequest req,HttpServletResponse res) throws IOException {
    	String login = req.getParameter("login");
    	String password = req.getParameter("password");
    	User user = us.login(login, password);
  
    	if(user != null) {
			//res.getWriter().println("user: "+user);
    		HttpSession session = req.getSession();
			session.setAttribute("userId", user.getId());
		
			if(req.getHeader("referer").contains("src")) {
				String to = req.getHeader("referer").split("8081")[1];
				System.out.println("to: "+to);
				res.sendRedirect(to);
			}else {
				
				res.sendRedirect("/LearningJavaWeb");
			}
			
		}else {
			res.sendRedirect("login.jsp?error=incorrect");
			
		}
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
