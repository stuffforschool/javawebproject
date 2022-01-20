package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import services.UserService;
import utils.RegisterResponse;

import java.io.IOException;

import entities.User;

/**
 * Servlet implementation class UserController
 */
@MultipartConfig
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService us = new UserService();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserController() {
		super();
		// TODO Auto-generated constructor stub
	}



	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (request.getParameter("op").equals("delete")) {
			int id = Integer.parseInt(request.getParameter("id"));
			if (us.deleteUser(us.findById(id))) {
				response.sendRedirect("/LearningJavaWeb/GestionUsers.jsp");
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		if (request.getParameter("op") != null) {
			if (request.getParameter("op").equals("add")) {
				String username = request.getParameter("username");
				String pw = request.getParameter("password");
				String email = request.getParameter("email");
				String role = request.getParameter("role");
				RegisterResponse res = us.register(new User(username, email, pw, role));
				System.out.println("m here  "+res);
				if (res.getUser() != null) {
					response.sendRedirect("/LearningJavaWeb/GestionUsers.jsp");
				}else if(res.getError() != null) {
					response.getWriter().println("response"+res.getError());
				}
			} else if (request.getParameter("op").equals("delete")) {
				int id = Integer.parseInt(request.getParameter("id"));
				if (us.deleteUser(us.findById(id))) {
					response.sendRedirect("/LearningJavaWeb/GestionUsers.jsp");
				}
			} else if (request.getParameter("op").equals("update")) {
				//System.out.println("here to update");
				int id = Integer.parseInt(request.getParameter("id"));

				String username = request.getParameter("username");
				String pw = request.getParameter("password");
				String email = request.getParameter("email");
				String role = request.getParameter("role");
				User user = new User(id, username, email, pw, role);
				System.out.println("user to update" + user);
				if (us.updateUser(user)) {
					response.sendRedirect("/LearningJavaWeb/GestionUsers.jsp");
				}
			}else if(request.getParameter("op").equals("upload")) {
				System.out.println("entred here");
				int id = Integer.parseInt(request.getParameter("id"));
				Part filePart = request.getPart("file");
				String fileName = "user-"+id;
				
				for (Part part : request.getParts()) {
				      part.write("C:\\Users\\isigm\\eclipse-workspace\\LearningJavaWeb\\src\\main\\webapp\\images\\users\\" + fileName);
				      
				  }
				response.sendRedirect("/LearningJavaWeb/profile.jsp");
			}
		}
	}

}
