package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import services.RoomService;
import services.UserService;
import utils.RegisterResponse;


import java.io.IOException;




import entities.Room;
import entities.User;

/**
 * Servlet implementation class RoomController
 */
@MultipartConfig
public class RoomController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RoomService rs = new RoomService();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RoomController() {
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
			if (rs.removeRoom(rs.findById(id))) {
				response.sendRedirect("/LearningJavaWeb/GestionRooms.jsp");
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
				String numero = request.getParameter("num");
				String type = request.getParameter("type");
				int price = Integer.parseInt(request.getParameter("price").toString());

				// ---- upload handling
				Part filePart = request.getPart("file");
				String fileName = "room-"+numero;
				for (Part part : request.getParts()) {
				      part.write("C:\\Users\\isigm\\eclipse-workspace\\LearningJavaWeb\\src\\main\\webapp\\images\\rooms\\" + fileName);
				}
				// ----- ended upload

				if (rs.addRoom(new Room(numero, type, price))) {
					response.sendRedirect("/LearningJavaWeb/GestionRooms.jsp");
				}
			} else if (request.getParameter("op").equals("delete")) {
				int id = Integer.parseInt(request.getParameter("id"));
				if (rs.removeRoom(rs.findById(id))) {
					response.sendRedirect("/LearningJavaWeb/GestionRooms.jsp");
				}
			} else if (request.getParameter("op").equals("update")) {
				// System.out.println("here to update");
				int id = Integer.parseInt(request.getParameter("id"));

				String numero = request.getParameter("num");
				String type = request.getParameter("type");
				int price = Integer.parseInt(request.getParameter("price"));
				System.out.println("num:" + numero + " type: " + type + " price: " + price);
				Room room = new Room(id, numero, type, price);
				System.out.println("room to update" + room);
				if (rs.updateRoom(room)) {
					response.sendRedirect("/LearningJavaWeb/GestionRooms.jsp");
				}
			}
		}
	}

	

}
