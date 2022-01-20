package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import services.UserService;
import utils.Hash;
import utils.MailSender;
import utils.RegisterResponse;

import java.io.IOException;

import entities.User;

/**
 * Servlet implementation class RegisterController
 */
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService us = new UserService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(request.getParameter("key") != null) {
			if(request.getParameter("key").equals(Hash.md5(request.getParameter("uid")))) {
				us.verify(us.findByUsername(request.getParameter("uid")));
				response.getWriter().println("User verified");
			}
		}
		if(request.getParameter("action") != null && request.getParameter("action").equals("send") ) {
			User user = us.findById(Integer.parseInt(request.getParameter("id")));
			String username = user.getUsername();
			String email = user.getEmail();
			MailSender.send("http://localhost:8081/LearningJavaWeb/RegisterController?uid="+username+"&key="+Hash.md5(username), email);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String username = req.getParameter("username");
		String pw = req.getParameter("password");
		String email = req.getParameter("email");
		RegisterResponse response = us.register(new User(username,email,pw,"client")) ;
		
		if(response.getUser() != null) {
			HttpSession session = req.getSession();
			session.setAttribute("userId", response.getUser().getId());
			res.sendRedirect("/LearningJavaWeb");
			//res.getWriter().println("user: "+response.getUser()+"session: userId = " + (int) session.getAttribute("userId"));
			
		}else if(response.getError() != null) {
			
			res.sendRedirect("register.jsp?field="+response.getError().field+response.getError().message+"&username="+username+"&email="+email);
			
		}else {
			res.getWriter().println("another error has occured");
		}
		
	}

}
