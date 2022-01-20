package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import services.BookingService;
import services.RoomService;
import services.UserService;
import utils.RegisterResponse;

import java.io.IOException;

import entities.User;

/**
 * Servlet implementation class AdminController
 */

public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private UserService us = new UserService();
    private RoomService rs = new RoomService();
    private BookingService bs = new BookingService();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(request.getParameter("type") != null) {
			if(request.getParameter("type").equals("users")) {
				if(request.getParameter("op") == null) {
					String username = request.getParameter("username");
					String pw = request.getParameter("password");
					String email = request.getParameter("email");
					String role = request.getParameter("role");
					RegisterResponse res = us.register(new User(username,pw,email,role)) ;
					if(res.getUser() != null) {
					
						
						response.sendRedirect("/LearningJavaWeb/admin.jsp");
						//res.getWriter().println("user: "+response.getUser()+"session: userId = " + (int) session.getAttribute("userId"));
						
					}
				}else if(request.getParameter("op").equals("delete")) {
					int id = Integer.parseInt(request.getParameter("id"));
					if(us.deleteUser(us.findById(id))) {
						response.sendRedirect("/LearningJavaWeb/admin.jsp");
					}
				}else if(request.getParameter("op").equals("update")) {
					int id = Integer.parseInt(request.getParameter("id"));
					
				
					String username = request.getParameter("username");
					
					String pw = request.getParameter("password");
					String email = request.getParameter("email");
					String role = request.getParameter("role");
					User user = new User(id,username,email,pw,role);
					System.out.println("user to update"+user);
					if(us.updateUser(user)) {
						response.sendRedirect("/LearningJavaWeb/admin.jsp");
					}
				}
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(request.getParameter("type") != null) {
			if(request.getParameter("type").equals("users")) {
				if(request.getParameter("op") == null) {
					String username = request.getParameter("username");
					String pw = request.getParameter("password");
					String email = request.getParameter("email");
					String role = request.getParameter("role");
					RegisterResponse res = us.register(new User(username,pw,email,role)) ;
					if(res.getUser() != null) {
					
						
						response.sendRedirect("/LearningJavaWeb/admin.jsp");
						//res.getWriter().println("user: "+response.getUser()+"session: userId = " + (int) session.getAttribute("userId"));
						
					}
				}else if(request.getParameter("op").equals("delete")) {
					int id = Integer.parseInt(request.getParameter("id"));
					if(us.deleteUser(us.findById(id))) {
						response.sendRedirect("/LearningJavaWeb/admin.jsp");
					}
				}else if(request.getParameter("op").equals("update")) {
					
				}
			}
		}
	}

}
